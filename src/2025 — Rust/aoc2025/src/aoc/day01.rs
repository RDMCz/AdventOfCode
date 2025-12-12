use crate::aoc::util;

pub fn part1() {
    let input = util::read_input("day01.txt");

    let mut position = 50;
    let mut result = 0;

    for line in input.lines() {
        let multiplier = if line.starts_with("L") { -1 } else { 1 };
        let n_clicks: i32 = line.get(1..).unwrap().parse().unwrap();

        position += n_clicks * multiplier;

        if position.rem_euclid(100) == 0 {
            result += 1;
        }
    }

    println!("Day 01 Part 1: {result}");
}

pub fn part2() {
    let input = util::read_input("day01.txt");

    let mut current_position = 50;
    let mut result = 0;

    for line in input.lines() {
        let multiplier = if line.starts_with("L") { -1 } else { 1 };
        let n_clicks: i32 = line.get(1..).unwrap().parse().unwrap();

        let next_position = current_position + n_clicks * multiplier;

        while current_position != next_position {
            current_position += multiplier;
            if current_position.rem_euclid(100) == 0 {
                result += 1;
            }
        }
    }

    println!("Day 01 Part 2: {result}");
}
