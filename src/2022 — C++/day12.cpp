#include "AdventOfCode.hpp"

#include <iostream>

const void AdventOfCode::day12part1() {
	getInput("day12");
	int hei = input.size();
	int wid = input[0].length();

	char** charVals = new  char* [hei];
	int** tileCosts = new int* [hei];
	int** euclidean = new int* [hei];
	int** combined = new int* [hei];

	int startY{};
	int startX{};
	int endY{};
	int endX{};

	for (int y = 0; y < hei; y++) {
		*(charVals + y) = new char[wid];
		*(tileCosts + y) = new int[wid];
		*(euclidean + y) = new int[wid];
		*(combined + y) = new int[wid];
		for (int x = 0; x < wid; x++) {
			char val = input[y][x];
			if (val == 'S') {
				startY = y;
				startX = x;
				val = 'a';
			}
			else if (val == 'E') {
				endY = y;
				endX = x;
				val = 'z';
			}
			*(*(charVals + y) + x) = val;
			*(*(tileCosts + y) + x) = hei * wid;
		}
	}

	*(*(tileCosts + startY) + startX) = 0;

	for (int y = 0; y < hei; y++) {
		for (int x = 0; x < wid; x++) {
			int man = sqrt(pow((endY - y), 2) + pow((endX - x), 2));
			*(*(euclidean + y) + x) = man;
			*(*(combined + y) + x) = man + *(*(tileCosts + y) + x);
		}
	}

	std::priority_queue<Day12PQElement> pq;
	pq.push(Day12PQElement(startY, startX, *(*(combined + startY) + startX)));
	std::set<std::pair<int, int>> visited;
	while (true) {
		Day12PQElement node = pq.top();
		pq.pop();
		int y = node.y;
		int x = node.x;
		int cost = *(*(tileCosts + y) + x);
		if (y == endY && x == endX) {
			std::cout << cost << "\n";
			break;
		}
		char val = *(*(charVals + y) + x);
		// Up
		if (y != 0) {
			int nY = y - 1;
			char nVal = *(*(charVals + nY) + x);
			int nCost = *(*(tileCosts + nY) + x);
			if (/*(val + 1 == nVal || val == nVal || (val == 's' && nVal == 'q'))*/val + 1 >= nVal && visited.count({ nY,x }) == 0 && cost + 1 < nCost) {
				*(*(tileCosts + nY) + x) = cost + 1;
				int com = *(*(euclidean + nY) + x) + cost + 1;
				*(*(combined + nY) + x) = com;
				pq.push(Day12PQElement(nY, x, com));
			}
		}
		// Down
		if (y != hei - 1) {
			int nY = y + 1;
			char nVal = *(*(charVals + nY) + x);
			int nCost = *(*(tileCosts + nY) + x);
			if (/*(val + 1 == nVal || val == nVal || (val == 's' && nVal == 'q'))*/val + 1 >= nVal && visited.count({ nY,x }) == 0 && cost + 1 < nCost) {
				*(*(tileCosts + nY) + x) = cost + 1;
				int com = *(*(euclidean + nY) + x) + cost + 1;
				*(*(combined + nY) + x) = com;
				pq.push(Day12PQElement(nY, x, com));
			}
		}
		// Left
		if (x != 0) {
			int nX = x - 1;
			char nVal = *(*(charVals + y) + nX);
			int nCost = *(*(tileCosts + y) + nX);
			if (/*(val + 1 == nVal || val == nVal || (val == 's' && nVal == 'q'))*/val + 1 >= nVal && visited.count({ y,nX }) == 0 && cost + 1 < nCost) {
				*(*(tileCosts + y) + nX) = cost + 1;
				int com = *(*(euclidean + y) + nX) + cost + 1;
				*(*(combined + y) + nX) = com;
				pq.push(Day12PQElement(y, nX, com));
			}
		}
		// Right
		if (x != wid - 1) {
			int nX = x + 1;
			char nVal = *(*(charVals + y) + nX);
			int nCost = *(*(tileCosts + y) + nX);
			if (/*(val + 1 == nVal || val == nVal || (val == 's' && nVal == 'q'))*/val + 1 >= nVal && visited.count({ y,nX }) == 0 && cost + 1 < nCost) {
				*(*(tileCosts + y) + nX) = cost + 1;
				int com = *(*(euclidean + y) + nX) + cost + 1;
				*(*(combined + y) + nX) = com;
				pq.push(Day12PQElement(y, nX, com));
			}
		}

		visited.insert({ y,x });
	}

	for (int y = 0; y < hei; y++) {
		delete[] *(charVals + y);
		delete[] *(tileCosts + y);
		delete[] *(euclidean + y);
		delete[] *(combined + y);
	}
	delete[] charVals;
	delete[] tileCosts;
	delete[] euclidean;
	delete[] combined;
}

