use crate::aoc::util;

pub fn part1() {
    let input = util::read_input("day03.txt");

    let mut result = 0;

    for line in input.lines() {
        let digit_1 = line.get(..line.len() - 1).unwrap().chars().max().unwrap(); // Search for the best digit (D1) in the whole line except for the last character
        let digit_1_pos = line.chars().position(|item| item == digit_1).unwrap(); // First occurence of the best digit (D1)
        let digit_2 = line.get(digit_1_pos + 1..).unwrap().chars().max().unwrap(); // Find the best digit (D2) after that occurence
        result += 10 * digit_1.to_digit(10).unwrap() + digit_2.to_digit(10).unwrap(); // result += 10 * D1 + D2
    }

    println!("Day 03 Part 1: {result}");
}

pub fn part2() {
    let input = util::read_input("day03.txt");
    let mut result = 0;

    // Same principle as in the first part
    for line in input.lines() {
        let mut left_border: i32 = -1;
        let mut right_border: i32 = 11;
        let mut subresult: String = String::with_capacity(12);

        for _ in 0..12 {
            // Find max in borders
            let in_search_range = line
                .get((left_border + 1) as usize..line.len() - right_border as usize)
                .unwrap();

            let max = in_search_range.chars().max().unwrap();

            subresult.push(max);

            // Update borders
            let index = in_search_range
                .chars()
                .position(|item| item == max)
                .unwrap() as i32;

            left_border += index + 1;
            right_border -= 1;
        }

        result += subresult.parse::<u64>().unwrap();
    }

    println!("Day 03 Part 2: {result}");
}
