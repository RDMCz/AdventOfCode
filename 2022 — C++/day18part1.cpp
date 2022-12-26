#include "AdventOfCode.hpp"

#include <iostream>

const void AdventOfCode::day18part1() {
	getInput("day18");

	std::vector<Day18Cube*> cubes;

	for (const std::string& line : input) {
		int x, y, z;
		(void)sscanf_s(line.c_str(), "%d,%d,%d", &x, &y, &z);

		Day18Cube* newCube = new Day18Cube(x, y, z);
		for (Day18Cube* cube : cubes) {
			cube->updateSides(x, y, z);
			newCube->updateSides(cube->x, cube->y, cube->z);
		}
		cubes.push_back(newCube);
	}

	int result = 0;

	for (const Day18Cube* cube : cubes) {
		for (int i = 0; i < 6; i++) {
			if (cube->visibleSides[i]) result++;
		}
	}

	std::cout << result << "\n";

	cubes.clear();
}

Day18Cube::Day18Cube(int x, int y, int z) : x(x), y(y), z(z) {
	for (int i = 0; i < 6; i++) visibleSides[i] = true;
}

const void Day18Cube::updateSides(int ox, int oy, int oz) {
	int xDiff = x - ox;
	int yDiff = y - oy;
	int zDiff = z - oz;
	int neighCheck = abs(xDiff) + abs(yDiff) + abs(zDiff);
	if (neighCheck == 1) {
		if (xDiff != 0) {
			visibleSides[((xDiff == 1) ? 0 : 1)] = false;
		}
		else if (yDiff != 0) {
			visibleSides[((yDiff == 1) ? 2 : 3)] = false;
		}
		else if (zDiff != 0) {
			visibleSides[((zDiff == 1) ? 4 : 5)] = false;
		}
	}
}
