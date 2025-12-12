use crate::aoc::util;
use std::collections::HashMap;

pub fn parts_1_and_2() {
    let input = util::read_input("day07.txt");
    let start_x = input.chars().position(|ch| ch == 'S').unwrap();

    let grid: Vec<Vec<char>> = input.lines().map(|line| line.chars().collect()).collect();
    let last_line_y = grid.len() - 1;

    let mut map: HashMap<(usize, usize), u64> = HashMap::new();
    let result2 = many_worlds_interpretation(1, start_x, last_line_y, &grid, &mut map);

    println!("Day 07 Part 1: {}", map.len());
    println!("Day 07 Part 2: {result2}");
}

fn many_worlds_interpretation(
    y: usize,
    x: usize,
    last_line_y: usize,
    grid: &Vec<Vec<char>>,
    map: &mut HashMap<(usize, usize), u64>,
) -> u64 {
    let mut current_y = y;
    let mut current_char = grid[current_y][x];

    while current_char != '^' {
        current_y += 1;
        if current_y == last_line_y {
            return 1;
        }
        current_char = grid[current_y][x];
    }

    if map.contains_key(&(current_y, x)) {
        return map[&(current_y, x)];
    }

    let mut subresult = 0;
    subresult += many_worlds_interpretation(current_y, x - 1, last_line_y, grid, map);
    subresult += many_worlds_interpretation(current_y, x + 1, last_line_y, grid, map);
    map.insert((current_y, x), subresult);
    subresult
}
