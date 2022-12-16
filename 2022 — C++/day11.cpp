#include "AdventOfCode.hpp"

#include <iostream>
#include <sstream>

const void AdventOfCode::day11part1() {
	getInput("day11");

	int nMonkeys = (input.size() + 1) / 7;
	Day11Monkey** monkeys = new Day11Monkey*[nMonkeys];
	std::vector<int> inspections;

	for (int i = 0; i < nMonkeys; i++) {
		Day11Monkey* newMonkey = new Day11Monkey();
		for (int j = 0; j < 7; j++) {
			if (i * 7 + j >= input.size()) break;
			std::string line = input[i * 7 + j];
			if (line.empty()) continue;
			if (j == 1) { // Starting items
				std::stringstream ss(line.substr(18));
				std::string item;
				while (getline(ss, item, ',')) {
					newMonkey->items.push(stoi(item));
				}
			}
			else if (j == 2) { // Operation
				char oper = line[23];
				if (oper == '*') {
					if (line[25] == 'o') {
						newMonkey->operation = 0;
					}
					else {
						newMonkey->operation = -stoi(line.substr(25));
					}
				}
				else {
					newMonkey->operation = stoi(line.substr(25));
				}
			}
			else if (j == 3) { // Divisible by
				newMonkey->testNum = stoi(line.substr(21));
			}
			else if (j == 4) { // If true
				newMonkey->ifTrue = line[29] - '0';
			}
			else if (j == 5) { // If false
				newMonkey->ifFalse = line[30] - '0';
			}
		}
		*(monkeys + i) = newMonkey;
		Day11Monkey* mp = *(monkeys + i);
		inspections.push_back(0);
	}

	for (int round = 0; round < 20; round++) {
		for (int i = 0; i < nMonkeys; i++) {
			Day11Monkey* mp = *(monkeys + i);
			int nItems = mp->items.size();

			for (int j = 0; j < nItems; j++) {
				int item = mp->items.front();
				// "Monkey inspects an item with a worry level of {item}."
				inspections[i]++;
				int operation = mp->operation;
				if (operation == 0) item *= item;
				else if (operation < 0) item *= abs(operation);
				else item += operation;
				// "Worry level is increased/multiplied by something to {item}."
				item /= 3;
				// "Monkey gets bored with item. Worry level is divided by 3 to {item}."
				int divider = mp->testNum;
				int monkeyReceiver = (item % divider == 0) ? mp->ifTrue : mp->ifFalse;
				(*(monkeys + monkeyReceiver))->items.push(item);
				mp->items.pop();
				// "Item with worry level {item} is thrown to monkey {monkeyReceiver}."
			}
		}
	}

	std::sort(inspections.begin(), inspections.end(), std::greater<int>());
	int result = inspections[0] * inspections[1];
	std::cout << result << "\n";

	// Tidy up
	for (int i = 0; i < nMonkeys; i++) {
		delete *(monkeys + i);
	}
	delete[] monkeys;
}

