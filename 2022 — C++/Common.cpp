#include "AdventOfCode.hpp"

#include <fstream>

const void AdventOfCode::getInput(std::string day) {
	if (lastInputName == day) return;

	input.clear();

	std::string fileLine;

	std::ifstream FileReader("input/" + day + ".txt");

	while (getline(FileReader, fileLine)) {
		input.push_back(fileLine);
	}

	FileReader.close();

	lastInputName = day;
}

/*
#include "AdventOfCode.hpp"

#include <iostream>

#define print(x) std::cout << x << "\n"

const void AdventOfCode::day0part1() {
	getInput("day0ex");

	for (const std::string& line : input) {
		print(line);
	}
}
*/
