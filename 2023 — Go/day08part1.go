package main

import (
	"fmt"
	"strconv"
	"strings"
)

func day08part1() {
	input := AoC("day08")
	lines := splitByNewline(input)

	var direction int
	var slice, fields []string
	mapa := make(map[string]int)
	index := 0

	for _, line := range lines[2:] {
		fields = strings.Fields(line)
		slice = append(slice, fields[0], fields[2][1:4], fields[3][:3])
		mapa[fields[0]] = index
		index += 3
	}

	replacer := strings.NewReplacer("L", "1", "R", "2")
	directions := replacer.Replace(lines[0])
	directionIndex := 0
	currentNode := "AAA"
	nSteps := 0
	for {
		direction, _ = strconv.Atoi(string(directions[directionIndex]))
		currentNode = slice[mapa[currentNode]+direction]
		nSteps++
		if currentNode == "ZZZ" {
			break
		}
		directionIndex = (directionIndex + 1) % len(directions)
	}

	fmt.Println(nSteps)
}
