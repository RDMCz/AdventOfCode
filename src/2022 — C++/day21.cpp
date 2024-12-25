#include "AdventOfCode.hpp"

#include <iostream>

const void AdventOfCode::day21() {
	getInput("day21");
	Day21Tree tree(&input);
}

Day21Tree::Day21Tree(std::vector<std::string>* input) {
	for (const std::string& line : *input) {
		map.insert({ line.substr(0,4), line.substr(6) });
	}
	Day21Monkey* root = new Day21Monkey();
	root->value = map["root"];
	emplaceMonkeys(root);
	// Part 1
	long long result = evaluate(root);
	std::cout << "Part 1: " << result << "\n";
	// Part 2
	std::string pathToHumn = "";
	getPathToHumn(pathToHumn, humn);
	char side = pathToHumn[0];
	pathToHumn = pathToHumn.substr(1);
	if (side == 'L') {
		evaluateHumn(pathToHumn, root->left, root->right->valuell);
	}
	else {
		evaluateHumn(pathToHumn, root->right, root->left->valuell);
	}
}

const void Day21Tree::emplaceMonkeys(Day21Monkey* m) {
	if (m->value.size() > 4) {
		m->left = new Day21Monkey();
		std::string lname = m->value.substr(0, 4);
		m->left->value = map[lname];
		m->left->parent = m;
		m->left->isLeft = true;
		emplaceMonkeys(m->left);
		monkeys.push_back(m->left);
		m->right = new Day21Monkey();
		std::string rname = m->value.substr(7);
		m->right->value = map[rname];
		m->right->parent = m;
		m->right->isLeft = false;
		emplaceMonkeys(m->right);
		monkeys.push_back(m->right);

		if (lname == "humn") humn = m->left;
		if (rname == "humn") humn = m->right;
	}
}

const long long Day21Tree::evaluate(Day21Monkey* m) const {
	if (m->value.size() > 4) {
		long long left = evaluate(m->left);
		long long right = evaluate(m->right);
		char oper = m->value[5];
		long long eval{};
		switch (oper) {
			case '+': eval = left + right; break;
			case '-': eval = left - right; break;
			case '*': eval = left * right; break;
			case '/': eval = left / right; break;
		}
		m->valuell = eval;
		return eval;
	}
	else {
		m->valuell = stoll(m->value);
		return m->valuell;
	}
}

const void Day21Tree::getPathToHumn(std::string& result, Day21Monkey* m) const {
	if (m->parent == root) return;
	getPathToHumn(result, m->parent);
	result += (m->isLeft) ? "L" : "R";
}

const void Day21Tree::evaluateHumn(std::string& pathToHumn, Day21Monkey* m, long long mustEvalTo) const {
	char side = pathToHumn[0];
	char oper = m->value[5];
	long long mustSide{};
	switch (oper) {
		case '+': mustSide = (side == 'L') ? mustEvalTo - m->right->valuell : mustEvalTo - m->left->valuell; break;
		case '-': mustSide = (side == 'L') ? mustEvalTo + m->right->valuell : m->left->valuell - mustEvalTo; break;
		case '*': mustSide = (side == 'L') ? mustEvalTo / m->right->valuell : mustEvalTo / m->left->valuell; break;
		case '/': mustSide = (side == 'L') ? mustEvalTo * m->right->valuell : m->left->valuell / mustEvalTo; break;
	}
	if (pathToHumn.size() == 1) {
		std::cout << "Part 2: " << mustSide << "\n";
	}
	else {
		evaluateHumn((std::string&)pathToHumn.substr(1), ((side == 'L') ? m->left : m->right), mustSide);
	}
}

Day21Tree::~Day21Tree() {
	map.clear();
	monkeys.clear();
	delete root;
}
