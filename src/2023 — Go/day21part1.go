package main

import "fmt"

func day21part1() {
	CORCODE := 1000
	NSTEPS := 64
	lines := splitByNewline(AoC("day21"))
	yLen := len(lines)
	xLen := len(lines[0])
	area := make([][]bool, yLen)
	set1 := make(map[int]bool)

	for y := 0; y < yLen; y++ {
		area[y] = make([]bool, xLen)
		for x := 0; x < xLen; x++ {
			area[y][x] = lines[y][x] != 35 /*#*/
			if lines[y][x] == 83 /*S*/ {
				set1[CORCODE*y+x] = true
			}
		}
	}

	var y, x int
	var set2 map[int]bool

	for i := 0; i < NSTEPS; i++ {
		set2 = make(map[int]bool)
		for key, value := range set1 {
			set2[key] = value // Deep copy set1->set2
		}
		set1 = make(map[int]bool)
		for key, _ := range set2 {
			y = key / CORCODE
			x = key - (y * CORCODE)
			if y != 0 && area[y-1][x] {
				set1[CORCODE*(y-1)+x] = true
			}
			if y != yLen-1 && area[y+1][x] {
				set1[CORCODE*(y+1)+x] = true
			}
			if x != 0 && area[y][x-1] {
				set1[CORCODE*y+(x-1)] = true
			}
			if x != xLen-1 && area[y][x+1] {
				set1[CORCODE*y+(x+1)] = true
			}
		}
	}

	fmt.Println(len(set1))
}
