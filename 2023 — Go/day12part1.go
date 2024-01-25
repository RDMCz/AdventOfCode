package main

import (
	"fmt"
	"math"
	"strconv"
	"strings"
)

func day12part1() {
	input := AoC("day12")

	var nUnknowns, possibilityIndex, nArrangements int
	var i, nPossibilities int64
	var springs, possibilityUnknowns, possibility, charStr, arrangementNumbers, correctArrangementNumbers string
	var fields, springGroups []string

	replacer := strings.NewReplacer("0", ".", "1", "#")
	result := 0

	for _, line := range splitByNewline(input) {
		fields = strings.Fields(line)
		springs = fields[0]
		correctArrangementNumbers = fields[1] + ","

		nUnknowns = strings.Count(springs, "?")
		nPossibilities = int64(math.Pow(2, float64(nUnknowns))) - 1
		nArrangements = 0
		for i = 0; i <= nPossibilities; i++ {
			possibilityUnknowns = strconv.FormatInt(i, 2)
			possibilityUnknowns = replacer.Replace(strings.Repeat("0", nUnknowns-len(possibilityUnknowns)) + possibilityUnknowns)
			possibility = ""
			possibilityIndex = 0
			for _, char := range springs {
				charStr = string(char)
				if charStr == "?" {
					possibility += string(possibilityUnknowns[possibilityIndex])
					possibilityIndex++
				} else {
					possibility += charStr
				}
			}
			springGroups = strings.Split(possibility, ".")
			arrangementNumbers = ""
			for _, springGroup := range springGroups {
				if springGroup != "" {
					arrangementNumbers += strconv.Itoa(len(springGroup)) + ","
				}
			}
			if arrangementNumbers == correctArrangementNumbers {
				nArrangements++
			}
		}
		result += nArrangements
	}

	fmt.Println(result)
}
