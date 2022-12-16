using System.Collections.Generic;
using System.IO;
using System.Reflection;
using static System.Console;

namespace AOC13
{
    class Program
    {
        static void Main(string[] args)
        {
            string path = Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location), @"Data\..\..\..\..\");
            string[] inputFile = File.ReadAllLines(path + "in.txt");

            AOC13 aoc13 = new AOC13(inputFile);
            WriteLine(aoc13.Part1());
        }
    }

    class AOC13
    {
        ulong earliest;
        List<ulong> busIDs;
        List<ulong> busTimes;

        public AOC13(string[] inputFile)
        {
            earliest = ulong.Parse(inputFile[0]);

            string[] tempBusIDs = inputFile[1].Split(',');
            busIDs = new List<ulong>();
            foreach (var v in tempBusIDs) if (v != "x") busIDs.Add(ulong.Parse(v));

            busTimes = new List<ulong>();
            for (ulong i = 0; i < (ulong)tempBusIDs.Length; i++) if (tempBusIDs[i] != "x") busTimes.Add(i);
        }                

        public ulong Part1()
        {
            for (ulong i = earliest; ; i++) {
                foreach (var v in busIDs) {
                    if (i % v == 0) {
                        return (i - earliest) * v;
                    }
                }
            }
        }
    }
}
