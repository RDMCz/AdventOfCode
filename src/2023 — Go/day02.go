package main

import (
	"fmt"
	"strings"
)

func day02part1() {
	input := AoC("day02")

	var gameN, nCubes int
	var color string
	var lineParts, gameDraws, cubeDraws []string

	maxCubes := map[string]int{"red": 12, "green": 13, "blue": 14}
	result := 0

game:
	for _, line := range splitByNewline(input) {
		lineParts = strings.Split(line, ":")
		_, _ = fmt.Sscanf(lineParts[0], "Game %d", &gameN)
		gameDraws = strings.Split(lineParts[1], ";")
		for _, gameDraw := range gameDraws {
			cubeDraws = strings.Split(gameDraw, ",")
			for _, cubeDraw := range cubeDraws {
				_, _ = fmt.Sscanf(cubeDraw, " %d %s", &nCubes, &color)
				if nCubes > maxCubes[color] {
					continue game
				}
			}
		}
		result += gameN
	}

	fmt.Println(result)
}

func day02part2() {
	input := AoC("day02")

	var nCubes int
	var color string
	var lineParts, gameDraws, cubeDraws []string

	colorIndexes := map[string]int{"red": 0, "green": 1, "blue": 2}
	result := 0

	for _, line := range splitByNewline(input) {
		maxCubes := [...]int{0, 0, 0}

		lineParts = strings.Split(line, ":")
		gameDraws = strings.Split(lineParts[1], ";")
		for _, gameDraw := range gameDraws {
			cubeDraws = strings.Split(gameDraw, ",")
			for _, cubeDraw := range cubeDraws {
				_, _ = fmt.Sscanf(cubeDraw, " %d %s", &nCubes, &color)
				index := colorIndexes[color]
				if nCubes > maxCubes[index] {
					maxCubes[index] = nCubes
				}
			}
		}

		result += maxCubes[0] * maxCubes[1] * maxCubes[2]
	}

	fmt.Println(result)
}
