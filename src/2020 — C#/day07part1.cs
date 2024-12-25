using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using static System.Console;

namespace AOC7
{
    struct Bag
    {
        public string name;
        public List<string> contains;
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

                if (entry.Substring(0, 10) == "shiny gold") continue;

                string bagName = "";
                int bagContainsStartIndex = 0;

                for (int j = 0; j < entry.Length; j++) {
                    if (entry.Substring(j, 14) == " bags contain ") {
                        bagContainsStartIndex = j + 14;
                        break;
                    }
                    bagName += entry[j];
                }
                
                List<string> bagContains = new List<string>();

                for (int j = bagContainsStartIndex; j < entry.Length; j++) {
                    string bagContainsToAdd = "";
                    if (char.IsDigit(entry[j])) {
                        for (int k = j + 2; k < entry.Length; k++) {
                            if (entry.Substring(k, 4) == " bag") {
                                break;
                            }
                            bagContainsToAdd += entry[k];
                        }
                    }
                    if (!String.IsNullOrEmpty(bagContainsToAdd)) bagContains.Add(bagContainsToAdd);
                }

                Bag bag = new Bag() { name = bagName, contains = bagContains };
                bags.Add(bag);
            }

            int result = 0;

            foreach (var bag in bags) {
                if (bag.contains.Any()) {
                    if (Search(bags, bag.name)) result++;
                }
            }

            WriteLine(result);
        }

        static bool Search(List<Bag> bags, string bagName)
        {
            var bag = bags.Single(x => x.name == bagName);

            foreach (var innerBag in bag.contains) {
                if (innerBag == "shiny gold") return true;
                if (Search(bags, innerBag)) return true;
            }

            return false;
        }
    }
}
