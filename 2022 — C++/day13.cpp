#include "AdventOfCode.hpp"

#include <iostream>
#include <regex>

const void AdventOfCode::day13part1() {
	getInput("day13");
	int inputLen = input.size();

	int sum = 0;
	int pairNum = 1;

	for (int i = 0; i < inputLen; i += 3) {
		std::string left = input[i].substr(1, input[i].length() - 2);
		std::string right = input[i + 1].substr(1, input[i + 1].length() - 2);
		
		left = std::regex_replace(left, std::regex("10"), "A");
		right = std::regex_replace(right, std::regex("10"), "A");
		
		if (day13Compare(left, right) == 1) {
			sum += pairNum;
		}
		pairNum++;
	}

	std::cout << sum << "\n";
}

const void AdventOfCode::day13part2() {
	getInput("day13");

	std::vector<std::string> formatted;
	for (const std::string& line : input) {
		if (line.empty()) continue;
		formatted.push_back(std::regex_replace(line.substr(1, line.length() - 2), std::regex("10"), "A"));
	}
	formatted.push_back("[2]");
	formatted.push_back("[6]");
	
	std::sort(formatted.begin(), formatted.end(), [&](std::string& s1, std::string& s2) {
		return (day13Compare(s1, s2) == 1) ? true : false;
	});

	int result = (find(formatted.begin(), formatted.end(), "[2]") - formatted.begin() + 1) * (find(formatted.begin(), formatted.end(), "[6]") - formatted.begin() + 1);
	std::cout << result << "\n";
}

const int AdventOfCode::day13Compare(std::string& left, std::string& right) {
	int leftLen = left.length();
	int rightLen = right.length();
	bool isLeftShorter = (leftLen < rightLen);
	int currLen = (isLeftShorter) ? leftLen : rightLen;

	for (int i = 0; i < currLen; i += 2) {
		if (i >= currLen) break;
		
		char l = left[i];
		char r = right[i];

		if (l == '[' || r == '[') {
			std::string innerLeft;
			std::string innerRight;
			int newIndex = i;

			if (l == '[') {
				int openedBrackets = 1;
				for (int j = i + 1; openedBrackets > 0; j++) {
					char inner = left[j];
					if (inner == '[') openedBrackets++;
					else if (inner == ']') openedBrackets--;
					if (openedBrackets > 0) innerLeft += inner;
					else newIndex = j;
				}
			}
			else innerLeft = l;
			
			if (r == '[') {
				int openedBrackets = 1;
				for (int j = i + 1; openedBrackets > 0; j++) {
					char inner = right[j];
					if (inner == '[') openedBrackets++;
					else if (inner == ']') openedBrackets--;
					if (openedBrackets > 0) innerRight += inner;
					else newIndex = j;
				}
			}
			else innerRight = r;

			int innerResult = day13Compare(innerLeft, innerRight);
			if (innerResult != 0) return innerResult;

			i = newIndex;
		}
		else if (l < r) {
			return 1;
		}
		else if (l > r) {
			return -1;
		}
	}
	
	return (isLeftShorter) ? 1 : (leftLen > rightLen) ? -1 : 0;
}
