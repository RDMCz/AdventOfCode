using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using static System.Console;

namespace AOC6
{
    class Program
    {
        static void Main(string[] args)
        {
            string path = Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location), @"Data\..\..\..\..\");
            string[] inputFile = System.IO.File.ReadAllLines(path + "in.txt");

            int inputLength = inputFile.Length;
            
            List<char>[] entries = new List<char>[inputFile.Count(x => x == "") + 1];
            int entriesIndex = 0;

            for (int i = 0; i < entries.Length; i++) entries[i] = new List<char>();

            for (int i = 0; i < inputLength; i++) {
                if (inputFile[i] == "") {
                    entriesIndex++;
                    continue;
                }
                foreach (char ch in inputFile[i]) if (!entries[entriesIndex].Contains(ch)) entries[entriesIndex].Add(ch);
            }

            int sum = 0;

            foreach (var v in entries) sum += v.Count;

            WriteLine(sum);
        }
    }
}
