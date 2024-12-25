using System;
using System.IO;
using System.Linq;
using System.Reflection;
using static System.Console;

namespace AOC3_1
{
    class Program
    {
        static void Main(string[] args)
        {
            string path = Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location), @"Data\..\..\..\..\");
            string[] inputFile = System.IO.File.ReadAllLines(path + "in.txt");

            int inputLength = inputFile.Length;

            bool[,] toboggan = new bool[inputLength, inputFile[0].Length];

            for (int i = 0; i < inputLength; i++) {
                int j = 0;
                foreach (char ch in inputFile[i]) {
                    toboggan[i, j++] = ch == '.' ? false : true;
                }
            }

            ulong slopesTreesHitMultiplied = SlopeCheck(1, 1, toboggan) * SlopeCheck(3, 1, toboggan) * SlopeCheck(5, 1, toboggan) * SlopeCheck(7, 1, toboggan) * SlopeCheck(1, 2, toboggan);

            WriteLine(slopesTreesHitMultiplied);
        }

        static ulong SlopeCheck(int right, int down, bool[,] toboggan)
        {
            ulong treesHit = 0;
            int xCor = 0;
            int yLen = toboggan.GetLength(0);
            int xLen = toboggan.GetLength(1);

            for (int yCor = 0; yCor < yLen; yCor += down) {
                if (toboggan[yCor, xCor]) treesHit++;
                for (int i = 0; i < right; i++) {
                    xCor++;
                    if (xCor >= xLen) xCor = 0;
                }
            }

            return treesHit;
        }
    }
}
