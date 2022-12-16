using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using static System.Console;

namespace AOC14
{
    class Program
    {
        static void Main(string[] args)
        {
            string path = Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location), @"Data\..\..\..\..\");
            string[] inputFile = File.ReadAllLines(path + "in.txt");

            AOC14 aoc14 = new AOC14(inputFile);
            WriteLine(aoc14.Part1());
            WriteLine(aoc14.Part2());
        }
    }

    class AOC14
    {
        (string, string, int, int)[] input;
        int len;

        public AOC14(string[] inputFile)
        {
            len = inputFile.Length;
            input = new (string, string, int, int)[len];

            for (int i = 0; i < len; i++) {
                (string, string, int, int) temp = ("", "", 0, 0);
                temp.Item1 = "mask";
                if (inputFile[i][0..3] == "mas") {
                    temp.Item1 = "mask";
                    temp.Item2 = inputFile[i][7..];
                }
                else if (inputFile[i][0..3] == "mem") {
                    temp.Item1 = "mem";
                    string index = "0";
                    string value = "0";
                    bool charSwitch = true;
                    for (int j = 4; j < inputFile[i].Length; j++) {
                        char ch = inputFile[i][j];
                        if (charSwitch) {
                            if (Char.IsDigit(ch)) index += ch;
                            else charSwitch = false;
                        }
                        else {
                            if (Char.IsDigit(ch)) value += ch;
                        }
                    }
                    temp.Item3 = int.Parse(index);
                    temp.Item4 = int.Parse(value);
                }
                input[i] = temp;
            }
        }

        public ulong Part1()
        {
            List<(int, ulong)> memory = new List<(int, ulong)>();

            string mask = "";
            
            foreach (var command in input) {
                if (command.Item1 == "mask") mask = command.Item2;
                if (command.Item1 == "mem") {
                    (int, ulong) temp;
                    temp.Item1 = command.Item3;
                    string binary = Convert.ToString(command.Item4, 2).PadLeft(36, '0');
                    string converted = "";

                    for (int i = 35; i >= 0; i--) {                        
                        converted += (mask[i] == 'X') ? binary[i] : mask[i];
                    }

                    char[] reverseTemp = converted.ToCharArray();
                    Array.Reverse(reverseTemp);
                    converted = new string(reverseTemp);

                    temp.Item2 = Convert.ToUInt64(converted, 2);

                    foreach (var v in memory) {
                        if (v.Item1 == temp.Item1) {
                            memory.Remove(v);
                            break;
                        }
                    }

                    memory.Add(temp);
                }
            }

            ulong rtrn = 0;

            foreach (var v in memory) {
                rtrn += v.Item2;
            }

            return rtrn;
        }

        public ulong Part2()
        {
            List<(ulong, ulong)> memory = new List<(ulong, ulong)>();

            string mask = "";

            foreach (var command in input) {
                if (command.Item1 == "mask") mask = command.Item2;
                if (command.Item1 == "mem") {
                    string binary = Convert.ToString(command.Item3, 2).PadLeft(36, '0');
                    string converted = "";

                    for (int i = 35; i >= 0; i--) {
                        converted += (mask[i] == '0') ? binary[i] : mask[i]; 
                    }

                    char[] reverseTemp = converted.ToCharArray();
                    Array.Reverse(reverseTemp);
                    converted = new string(reverseTemp);

                    int xs = converted.Count(x => x == 'X');
                    int possibilities = (int)Math.Pow(2, xs);

                    //WriteLine("\n\n" + mask);

                    for (int i = 0; i < possibilities; i++) {
                        string binaryPossibility = Convert.ToString(i, 2).PadLeft(xs, '0');
                        int xindex = xs - 1;
                        string possibility = "";
                        for (int j = 35; j >= 0; j--) {
                            possibility += (converted[j] == 'X') ? binaryPossibility[xindex--] : converted[j];
                        }
                        char[] reverseTemp2 = possibility.ToCharArray();
                        Array.Reverse(reverseTemp2);
                        possibility = new string(reverseTemp2);
                        //WriteLine(possibility);
                        ulong possibilityInt = Convert.ToUInt64(possibility, 2);
                        //WriteLine(possibilityInt);
                        (ulong, ulong) temp;
                        temp.Item1 = possibilityInt;
                        temp.Item2 = (ulong)command.Item4;

                        foreach (var v in memory) {
                            if (v.Item1 == temp.Item1) {
                                memory.Remove(v);
                                break;
                            }
                        }

                        memory.Add(temp);
                    }
                    /*
                    WriteLine(binary);
                    WriteLine(mask);
                    WriteLine(converted);
                    WriteLine(possibilities);
                    WriteLine();
                    */

                }
            }

            ulong rtrn = 0;

            foreach (var v in memory) {
                rtrn += v.Item2;
            }

            return rtrn;
        }
    }
}
