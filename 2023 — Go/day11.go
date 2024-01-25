package main

import (
	"fmt"
	"regexp"
	"strings"
)

func day11() {
	input := AoC("day11")
	part2expansion := 1000000
	part2expansion--

	var ix, iy, jx, jy, xLen1, yLen1, xLen2, yLen2 int
	var xs, ys, expandX, expandY []int
	var matches [][]int

	space := splitByNewline(input)
	nCols := len(space[0])

	re := regexp.MustCompile("#")

	for y, line := range space {
		if strings.Contains(line, "#") {
			matches = re.FindAllSubmatchIndex([]byte(line), -1)
			for _, match := range matches {
				xs = append(xs, match[0])
				ys = append(ys, y)
			}
		} else {
			expandY = append(expandY, y)
		}
	}

horizontalexpansion:
	for everyX := 0; everyX < nCols; everyX++ {
		for _, galaxyX := range xs {
			if everyX == galaxyX {
				continue horizontalexpansion
			}
		}
		expandX = append(expandX, everyX)
	}

	result1 := 0
	result2 := 0
	nPoints := len(xs)
	for i := 0; i < nPoints; i++ {
		for j := i + 1; j < nPoints; j++ {
			ix = xs[i]
			iy = ys[i]
			jx = xs[j]
			jy = ys[j]
			xLen1 = abs(ix - jx)
			yLen1 = abs(iy - jy)
			xLen2 = xLen1
			yLen2 = yLen1
			for _, e := range expandX {
				if (ix < jx && ix <= e && e < jx) || (jx < ix && jx <= e && e < ix) {
					xLen1++
					xLen2 += part2expansion
				}
			}
			for _, e := range expandY {
				if (iy < jy && iy <= e && e < jy) || (jy < iy && jy <= e && e < iy) {
					yLen1++
					yLen2 += part2expansion
				}
			}
			result1 += xLen1 + yLen1
			result2 += xLen2 + yLen2
		}
	}

	fmt.Println("Part 1:", result1)
	fmt.Println("Part 2:", result2)
}
