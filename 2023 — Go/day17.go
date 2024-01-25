package main

import (
	"fmt"
	"math"
	"slices"
	"strconv"
)

type day17pseudoPQElement struct{ y, x, combined int }

func day17addToSet(set *map[int]bool, y int, x int) {
	(*set)[1000*y+x] = true
}

func day17isInSet(set *map[int]bool, y int, x int) bool {
	_, exists := (*set)[1000*y+x]
	return exists
}

func day17moveAgainstDirection(allDirections *[][]string, dY *int, dX *int) {
	switch (*allDirections)[*dY][*dX] {
	case "U":
		*dY++
	case "D":
		*dY--
	case "L":
		*dX++
	case "R":
		*dX--
	}
}

func day17part1() {
	var number, index, yCor, xCor, price, dY, dX, neiY, neiX, neiPrice, neiValue int
	var lastDirection, lastDirections string
	var currentNode *day17pseudoPQElement

	lines := splitByNewline(AoC("day17example"))
	yLen := len(lines)
	xLen := len(lines[0])
	unreachablePrice := yLen * xLen
	endY := yLen - 1
	endX := xLen - 1
	values, prices, euclidean := make([][]int, yLen), make([][]int, yLen), make([][]int, yLen)
	allDirections := make([][]string, yLen)
	debug := make([][]string, yLen)

	for y := 0; y < yLen; y++ {
		values[y], prices[y], euclidean[y] = make([]int, xLen), make([]int, xLen), make([]int, xLen)
		allDirections[y] = make([]string, xLen)
		debug[y] = make([]string, xLen)
		for x := 0; x < xLen; x++ {
			number, _ = strconv.Atoi(string(lines[y][x]))
			values[y][x] = number
			debug[y][x] = strconv.Itoa(number)
			prices[y][x] = unreachablePrice
			number = int(math.Sqrt(math.Pow(float64(endY-y), 2) + math.Pow(float64(endX-x), 2)))
			euclidean[y][x] = number
			allDirections[y][x] = "-"
		}
	}
	startY, startX := 0, 0
	prices[startY][startX] = 0

	pseudoPQ := make([]*day17pseudoPQElement, 0)
	start := day17pseudoPQElement{startY, startX, 0}
	pseudoPQ = append(pseudoPQ, &start)
	pseudoSet := make(map[int]bool)

	for {
		// Pop element from priority queue
		index = 0
		number = (*pseudoPQ[0]).combined
		for i, el := range pseudoPQ {
			if (*el).combined < number {
				number = (*el).combined
				index = i
			}
		}
		currentNode = pseudoPQ[index]
		pseudoPQ = slices.Delete(pseudoPQ, index, index+1)
		// Get element's data, stop if we're at the end
		yCor = (*currentNode).y
		xCor = (*currentNode).x
		price = prices[yCor][xCor]
		if yCor == endY && xCor == endX {
			break
		}
		// Add current location to visited locations set
		day17addToSet(&pseudoSet, yCor, xCor)
		// Determine direction
		lastDirection = allDirections[yCor][xCor]
		lastDirections = lastDirection
		dY = yCor
		dX = xCor
		day17moveAgainstDirection(&allDirections, &dY, &dX)
		lastDirections += allDirections[dY][dX]
		day17moveAgainstDirection(&allDirections, &dY, &dX)
		lastDirections += allDirections[dY][dX]
		// Check neighbours, add them to priority queue if necessary
		if yCor != 0 && lastDirection != "D" && lastDirections != "UUU" {
			neiY = yCor - 1
			neiPrice = prices[neiY][xCor]
			neiValue = values[neiY][xCor]
			if !day17isInSet(&pseudoSet, neiY, xCor) && price+neiValue < neiPrice {
				neiPrice = price + neiValue
				prices[neiY][xCor] = neiPrice
				neighbour := day17pseudoPQElement{neiY, xCor, neiPrice + euclidean[neiY][xCor]}
				pseudoPQ = append(pseudoPQ, &neighbour)
				allDirections[neiY][xCor] = "U"
			}
		}
		if yCor != yLen-1 && lastDirection != "U" && lastDirections != "DDD" {
			neiY = yCor + 1
			neiPrice = prices[neiY][xCor]
			neiValue = values[neiY][xCor]
			if !day17isInSet(&pseudoSet, neiY, xCor) && price+neiValue < neiPrice {
				neiPrice = price + neiValue
				prices[neiY][xCor] = neiPrice
				neighbour := day17pseudoPQElement{neiY, xCor, neiPrice + euclidean[neiY][xCor]}
				pseudoPQ = append(pseudoPQ, &neighbour)
				allDirections[neiY][xCor] = "D"
			}
		}
		if xCor != 0 && lastDirection != "R" && lastDirections != "LLL" {
			neiX = xCor - 1
			neiPrice = prices[yCor][neiX]
			neiValue = values[yCor][neiX]
			if !day17isInSet(&pseudoSet, yCor, neiX) && price+neiValue < neiPrice {
				neiPrice = price + neiValue
				prices[yCor][neiX] = neiPrice
				neighbour := day17pseudoPQElement{yCor, neiX, neiPrice + euclidean[yCor][neiX]}
				pseudoPQ = append(pseudoPQ, &neighbour)
				allDirections[yCor][neiX] = "L"
			}
		}
		if xCor != xLen-1 && lastDirection != "L" && lastDirections != "RRR" {
			neiX = xCor + 1
			neiPrice = prices[yCor][neiX]
			neiValue = values[yCor][neiX]
			if !day17isInSet(&pseudoSet, yCor, neiX) && price+neiValue < neiPrice {
				neiPrice = price + neiValue
				prices[yCor][neiX] = neiPrice
				neighbour := day17pseudoPQElement{yCor, neiX, neiPrice + euclidean[yCor][neiX]}
				pseudoPQ = append(pseudoPQ, &neighbour)
				allDirections[yCor][neiX] = "R"
			}
		}
	}

	result := 0
	dY = endY
	dX = endX
	for dY != startY || dX != startX {
		result += values[dY][dX]
		debug[dY][dX] = "#"
		day17moveAgainstDirection(&allDirections, &dY, &dX)
	}
	fmt.Println(result)

	for y := 0; y < len(debug); y++ {
		for x := 0; x < len(debug[y]); x++ {
			fmt.Print(debug[y][x])
		}
		fmt.Println()
	}
}
