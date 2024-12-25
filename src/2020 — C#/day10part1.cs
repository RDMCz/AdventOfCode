using System.Collections.Generic;
using System.IO;
using System.Reflection;
using static System.Console;

namespace AOC10
{
    class Program
    {
        static void Main(string[] args)
        {
            string path = Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location), @"Data\..\..\..\..\");
            string[] inputFile = File.ReadAllLines(path + "in.txt");

            Adapters adapters = new Adapters(inputFile);
            WriteLine(adapters.Part1());
        }
    }

    class Adapters
    {
        List<int> input;
        int len;
        int deviceNeed;

        public Adapters(string[] input)
        {
            len = input.Length;
            this.input = new List<int>();
            for (int i = 0; i < len; i++) this.input.Add(int.Parse(input[i]));

            deviceNeed = 0;
            foreach (var v in this.input) if (v > deviceNeed) deviceNeed = v;
            deviceNeed += 3;
            this.input.Add(deviceNeed);
            len++;
        }

        public int Part1()
        {
            int currentAdapter = 0;
            int jumpOne = 0;
            int jumpThree = 0;
            List<int> usedAdapters = new List<int>();
            bool resetSearch;

            while (true) {
                if (usedAdapters.Count == len) return jumpOne * jumpThree;

                resetSearch = false;

                for (int i = 0; i < len; i++) {
                    if (usedAdapters.Contains(i)) {
                        continue;
                    }
                    if (input[i] == currentAdapter + 1) {
                        currentAdapter++;
                        jumpOne++;
                        usedAdapters.Add(i);
                        resetSearch = true;
                        break;
                    }
                }

                if (resetSearch) continue;

                for (int i = 0; i < len; i++) {
                    if (usedAdapters.Contains(i)) {
                        continue;
                    }
                    if (input[i] == currentAdapter + 2) {
                        currentAdapter += 2;
                        usedAdapters.Add(i);
                        resetSearch = true;
                        break;
                    }
                }

                if (resetSearch) continue;

                for (int i = 0; i < len; i++) {
                    if (usedAdapters.Contains(i)) {
                        continue;
                    }
                    if (input[i] == currentAdapter + 3) {
                        currentAdapter += 3;
                        jumpThree++;
                        usedAdapters.Add(i);
                        break;
                    }
                }
            }
        }
    }
}
