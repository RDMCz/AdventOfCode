using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using static System.Console;

namespace AOC11
{
    class Program
    {
        static void Main(string[] args)
        {
            string path = Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location), @"Data\..\..\..\..\");
            string[] inputFile = File.ReadAllLines(path + "in.txt");

            Seats seats = new Seats(inputFile);
            WriteLine(seats.Part1());
            WriteLine(seats.Part2());
        }
    }

    class Seats
    {
        char[,] input;
        int width;
        int heigth;

        public Seats(string[] inputFile)
        {
            width = inputFile[0].Length;
            heigth = inputFile.Length;
            input = new char[width, heigth];
            for (int i = 0; i < heigth; i++) {
                for (int j = 0; j < width; j++) {
                    input[j, i] = inputFile[i][j];
                }
            }
        }

        public int Part2()
        {
            var nextInput = Simulate(input);
            char[,] prevInput;
            while (true) {
                prevInput = nextInput;
                nextInput = Simulate2(nextInput);
                string nextInputStr = "";
                string prevInputStr = "";
                foreach (var v in prevInput) prevInputStr += v;
                foreach (var v in nextInput) nextInputStr += v;
                if (nextInputStr == prevInputStr) break;
            }

            int occupied = 0;

            foreach (var v in nextInput) if (v == '#') occupied++;

            return occupied;
        }

        char[,] Simulate2(char[,] input)
        {
            char[,] newInput = (char[,])input.Clone();

            for (int i = 0; i < heigth; i++) {
                for (int j = 0; j < width; j++) {
                    char place = input[j, i];
                    if (place == '.') continue;

                    string neighbours = "";

                    for (int k = 1; ; k++) {
                        if (j - k < 0 || i - k < 0) break;
                        if (input[j - k, i - k] == '.') continue;
                        neighbours += input[j - k, i - k];
                        break;
                    }
                    for (int k = 1; ; k++) {
                        if (i - k < 0) break;
                        if (input[j, i - k] == '.') continue;
                        neighbours += input[j, i - k];
                        break;
                    }
                    for (int k = 1; ; k++) {
                        if (j + k > width - 1 || i - k < 0) break;
                        if (input[j + k, i - k] == '.') continue;
                        neighbours += input[j + k, i - k];
                        break;
                    }
                    for (int k = 1; ; k++) {
                        if (j + k > width - 1) break;
                        if (input[j + k, i] == '.') continue;
                        neighbours += input[j + k, i];
                        break;
                    }
                    for (int k = 1; ; k++) {
                        if (j + k > width - 1 || i + k > heigth - 1) break;
                        if (input[j + k, i + k] == '.') continue;
                        neighbours += input[j + k, i + k];
                        break;
                    }
                    for (int k = 1; ; k++) {
                        if (i + k > heigth - 1) break;
                        if (input[j, i + k] == '.') continue;
                        neighbours += input[j, i + k];
                        break;
                    }
                    for (int k = 1; ; k++) {
                        if (j - k < 0 || i + k > heigth - 1) break;
                        if (input[j - k, i + k] == '.') continue;
                        neighbours += input[j - k, i + k];
                        break;
                    }
                    for (int k = 1; ; k++) {
                        if (j - k < 0) break;
                        if (input[j - k, i] == '.') continue;
                        neighbours += input[j - k, i];
                        break;
                    }

                    int occupiedNeighbours = 0;
                    foreach (var v in neighbours) if (v == '#') occupiedNeighbours++;

                    if (place == 'L') if (occupiedNeighbours == 0) newInput[j, i] = '#';
                    if (place == '#') if (occupiedNeighbours >= 5) newInput[j, i] = 'L';
                }
            }

            return newInput;
        }

        public int Part1()
        {
            var nextInput = Simulate(input);
            char[,] prevInput;

            while (true) {
                prevInput = nextInput;
                nextInput = Simulate(nextInput);
                string nextInputStr = "";
                string prevInputStr = "";
                foreach (var v in prevInput) prevInputStr += v;
                foreach (var v in nextInput) nextInputStr += v;
                if (nextInputStr == prevInputStr) break;
            }

            int occupied = 0;

            foreach (var v in nextInput) if (v == '#') occupied++;

            return occupied;
        }

        char[,] Simulate(char[,] input)
        {
            char[,] newInput = (char[,])input.Clone();

            for (int i = 0; i < heigth; i++) {
                for (int j = 0; j < width; j++) {
                    char place = input[j, i];
                    if (place == '.') continue;

                    string neighbours = "";

                    neighbours += (j == 0 || i == 0) ? 'E' : input[j-1, i-1];
                    neighbours += (i == 0) ? 'E' : input[j, i-1];
                    neighbours += (j == width - 1 || i == 0) ? 'E' : input[j+1, i-1];
                    neighbours += (j == width - 1) ? 'E' : input[j+1, i];
                    neighbours += (j == width - 1 || i == heigth - 1) ? 'E' : input[j+1, i+1];
                    neighbours += (i == heigth - 1) ? 'E' : input[j, i+1];
                    neighbours += (j == 0 || i == heigth - 1) ? 'E' : input[j-1, i+1];
                    neighbours += (j == 0) ? 'E' : input[j-1, i];

                    int occupiedNeighbours = 0;
                    foreach (var v in neighbours) if (v == '#') occupiedNeighbours++;

                    if (place == 'L') if (occupiedNeighbours == 0) newInput[j, i] = '#';
                    if (place == '#') if (occupiedNeighbours >= 4) newInput[j, i] = 'L';
                }
            }

            return newInput;
        }
    }
}
