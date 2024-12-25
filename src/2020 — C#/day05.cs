using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using static System.Console;

namespace AOC5
{
    class Program
    {
        static void Main(string[] args)
        {
            string path = Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location), @"Data\..\..\..\..\");
            string[] inputFile = System.IO.File.ReadAllLines(path + "in.txt");

            int inputLength = inputFile.Length;

            int highestSeatID = 0;

            List<int> seatIDs = new List<int>();

            for (int i = 0; i < inputLength; i++) {
                string _row = "";
                string _column = "";

                foreach (char ch in inputFile[i].Substring(0, 7)) _row += (ch == 'B') ? 1 : 0;
                foreach (char ch in inputFile[i].Substring(7)) _column += (ch == 'R') ? 1 : 0;

                int row = Convert.ToInt32(_row, 2);
                int column = Convert.ToInt32(_column, 2);

                int seatID = row * 8 + column;

                if (seatID > highestSeatID) highestSeatID = seatID;

                seatIDs.Add(seatID);
            }

            WriteLine($"Nejvyšší ID: {highestSeatID}");

            seatIDs.Sort();
            for (int i = 1; i < seatIDs.Count; i++) {
                if (seatIDs[i] != seatIDs[i - 1] + 1) WriteLine($"Moje ID: {seatIDs[i - 1] + 1}");
            }
        }
    }
}
