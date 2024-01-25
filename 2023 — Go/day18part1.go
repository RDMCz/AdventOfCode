package main

import (
	"fmt"
	"strconv"
	"strings"
)

func day18part1() {
	input := AoC("day18")

	// Move the miner based on the dig plan instructions, note the mined blocks (border)
	var nSteps, xCor, yCor, xMin, xMax, yMin, yMax, xDiff, yDiff int
	var direction string
	var fields []string

	set := map[int]bool{}
	set[0] = true
	xDiffMap := map[string]int{"U": 0, "R": 1, "D": 0, "L": -1}
	yDiffMap := map[string]int{"U": -1, "R": 0, "D": 1, "L": 0}

	for _, line := range splitByNewline(input) {
		fields = strings.Fields(line)
		direction = fields[0]
		nSteps, _ = strconv.Atoi(fields[1])
		xDiff = xDiffMap[direction]
		yDiff = yDiffMap[direction]
		for i := 0; i < nSteps; i++ {
			yCor += yDiff
			xCor += xDiff
			set[100000*yCor+xCor] = true
		}
		switch {
		case xCor < xMin:
			xMin = xCor
		case xCor > xMax:
			xMax = xCor
		case yCor < yMin:
			yMin = yCor
		case yCor > yMax:
			yMax = yCor
		}
	}

	// Convert to string representation (with dots and hashtags)
	var digPlanSB strings.Builder
	for y := yMin - 1; y <= yMax+1; y++ {
		for x := xMin - 1; x <= xMax+1; x++ {
			_, exists := set[100000*y+x]
			if exists {
				digPlanSB.WriteString("#")
			} else {
				digPlanSB.WriteString(".")
			}
		}
		digPlanSB.WriteString(".\r\n")
	}
	digPlan := digPlanSB.String()

	// Dig out the interior
	var isInsideTrench bool
	var lookaheadIndex int
	var charStr, prevCharStr, lookaheadCharStr, l1, l2, l3, l4 string
	result := 0
	lines := splitByNewline(digPlan)
	for lineIndex, line := range lines {
		isInsideTrench = false
		for charIndex, char := range line {
			charStr = string(char)
			if charIndex != 0 {
				prevCharStr = string(line[charIndex-1])
			}
			if charStr == "." {
				if isInsideTrench {
					result++
				} else {
				}
			} else {
				result++
				if prevCharStr == "." {
					lookaheadCharStr = string(line[charIndex+1])
					if lookaheadCharStr == "." {
						isInsideTrench = !isInsideTrench
					} else {
						lookaheadIndex = 2
						for {
							lookaheadCharStr = string(line[charIndex+lookaheadIndex])
							if lookaheadCharStr == "." {
								l1 = string(lines[lineIndex-1][charIndex])
								l2 = string(lines[lineIndex-1][charIndex+lookaheadIndex-1])
								l3 = string(lines[lineIndex+1][charIndex])
								l4 = string(lines[lineIndex+1][charIndex+lookaheadIndex-1])
								if !((l1 == "#" && l2 == "#" && l3 == "." && l4 == ".") || (l1 == "." && l2 == "." && l3 == "#" && l4 == "#")) {
									isInsideTrench = !isInsideTrench
								}
								break
							}
							lookaheadIndex++
						}
					}
				}
			}
		}
	}

	fmt.Println(result)
}
