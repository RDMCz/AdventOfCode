package main

import (
	"fmt"
	"os"
	"reflect"
	"runtime"
	"strings"
	"time"
)

func main() {
	var fName string
	var startTimeDay time.Time
	startTimeTotal := time.Now()

	days := [...]func(){
		day01part1,
		day01part2,
		day02part1,
		day02part2,
		day03part1,
		day03part2,
		day04part1,
		day04part2,
		day05part1,
		//day05part2, // takes ~5 minutes
		day06part1,
		day06part2,
		day07part1,
		day07part2,
		day08part1,
		day09,
		day10part1,
		day10part2,
		day11,
		//day12part1, // takes ~8 seconds
		day13part1,
		day13part2,
		//day14, // part 2 takes 53 hours :)
		day15part1,
		day15part2,
		day16,
		day18part1,
		day19,
		day21part1,
	}

	for _, day := range days {
		fName = runtime.FuncForPC(reflect.ValueOf(day).Pointer()).Name()
		fmt.Printf("\n>> %s\n", fName[5:])
		startTimeDay = time.Now()
		day()
		fmt.Printf("[%s]\n", time.Since(startTimeDay))
	}

	fmt.Printf("\nTotal execution time: %s", time.Since(startTimeTotal))
}

func AoC(fileName string) string {
	b, err := os.ReadFile("input/" + fileName + ".txt")
	if err != nil {
		fmt.Print(err)
	}
	return string(b)
}

func splitByNewline(input string) []string {
	return strings.Split(strings.ReplaceAll(input, "\r\n", "\n"), "\n")
}

func abs(number int) int {
	if number < 0 {
		return -number
	}
	return number
}
