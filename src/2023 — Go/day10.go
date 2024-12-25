package main

import (
	"fmt"
	"strings"
)

func day10part1() {
	input := AoC("day10")

	var x, y int
	var currentPipe, direction string

	area := splitByNewline(input)

	for i, line := range area {
		if strings.Contains(line, "S") {
			y = i
			x = strings.Index(line, "S")
			break
		}
	}

	if strings.Contains("|7F", string(area[y-1][x])) {
		direction = "U"
	} else if strings.Contains("-7J", string(area[y][x+1])) {
		direction = "R"
	} else if strings.Contains("|LJ", string(area[y+1][x])) {
		direction = "D"
	} else if strings.Contains("-LF", string(area[y][x-1])) {
		direction = "L"
	}

	newDirection := map[string]string{
		"|U": "U", "|D": "D",
		"-R": "R", "-L": "L",
		"LD": "R", "LL": "U",
		"JR": "U", "JD": "L",
		"7U": "L", "7R": "D",
		"FU": "R", "FL": "D",
	}

	result := 0
	for {
		result++
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
		currentPipe = string(area[y][x])
		if currentPipe == "S" {
			break
		}
		direction = newDirection[currentPipe+direction]
	}

	result /= 2
	fmt.Println(result)
}

func day10part2() {
	var outside bool
	var xCor, yCor int // Souřadnice aktuální pozice při procházení
	var currentPipe, lastCornerPipe string
	var areaLoop [][]string // Obsahuje pouze loop, ostatní trubky zahozeny

	area := splitByNewline(AoC("day10"))
	rowLen := len(area[0])

	// Init areaLoop a aktuální pozice
	for i, line := range area {
		if strings.Contains(line, "S") { // Začínáme na startovní pozici 'S'
			yCor = i
			xCor = strings.Index(line, "S")
		}
		areaLoop = append(areaLoop, make([]string, rowLen))
	}

	// Okometricky zjistit ze zadání
	startPipe := "L"
	direction := "R"

	// Nová direction podle aktuální trubky a směru příjezdu do ní
	newDirection := map[string]string{
		"|U": "U", "|D": "D",
		"-R": "R", "-L": "L",
		"LD": "R", "LL": "U",
		"JR": "U", "JD": "L",
		"7U": "L", "7R": "D",
		"FU": "R", "FL": "D",
	}

	// Projet loop a nastavit hodnoty areaLoop
	for {
		switch direction {
		case "U":
			yCor--
		case "R":
			xCor++
		case "D":
			yCor++
		case "L":
			xCor--
		}
		currentPipe = string(area[yCor][xCor])
		areaLoop[yCor][xCor] = currentPipe
		if currentPipe == "S" {
			break
		}
		direction = newDirection[currentPipe+direction]
	}

	// Magie
	result := 0
	for y := 0; y < len(areaLoop); y++ {
		outside = true
		for x := 0; x < rowLen; x++ {
			currentPipe = areaLoop[y][x]
			if currentPipe == "S" {
				currentPipe = startPipe
			}
			if currentPipe == "" && !outside {
				result++
			} else if currentPipe == "|" {
				outside = !outside
			} else if currentPipe == "F" || currentPipe == "L" {
				lastCornerPipe = currentPipe
			} else if (lastCornerPipe == "F" && currentPipe == "J") || (lastCornerPipe == "L" && currentPipe == "7") {
				outside = !outside
			}
		}
	}
	fmt.Println(result)
}
