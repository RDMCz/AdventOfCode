using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using static System.Console;

namespace AOC4
{
    class Program
    {
        static void Main(string[] args)
        {
            string path = Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location), @"Data\..\..\..\..\");
            string[] inputFile = System.IO.File.ReadAllLines(path + "in.txt");

            int inputLength = inputFile.Length;

            string[] passports = new string[inputLength];
            int passportIndex = 0;
            for (int i = 0; i < inputLength; i++) {
                string currentLine = inputFile[i];
                if (currentLine == "") {
                    passportIndex++;
                    continue;
                }
                passports[passportIndex] += currentLine;
            }

            int validPassports = 0;

            foreach (string pass in passports) {
                if (String.IsNullOrEmpty(pass)) break;
                if (pass.Contains("byr:") && pass.Contains("iyr:") && pass.Contains("eyr:") && pass.Contains("hgt:") && pass.Contains("hcl:") && pass.Contains("ecl:") && pass.Contains("pid:"))
                    validPassports++;
            }

            WriteLine(validPassports);
        }
    }
}
