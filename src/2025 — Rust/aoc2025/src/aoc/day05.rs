use crate::aoc::util;

pub fn parts_1_and_2() {
    let input = util::read_input("day05.txt");
    let mut input_parts = input.split("\n\n");

    let input_part1 = input_parts.next().unwrap();
    let mut input_part1_parsed_and_sorted: Vec<(u64, u64)> = Vec::new();

    for line in input_part1.lines() {
        let mut line_parts = line.split("-");
        input_part1_parsed_and_sorted.push((
            line_parts.next().unwrap().parse().unwrap(),
            line_parts.next().unwrap().parse().unwrap(),
        ));
    }

    input_part1_parsed_and_sorted.sort();

    let mut mins: Vec<u64> = Vec::with_capacity(input_part1_parsed_and_sorted.len());
    let mut maxs: Vec<u64> = Vec::with_capacity(input_part1_parsed_and_sorted.len());

    'outer: for pair in &input_part1_parsed_and_sorted {
        let min = pair.0;
        let max = pair.1;

        // Doing this on sorted input is enough to prevent overlapping ranges
        for i in 0..mins.len() {
            if min >= mins[i] && min <= maxs[i] {
                if max > maxs[i] {
                    maxs[i] = max; // This range starts inside other range, but ends later; so just update other range's end
                } // Else there is already a range that entirely covers this range
                continue 'outer;
            }
        }

        // If we didn't `continue 'outer`, than this range does not overlap with any other range
        mins.push(min);
        maxs.push(max);
    }

    let mut result = 0;
    let input_part2 = input_parts.next().unwrap();

    'outer: for line in input_part2.lines() {
        let number: u64 = line.parse().unwrap();
        // Is number in any range?
        for i in 0..mins.len() {
            if number >= mins[i] && number <= maxs[i] {
                result += 1;
                continue 'outer;
            }
        }
    }

    println!("Day 05 Part 1: {result}");

    // How many numbers are there in all of the (non-overlapping) ranges?
    let mut result = 0;

    for i in 0..mins.len() {
        result += (maxs[i] - mins[i]) + 1;
    }

    println!("Day 05 Part 2: {result}");
}
