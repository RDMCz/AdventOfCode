package main

import (
	"fmt"
	"sort"
	"strconv"
	"strings"
)

func day07getHandType(hand string) string {
	occurences := make(map[rune]int)
	for _, c := range hand {
		occurences[c]++
	}
	handLen := len(occurences)
	if handLen == 1 {
		return "0"
	} else if handLen == 2 {
		if day07isValueInMap(4, &occurences) {
			return "1"
		} else {
			return "2"
		}
	} else if handLen == 3 {
		if day07isValueInMap(3, &occurences) {
			return "3"
		} else {
			return "4"
		}
	} else {
		return strconv.Itoa(handLen + 1)
	}
}

func day07isValueInMap(value int, mapa *map[rune]int) bool {
	for _, possibleValue := range *mapa {
		if possibleValue == value {
			return true
		}
	}
	return false
}

func day07getBestHandType(mapa *map[string]string) string {
	var valueInt int
	result := 6
	for _, value := range *mapa {
		valueInt, _ = strconv.Atoi(value)
		if valueInt < result {
			result = valueInt
		}
	}
	return strconv.Itoa(result)
}

func day07printResult(lines *[]string) {
	var result, bid int
	sort.Sort(sort.Reverse(sort.StringSlice(*lines)))
	result = 0
	for i, value := range *lines {
		bid, _ = strconv.Atoi(value[6:])
		result += (i + 1) * bid
	}
	fmt.Println(result)
}

func day07part1() {
	input := AoC("day07")

	var hand, bid, handType string
	var lineParts []string

	lines := splitByNewline(input)
	replacer := strings.NewReplacer("A", "a", "K", "b", "Q", "c", "J", "d", "T", "e", "9", "f", "8", "g", "7", "h", "6", "i", "5", "j", "4", "k", "3", "l", "2", "m")

	for i := 0; i < len(lines); i++ {
		lineParts = strings.Fields(lines[i])
		hand = lineParts[0]
		bid = lineParts[1]
		handType = day07getHandType(hand)
		lines[i] = handType + replacer.Replace(hand) + bid
	}

	day07printResult(&lines)
}

func day07part2() {
	input := AoC("day07")

	var exists bool
	var hand, jHand, bid, handType string
	var lineParts []string
	var jPossibilities map[string]string

	lines := splitByNewline(input)
	replacer := strings.NewReplacer("A", "a", "K", "b", "Q", "c", "T", "e", "9", "f", "8", "g", "7", "h", "6", "i", "5", "j", "4", "k", "3", "l", "2", "m", "J", "n")

	for i := 0; i < len(lines); i++ {
		lineParts = strings.Fields(lines[i])
		hand = lineParts[0]
		bid = lineParts[1]

		if strings.Contains(hand, "J") {
			jPossibilities = make(map[string]string)
			for _, card := range hand {
				jHand = strings.ReplaceAll(hand, "J", string(card))
				_, exists = jPossibilities[jHand]
				if !exists {
					jPossibilities[jHand] = day07getHandType(jHand)
				}
			}
			handType = day07getBestHandType(&jPossibilities)
		} else {
			handType = day07getHandType(hand)
		}

		lines[i] = handType + replacer.Replace(hand) + bid
	}

	day07printResult(&lines)
}
