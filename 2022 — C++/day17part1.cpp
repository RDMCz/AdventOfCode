#include "AdventOfCode.hpp"

#include <iostream>

const void AdventOfCode::day17part1() {
	getInput("day17");
	std::string winds = input[0];
	int windPointer = 0;
	int windsLen = winds.size();
	std::string rocks = "-+L|o";
	int rockPointer = 0;
	int nStoppedRocks = 0;
	int maxHei = 0;
	std::set<int> blocks[7]{};
	for (int i = 0; i < 7; i++) blocks[i].insert(0);

	while (nStoppedRocks < 2022) {
		char rock = rocks[rockPointer++];
		if (rockPointer > 4) rockPointer = 0;
		int y = maxHei + 4, x = 2;
		if (rock == '+') x = 3;

		while (true) {
			char wind = winds[windPointer++];
			if (windPointer == windsLen) windPointer = 0;
			if (rock == '-') {
				if (wind == '>') { if (x < 3 && blocks[x + 4].count(y) == 0) x++; }
				else { if (x > 0 && blocks[x - 1].count(y) == 0) x--; }
			}
			else if (rock == '+') {
				if (wind == '>') { if (x < 5 && blocks[x + 1].count(y) == 0 && blocks[x + 2].count(y + 1) == 0 && blocks[x + 1].count(y + 2) == 0) x++; }
				else { if (x > 1 && blocks[x - 1].count(y) == 0 && blocks[x - 2].count(y + 1) == 0 && blocks[x - 1].count(y + 2) == 0) x--; }
			}
			else if (rock == 'L') {
				if (wind == '>') { if (x < 4 && blocks[x + 3].count(y) == 0 && blocks[x + 3].count(y + 1) == 0 && blocks[x + 3].count(y + 2) == 0) x++; }
				else { if (x > 0 && blocks[x - 1].count(y) == 0 && blocks[x + 1].count(y + 1) == 0 && blocks[x + 1].count(y + 2) == 0) x--; }
			}
			else if (rock == '|') {
				if (wind == '>') { if (x < 6 && blocks[x + 1].count(y) == 0 && blocks[x + 1].count(y + 1) == 0 && blocks[x + 1].count(y + 2) == 0 && blocks[x + 1].count(y + 3) == 0) x++; }
				else { if (x > 0 && blocks[x - 1].count(y) == 0 && blocks[x - 1].count(y + 1) == 0 && blocks[x - 1].count(y + 2) == 0 && blocks[x - 1].count(y + 3) == 0) x--; }
			}
			else if (rock == 'o') {
				if (wind == '>') { if (x < 5 && blocks[x + 2].count(y) == 0 && blocks[x + 2].count(y + 1) == 0) x++; }
				else { if (x > 0 && blocks[x - 1].count(y) == 0 && blocks[x - 1].count(y + 1) == 0) x--; }
			}
			y--;
			if (rock == '-') {
				if (blocks[x].count(y) != 0 || blocks[x + 1].count(y) != 0 || blocks[x + 2].count(y) != 0 || blocks[x + 3].count(y) != 0) {
					y++;
					if (y > maxHei) maxHei = y;
					blocks[x].insert(y);
					blocks[x + 1].insert(y);
					blocks[x + 2].insert(y);
					blocks[x + 3].insert(y);
					break;
				}
			}
			else if (rock == '+') {
				if (blocks[x].count(y) != 0 || blocks[x - 1].count(y + 1) != 0 || blocks[x + 1].count(y + 1) != 0) {
					y++;
					if (y + 2 > maxHei) maxHei = y + 2;
					blocks[x].insert(y);
					blocks[x].insert(y + 1);
					blocks[x].insert(y + 2);
					blocks[x - 1].insert(y + 1);
					blocks[x + 1].insert(y + 1);
					break;
				}
			}
			else if (rock == 'L') {
				if (blocks[x].count(y) != 0 || blocks[x + 1].count(y) != 0 || blocks[x + 2].count(y) != 0) {
					y++;
					if (y + 2 > maxHei) maxHei = y + 2;
					blocks[x].insert(y);
					blocks[x + 1].insert(y);
					blocks[x + 2].insert(y);
					blocks[x + 2].insert(y + 1);
					blocks[x + 2].insert(y + 2);
					break;
				}
			}
			else if (rock == '|') {
				if (blocks[x].count(y) != 0) {
					y++;
					if (y + 3 > maxHei) maxHei = y + 3;
					blocks[x].insert(y);
					blocks[x].insert(y + 1);
					blocks[x].insert(y + 2);
					blocks[x].insert(y + 3);
					break;
				}
			}
			else if (rock == 'o') {
				if (blocks[x].count(y) != 0 || blocks[x + 1].count(y) != 0) {
					y++;
					if (y + 1 > maxHei) maxHei = y + 1;
					blocks[x].insert(y);
					blocks[x].insert(y + 1);
					blocks[x + 1].insert(y);
					blocks[x + 1].insert(y + 1);
					break;
				}
			}
		}
		nStoppedRocks++;
	}

	std::cout << maxHei << "\n";
}
