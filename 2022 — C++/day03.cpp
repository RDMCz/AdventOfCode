#include "AdventOfCode.hpp"

#include <iostream>

const void AdventOfCode::day03part1() {
	getInput("day03");

	int sum = 0;

	for (const std::string& line : input) {
		int lineLen = line.length();
		int compLen = lineLen / 2;
		bool occurences[53] = {};

		for (int i = 0; i < lineLen; i++) {
			char ch = line[i];
			int itemPriority = (islower(ch)) ? ch - 96 : ch - 38;
			if (i < compLen) {
				occurences[itemPriority] = true;
			}
			else {
				if (occurences[itemPriority]) {
					sum += itemPriority;
					break;
				}
			}
		}
	}

	std::cout << sum << "\n";
}

const void AdventOfCode::day03part2() {
	getInput("day03");

	int sum = 0;

	int nLines = input.size();

	for (int g = 0; g < nLines; g += 3) {
		int occurences[53] = {};
		for (int l = 0; l < 3; l++) {
			std::string line = input[g + l];
			int lineLen = line.length();
			for (int i = 0; i < lineLen; i++) {
				char ch = line[i];
				int itemPriority = (islower(ch)) ? ch - 96 : ch - 38;
				if (occurences[itemPriority] == l) {
					if (l == 2) {
						sum += itemPriority;
						break;
					}
					occurences[itemPriority]++;
				}
			}
		}
	}

	std::cout << sum << "\n";
}
