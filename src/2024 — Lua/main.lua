local time_start = os.time()

---[[
print("\n== Day 01 ==")
require("day01").parts1and2()

print("\n== Day 02 ==")
require("day02").parts1and2()

print("\n== Day 03 ==")
require("day03").parts1and2()

print("\n== Day 04 ==")
require("day04").parts1and2()

print("\n== Day 05 ==")
require("day05").parts1and2()       -- Day 05 Part 2 takes about 10 seconds

print("\n== Day 06 ==")
require("day06").parts1and2()       -- Day 06 Part 2 takes about 8 seconds

print("\n== Day 07 ==")
require("day07").parts1and2()       -- Day 07 Part 2 takes about 6 seconds

print("\n== Day 08 ==")
require("day08").part1()
require("day08").part2()

print("\n== Day 09 ==")
require("day09").part1()
require("day09").part2()            -- Day 09 Part 2 takes about 3 seconds

print("\n== Day 10 ==")
require("day10").parts1and2()

print("\n== Day 11 ==")
require("day11part1").part1iterative()

print("\n== Day 12 ==")
require("day12").part1()
require("day12").part2()            -- Day 12 Part 2 takes about 3 seconds

print("\n== Day 13 ==")
require("day13").part1or2(true)
require("day13").part1or2(false)

print("\n== Day 14 ==")
require("day14").part1()
require("day14").part2()

print("\n== Day 15 ==")
require("day15").part1()
require("day15").part2()

print("\n== Day 17 ==")
require("day17part1").part1()

print("\n== Day 18 ==")
require("day18").part1or2(true)
require("day18").part1or2(false)    -- Day 18 Part 2 takes about 30 seconds

print("\n== Day 19 ==")
require("day19").part1()
require("day19").part2()

print("\n== Day 20 ==")
require("day20").parts1and2()       -- Day 20 Part 2 takes about 2 seconds

print("\n== Day 22 ==")
require("day22").part1()
require("day22").part2()            -- Day 22 Part 2 takes about 3 seconds

print("\n== Day 24 ==")
require("day24part1").part1()

print("\n== Day 25 ==")
require("day25").part1()
--]]

print("\nTook approximately " .. os.difftime(os.time(), time_start) .. " seconds.")
