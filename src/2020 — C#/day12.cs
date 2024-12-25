using System;
using System.Collections.Generic;
using System.IO;
using System.Reflection;
using static System.Console;

namespace AOC12
{
    class Program
    {
        static void Main(string[] args)
        {
            string path = Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location), @"Data\..\..\..\..\");
            string[] inputFile = File.ReadAllLines(path + "in.txt");

            AOC12 aoc12 = new AOC12(inputFile);
            WriteLine(aoc12.Part1());
            WriteLine(aoc12.Part2());
        }
    }

    class AOC12
    {
        (char, int)[] input;
        int len;
        string directions = "NESW";

        public AOC12(string[] inputFile)
        {
            len = inputFile.Length;
            input = new (char, int)[len];
            for (int i = 0; i < len; i++) {
                (char, int) temp;
                temp.Item1 = inputFile[i][0];
                temp.Item2 = int.Parse(inputFile[i][1..]);
                input[i] = temp;
            }
        }

        public int Part2() 
        {
            int east = 0;
            int north = 0;
            int wpEast = 10;
            int wpNorth = 1;

            foreach (var instruction in input) {
                char ch = instruction.Item1;
                int value = instruction.Item2;
                if (ch == 'F') {
                    int eastDiff = wpEast - east;
                    int northDiff  = wpNorth - north;
                    for (int i = 0; i < value; i++) {
                        east += eastDiff;
                        north += northDiff;
                    }
                    wpEast = east + eastDiff;
                    wpNorth = north + northDiff;
                }
                else if (ch == 'N') {
                    wpNorth += value;
                }
                else if (ch == 'E') {
                    wpEast += value;
                }
                else if (ch == 'S') {
                    wpNorth -= value;
                }
                else if (ch == 'W') {
                    wpEast -= value;
                }
                else if (ch == 'L') {
                    int eastDiff = wpEast - east;
                    int northDiff = wpNorth - north;
                    wpEast -= eastDiff;
                    wpNorth -= northDiff;
                    for (int i = 0; i < value; i += 90) {
                        (eastDiff, northDiff) = (northDiff, eastDiff);
                        eastDiff *= -1;
                    }
                    wpEast += eastDiff;
                    wpNorth += northDiff;
                }
                else if (ch == 'R') {
                    int eastDiff = wpEast - east;
                    int northDiff = wpNorth - north;
                    wpEast -= eastDiff;
                    wpNorth -= northDiff;
                    for (int i = 0; i < value; i += 90) {
                        (eastDiff, northDiff) = (northDiff, eastDiff);
                        northDiff *= -1;
                    }
                    wpEast += eastDiff;
                    wpNorth += northDiff;
                }
            }

            return Math.Abs(east) + Math.Abs(north);
        }

        public int Part1()
        {
            char currentDirection = 'E';

            int east = 0;
            int north = 0;

            foreach (var instruction in input) {
                char ch = instruction.Item1;
                int value = instruction.Item2;
                if (ch == 'F') {
                    if (currentDirection == 'N') {
                        north += value;
                    }
                    else if (currentDirection == 'E') {
                        east += value;
                    }
                    else if (currentDirection == 'S') {
                        north -= value;
                    }
                    else if (currentDirection == 'W') {
                        east -= value;
                    }
                }
                else if (ch == 'N') {
                    north += value;
                }
                else if (ch == 'E') {
                    east += value;
                }
                else if (ch == 'S') {
                    north -= value;
                }
                else if (ch == 'W') {
                    east -= value;
                }
                else if (ch == 'L') {
                    int dirIndex = directions.IndexOf(currentDirection);
                    for (int i = 0; i < value; i += 90) {
                        dirIndex--;
                        if (dirIndex < 0) dirIndex = 3;
                    }
                    currentDirection = directions[dirIndex];
                }
                else if (ch == 'R') {
                    int dirIndex = directions.IndexOf(currentDirection);
                    for (int i = 0; i < value; i += 90) {
                        dirIndex++;
                        if (dirIndex > 3) dirIndex = 0;
                    }
                    currentDirection = directions[dirIndex];
                }
            }

            return Math.Abs(east) + Math.Abs(north);
        }
    }
}
