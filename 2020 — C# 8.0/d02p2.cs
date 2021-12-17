using System;
using System.IO;
using System.Linq;
using System.Reflection;
using static System.Console;

namespace AOC2_1
{
    class Program
    {
        static void Main(string[] args)
        {
            string path = Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location), @"Data\..\..\..\..\");
            string[] inputFile = System.IO.File.ReadAllLines(path + "in.txt");

            int inputLength = inputFile.Length;

            int correctPasswords = 0;

            for (int i = 0; i < inputLength; i++) {

                string entry = inputFile[i];

                string first = "", second = "", pass = "";
                char letter = ' ';
                bool minMaxSwitch = false;
                int passStart = 0;

                for (int ch = 0; ch < entry.Length; ch++) {
                    if (entry[ch] == '-') minMaxSwitch = true;
                    else if (entry[ch] == ' ') {
                        letter = entry[ch + 1];
                        passStart = ch + 4;
                        pass = entry.Substring(passStart);
                        break;
                    }
                    else {
                        if (!minMaxSwitch) first += entry[ch];
                        else second += entry[ch];
                    }
                }

                bool firstCorrect = entry[passStart + int.Parse(first) - 1] == letter;
                bool secondCorrect = entry[passStart + int.Parse(second) - 1] == letter;

                if (firstCorrect && !secondCorrect || !firstCorrect  && secondCorrect) correctPasswords++;
            }

            WriteLine(correctPasswords);
        }
    }
}
