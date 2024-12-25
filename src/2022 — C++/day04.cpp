#include "AdventOfCode.hpp"

#include <iostream>
#include <sstream>

const void AdventOfCode::day04() {
	getInput("day04");

	int sum1 = 0;
	int sum2 = 0;

	for (const std::string& line : input) {
		std::stringstream ss(line);
		std::string item;
		int sections[4];
		int index = 0;
		bool charswitch = true;

		while (getline(ss, item, (charswitch) ? '-' : ',')) {
			sections[index++] = stoi(item);
			charswitch = !charswitch;
		}

		if (sections == NULL) {}
		else if (sections[0] == sections[2] || sections[1] == sections[3]) {
			sum1++;
			sum2++;
		}
		else if (sections[0] <= sections[2]) {
			if (sections[1] >= sections[3]) {
				sum1++;		
			}
			if (sections[1] >= sections[2]) {
				sum2++;
			}
		}
		else {
			if (sections[3] >= sections[1]) {
				sum1++;
			}
			if (sections[3] >= sections[0]) {
				sum2++;
			}
		}
	}

	std::cout << "part1: " << sum1 << "\npart2: " << sum2 << "\n";
}
