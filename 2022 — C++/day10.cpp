#include "AdventOfCode.hpp"

#include <iostream>

const void AdventOfCode::day10() {
	getInput("day10");

	std::vector<std::string> oneCycleConverted;

	for (const std::string& line : input) {
		if (line[0] == 'a') {
			oneCycleConverted.push_back("noop");
		}
		oneCycleConverted.push_back(line);
	}

	int duringCycle = 1;
	int X = 1;
	int sum = 0;

	bool pixels[240]{};
	pixels[0] = true;

	for (const std::string& line : oneCycleConverted) {
		if (line[0] != 'n') {
			X += stoi(line.substr(5));
		}
		if (duringCycle % 40 >= X - 1 && duringCycle % 40 <= X + 1) {
			pixels[duringCycle] = true;
		}
		duringCycle++;
		if ((duringCycle + 20) % 40 == 0) {
			sum += duringCycle * X;
		} 
	}

	std::cout << "part1: " << sum << "\npart2:\n";

	for (int i = 0; i < 240; i++) {
		std::cout << ((pixels[i]) ? (char)219 : ' ');
		std::cout << ((pixels[i]) ? (char)219 : ' ');
		if ((i + 1) % 40 == 0) {
			std::cout << "\n";
		}
	}

	std::cout << "\n";
}
