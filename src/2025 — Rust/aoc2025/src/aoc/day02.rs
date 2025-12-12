use crate::aoc::util;

pub fn part1() {
    let input = util::read_input("day02.txt");

    let mut result = 0;

    for range in input.split(",") {
        let mut parts = range.split("-");
        let mut current: u64 = parts.next().unwrap().parse().unwrap();
        let end: u64 = parts.next().unwrap().parse().unwrap();
        while current <= end {
            let half_mask = 10_u64.pow((current.to_string().len() / 2) as u32);
            let former_half = current / half_mask;
            let latter_half = current - (former_half * half_mask);

            if former_half == latter_half {
                result += current;
            }

            current += 1;
        }
    }

    println!("Day 02 Part 1: {result}");
}

pub fn part2() {
    let input = util::read_input("day02.txt");

    let mut result = 0;

    for range in input.split(",") {
        let mut parts = range.split("-");
        let mut current: u64 = parts.next().unwrap().parse().unwrap();
        let end: u64 = parts.next().unwrap().parse().unwrap();

        while current <= end {
            let current_str = current.to_string();

            let half_digits = current_str.len() / 2;

            for i in (1..half_digits + 1).rev() {
                if current_str
                    .chars()
                    .collect::<Vec<_>>()
                    .chunks(i)
                    .collect::<Vec<_>>()
                    .windows(2)
                    .all(|chunk_window| chunk_window[0] == chunk_window[1])
                {
                    result += current;
                    break;
                }
            }

            current += 1;
        }
    }

    println!("Day 02 Part 2: {result}");
}
