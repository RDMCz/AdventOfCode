#include "AdventOfCode.hpp"

#include <iostream>
#include <set>

const void AdventOfCode::day09part1() {
	getInput("day09");

	std::pair<int, int> head = { 0, 0 };
	std::pair<int, int> tail = { 0, 0 };

	std::set<std::pair<int, int>> visited;
	visited.insert(tail);

	for (const std::string& line : input) {
		char dir = line[0];
		int nSteps = stoi(line.substr(2));
		int directionMultiplier = (dir == 'R' || dir == 'U') ? 1 : -1;
		bool horizontal = (dir == 'R' || dir == 'L');

		for (int i = 0; i < nSteps; i++) {
			if (horizontal) {
				head.first += directionMultiplier;
			}
			else {
				head.second += directionMultiplier;
			}

			int xDiff = (head.first - tail.first);
			int yDiff = (head.second - tail.second);
			int xDiffAbs = abs(xDiff);
			int yDiffAbs = abs(yDiff);

			int len = sqrt(pow(xDiff, 2) + pow(yDiff, 2));

			if (len > 1) {
				if (xDiff != 0 && yDiff != 0) { // Diag
					tail.first += xDiff / xDiffAbs;
					tail.second += yDiff / yDiffAbs;
				}
				else if (xDiffAbs == 2) { // Hor
					tail.first += xDiff / 2;
				}
				else { // Ver
					tail.second += yDiff / 2;
				}
				visited.insert(tail);
			}
		}

	}
	std::cout << visited.size() << "\n";
}

const void AdventOfCode::day09part2() {
	getInput("day09");

	std::pair<int, int> knots[10]{};

	std::set<std::pair<int, int>> visited;
	visited.insert(knots[9]);

	for (const std::string& line : input) {
		char dir = line[0];
		int nSteps = stoi(line.substr(2));
		int directionMultiplier = (dir == 'R' || dir == 'U') ? 1 : -1;
		bool horizontal = (dir == 'R' || dir == 'L');

		for (int i = 0; i < nSteps; i++) {
			if (horizontal) {
				knots[0].first += directionMultiplier;
			}
			else {
				knots[0].second += directionMultiplier;
			}
			
			for (int i = 0; i < 9; i++) {
				int xDiff = (knots[i].first - knots[i + 1].first);
				int yDiff = (knots[i].second - knots[i + 1].second);
				int xDiffAbs = abs(xDiff);
				int yDiffAbs = abs(yDiff);

				int len = sqrt(pow(xDiff, 2) + pow(yDiff, 2));

				if (len > 1) {
					if (xDiff != 0 && yDiff != 0) { // Diag
						knots[i + 1].first += xDiff / xDiffAbs;
						knots[i + 1].second += yDiff / yDiffAbs;
					}
					else if (xDiffAbs == 2) { // Hor
						knots[i + 1].first += xDiff / 2;
					}
					else { // Ver
						knots[i + 1].second += yDiff / 2;
					}
				}
			}
			visited.insert(knots[9]);
		}
	}
	std::cout << visited.size() << "\n";
}
