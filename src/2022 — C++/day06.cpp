#include "AdventOfCode.hpp"

#include <iostream>
#include <set>

#define MARKERLEN 14

const void AdventOfCode::day06() {
	getInput("day06");

	std::set<char> set;

	int lineLen = input[0].length();
	for (int li = 0; li <= lineLen - MARKERLEN; li++) {
		set.clear();
		for (int i = li; i < li + MARKERLEN; i++) {
			set.insert(input[0][i]);
		}
		if (set.size() == MARKERLEN) {
			std::cout << li + MARKERLEN << "\n";
			break;
		}
	}
}
