#include "AdventOfCode.hpp"

#include <iostream>
#include <unordered_map>

const void AdventOfCode::day07() {
	getInput("day07");

	int nCommands = input.size();
		
	std::string pwd = "/";
	std::unordered_map<std::string, Day07Directory*> map;
	map[pwd] = new Day07Directory();

	for (int commandIndex = 1; commandIndex < nCommands;) {
		std::string command = input[commandIndex];
		if (command == "$ ls") {
			int lsIndex = 1;
			while (true) {
				if (commandIndex + lsIndex >= nCommands) {
					commandIndex = nCommands;
					break;
				}
				std::string item = input[commandIndex + lsIndex];
				if (item[0] == '$') {
					commandIndex += lsIndex;
					break;
				}
				else if (item.substr(0, 3) == "dir") {
					Day07Directory* newDir = new Day07Directory();
					map[pwd + item.substr(4) + "/"] = newDir;
					map[pwd]->addFolder(newDir);
				}
				else {
					map[pwd]->addFile(stoi(item));
				}
				lsIndex++;
			}
		}
		else {
			std::string cdTarget = command.substr(5);
			if (cdTarget == "..") {
				pwd = pwd.substr(0, pwd.substr(0, pwd.length() - 1).rfind('/') + 1);
			}
			else {
				pwd += cdTarget + "/";
			}
			commandIndex++;
		}
	}

	int part1 = 0;
	int leastToDelete = 30000000 - (70000000 - map["/"]->getTotalSize());
	int part2 = 70000000;

	for (const auto& dir : map) {
		int totalSize = dir.second->getTotalSize();
		if (totalSize <= 100000) {
			part1 += totalSize;
		}
		if (totalSize > leastToDelete && totalSize < part2) {
			part2 = totalSize;
		}
	}

	std::cout << "part1: " << part1 << "\npart2: " << part2 << "\n";
}

const void Day07Directory::addFile(int size) {
	filesSize += size;
}

const void Day07Directory::addFolder(Day07Directory* day_p) {
	childDirs.push_back(day_p);
}

const int Day07Directory::getTotalSize() const {
	int result = filesSize;
	for (const auto& childDir : childDirs) {
		result += childDir->getTotalSize();
	}
	return result;
}
