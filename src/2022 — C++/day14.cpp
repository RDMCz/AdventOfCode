#include "AdventOfCode.hpp"

#include <iostream>
#include <regex>
#include <sstream>

const void AdventOfCode::day14part1() {
	getInput("day14");

	int gridMinX = 1000;
	int gridMaxX = -1;
	int gridMaxY = -1;

	std::set<std::pair<int, int>> grid;

	for (const std::string& line : input) {
		std::string formatted = std::regex_replace(line, std::regex(" -> "), ";");

		std::stringstream ss(formatted);
		std::string part;
		std::vector<std::pair<int, int>> parts;

		while (getline(ss, part, ';')) {
			int x = stoi(part);
			int y = stoi(part.substr(part.find(',') + 1));

			if (x > gridMaxX) gridMaxX = x;
			if (x < gridMinX) gridMinX = x;
			if (y > gridMaxY) gridMaxY = y;

			parts.emplace_back(x, y);
		}

		int nParts = parts.size();
		for (int i = 1; i < nParts; i++) {
			int x1 = parts[i - 1].first;
			int y1 = parts[i - 1].second;
			int x2 = parts[i].first;
			int y2 = parts[i].second;
			if (x1 == x2) {
				for (int y = y1; y != y2;) {
					grid.insert({ x1,y });
					if (y1 > y2) y--;
					else y++;
				}
				grid.insert({ x1,y2 });
			}
			else {
				for (int x = x1; x != x2;) {
					grid.insert({ x,y1 });
					if (x1 > x2) x--;
					else x++;
				}
				grid.insert({ x2,y1 });
			}
		}
	}

	int nSands = 0;
	bool done = false;
	while (true) {
		int sandX = 500;
		int sandY = 0;
		while (true) {
			if (sandY > gridMaxY) {
				done = true;
				break;
			}
			if (grid.count({ sandX,sandY + 1 }) == 0) {
				sandY++;
			}
			else if (grid.count({ sandX - 1,sandY + 1 }) == 0) {
				sandY++;
				sandX--;
			}
			else if (grid.count({ sandX + 1,sandY + 1 }) == 0) {
				sandY++;
				sandX++;
			}
			else {
				grid.insert({ sandX,sandY });
				break;
			}
		}
		if (done) {
			break;
		}
		nSands++;
	}

	std::cout << nSands << "\n";
}

const void AdventOfCode::day14part2() {
	getInput("day14");

	int gridMinX = 1000;
	int gridMaxX = -1;
	int gridMaxY = -1;

	std::set<std::pair<int, int>> grid;

	for (const std::string& line : input) {
		std::string formatted = std::regex_replace(line, std::regex(" -> "), ";");

		std::stringstream ss(formatted);
		std::string part;
		std::vector<std::pair<int, int>> parts;

		while (getline(ss, part, ';')) {
			int x = stoi(part);
			int y = stoi(part.substr(part.find(',') + 1));

			if (x > gridMaxX) gridMaxX = x;
			if (x < gridMinX) gridMinX = x;
			if (y > gridMaxY) gridMaxY = y;

			parts.emplace_back(x, y);
		}

		int nParts = parts.size();
		for (int i = 1; i < nParts; i++) {
			int x1 = parts[i - 1].first;
			int y1 = parts[i - 1].second;
			int x2 = parts[i].first;
			int y2 = parts[i].second;
			if (x1 == x2) {
				for (int y = y1; y != y2;) {
					grid.insert({ x1,y });
					if (y1 > y2) y--;
					else y++;
				}
				grid.insert({ x1,y2 });
			}
			else {
				for (int x = x1; x != x2;) {
					grid.insert({ x,y1 });
					if (x1 > x2) x--;
					else x++;
				}
				grid.insert({ x2,y1 });
			}
		}
	}

	int nSands = 0;
	bool done = false;
	while (true) {
		int sandX = 500;
		int sandY = 0;
		while (true) {
			if (sandY == gridMaxY + 1) {
				grid.insert({ sandX,sandY });		
				break;
			}
			if (grid.count({ sandX,sandY + 1 }) == 0) {
				sandY++;
			}
			else if (grid.count({ sandX - 1,sandY + 1 }) == 0) {
				sandY++;
				sandX--;
			}
			else if (grid.count({ sandX + 1,sandY + 1 }) == 0) {
				sandY++;
				sandX++;
			}
			else {
				grid.insert({ sandX,sandY });
				if (sandX == 500 && sandY == 0) {
					done = true;
				}
				break;
			}
		}
		nSands++;
		if (done) {
			break;
		}
	}

	std::cout << nSands << "\n";
}
