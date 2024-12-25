package main

import (
	"fmt"
	"strconv"
	"strings"
)

type day19ruleSet struct {
	oper []string
	valu []int
	dest []string
	last string
	cond []string // oper+valu, for part2
}

type day19machinePart struct {
	x, m, a, s int
}

type day19machinePart64 struct { // for part 2
	x, m, a, s uint64
}

func day19workflow(mapa *map[string]*day19ruleSet, key string, machinePart *day19machinePart) bool {
	ruleSet := *((*mapa)[key])
	for i := 0; i < len(ruleSet.oper); i++ {
		if day19eval(machinePart, ruleSet.oper[i], ruleSet.valu[i]) {
			switch ruleSet.dest[i] {
			case "A":
				return true
			case "R":
				return false
			default:
				return day19workflow(mapa, ruleSet.dest[i], machinePart)
			}
		}
	}
	switch ruleSet.last {
	case "A":
		return true
	case "R":
		return false
	default:
		return day19workflow(mapa, ruleSet.last, machinePart)
	}
}

func day19eval(machinePart *day19machinePart, ope string, val int) bool {
	var studiedValue int
	letter := string(ope[0])
	operation := string(ope[1])
	switch letter {
	case "x":
		studiedValue = (*machinePart).x
	case "m":
		studiedValue = (*machinePart).m
	case "a":
		studiedValue = (*machinePart).a
	case "s":
		studiedValue = (*machinePart).s
	}
	switch operation {
	case ">":
		return studiedValue > val
	default:
		return studiedValue < val
	}
}

func day19crawl(mapa *map[string]*day19ruleSet, key string, list *[]string, way string) {
	ruleSet := *((*mapa)[key])
	for i := 0; i < len(ruleSet.oper); i++ {
		if ruleSet.dest[i] == "A" {
			*list = append(*list, way+";"+ruleSet.cond[i])
		} else if ruleSet.dest[i] != "R" {
			day19crawl(mapa, ruleSet.dest[i], list, way+";"+ruleSet.cond[i])
		}
		way += ";!" + ruleSet.cond[i]
	}
	if ruleSet.last == "A" {
		*list = append(*list, way)
	} else if ruleSet.last != "R" {
		day19crawl(mapa, ruleSet.last, list, way)
	}
}

func day19pathToNCombinations(path string, pmin *day19machinePart64, pmax *day19machinePart64) uint64 {
	var negative bool
	var number uint64
	var letter, operation string
	day19resetPminPmax(pmin, pmax)
	rules := strings.Split(path[1:], ";")
	for _, rule := range rules {
		negative = string(rule[0]) == "!"
		if negative {
			rule = rule[1:]
		}
		letter = string(rule[0])
		operation = string(rule[1])
		number, _ = strconv.ParseUint(rule[2:], 10, 64)
		switch operation {
		case ">":
			if negative && number < day19getXMAS(pmax, letter) { // letter<=number
				day19setXMAS(pmax, letter, number)
			} else if !negative && number+1 > day19getXMAS(pmin, letter) { // letter>number
				day19setXMAS(pmin, letter, number+1)
			}
		case "<":
			if negative && number > day19getXMAS(pmin, letter) { // letter>=number
				day19setXMAS(pmin, letter, number)
			} else if !negative && number-1 < day19getXMAS(pmax, letter) { // letter<number
				day19setXMAS(pmax, letter, number-1)
			}
		}
	}
	if (*pmin).x > (*pmax).x || (*pmin).m > (*pmax).m || (*pmin).a > (*pmax).a || (*pmin).s > (*pmax).s {
		return 0
	}
	return ((*pmax).x - (*pmin).x + 1) * ((*pmax).m - (*pmin).m + 1) * ((*pmax).a - (*pmin).a + 1) * ((*pmax).s - (*pmin).s + 1)
}

func day19resetPminPmax(pmin *day19machinePart64, pmax *day19machinePart64) {
	(*pmin).x, (*pmin).m, (*pmin).a, (*pmin).s = 1, 1, 1, 1
	(*pmax).x, (*pmax).m, (*pmax).a, (*pmax).s = 4000, 4000, 4000, 4000
}

