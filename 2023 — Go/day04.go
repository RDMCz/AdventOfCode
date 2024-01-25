package main

import (
	"fmt"
	"math"
	"strings"
)

func day04nNumberHits(line string) int {
	cardParts := strings.Split(line, "|")
	winNums := strings.Fields(cardParts[0])[2:]
	playerNums := strings.Fields(cardParts[1])
	nHits := 0
	for _, winNum := range winNums {
		if winNum != "" {
			for _, playerNum := range playerNums {
				if winNum == playerNum {
					nHits++
				}
			}
		}
	}
	return nHits
}

func day04part1() {
	input := AoC("day04")
	result := 0
	for _, line := range splitByNewline(input) {
		result += int(math.Pow(2, float64(day04nNumberHits(line)-1)))
	}
	fmt.Println(result)
}

func day04part2() {
	input := AoC("day04")

	linesSplit := splitByNewline(input)
	nGames := len(linesSplit)

	cards := make([]int, nGames)
	for i := range cards {
		cards[i] = 1
	}

	var nHits int

	for cardN, line := range linesSplit {
		nHits = day04nNumberHits(line)
		for i := 0; i < nHits; i++ {
			cards[cardN+i+1] += cards[cardN]
		}
	}

	result := 0
	for i := range cards {
		result += cards[i]
	}
	fmt.Println(result)
}
