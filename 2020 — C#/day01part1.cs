using System;
using System.IO;
using System.Reflection;
using static System.Console;

namespace AOC1
{
    class Program
    {
        static void Main(string[] args)
        {
            string path = Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location), @"Data\..\..\..\..\");
            string[] inputFile = System.IO.File.ReadAllLines(path + "in.txt");

            int inputLength = inputFile.Length;
            int[] parsedInput = new int[inputLength];

            for (int i = 0; i < inputLength; i++) parsedInput[i] = int.Parse(inputFile[i]);

            for (int i = 0; i < inputLength; i++) {

                for (int j = i + 1; j < inputLength; j++) {
                    
                    if (parsedInput[i] + parsedInput[j] == 2020) {
                        WriteLine($"{parsedInput[i] * parsedInput[j]}");
                        ReadLine();
                    }

                }

            }
        }
    }
}
