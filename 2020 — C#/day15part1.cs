using System.IO;
using System.Reflection;
using static System.Console;

namespace AOC15
{
    class Program
    {
        static void Main(string[] args)
        {
            string path = Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location), @"Data\..\..\..\..\");
            string[] inputFile = File.ReadAllLines(path + "in.txt");

            AOC15 aoc15 = new AOC15(inputFile);
            WriteLine(aoc15.Part1());
        }
    }

    class AOC15
    {
        int[] input;
        int startIndex;

        public AOC15(string[] inputFile)
        {
            input = new int[2020];
            int i = 0;
            foreach (var v in inputFile[0].Split(',')) input[i++] = int.Parse($"{v}");
            startIndex = i;
        }

        public string Part1()
        {
            for (int i = startIndex; i < 2020; i++) {
                int before = input[i - 1];
                bool firstTime = true;
                int difference = 0;
                for (int j = i - 2; j >= 0; j--) {
                    if (input[j] == before) {
                        firstTime = false;
                        difference = (i - 1) - j;
                        break;
                    }
                }
                input[i] = (firstTime) ? 0 : difference;
            }

            return $"{input[2019]}";
        }

    }
}
