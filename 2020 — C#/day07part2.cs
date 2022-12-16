using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using static System.Console;

namespace AOC7_1
{
    struct Bag
    {
        public string name;
        public List<Tuple<int, string>> contains;
    }

    class Program
    {
        static void Main(string[] args)
        {
            string path = Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location), @"Data\..\..\..\..\");
            string[] inputFile = System.IO.File.ReadAllLines(path + "in.txt");

            int inputLength = inputFile.Length;

            List<Bag> bags = new List<Bag>();

            for (int i = 0; i < inputLength; i++) {
                string entry = inputFile[i];

                string bagName = "";
                int bagContainsStartIndex = 0;

                for (int j = 0; j < entry.Length; j++) {
                    if (entry.Substring(j, 14) == " bags contain ") {
                        bagContainsStartIndex = j + 14;
                        break;
                    }
                    bagName += entry[j];
                }

                List<Tuple<int, string>> bagContains = new List<Tuple<int, string>>();

                for (int j = bagContainsStartIndex; j < entry.Length; j++) {
                    string bagContainsToAdd = "";
                    int bagContainsNumber = 0;
                    if (char.IsDigit(entry[j])) {
                        bagContainsNumber = int.Parse($"{entry[j]}");
                        for (int k = j + 2; k < entry.Length; k++) {
                            if (entry.Substring(k, 4) == " bag") {
                                break;
                            }
                            bagContainsToAdd += entry[k];
                        }
                    }
                    if (!String.IsNullOrEmpty(bagContainsToAdd)) bagContains.Add(new Tuple<int, string>(bagContainsNumber, bagContainsToAdd));
                }

                Bag bag = new Bag() { name = bagName, contains = bagContains };
                bags.Add(bag);
            }

            int result = 0;

            foreach (var bag in bags) {
                if (bag.name == "shiny gold") {
                    result += Count(bags, bag.name);
                }
            }

            WriteLine(result - 1);
        }

        static int Count(List<Bag> bags, string bagName)
        {
            var bag = bags.Single(x => x.name == bagName);
            
            if (!bag.contains.Any()) return 1;

            int rtrn = 1;

            foreach (var innerBag in bag.contains) {
                rtrn += innerBag.Item1 * Count(bags, innerBag.Item2);
            }

            return rtrn;
        }
    }
}
