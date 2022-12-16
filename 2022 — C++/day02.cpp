#include "AdventOfCode.hpp"

#include <iostream>

const void AdventOfCode::day02part1() {
	getInput("day02");

	int totalScore = 0;

	for (const std::string& line : input) {
		char elf = line[0];
		char human = line[2];

		int scoreShape = human - 'W';
		int result = scoreShape - (elf - '@');
		if (abs(result) == 2) result /= -2;

		int scoreResult = (result + 1) * 3;

		totalScore += scoreShape + scoreResult;
	}

	std::cout << totalScore << "\n";
}

const void AdventOfCode::day02part2() {
	getInput("day02");

	int totalScore = 0;

	for (const std::string& line : input) {
		char elf = line[0];
		char outcome = line[2];

		int scoreResult = (outcome - 'X') * 3;
		int outcomeOperation = outcome - 'Y';
		int scoreShape = ((elf - 'A') + outcomeOperation) % 3;
		if (scoreShape == -1) scoreShape = 2;

		totalScore += scoreShape + 1 + scoreResult;
	}

	std::cout << totalScore << "\n";
}
