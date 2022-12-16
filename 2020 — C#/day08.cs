using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using static System.Console;

namespace AOC8
{
    class Program
    {
        static void Main(string[] args)
        {
            string path = Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location), @"Data\..\..\..\..\");
            string[] inputFile = System.IO.File.ReadAllLines(path + "in.txt");

            Handheld handheld = new Handheld(inputFile);
            handheld.Run();

            HandheldPart2 handheld2 = new HandheldPart2(inputFile);
            handheld2.Run();
        }
    }

    // PART 2
    class HandheldPart2
    {
        int accelerator;
        List<int> usedIndexes;
        List<(string, char, int)> input;

        public HandheldPart2(string[] rawInput)
        {
            input = new List<(string, char, int)>();
            accelerator = 0;
            usedIndexes = new List<int>();

            foreach (var v in rawInput) {
                var splitted = v.Split(' ');
                input.Add((splitted[0], splitted[1][0], int.Parse(splitted[1][1..])));
            }
        }

        public void Run()
        {
            int i = 0;

            while (true) {
                usedIndexes.Add(i);
                string instruction = input[i].Item1;
                int value = input[i].Item3;
                if (input[i].Item2 == '-') value *= -1;
                if (instruction == "acc") {
                    accelerator += value;
                    i++;
                }
                else {
                    if (ChangeAndCheckIfPossible(i, accelerator, usedIndexes, instruction, value)) break;
                    else {
                        if (instruction == "nop") i++;
                        else i += value;
                    }
                }
            }
        }

        public bool ChangeAndCheckIfPossible(int i, int accelerator, List<int> usedIndexes, string startInstruciton, int startValue)
        {
            List<int> _usedIndexes = usedIndexes;
            int _i = i;
            int _acc = accelerator;

            if (startInstruciton == "nop") _i += startValue; else _i++;

            while (true) {
                if (_i == input.Count()) {
                    WriteLine(_acc);
                    return true;
                }
                if (_usedIndexes.Contains(_i)) return false;
                _usedIndexes.Add(_i);

                string instruction = input[_i].Item1;
                int value = input[_i].Item3;
                if (input[_i].Item2 == '-') value *= -1;

                if (instruction == "nop") {
                    _i++;
                }
                else if (instruction == "acc") {
                    _acc += value;
                    _i++;
                }
                else { // jmp
                    _i += value;
                }
            }
        }
    }

    // PART 1
    class Handheld
    {
        int accelerator;
        string[] input;
        List<int> usedIndexes;

        public Handheld(string[] input)
        {
            this.input = input;
            accelerator = 0;
            usedIndexes = new List<int>();
        }

        public void Run()
        {
            int i = 0;

            while (true) {
                if (usedIndexes.Contains(i)) {
                    WriteLine(accelerator);
                    break;
                }
                usedIndexes.Add(i);
                string instruction = input[i].Split(' ')[0];
                if (instruction  == "nop") {
                    i++;
                    continue;
                }
                string parameter = input[i].Split(' ')[1];
                char sign = parameter[0];
                int value = int.Parse(parameter.Substring(1));
                if (instruction == "acc") {
                    accelerator += (sign == '+') ? value : -value;
                    i++;
                }
                else { // jmp
                    i += (sign == '+') ? value : -value;
                }
            }
        }
    }
}
