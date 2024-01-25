package main

import (
	"fmt"
	"strconv"
	"strings"
)

func day06getNPossibilities(time int, distance int) int {
	nPossibilities := 0
	for j := time - 1; j > 0; j-- {
		if (time-j)*j > distance {
			nPossibilities++
		}
	}
	return nPossibilities
}

func day06part1() {
	input := AoC("day06")
	lines := splitByNewline(input)
	timeStrSlice := strings.Fields(lines[0])[1:]
	distanceStrSlice := strings.Fields(lines[1])[1:]

	var time, distance, result int

	result = 1
	for i := 0; i < len(timeStrSlice); i++ {
		time, _ = strconv.Atoi(timeStrSlice[i])
		distance, _ = strconv.Atoi(distanceStrSlice[i])
		result *= day06getNPossibilities(time, distance)
	}

	fmt.Println(result)
}

func day06part2() {
	input := AoC("day06")
	lines := splitByNewline(input)
	time, _ := strconv.Atoi(strings.Split(strings.ReplaceAll(lines[0], " ", ""), ":")[1])
	distance, _ := strconv.Atoi(strings.Split(strings.ReplaceAll(lines[1], " ", ""), ":")[1])
	fmt.Println(day06getNPossibilities(time, distance))
}
