#include "AdventOfCode.hpp"

#include <iostream>
#include <stack>

const void AdventOfCode::day05part1() {
	getInput("day05");

	bool procedure = false;
	std::vector<std::string> crates;
	
	int nStacks{};
	std::stack<char>* stacks = nullptr;

	for (const std::string& line : input) {
		if (!line.empty()) {
			if (!procedure) {
				crates.push_back(line);
			}
			else {
				int nCrates = stoi(line.substr(5));
				auto lineLen = line.length();
				int from = line[lineLen - 6] - '0';
				int to = line[lineLen - 1] - '0';
				from--;
				to--;
				for (int i = 0; i < nCrates; i++) {
					char crate = stacks[from].top();
					stacks[from].pop();
					stacks[to].push(crate);
				}
			}
		}
		else {
			procedure = true;

			std::string stackNums = crates[crates.size() - 1];
			nStacks = stackNums[stackNums.length() - 2] - '0';
			stacks = new std::stack<char>[nStacks];

			for (int i = crates.size() - 2; i >= 0; i--) {
				std::string crateLayer = crates[i];
				int stackIndex = 0;
				for (int ci = 1; ci <= 1 + ((nStacks - 1) * 4); ci += 4) {
					char crateLetter = crateLayer[ci];
					if (crateLetter != ' ') {
						stacks[stackIndex].push(crateLetter);
					}
					stackIndex++;
				}
			}

			crates.clear();
		}
	}

	for (int i = 0; i < nStacks; i++) {
		std::cout << stacks[i].top();
	}
	delete[] stacks;
	std::cout << "\n";
}

const void AdventOfCode::day05part2() {
	getInput("day05");

	bool procedure = false;
	std::vector<std::string> crates;

	int nStacks{};
	std::stack<char>* stacks = nullptr;
	std::stack<char> buffer;

	for (const std::string& line : input) {
		if (!line.empty()) {
			if (!procedure) {
				crates.push_back(line);
			}
			else {
				int nCrates = stoi(line.substr(5));
				auto lineLen = line.length();
				int from = line[lineLen - 6] - '0';
				int to = line[lineLen - 1] - '0';
				from--;
				to--;
				for (int i = 0; i < nCrates; i++) {
					char crate = stacks[from].top();
					stacks[from].pop();
					buffer.push(crate);
				}
				for (int i = 0; i < nCrates; i++) {
					char crate = buffer.top();
					buffer.pop();
					stacks[to].push(crate);
				}
			}
		}
		else {
			procedure = true;

			std::string stackNums = crates[crates.size() - 1];
			nStacks = stackNums[stackNums.length() - 2] - '0';
			stacks = new std::stack<char>[nStacks];

			for (int i = crates.size() - 2; i >= 0; i--) {
				std::string crateLayer = crates[i];
				int stackIndex = 0;
				for (int ci = 1; ci <= 1 + ((nStacks - 1) * 4); ci += 4) {
					char crateLetter = crateLayer[ci];
					if (crateLetter != ' ') {
						stacks[stackIndex].push(crateLetter);
					}
					stackIndex++;
				}
			}

			crates.clear();
		}
	}

	for (int i = 0; i < nStacks; i++) {
		std::cout << stacks[i].top();
	}
	delete[] stacks;
	std::cout << "\n";
}
