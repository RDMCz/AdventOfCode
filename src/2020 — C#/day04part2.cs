using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using static System.Console;

namespace AOC4_1
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
                passports[passportIndex] += " " + currentLine;
            }
            
            List<Passport> completePassports = new List<Passport>();

            foreach (string pass in passports) {
                if (String.IsNullOrEmpty(pass)) break;
                if (pass.Contains("byr:") && pass.Contains("iyr:") && pass.Contains("eyr:") && pass.Contains("hgt:") && pass.Contains("hcl:") && pass.Contains("ecl:") && pass.Contains("pid:")) {
                    completePassports.Add(new Passport(pass));
                }
            }

            int correctPassports = 0;

            foreach (var pass in completePassports) { 
                WriteLine(pass);
                if (pass.IsValid()) correctPassports++;
            }

            WriteLine($"\nsprávných pasů:\n{correctPassports}");
        }
    }

    class Passport
    {
        string byr;
        string iyr;
        string eyr;
        string hgt;
        string hcl;
        string ecl;
        string pid;

        public Passport(string pass)
        {
            byr = ExtractInfo("byr", pass);
            iyr = ExtractInfo("iyr", pass);
            eyr = ExtractInfo("eyr", pass);
            hgt = ExtractInfo("hgt", pass);
            hcl = ExtractInfo("hcl", pass);
            ecl = ExtractInfo("ecl", pass);
            pid = ExtractInfo("pid", pass);
        }

        public override string ToString() => $"---\nbyr:{byr} iyr:{iyr} eyr:{eyr} hgt:{hgt} hcl:{hcl} ecl:{ecl} pid:{pid}";

        string ExtractInfo(string what, string pass)
        {
            string rtrn = "";
            int index = pass.IndexOf(what) + 4;

            while (true) {
                if (index >= pass.Length) break;
                if (pass[index] == ' ') break;
                rtrn += pass[index];
                index++;
            }

            return rtrn;
        }

        public bool IsValid()
        {
            WriteLine($"validace: {byr.Length}");

            if (byr.Length != 4) return false;
            if (!int.TryParse(byr, out _)) return false;
            int byrParsed = int.Parse(byr);
            if (byrParsed < 1920 || byrParsed > 2002) return false;
            WriteLine("byr ok");

            if (iyr.Length != 4) return false;
            if (!int.TryParse(iyr, out _)) return false;
            int iyrParsed = int.Parse(iyr);
            if (iyrParsed < 2010 || iyrParsed > 2020) return false;
            WriteLine("iyr ok");

            if (eyr.Length != 4) return false;
            if (!int.TryParse(eyr, out _)) return false;
            int eyrParsed = int.Parse(eyr);
            if (eyrParsed < 2020 || eyrParsed > 2030) return false;
            WriteLine("eyr ok");

            string height = "";
            string unit = "";
            foreach (char ch in hgt) if (char.IsDigit(ch)) height += ch; else unit += ch;
            if (!int.TryParse(height, out _)) return false;
            if (unit != "cm" && unit != "in") return false;
            int heightParsed = int.Parse(height);
            if (unit == "cm") if (heightParsed < 150 || heightParsed > 193) return false;
            if (unit == "in") if (heightParsed < 59 || heightParsed > 76) return false;
            WriteLine("hgt ok");

            if (hcl.Length != 7 || hcl[0] != '#') return false;
            for (int i = 1; i < 7; i++) {
                char ch = hcl[i];
                if (!char.IsDigit(ch) && ch != 'a' && ch != 'b' && ch != 'c' && ch != 'd' && ch != 'e' && ch != 'f') return false;
            }
            WriteLine("hcl ok");

            if (ecl != "amb" && ecl != "blu" && ecl != "brn" && ecl != "gry" && ecl != "grn" && ecl != "hzl" && ecl != "oth") return false;
            WriteLine("ecl ok");

            if (pid.Length != 9) return false;
            foreach (char ch in pid) if (!char.IsDigit(ch)) return false;
            WriteLine("pid ok");

            return true;
        }
    }
}