const void AdventOfCode::day12part2() {
	getInput("day12");
	int hei = input.size();
	int wid = input[0].length();

	std::vector<std::pair<int, int>> starts;
	int endY{};
	int endX{};

	for (int y = 0; y < hei; y++) {
		for (int x = 0; x < wid; x++) {
			char val = input[y][x];
			if (val == 'a' || val == 'S') {
				starts.emplace_back(y, x);
			}
			else if (val == 'E') {
				endY = y;
				endX = x;
			}
		}
	}

	int result = hei * wid;

	for (const std::pair<int, int>& start : starts) {
		int startY = start.first;
		int startX = start.second;

		char** charVals = new  char* [hei];
		int** tileCosts = new int* [hei];
		int** euclidean = new int* [hei];
		int** combined = new int* [hei];

		for (int y = 0; y < hei; y++) {
			*(charVals + y) = new char[wid];
			*(tileCosts + y) = new int[wid];
			*(euclidean + y) = new int[wid];
			*(combined + y) = new int[wid];
			for (int x = 0; x < wid; x++) {
				char val = input[y][x];
				if (val == 'S') {
					val = 'a';
				}
				else if (val == 'E') {
					val = 'z';
				}
				*(*(charVals + y) + x) = val;
				*(*(tileCosts + y) + x) = hei * wid;
			}
		}

		*(*(tileCosts + startY) + startX) = 0;

		for (int y = 0; y < hei; y++) {
			for (int x = 0; x < wid; x++) {
				int man = sqrt(pow((endY - y), 2) + pow((endX - x), 2));
				*(*(euclidean + y) + x) = man;
				*(*(combined + y) + x) = man + *(*(tileCosts + y) + x);
			}
		}

		std::priority_queue<Day12PQElement> pq;
		pq.push(Day12PQElement(startY, startX, *(*(combined + startY) + startX)));
		std::set<std::pair<int, int>> visited;
		while (true) {
			if (pq.empty()) {
				break;
			}
			Day12PQElement node = pq.top();
			pq.pop();
			int y = node.y;
			int x = node.x;
			int cost = *(*(tileCosts + y) + x);
			if (y == endY && x == endX) {
				if (cost < result) result = cost;
				break;
			}
			char val = *(*(charVals + y) + x);
			// Up
			if (y != 0) {
				int nY = y - 1;
				char nVal = *(*(charVals + nY) + x);
				int nCost = *(*(tileCosts + nY) + x);
				if (val + 1 >= nVal && visited.count({ nY,x }) == 0 && cost + 1 < nCost) {
					*(*(tileCosts + nY) + x) = cost + 1;
					int com = *(*(euclidean + nY) + x) + cost + 1;
					*(*(combined + nY) + x) = com;
					pq.push(Day12PQElement(nY, x, com));
				}
			}
			// Down
			if (y != hei - 1) {
				int nY = y + 1;
				char nVal = *(*(charVals + nY) + x);
				int nCost = *(*(tileCosts + nY) + x);
				if (val + 1 >= nVal && visited.count({ nY,x }) == 0 && cost + 1 < nCost) {
					*(*(tileCosts + nY) + x) = cost + 1;
					int com = *(*(euclidean + nY) + x) + cost + 1;
					*(*(combined + nY) + x) = com;
					pq.push(Day12PQElement(nY, x, com));
				}
			}
			// Left
			if (x != 0) {
				int nX = x - 1;
				char nVal = *(*(charVals + y) + nX);
				int nCost = *(*(tileCosts + y) + nX);
				if (val + 1 >= nVal && visited.count({ y,nX }) == 0 && cost + 1 < nCost) {
					*(*(tileCosts + y) + nX) = cost + 1;
					int com = *(*(euclidean + y) + nX) + cost + 1;
					*(*(combined + y) + nX) = com;
					pq.push(Day12PQElement(y, nX, com));
				}
			}
			// Right
			if (x != wid - 1) {
				int nX = x + 1;
				char nVal = *(*(charVals + y) + nX);
				int nCost = *(*(tileCosts + y) + nX);
				if (val + 1 >= nVal && visited.count({ y,nX }) == 0 && cost + 1 < nCost) {
					*(*(tileCosts + y) + nX) = cost + 1;
					int com = *(*(euclidean + y) + nX) + cost + 1;
					*(*(combined + y) + nX) = com;
					pq.push(Day12PQElement(y, nX, com));
				}
			}

			visited.insert({ y,x });
		}

		for (int y = 0; y < hei; y++) {
			delete[] * (charVals + y);
			delete[] * (tileCosts + y);
			delete[] * (euclidean + y);
			delete[] * (combined + y);
		}
		delete[] charVals;
		delete[] tileCosts;
		delete[] euclidean;
		delete[] combined;
	}

	std::cout << result << "\n";
}

Day12PQElement::Day12PQElement(int y, int x, int combined) : y(y), x(x), combined(combined) {}

bool Day12PQElement::operator<(const struct Day12PQElement& other) const {
	return combined > other.combined;
}
