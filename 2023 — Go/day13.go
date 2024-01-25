package main

import (
	"fmt"
	"strings"
)

func day13part1() {
	patterns := strings.Split(strings.ReplaceAll(AoC("day13"), "\r\n", "\n"), "\n\n")

	var secondIteration bool
	var nLines, checkIndex, rowLen int
	var transposed string
	var lines []string

	result := 0
	for _, pattern := range patterns {
		secondIteration = false
	patterncheck:
		for {
			if secondIteration {
				transposed = ""
				for i := 0; i < rowLen; i++ {
					for _, line := range lines {
						transposed += string(line[i])
					}
					if i != rowLen-1 {
						transposed += "\n"
					}
				}
				pattern = transposed
			}
			lines = splitByNewline(pattern)
			nLines = len(lines)
			rowLen = len(lines[0])
			for i, line := range lines {
				if i != 0 && line == lines[i-1] {
					checkIndex = 1
					for {
						if i-1-checkIndex == -1 || i+checkIndex == nLines {
							if secondIteration {
								result += i
							} else {
								result += i * 100
							}
							break patterncheck
						}
						if lines[i-1-checkIndex] != lines[i+checkIndex] {
							break
						}
						checkIndex++
					}
				}

			}
			secondIteration = true
		}
	}

	fmt.Println(result)
}

func day13stringCompare(s1 string, s2 string) bool {
	if s1 == s2 {
		return false
	}
	var ch1, ch2 string
	smudgeUsed := false
	for i := 0; i < len(s1); i++ {
		ch1 = string(s1[i])
		ch2 = string(s2[i])
		if ch1 != ch2 {
			if smudgeUsed {
				return false
			} else {
				smudgeUsed = true
			}
		}
	}
	return true
}

func day13part2() {
	patterns := strings.Split(strings.ReplaceAll(AoC("day13"), "\r\n", "\n"), "\n\n")

	var secondIteration, smudgeUsed bool
	var nLines, checkIndex, rowLen int
	var transposed string
	var lines []string

	result := 0
	for _, pattern := range patterns {
		secondIteration = false
	patterncheck:
		for {
			if secondIteration {
				transposed = ""
				for i := 0; i < rowLen; i++ {
					for _, line := range lines {
						transposed += string(line[i])
					}
					if i != rowLen-1 {
						transposed += "\n"
					}
				}
				pattern = transposed
			}
			lines = splitByNewline(pattern)
			nLines = len(lines)
			rowLen = len(lines[0])
			for i, line := range lines {
				if i != 0 && (line == lines[i-1] || day13stringCompare(line, lines[i-1])) {
					smudgeUsed = !(line == lines[i-1])
					checkIndex = 1
					for {
						if i-1-checkIndex == -1 || i+checkIndex == nLines {
							if smudgeUsed {
								if secondIteration {
									result += i
								} else {
									result += i * 100
								}
								break patterncheck
							}
							break // mirrors but smudge not used
						}
						if smudgeUsed && lines[i-1-checkIndex] != lines[i+checkIndex] {
							break
						}
						if !smudgeUsed && day13stringCompare(lines[i-1-checkIndex], lines[i+checkIndex]) {
							smudgeUsed = true
						}
						checkIndex++
					}
				}

			}
			secondIteration = true
		}
	}

	fmt.Println(result)
}
