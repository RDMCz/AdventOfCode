#include "AdventOfCode.hpp"

#include <iostream>

const void AdventOfCode::day20part1() {
	getInput("day20");
	int len = input.size();

	std::vector<Day20RingElement*> ring;
	Day20RingElement* zero = nullptr;

	for (int i = 0; i < len; i++) {
		Day20RingElement* el = new Day20RingElement();
		el->value = stoi(input[i]);
		if (el->value == 0) zero = el;
		if (i == len - 1) {
			el->next = ring[0];
			ring[0]->prev = el;
		}
		ring.push_back(el);
		if (i != 0) {
			ring[i - 1]->next = el;
			el->prev = ring[i - 1];
		}
	}

	if (zero == nullptr) return;
	
	for (Day20RingElement* el : ring) {
		int shift = el->value;
		if (shift == 0) continue;
		shift -= (shift / (len - 1)) * (len - 1);
		if (shift < 0) shift = (len - 1) + shift;
		if (shift == 0) continue;
		Day20RingElement* pointer = el;
		for (int i = 0; i < shift; i++) {
			pointer = pointer->next;
		}
		el->prev->next = el->next;
		el->next->prev = el->prev;
		el->next = pointer->next;
		pointer->next->prev = el;
		el->prev = pointer;
		pointer->next = el;
	}

	int result = 0;

	for (int corShift = 1000; corShift <= 3000; corShift += 1000) {
		int shift = corShift;
		shift -= (shift / len) * len;
		Day20RingElement* pointer = zero;
		for (int i = 0; i < shift; i++) {
			pointer = pointer->next;
		}
		result += pointer->value;
	}

	std::cout << result << "\n";

	ring.clear();
}

const void AdventOfCode::day20part2() {
	getInput("day20");
	int len = input.size();

	std::vector<Day20Part2RingElement*> ring;
	Day20Part2RingElement* zero = nullptr;

	for (int i = 0; i < len; i++) {
		Day20Part2RingElement* el = new Day20Part2RingElement();
		el->value = stoll(input[i]) * 811589153;
		if (el->value == 0) zero = el;
		if (i == len - 1) {
			el->next = ring[0];
			ring[0]->prev = el;
		}
		ring.push_back(el);
		if (i != 0) {
			ring[i - 1]->next = el;
			el->prev = ring[i - 1];
		}
	}

	if (zero == nullptr) return;

	for (int times = 0; times < 10; times++) {
		for (Day20Part2RingElement* el : ring) {
			long long shift = el->value;
			if (shift == 0) continue;
			shift -= (shift / (len - 1)) * (len - 1);
			if (shift < 0) shift = (len - 1) + shift;
			if (shift == 0) continue;
			Day20Part2RingElement* pointer = el;
			for (long long i = 0; i < shift; i++) {
				pointer = pointer->next;
			}
			el->prev->next = el->next;
			el->next->prev = el->prev;
			el->next = pointer->next;
			pointer->next->prev = el;
			el->prev = pointer;
			pointer->next = el;
		}
	}

	long long result = 0;

	for (int corShift = 1000; corShift <= 3000; corShift += 1000) {
		int shift = corShift;
		shift -= (shift / len) * len;
		Day20Part2RingElement* pointer = zero;
		for (int i = 0; i < shift; i++) {
			pointer = pointer->next;
		}
		result += pointer->value;
	}

	std::cout << result << "\n";

	ring.clear();
}
