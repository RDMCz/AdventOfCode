#include "AdventOfCode.hpp"

#include <iostream>

const void AdventOfCode::day01part1() {
	getInput("day01");

	int max = 0;
	int sum = 0;

	for (const std::string& line : input) {
		if (!line.empty()) {
			int numLine = std::stoi(line);
			sum += numLine;
		}
		else {
			if (sum > max) {
				max = sum;
			}
			sum = 0;
		}
	}

	std::cout << max << "\n";
}

const void AdventOfCode::day01part2() {
	getInput("day01");

	int sumCumulate = 0;
	std::vector<int> sums;

	for (const std::string& line : input) {
		if (!line.empty()) {
			int numLine = std::stoi(line);
			sumCumulate += numLine;
		}
		else {
			sums.push_back(sumCumulate);
			sumCumulate = 0;
		}
	}

	std::sort(sums.begin(), sums.end(), std::greater<int>());

	int sumsum = 0;

	for (int i = 0; i < 3; sumsum += sums[i++]);

	std::cout << sumsum << "\n";
}