func day19getXMAS(machinePart *day19machinePart64, letter string) uint64 {
	switch letter {
	case "x":
		return (*machinePart).x
	case "m":
		return (*machinePart).m
	case "a":
		return (*machinePart).a
	default:
		return (*machinePart).s
	}
}

func day19setXMAS(machinePart *day19machinePart64, letter string, value uint64) {
	switch letter {
	case "x":
		(*machinePart).x = value
	case "m":
		(*machinePart).m = value
	case "a":
		(*machinePart).a = value
	case "s":
		(*machinePart).s = value
	}
}

func day19() {
	input := strings.Split(strings.ReplaceAll(AoC("day19"), "\r\n", "\n"), "\n\n")

	var number int
	var key string
	var nums [4]int
	var lineFields, ruleFields []string
	var machinePart day19machinePart

	mapa := make(map[string]*day19ruleSet)

	for _, line := range splitByNewline(input[0]) {
		lineFields = strings.Split(line, "{")
		key = lineFields[0]
		lineFields = strings.Split(lineFields[1][:len(lineFields[1])-1], ",")
		ruleSet := day19ruleSet{make([]string, 0), make([]int, 0), make([]string, 0), "", make([]string, 0)}
		for i, rule := range lineFields {
			if i == len(lineFields)-1 {
				ruleSet.last = rule
			} else {
				ruleFields = strings.Split(rule, ":")
				ruleSet.oper = append(ruleSet.oper, ruleFields[0][0:2])
				number, _ = strconv.Atoi(ruleFields[0][2:])
				ruleSet.valu = append(ruleSet.valu, number)
				ruleSet.dest = append(ruleSet.dest, ruleFields[1])
				ruleSet.cond = append(ruleSet.cond, ruleFields[0])
			}
		}
		mapa[key] = &ruleSet
	}

	// Part 1
	result1 := 0
	for _, line := range splitByNewline(input[1]) {
		lineFields = strings.Split(line[1:len(line)-1], ",")
		for i, field := range lineFields {
			nums[i], _ = strconv.Atoi(field[2:])
		}
		machinePart = day19machinePart{nums[0], nums[1], nums[2], nums[3]}
		if day19workflow(&mapa, "in", &machinePart) {
			result1 += nums[0] + nums[1] + nums[2] + nums[3]
		}
	}
	fmt.Println("Part 1:", result1)

	// Part 2
	// |A ∪ B ∪ C| = |A| + |B| + |C| - |A ∩ B| - |A ∩ C| - |B ∩ C| + |A ∩ B ∩ C|
	//⟹ Pro obecný počet n množin:
	//    velikosti všech průniků lichého počtu množin přičítáme
	//    velikosti všech průniků sudého počtu množin odčítáme

	var isZeroPath, exists bool
	var index, maxValue, newValue int
	var nPathCombinations uint64
	var path string
	var combination []int
	var result2 uint64 = 0
	pmin := day19machinePart64{}
	pmax := day19machinePart64{}

	paths := make([]string, 0)
	day19crawl(&mapa, "in", &paths, "")
	n := len(paths)
	addOrSubtract := true

	zeroPathsSet := make(map[string]bool)

	for k := 1; k <= n; k++ {
		combination = make([]int, k)
		for i := 0; i < k; i++ {
			combination[i] = i
		}
	combinationsloop:
		for {
			path = ""
			isZeroPath = false
			for _, i := range combination {
				path += paths[i]
				_, exists = zeroPathsSet[path]
				if exists {
					isZeroPath = true
					break
				}
			}
			if !isZeroPath {
				nPathCombinations = day19pathToNCombinations(path, &pmin, &pmax)
				if nPathCombinations == 0 {
					zeroPathsSet[path] = true
				} else {
					if addOrSubtract {
						result2 += nPathCombinations
					} else {
						result2 -= nPathCombinations
					}
				}
			}

			// Generate new combination
			index = k - 1
			maxValue = n - 1
			for {
				if index == 0 && combination[index] == maxValue {
					break combinationsloop
				}
				if combination[index] < maxValue {
					break
				}
				index--
				maxValue--
			}
			combination[index]++
			newValue = combination[index]
			index++
			for index <= k-1 {
				newValue++
				combination[index] = newValue
				index++
			}
		}
		addOrSubtract = !addOrSubtract

		break // Turns out one iteration is enough
	}
	fmt.Println("Part 2:", result2)
}
