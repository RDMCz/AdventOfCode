#include "AdventOfCode.hpp"

#include <iostream>

const void AdventOfCode::day22part1() {
	getInput("day22");
	int hei = input.size() - 2;
	int wid = 0;
	std::string instructions = input[hei + 1];
	int yPos = 0;
	int xPos = -1;
	int face = 0;
	bool faceHor = true;

	for (int i = 0; i < hei; i++) {
		if (i == 0) xPos = input[i].find('.');
		int lineWid = input[i].length();
		if (lineWid > wid) wid = lineWid;
	}

	char** grid = new char* [hei];
	int** horTrans = new int* [hei];
	int** verTrans = new int* [wid];

	for (int i = 0; i < hei; i++) {
		*(grid + i) = new char[wid];
		*(horTrans + i) = new int[2];
		int lineWid = input[i].length();
		for (int j = 0; j < wid; j++) {
			char ch = (j >= lineWid) ? ' ' : input[i][j];
			*(*(grid + i) + j) = ch;
			if (i == 0) {
				*(verTrans + j) = new int[2];
				*(*(verTrans + j) + 0) = -2;
				*(*(verTrans + j) + 1) = -2;
			}
			if (ch != ' ' && *(*(verTrans + j) + 1) == -2) {
				*(*(verTrans + j) + 1) = (ch == '.') ? i : -1;
			}
		}
		int firstLeftDot = input[i].find('.');
		int firstLeftWall = input[i].find('#');
		char firstLeft = (firstLeftDot < firstLeftWall) ? '.' : '#';
		int firstRightDot = input[i].rfind('.');
		int firstRightWall = input[i].rfind('#');
		char firstRight = (firstRightDot > firstRightWall) ? '.' : '#';

		if ((firstLeft == '#' || firstRight == '#') && firstLeftWall != std::string::npos) {
			*(*(horTrans + i) + 0) = -1;
			*(*(horTrans + i) + 1) = -1;
		}
		else {
			*(*(horTrans + i) + 0) = firstRightDot;
			*(*(horTrans + i) + 1) = firstLeftDot;
		}
	}

	for (int y = hei - 1; y >= 0; y--) {
		for (int x = 0; x < wid; x++) {
			char ch = *(*(grid + y) + x);
			if (ch != ' ' && *(*(verTrans + x) + 0) == -2) {
				*(*(verTrans + x) + 0) = (ch == '.') ? y : -1;
			}
			if (*(*(verTrans + x) + 0) == -1 || *(*(verTrans + x) + 1) == -1) {
				*(*(verTrans + x) + 0) = -1;
				*(*(verTrans + x) + 1) = -1;
			}
		}
	}

	while (true) {
		char ch = instructions[0];
		if (ch >= '0' && ch <= '9') {
			int nSteps = stoi(instructions);
			int hor = (faceHor) ? ((face == 0) ? 1 : -1) : 0;
			int ver = (!faceHor) ? ((face == 3) ? 1 : -1) : 0;

			for (int i = 0; i < nSteps; i++) {
				if (faceHor && ((xPos == wid - 1 && hor == 1) || (xPos == 0 && hor == -1) || (xPos != 0 && xPos != wid - 1 && *(*(grid + yPos - ver) + xPos + hor) == ' '))) {
					int newXPos = *(*(horTrans + yPos) + (hor + 1) / 2);
					if (newXPos == -1) break;
					xPos = newXPos;
				}
				else if (!faceHor && ((yPos == hei - 1 && ver == -1) || (yPos == 0 && ver == 1) || (yPos != 0 && yPos != hei - 1 && *(*(grid + yPos - ver) + xPos + hor) == ' '))) {
					int newYPos = *(*(verTrans + xPos) + (ver - 1) / -2);
					if (newYPos == -1) break;
					yPos = newYPos;
				}
				else if (*(*(grid + yPos - ver) + xPos + hor) == '#') {
					break;
				}
				else {
					yPos -= ver;
					xPos += hor;
				}
			}

			int nDigits = std::to_string(nSteps).length();
			if (instructions.length() == nDigits) break;
			instructions = instructions.substr(nDigits);
		}
		else {
			int mod = (ch == 'L') ? -1 : 1;
			faceHor = !faceHor;
			face = (face + mod) % 4;
			if (face == -1) face = 3;
			if (instructions.length() == 1) break;
			instructions = instructions.substr(1);
		}
	}

	int result = 1000 * (yPos + 1) + 4 * (xPos + 1) + face;
	std::cout << result << "\n";

	for (int y = 0; y < hei; y++) {
		delete[] * (grid + y);
		delete[] * (horTrans + y);
	}
	delete[] grid;
	delete[] horTrans;
	for (int x = 0; x < wid; x++) {
		delete[] * (verTrans + x);
	}
	delete[] verTrans;
}

