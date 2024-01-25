package main

import (
	"fmt"
	"slices"
	"strings"
)

func day15HASH(input string) int32 {
	var currentValue int32 = 0
	for _, char := range input {
		currentValue += char
		currentValue *= 17
		currentValue %= 256
	}
	return currentValue
}

func day15part1() {
	input := AoC("day15")
	var result int32 = 0
	for _, step := range strings.Split(input, ",") {
		result += day15HASH(step)
	}
	fmt.Println(result)
}

func day15part2() {
	input := AoC("day15")

	var stepLenMinusOneOrTwo int
	var boxN int32
	var label, otherLabel string

	boxes := make([][]string, 256)
	for i := 0; i < 256; i++ {
		boxes[i] = make([]string, 0)
	}

instructions:
	for _, step := range strings.Split(input, ",") {
		stepLenMinusOneOrTwo = len(step) - 1
		if string(step[stepLenMinusOneOrTwo]) == "-" {
			label = step[:stepLenMinusOneOrTwo]
			boxN = day15HASH(label)
			for index, item := range boxes[boxN] {
				otherLabel = strings.Split(item, "=")[0]
				if label == otherLabel {
					boxes[boxN] = slices.Delete(boxes[boxN], index, index+1)
					continue instructions
				}
			}
		} else {
			stepLenMinusOneOrTwo--
			label = step[:stepLenMinusOneOrTwo]
			boxN = day15HASH(label)
			for index, item := range boxes[boxN] {
				otherLabel = strings.Split(item, "=")[0]
				if label == otherLabel {
					boxes[boxN][index] = label + step[stepLenMinusOneOrTwo:]
					continue instructions
				}
			}
			boxes[boxN] = append(boxes[boxN], step)
		}
	}
	result := 0
	for boxIndex, box := range boxes {
		for lensIndex, lens := range box {
			result += (boxIndex + 1) * (lensIndex + 1) * int(lens[len(lens)-1]-48)
		}
	}
	fmt.Println(result)
}
