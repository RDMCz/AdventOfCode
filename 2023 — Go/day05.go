package main

import (
	"fmt"
	"strconv"
	"strings"
	"unicode"
)

func day05getSeedsStringArray(source string) []string {
	return strings.Fields(splitByNewline(AoC(source))[0])[1:]
}

func day05getMaps(source string) [7][]int {
	input := AoC(source)

	var v1, v2, v3 int
	var maps [7][]int

	mapIndex := -1
	for _, line := range splitByNewline(input) {
		if line == "" {
			mapIndex++
		} else if unicode.IsDigit(rune(line[0])) {
			_, _ = fmt.Sscanf(line, "%d %d %d", &v1, &v2, &v3)
			maps[mapIndex] = append(maps[mapIndex], v1, v2, v2+v3-1)
		}
	}

	return maps
}

func day05getLocation(number int, maps *[7][]int) int {
mapsloop:
	for _, mapa := range *maps {
		for i := 0; i < len(mapa); i += 3 {
			if number >= mapa[i+1] && number <= mapa[i+2] {
				number = mapa[i] + (number - mapa[i+1])
				continue mapsloop
			}
		}
	}
	return number
}

func day05part1() {
	source := "day05"
	seedsStr := day05getSeedsStringArray(source)
	maps := day05getMaps(source)
	result := 999999999

	var seed, location int
	for _, seedStr := range seedsStr {
		seed, _ = strconv.Atoi(seedStr)
		location = day05getLocation(seed, &maps)
		if location < result {
			result = location
		}
	}

	fmt.Println(result)
}

func day05part2() {
	source := "day05"
	seedsStr := day05getSeedsStringArray(source)
	maps := day05getMaps(source)
	result := 999999999

	var firstSeed, nSeeds, location int
	for i := 0; i < len(seedsStr); i += 2 {
		firstSeed, _ = strconv.Atoi(seedsStr[i])
		nSeeds, _ = strconv.Atoi(seedsStr[i+1])
		for seedN := firstSeed; seedN < firstSeed+nSeeds; seedN++ {
			location = day05getLocation(seedN, &maps)
			if location < result {
				result = location
			}
		}
		//fmt.Printf("%d/%d\n", i/2+1, len(seedsStr)/2)
	}

	fmt.Println(result)
}