const void AdventOfCode::day22part2() {
	getInput("day22");
	int hei = input.size() - 2;
	int wid = 0;
	std::string instructions = input[hei + 1];
	int yPos = 0;
	int xPos = -1;
	int face = 0;
	bool faceHor = true;

	for (int i = 0; i < hei; i++) {
		if (i == 0) xPos = input[i].find('.');
		int lineWid = input[i].length();
		if (lineWid > wid) wid = lineWid;
	}

	char** grid = new char* [hei];
	std::pair<int, int>** horTrans = new std::pair<int, int>* [hei];
	std::pair<int, int>** verTrans = new std::pair<int, int>* [wid];

	for (int i = 0; i < hei; i++) {
		*(grid + i) = new char[wid];
		*(horTrans + i) = new std::pair<int, int>[2];
		int lineWid = input[i].length();
		for (int j = 0; j < wid; j++) {
			char ch = (j >= lineWid) ? ' ' : input[i][j];
			*(*(grid + i) + j) = ch;
			if (i == 0) *(verTrans + j) = new std::pair<int, int>[2];
		}		
	}

	for (int y = 0; y < hei; y++) {
		if (y <= 49) {
			*(*(horTrans + y) + 0) = { 0,149 - y };
			*(*(horTrans + y) + 1) = { 99,149 - y };
		}
		else if (y > 49 && y <= 99) {
			*(*(horTrans + y) + 0) = { y - 50,100 };
			*(*(horTrans + y) + 1) = { y + 50,49 };
		}
		else if (y > 99 && y <= 149) {
			*(*(horTrans + y) + 0) = { 50,149 - y };
			*(*(horTrans + y) + 1) = { 149,149 - y };
		}
		else if (y > 149) {
			*(*(horTrans + y) + 0) = { y - 100,0 };
			*(*(horTrans + y) + 1) = { y - 100,149 };
		}		
	}

	for (int x = 0; x < wid; x++) {
		if (x <= 49) {
			*(*(verTrans + x) + 0) = { 50,x + 50 };
			*(*(verTrans + x) + 1) = { x + 100,0 };
		}
		else if (x > 49 && x <= 99) {
			*(*(verTrans + x) + 0) = { 0,x + 100 };
			*(*(verTrans + x) + 1) = { 49,x + 100 };
		}
		else if (x > 99) {
			*(*(verTrans + x) + 0) = { x - 100,199 };
			*(*(verTrans + x) + 1) = { 99,x - 50 };
		}
	}

	while (true) {
		char ch = instructions[0];
		if (ch >= '0' && ch <= '9') {
			int nSteps = stoi(instructions);
			int hor = (faceHor) ? ((face == 0) ? 1 : -1) : 0;
			int ver = (!faceHor) ? ((face == 3) ? 1 : -1) : 0;

			for (int i = 0; i < nSteps; i++) {
				hor = (faceHor) ? ((face == 0) ? 1 : -1) : 0;
				ver = (!faceHor) ? ((face == 3) ? 1 : -1) : 0;
				if (faceHor && ((xPos == wid - 1 && hor == 1) || (xPos == 0 && hor == -1) || (xPos != 0 && xPos != wid - 1 && *(*(grid + yPos - ver) + xPos + hor) == ' '))) {
					std::pair<int, int> newPos = *(*(horTrans + yPos) + (hor + 1) / 2);
					int newX = newPos.first;
					int newY = newPos.second;
					if (*(*(grid + newY) + newX) == '#') { break; }
					if (yPos <= 49) {
						if (face == 2) {
							face = 0;
						}
						else {
							face = 2;
						}
					}
					else if (yPos > 49 && yPos <= 99) {
						if (face == 2) {
							face = 1;
							faceHor = false;
						}
						else {
							face = 3;
							faceHor = false;
						}
					}
					else if (yPos > 99 && yPos <= 149) {
						if (face == 2) {
							face = 0;
						}
						else {
							face = 2;
						}
					}
					else if (yPos > 149) {
						if (face == 2) {
							face = 1;
							faceHor = false;
						}
						else {
							face = 3;
							faceHor = false;
						}
					}
					xPos = newX;
					yPos = newY;
				}
				else if (!faceHor && ((yPos == hei - 1 && ver == -1) || (yPos == 0 && ver == 1) || (yPos != 0 && yPos != hei - 1 && *(*(grid + yPos - ver) + xPos + hor) == ' '))) {
					std::pair<int, int> newPos = *(*(verTrans + xPos) + (ver - 1) / -2);
					int newX = newPos.first;
					int newY = newPos.second;
					if (*(*(grid + newY) + newX) == '#') { break; }
					if (xPos <= 49) {
						if (face == 3) {
							face = 0;
							faceHor = true;
						}
					}
					else if (xPos > 49 && xPos <= 99) {
						if (face == 3) {
							face = 0;
							faceHor = true;
						}
						else {
							face = 2;
							faceHor = true;
						}
					}
					else if (xPos > 99) {
						if (face == 1) {
							face = 2;
							faceHor = true;
						}
					}
					xPos = newX;
					yPos = newY;
				}
				else if (*(*(grid + yPos - ver) + xPos + hor) == '#') {
					break;
				}
				else {
					yPos -= ver;
					xPos += hor;
				}
			}

			int nDigits = std::to_string(nSteps).length();
			if (instructions.length() == nDigits) break;
			instructions = instructions.substr(nDigits);
		}
		else {
			int mod = (ch == 'L') ? -1 : 1;
			faceHor = !faceHor;
			face = (face + mod) % 4;
			if (face == -1) face = 3;
			if (instructions.length() == 1) break;
			instructions = instructions.substr(1);
		}
	}

	int result = 1000 * (yPos + 1) + 4 * (xPos + 1) + face;
	std::cout << result << "\n";

	for (int y = 0; y < hei; y++) {
		delete[] * (grid + y);
		delete[] * (horTrans + y);
	}
	delete[] grid;
	delete[] horTrans;
	for (int x = 0; x < wid; x++) {
		delete[] * (verTrans + x);
	}
	delete[] verTrans;
}
