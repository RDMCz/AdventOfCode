package main

import (
	"fmt"
	"strconv"
	"strings"
	"unicode"
)

func day03isSymbol(possibleSymbol uint8) bool {
	return possibleSymbol != 46 && !unicode.IsDigit(rune(possibleSymbol))
}

func day03part1() {
	input := AoC("day03")

	var left, right int
	var isNextToSymbol bool

	lines := splitByNewline(input)
	xLen := len(lines[0])
	yLen := len(lines)
	result := 0
	for y, line := range lines {
		for x, char := range line {
			if unicode.IsDigit(char) && (x == 0 || !unicode.IsDigit(rune(line[x-1]))) {
				left, right = x, x
				for right+1 < xLen && unicode.IsDigit(rune(line[right+1])) {
					right++
				}
				isNextToSymbol = false
				if left != 0 { // Left side
					if y != 0 && day03isSymbol(lines[y-1][left-1]) { // Upper-left corner
						isNextToSymbol = true
					} else if day03isSymbol(line[left-1]) { // Middle-left
						isNextToSymbol = true
					} else if y != yLen-1 && day03isSymbol(lines[y+1][left-1]) { // Lower-left corner
						isNextToSymbol = true
					}
				}
				if !isNextToSymbol && right != xLen-1 { // Right side
					if y != 0 && day03isSymbol(lines[y-1][right+1]) { // Upper-right corner
						isNextToSymbol = true
					} else if day03isSymbol(line[right+1]) { // Middle-right
						isNextToSymbol = true
					} else if y != yLen-1 && day03isSymbol(lines[y+1][right+1]) { // Lower-right corner
						isNextToSymbol = true
					}
				}
				if !isNextToSymbol && y != 0 { // Ceiling
					for i := left; i <= right; i++ {
						if day03isSymbol(lines[y-1][i]) {
							isNextToSymbol = true
							continue
						}
					}
				}
				if !isNextToSymbol && y != yLen-1 { // Floor
					for i := left; i <= right; i++ {
						if day03isSymbol(lines[y+1][i]) {
							isNextToSymbol = true
							continue
						}
					}
				}
				if isNextToSymbol {
					number, _ := strconv.Atoi(line[left : right+1])
					result += number
				}
			}
		}
	}

	fmt.Println(result)
}

func day03part2() {
	input := AoC("day03")

	var numY, numX, left, right, gearRatio int

	lines := splitByNewline(input)
	xLen := len(lines[0])
	result := 0

	// Wrap lines into dotted box
	linesSlice := lines[:]
	for i := range linesSlice {
		linesSlice[i] = "." + linesSlice[i] + "."
	}
	appendString := strings.Repeat(".", xLen+1)
	linesSlice = append(linesSlice, appendString)
	linesSlice = append([]string{appendString}, linesSlice...)
	yLen := len(linesSlice)

	for y, line := range linesSlice {
		if y == 0 || y == yLen-1 {
			continue
		}

		for x := range line {
			if linesSlice[y][x] == 42 {
				var adjNumCors []int
				for i := -1; i <= 1; i += 2 {
					if unicode.IsDigit(rune(linesSlice[y][x+i])) { // Left; Right
						adjNumCors = append(adjNumCors, y, x+i)
					}
					if unicode.IsDigit(rune(linesSlice[y+i][x])) { // Up; Down
						adjNumCors = append(adjNumCors, y+i, x)
					} else {
						if unicode.IsDigit(rune(linesSlice[y+i][x-1])) { // UpLeft; DownLeft
							adjNumCors = append(adjNumCors, y+i, x-1)
						}
						if unicode.IsDigit(rune(linesSlice[y+i][x+1])) { // UpRight; DownRight
							adjNumCors = append(adjNumCors, y+i, x+1)
						}
					}
				}
				if len(adjNumCors) == 4 {
					gearRatio = 1
					for i := 0; i <= 2; i += 2 {
						numY = adjNumCors[i]
						numX = adjNumCors[i+1]
						left, right = numX, numX
						for unicode.IsDigit(rune(linesSlice[numY][right+1])) {
							right++
						}
						for unicode.IsDigit(rune(linesSlice[numY][left-1])) {
							left--
						}
						number, _ := strconv.Atoi(linesSlice[numY][left : right+1])
						gearRatio *= number
					}
					result += gearRatio
				}
			}
		}
	}

	fmt.Println(result)
}
