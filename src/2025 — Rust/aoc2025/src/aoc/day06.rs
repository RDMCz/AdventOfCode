use crate::aoc::util;

pub fn part1() {
    let input = util::read_input("day06.txt");

    let n_lines = input.lines().count();

    let parsed_numbers: Vec<Vec<u64>> = input
        .lines()
        .take(n_lines - 1)
        .map(|line| {
            line.split_ascii_whitespace()
                .map(|number| number.parse().unwrap())
                .collect()
        })
        .collect();

    let mut result = 0;

    for (index, operation) in input
        .lines()
        .last()
        .unwrap()
        .split_ascii_whitespace()
        .enumerate()
    {
        if operation == "+" {
            result += parsed_numbers
                .iter()
                .fold(0, |acc, parsed_line| acc + parsed_line[index]);
        } else {
            result += parsed_numbers
                .iter()
                .fold(1, |acc, parsed_line| acc * parsed_line[index]);
        }
    }

    println!("Day 06 Part 1: {result}");
}

pub fn part2() {
    let input: Vec<Vec<char>> = util::read_input("day06.txt")
        .lines()
        .map(|line| line.chars().collect())
        .collect();

    let mut input_transposed = String::new();

    for i in 0..input[0].len() {
        input_transposed.push_str(&format!(
            "{}\n",
            input
                .iter()
                .fold(String::with_capacity(5), |mut acc, vec| {
                    acc.push(vec[i]);
                    acc
                })
                .trim()
        ));
    }

    let mut result: u64 = 0;

    for problem in input_transposed.split("\n\n") {
        if problem.split("\n").next().unwrap().chars().last().unwrap() == '+' {
            result += problem
                .split("\n")
                .map(|line| {
                    line.trim_matches(|ch: char| !ch.is_digit(10))
                        .parse::<u64>()
                        .unwrap_or(0)
                })
                .sum::<u64>();
        } else {
            result += problem
                .split("\n")
                .map(|line| {
                    line.trim_matches(|ch: char| !ch.is_digit(10))
                        .parse::<u64>()
                        .unwrap_or(1)
                })
                .product::<u64>();
        }
    }

    println!("Day 06 Part 2: {result}");
}