const void AdventOfCode::day11part2() {
	getInput("day11");
	int inputLen = input.size();

	int nMonkeys = (inputLen + 1) / 7;
	Day11Monkey** monkeys = new Day11Monkey* [nMonkeys];
	std::vector<int> inspections;
	std::vector<Day11Part2Item*> items;

	for (int i = 3; i < inputLen; i += 7) Day11Part2Item::basises.push_back(stoi(input[i].substr(21)));

	for (int i = 0; i < nMonkeys; i++) {
		Day11Monkey* newMonkey = new Day11Monkey();
		for (int j = 0; j < 7; j++) {
			if (i * 7 + j >= inputLen) break;
			std::string line = input[i * 7 + j];
			if (line.empty()) continue;
			if (j == 1) { // Starting items
				std::stringstream ss(line.substr(18));
				std::string item;
				while (getline(ss, item, ',')) {
					Day11Part2Item* newItem = new Day11Part2Item(stoi(item));
					items.push_back(newItem);
					newMonkey->items.push(items.size() - 1);
				}
			}
			else if (j == 2) { // Operation
				char oper = line[23];
				if (oper == '*') {
					if (line[25] == 'o') {
						newMonkey->operation = 0;
					}
					else {
						newMonkey->operation = -stoi(line.substr(25));
					}
				}
				else {
					newMonkey->operation = stoi(line.substr(25));
				}
			}
			else if (j == 4) { // If true
				newMonkey->ifTrue = line[29] - '0';
			}
			else if (j == 5) { // If false
				newMonkey->ifFalse = line[30] - '0';
			}
		}
		newMonkey->testNum = Day11Part2Item::basises[i];
		*(monkeys + i) = newMonkey;
		Day11Monkey* mp = *(monkeys + i);
		inspections.push_back(0);
	}

	for (int round = 0; round < 10000; round++) {
		for (int i = 0; i < nMonkeys; i++) {
			Day11Monkey* mp = *(monkeys + i);
			int nItems = mp->items.size();

			for (int j = 0; j < nItems; j++) {
				int itemIndex = mp->items.front();
				Day11Part2Item* item = items[itemIndex];
				// "Monkey inspects an item"
				inspections[i]++;
				int operation = mp->operation;
				if (operation == 0) item->Pow();
				else if (operation < 0) item->Mul(abs(operation));
				else item->Add(operation);
				// "Worry level is increased/multiplied"
				int divider = mp->testNum;
				int monkeyReceiver = (item->Mod(divider)) ? mp->ifTrue : mp->ifFalse;
				(*(monkeys + monkeyReceiver))->items.push(itemIndex);
				mp->items.pop();
				// "Item is thrown to monkey {monkeyReceiver}"
			}
		}
	}

	std::sort(inspections.begin(), inspections.end(), std::greater<int>());
	long long result = (long long)inspections[0] * (long long)inspections[1];
	std::cout << result << "\n";

	// Tidy up
	for (int i = 0; i < nMonkeys; i++) {
		delete* (monkeys + i);
	}
	delete[] monkeys;
	items.clear();
}

Day11Part2Item::Day11Part2Item(int input) {
	for (int i = 0; i < basises.size(); i++) {
		int basis = basises[i];
		int times = input / basis;
		int offst = input % basis;
		number.emplace_back(basises[i], times, offst);
	}
}

std::vector<int> Day11Part2Item::basises;

const void Day11Part2Item::Pow() {
	for (auto& repre : number) {
		int basis = std::get<0>(repre);
		int times = std::get<1>(repre);
		int offst = std::get<2>(repre);

		times = basis * times * times + 2 * times * offst;
		offst *= offst;
		times += offst / basis;
		offst %= basis;

		std::get<0>(repre) = basis;
		std::get<1>(repre) = times;
		std::get<2>(repre) = offst;
	}
}

const void Day11Part2Item::Mul(int c) {
	for (auto& repre : number) {
		int basis = std::get<0>(repre);
		int times = std::get<1>(repre);
		int offst = std::get<2>(repre);

		times *= c;
		offst *= c;
		times += offst / basis;
		offst %= basis;

		std::get<0>(repre) = basis;
		std::get<1>(repre) = times;
		std::get<2>(repre) = offst;
	}
}

const void Day11Part2Item::Add(int c) {
	for (auto& repre : number) {
		int basis = std::get<0>(repre);
		int times = std::get<1>(repre);
		int offst = std::get<2>(repre);

		offst += c;
		times += offst / basis;
		offst %= basis;

		std::get<0>(repre) = basis;
		std::get<1>(repre) = times;
		std::get<2>(repre) = offst;
	}
}

const bool Day11Part2Item::Mod(int c) {
	for (auto& repre : number) {
		int basis = std::get<0>(repre);
		if (basis != c) continue;
		int offst = std::get<2>(repre);
		if (offst == 0) return true;
	}
	return false;
}

Day11Part2Item::~Day11Part2Item() {
	number.clear();
}
