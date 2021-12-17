using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using static System.Console;

namespace AOC6_1
{
    class Program
    {
        static void Main(string[] args)
        {
            string path = Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location), @"Data\..\..\..\..\");
            string[] inputFile = System.IO.File.ReadAllLines(path + "in.txt");

            int inputLength = inputFile.Length;

            string[] entries = new string[inputFile.Count(x => x == "") + 1];
            int[] groups = new int[entries.Length];
            int entriesIndex = 0;

            for (int i = 0; i < inputLength; i++) {
                if (inputFile[i] == "") {
                    entriesIndex++;
                    continue;
                }
                entries[entriesIndex] += inputFile[i];
                groups[entriesIndex]++;
            }

            int sum = 0;

            for (int i = 0; i < entries.Length; i++) {
                foreach (char ch in "abcdefghijklmnopqrstuvwxyz") {
                    if (entries[i].Count(x => x == ch) == groups[i]) {
                        sum++;
                    }
                }
            }

            WriteLine(sum);
        }
    }
}
