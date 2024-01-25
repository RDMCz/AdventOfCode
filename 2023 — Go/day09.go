package main

import (
	"fmt"
	"strconv"
	"strings"
)

func day09() {
	input := AoC("day09")

	var allZeros bool
	var number, index, nextValue, multiplier int
	var history [][]int

	result1 := 0
	result2 := 0
	for _, line := range splitByNewline(input) {
		history = make([][]int, 0)
		history = append(history, make([]int, 0))
		for _, item := range strings.Fields(line) {
			number, _ = strconv.Atoi(item)
			history[0] = append(history[0], number)
		}
		index = 1
		nextValue = number
		for {
			history = append(history, make([]int, 0))
			allZeros = true

			for i := 1; i < len(history[index-1]); i++ {
				number = history[index-1][i] - history[index-1][i-1]
				history[index] = append(history[index], number)
				if number != 0 {
					allZeros = false
				}
			}
			nextValue += number
			if allZeros {
				break
			}
			index++
		}
		result1 += nextValue
		// Part 2
		multiplier = 1
		for i := 0; i < len(history); i++ {
			result2 += history[i][0] * multiplier
			multiplier *= -1
		}
	}
	fmt.Println("Part 1:", result1)
	fmt.Println("Part 2:", result2)
}
