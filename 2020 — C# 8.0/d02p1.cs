using System;
using System.IO;
using System.Linq;
using System.Reflection;
using static System.Console;

namespace AOC2
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

                string min = "", max = "", pass = "";
                char letter = ' ';
                bool minMaxSwitch = false;
                
                for (int ch = 0; ch < entry.Length; ch++) {
                    if (entry[ch] == '-') minMaxSwitch = true;
                    else if (entry[ch] == ' ') {
                        letter = entry[ch + 1];
                        pass = entry.Substring(ch + 4);
                        break;
                    }
                    else {
                        if (!minMaxSwitch) min += entry[ch];
                        else max += entry[ch];
                    }
                }

                int letterCount = pass.Count(x => x == letter);

                if (letterCount >= int.Parse(min) && letterCount <= int.Parse(max)) correctPasswords++;
            }

            WriteLine(correctPasswords);
        }
    }
}
