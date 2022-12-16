#include "AdventOfCode.hpp"

#include <iostream>

#define ROWNUMBER 2000000

const void AdventOfCode::day15part1() {
	getInput("day15");
	int inputLen = input.size();

	std::set<int> rowNonBeacons;
	std::set<int> rowBeacons;

	for (int i = 0; i < inputLen; i++) {
		std::string line = input[i];
		int sX, sY, bX, bY;
		(void)sscanf_s(line.c_str(), "Sensor at x=%d, y=%d: closest beacon is at x=%d, y=%d", &sX, &sY, &bX, &bY);
		
		if (bY == ROWNUMBER) {
			rowBeacons.insert(bX);
		}
		
		int manhattan = abs(sX - bX) + abs(sY - bY);
		int distToRow = abs(sY - ROWNUMBER);

		if (distToRow <= manhattan) {
			int rowSpread = manhattan - distToRow;
			for (int rX = sX - rowSpread; rX <= sX + rowSpread; rX++) {
				rowNonBeacons.insert(rX);				
			}
		}
	}

	int result = rowNonBeacons.size() - rowBeacons.size();
	std::cout << result << "\n";
}
