#include "AdventOfCode.hpp"

#include <iostream>

const void AdventOfCode::day08part1() {
	getInput("day08");

	int wid = input[0].length();
	int hei = input.size();

	int** grid = new int*[hei];
	for (int i = 0; i < hei; i++) {
		*(grid + i) = new int[wid];
		for (int j = 0; j < wid; j++) {
			*(*(grid + i) + j) = input[i][j];// -'0';
		}
	}

	int nVisibleTrees = 0;

	for (int i = 1; i < hei - 1; i++) {
		for (int j = 1; j < wid - 1; j++) {
			int value = *(*(grid + i) + j);
			bool visible;
			// Top
			visible = true;
			for (int v = i - 1; v >= 0; v--) {
				if (*(*(grid + v) + j) >= value) {
					visible = false;
					break;
				}
			}
			if (visible) {
				nVisibleTrees++;
				continue;
			}
			// Bottom
			visible = true;
			for (int v = i + 1; v < hei; v++) {
				if (*(*(grid  + v) + j) >= value) {
					visible = false;
					break;
				}
			}
			if (visible) {
				nVisibleTrees++;
				continue;
			}
			// Left
			visible = true;
			for (int h = j - 1; h >= 0; h--) {
				if (*(*(grid + i) + h) >= value) {
					visible = false;
					break;
				}
			}
			if (visible) {
				nVisibleTrees++;
				continue;
			}
			// Right
			visible = true;
			for (int h = j + 1; h < wid; h++) {
				if (*(*(grid + i) + h) >= value) {
					visible = false;
					break;
				}
			}
			if (visible) nVisibleTrees++;
		}
	}

	nVisibleTrees += 2 * (wid + hei) - 4;

	std::cout << nVisibleTrees << "\n";

	// Tidy up
	for (int i = 0; i < hei; i++) {
		delete[] *(grid + i);
	}
	delete[] grid;
}

const void AdventOfCode::day08part2() {
	getInput("day08");

	int wid = input[0].length();
	int hei = input.size();

	int** grid = new int* [hei];
	for (int i = 0; i < hei; i++) {
		*(grid + i) = new int[wid];
		for (int j = 0; j < wid; j++) {
			*(*(grid + i) + j) = input[i][j];
		}
	}

	int maxScore = 0;

	for (int i = 1; i < hei - 1; i++) {
		for (int j = 1; j < wid - 1; j++) {
			int value = *(*(grid + i) + j);
			int score = 1;
			for (int v = 1; ; v++) { // Up
				if (i - v == 0 || *(*(grid + i - v) + j) >= value) {
					score *= v;
					break;
				}
			}
			for (int v = 1; ; v++) { // Down
				if (i + v == hei - 1 || *(*(grid + i + v) + j) >= value) {
					score *= v;
					break;
				}
			}
			for (int h = 1; ; h++) { // Left
				if (j - h == 0 || *(*(grid + i) + j - h) >= value) {
					score *= h;
					break;
				}
			}
			for (int h = 1; ; h++) { // Right
				if (j + h == wid - 1 || *(*(grid + i) + j + h) >= value) {
					score *= h;
					break;
				}
			}			
			if (score > maxScore) {
				maxScore = score;
			}
		}
	}

	std::cout << maxScore << "\n";

	// Tidy up
	for (int i = 0; i < hei; i++) {
		delete[] * (grid + i);
	}
	delete[] grid;
}
