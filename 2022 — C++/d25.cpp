#include "AdventOfCode.hpp"

#include <iostream>

const void AdventOfCode::day25part1() {
	getInput("day25");
	long long sum = 0;

	for (const std::string& line : input) {
		long long value = 0;
		long long place = 1;
		int lineLen = line.length();
		for (int i = lineLen - 1; i >= 0; i--) {
			char ch = line[i];
			int placeVal{};
			if (ch == '=') placeVal = -2;
			else if (ch == '-') placeVal = -1;
			else placeVal = ch - '0';
			value += place * placeVal;
			place *= 5;
		}
		sum += value;
	}

	long long thresh = 2;
	int power = 0;
	std::string result = "2";

	while (thresh < sum) {
		thresh += 2 * pow(5, ++power);
		result += '2';
	}

	int len = result.length();

	for (int i = 0; i < len; i++) {
		long long powVal = pow(5, power--);
		for (int j = 4; j > 0; j--) {
			if (thresh - (j * powVal) >= sum) {
				thresh -= j * powVal;
				result[i] = (j == 4) ? '=' : (j == 3) ? '-' : (j == 2) ? '0' : '1';
			}
		}
	}

	std::cout << result << "\n";
}
