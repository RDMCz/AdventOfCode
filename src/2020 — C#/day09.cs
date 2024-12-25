using System;
using System.IO;
using System.Reflection;
using static System.Console;

namespace AOC9
{
    class Program
    {
        static void Main(string[] args)
        {
            string path = Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location), @"Data\..\..\..\..\");
            string[] inputFile = File.ReadAllLines(path + "in.txt");

            XMAS xmas = new XMAS(inputFile);
            WriteLine(xmas.Part1());
            WriteLine(xmas.Part2());
        }
    }

    class XMAS
    {
        long[] input;
        int len;

        public XMAS(string[] input)
        {
            len = input.Length;
            this.input = new long[len];
            for (int i = 0; i < len; i++) this.input[i] = long.Parse(input[i]);
        }

        public long Part1()
        {
            for (int i = 25; i < input.Length; i++) {
                if (!CheckPreamble(input[(i - 25)..(i)], input[i])) {
                    return input[i];
                }
            }
            return -1;
        }

        bool CheckPreamble(long[] preamble, long number)
        {
            for (int i = 0; i < 25; i++) {
                for (int j = i + 1; j < 25; j++) {
                    if (preamble[i] + preamble[j] == number) {
                        return true;
                    }
                }
            }
            return false;
        }

        public long Part2()
        {
            long number = Part1();

            for (int i = 0; i < len; i++) {
                long sum = input[i];
                for (int j = i + 1; j < len; j++) {
                    sum += input[j];
                    if (sum == number) {
                        long min = input[i];
                        long max = input[i];
                        foreach (var v in input[(i)..(j + 1)]) {
                            if (v < min) min = v;
                            if (v > max) max = v;
                        }
                        return min + max;
                    }
                }
            }

            return -1;
        }
    }
}
