package main

import "fmt"

const day14emptySpace uint8 = 46
const day14roundRock uint8 = 79
const day14cubeRock uint8 = 35

var day14value uint8
var day14bestEmpty int

func day14north(platform *[][]uint8, xLen int, yLen int) {
	for x := 0; x < xLen; x++ {
		day14bestEmpty = yLen
		for y := 0; y < yLen; y++ {
			day14value = (*platform)[y][x]
			if day14bestEmpty == yLen && day14value == day14emptySpace {
				day14bestEmpty = y
			} else if day14value == day14cubeRock {
				day14bestEmpty = y + 1
			} else if day14value == day14roundRock {
				if y > day14bestEmpty {
					(*platform)[day14bestEmpty][x] = day14roundRock
					day14bestEmpty++
					(*platform)[y][x] = day14emptySpace
				} else if y == day14bestEmpty {
					day14bestEmpty++
				}
			}
		}
	}
}

func day14south(platform *[][]uint8, xLen int, yLen int) {
	for x := 0; x < xLen; x++ {
		day14bestEmpty = -1
		for y := yLen - 1; y >= 0; y-- {
			day14value = (*platform)[y][x]
			if day14bestEmpty == -1 && day14value == day14emptySpace {
				day14bestEmpty = y
			} else if day14value == day14cubeRock {
				day14bestEmpty = y - 1
			} else if day14value == day14roundRock {
				if y < day14bestEmpty {
					(*platform)[day14bestEmpty][x] = day14roundRock
					day14bestEmpty--
					(*platform)[y][x] = day14emptySpace
				} else if y == day14bestEmpty {
					day14bestEmpty--
				}
			}
		}
	}
}

func day14west(platform *[][]uint8, xLen int, yLen int) {
	for y := 0; y < yLen; y++ {
		day14bestEmpty = xLen
		for x := 0; x < xLen; x++ {
			day14value = (*platform)[y][x]
			if day14bestEmpty == xLen && day14value == day14emptySpace {
				day14bestEmpty = x
			} else if day14value == day14cubeRock {
				day14bestEmpty = x + 1
			} else if day14value == day14roundRock {
				if x > day14bestEmpty {
					(*platform)[y][day14bestEmpty] = day14roundRock
					day14bestEmpty++
					(*platform)[y][x] = day14emptySpace
				} else if x == day14bestEmpty {
					day14bestEmpty++
				}
			}
		}
	}
}

func day14east(platform *[][]uint8, xLen int, yLen int) {
	for y := 0; y < yLen; y++ {
		day14bestEmpty = -1
		for x := xLen - 1; x >= 0; x-- {
			day14value = (*platform)[y][x]
			if day14bestEmpty == -1 && day14value == day14emptySpace {
				day14bestEmpty = x
			} else if day14value == day14cubeRock {
				day14bestEmpty = x - 1
			} else if day14value == day14roundRock {
				if x < day14bestEmpty {
					(*platform)[y][day14bestEmpty] = day14roundRock
					day14bestEmpty--
					(*platform)[y][x] = day14emptySpace
				} else if x == day14bestEmpty {
					day14bestEmpty--
				}
			}
		}
	}
}

func day14getResult(platform *[][]uint8, yLen int) int {
	result := 0
	for y, row := range *platform {
		for _, char := range row {
			if char == day14roundRock {
				result += yLen - y
			}
		}
	}
	return result
}

func day14() {
	lines := splitByNewline(AoC("day14"))
	yLen := len(lines)
	xLen := len(lines[0])
	platform := make([][]uint8, yLen)

	for i := range platform {
		platform[i] = make([]uint8, xLen)
		for j := range lines[i] {
			platform[i][j] = lines[i][j]
		}
	}

	// Part 1
	day14north(&platform, xLen, yLen)
	result := day14getResult(&platform, yLen)
	fmt.Println("Part 1:", result)

	// Part 2
	nCycles := 1000000000
	for cycle := 0; cycle < nCycles; cycle++ {
		day14north(&platform, xLen, yLen)
		day14west(&platform, xLen, yLen)
		day14south(&platform, xLen, yLen)
		day14east(&platform, xLen, yLen)
	}
	result = day14getResult(&platform, yLen)
	fmt.Println("Part 2:", result)
}
