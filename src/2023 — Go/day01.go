package main

import (
	"fmt"
	"strconv"
	"strings"
	"unicode"
)

func day01part1() {
	input := AoC("day01")
	result := 0

	for _, line := range splitByNewline(input) {
		var lineNum string

		for _, char := range line {
			if unicode.IsDigit(char) {
				lineNum = string(char)
				break
			}
		}

		for i := len(line) - 1; i >= 0; i-- {
			if unicode.IsDigit(rune(line[i])) {
				lineNum += string(line[i])
				break
			}
		}

		lineNumConverted, _ := strconv.Atoi(lineNum)
		result += lineNumConverted
	}

	fmt.Println(result)
}

func day01part2() {
	input := AoC("day01")
	numWords := map[string]int{"one": 3, "two": 3, "three": 5, "four": 4, "five": 4, "six": 3, "seven": 5, "eight": 5, "nine": 4}
	numWord2num := map[string]string{"one": "1", "two": "2", "three": "3", "four": "4", "five": "5", "six": "6", "seven": "7", "eight": "8", "nine": "9"}
	beginLetters := "otfsen"
	endLetters := "eorxnt"
	result := 0

	for _, line := range splitByNewline(input) {
		var lineNum string

	charinline:
		for i, char := range line {
			if unicode.IsDigit(char) {
				lineNum = string(char)
				break
			}

			if strings.Contains(beginLetters, string(char)) {
				for numWord, length := range numWords {
					if i+length < len(line)+1 && numWord == line[i:i+length] {
						lineNum = numWord2num[numWord]
						break charinline
					}
				}
			}
		}

	charinlinereversed:
		for i := len(line) - 1; i >= 0; i-- {
			if unicode.IsDigit(rune(line[i])) {
				lineNum += string(line[i])
				break
			}

			if strings.Contains(endLetters, string(line[i])) {
				for numWord, length := range numWords {
					if i-length >= -1 && numWord == line[i-length+1:i+1] {
						lineNum += numWord2num[numWord]
						break charinlinereversed
					}
				}
			}
		}

		lineNumConverted, _ := strconv.Atoi(lineNum)
		result += lineNumConverted
	}

	fmt.Println(result)
}
