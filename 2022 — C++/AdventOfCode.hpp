#pragma once
#pragma warning( disable : 4267 )

#include <vector>
#include <string>
#include <queue>
#include <tuple>
#include <set>

class AdventOfCode {
private:
	std::vector<std::string> input;
	std::string lastInputName;
	const void getInput(std::string day);
	const int day13Compare(std::string& left, std::string& right);
public:
	const void day01part1();
	const void day01part2();
	const void day02part1();
	const void day02part2();
	const void day03part1();
	const void day03part2();
	const void day04();
	const void day05part1();
	const void day05part2();
	const void day06();
	const void day07();
	const void day08part1();
	const void day08part2();
	const void day09part1();
	const void day09part2();
	const void day10();
	const void day11part1();
	const void day11part2();
	const void day12part1();
	const void day12part2();
	const void day13part1();
	const void day13part2();
	const void day14part1();
	const void day14part2();
	const void day15part1();
};

class Day07Directory {
private:
	int filesSize = 0;
	std::vector<Day07Directory*> childDirs;
public:
	const void addFile(int size);
	const void addFolder(Day07Directory* dir_p);
	const int getTotalSize() const;
};

struct Day11Monkey {
	std::queue<int> items;
	int operation{}; // +x = +x; 0 = ^2; -x = *x
	int testNum{};
	int ifTrue{};
	int ifFalse{};
};

class Day11Part2Item {
private:	
	std::vector<std::tuple<int, int, int>> number;
public:	
	Day11Part2Item(int input);
	static std::vector<int> basises;
	const void Pow();
	const void Mul(int c);
	const void Add(int c);
	const bool Mod(int c);
	~Day11Part2Item();
};

struct Day12PQElement {
	int y;
	int x;
	int combined;
	Day12PQElement(int y, int x, int combined);
	bool operator<(const struct Day12PQElement& other) const;
};
