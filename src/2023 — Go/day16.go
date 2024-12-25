package main

import (
	"fmt"
	"strconv"
	"strings"
)

func day16() {
	input := AoC("day16")
	lines := splitByNewline(input)
	appendStr := strings.Repeat("#", len(lines[0]))
	lines = append([]string{appendStr}, lines...)
	lines = append(lines, appendStr)
	for i := 0; i < len(lines); i++ {
		lines[i] = "#" + lines[i] + "#"
	}
	// Part 1
	set := map[int]bool{}
	setWithDirections := map[string]bool{}
	day16beam(&lines, &set, 1, 1, "R", &setWithDirections)
	result := len(set)
	fmt.Println("Part 1:", result)
	// Part 2
	var possibleResult int
	yLen := len(lines)
	xLen := len(lines[0])
	for x := 1; x < xLen-1; x++ {
		set = map[int]bool{}
		setWithDirections = map[string]bool{}
		day16beam(&lines, &set, 1, x, "D", &setWithDirections)
		possibleResult = len(set)
		if possibleResult > result {
			result = possibleResult
		}
		set = map[int]bool{}
		setWithDirections = map[string]bool{}
		day16beam(&lines, &set, yLen-2, x, "U", &setWithDirections)
		possibleResult = len(set)
		if possibleResult > result {
			result = possibleResult
		}
	}
	for y := 1; y < yLen-1; y++ {
		set = map[int]bool{}
		setWithDirections = map[string]bool{}
		day16beam(&lines, &set, y, 1, "R", &setWithDirections)
		possibleResult = len(set)
		if possibleResult > result {
			result = possibleResult
		}
		set = map[int]bool{}
		setWithDirections = map[string]bool{}
		day16beam(&lines, &set, y, yLen-2, "L", &setWithDirections)
		possibleResult = len(set)
		if possibleResult > result {
			result = possibleResult
		}
	}
	fmt.Println("Part 2:", result)
}

func day16beam(lines *[]string, set *map[int]bool, y int, x int, direction string, setWithDirections *map[string]bool) {
	var exists bool
	var tileValue int
	var tile, tileValueWithDirection string
	for {
		tile = string((*lines)[y][x])
		if tile == "#" {
			return
		}
		tileValue = 1000*y + x
		(*set)[tileValue] = true
		tileValueWithDirection = direction + strconv.Itoa(tileValue)
		_, exists = (*setWithDirections)[tileValueWithDirection]
		if exists {
			return
		}
		(*setWithDirections)[tileValueWithDirection] = true
		switch tile {
		case "/":
			switch direction {
			case "U":
				direction = "R"
			case "R":
				direction = "U"
			case "D":
				direction = "L"
			case "L":
				direction = "D"
			}
		case "\\":
			switch direction {
			case "U":
				direction = "L"
			case "R":
				direction = "D"
			case "D":
				direction = "R"
			case "L":
				direction = "U"
			}
		case "|":
			if direction == "L" || direction == "R" {
				direction = "U"
				day16beam(lines, set, y, x, "D", setWithDirections)
			}
		case "-":
			if direction == "U" || direction == "D" {
				direction = "R"
				day16beam(lines, set, y, x, "L", setWithDirections)
			}
		}
		switch direction {
		case "U":
			y--
		case "R":
			x++
		case "D":
			y++
		case "L":
			x--
		}
	}
}
