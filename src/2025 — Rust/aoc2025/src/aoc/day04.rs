use crate::aoc::util;

pub fn parts_1_and_2() {
    let mut grid: Vec<Vec<_>> =
        util::get_grid_with_added_border(&util::read_input("day04.txt").lines().collect(), ".", 1)
            .iter()
            .map(|line| line.chars().map(|c| if c == '@' { 1 } else { 0 }).collect())
            .collect();

    let width = grid[0].len();
    let height = grid.len();

    let mut result = 0;
    let mut is_part1_done = false;
    let mut did_anything_change = true;

    while did_anything_change {
        did_anything_change = false;

        for y in 1..height {
            for x in 1..width {
                if grid[y][x] == 1 {
                    if [
                        &grid[y - 1][x - 1..x + 2],
                        &grid[y][x - 1..x + 2],
                        &grid[y + 1][x - 1..x + 2],
                    ]
                    .concat()
                    .iter()
                    .sum::<i32>()
                        - 1
                        < 4
                    {
                        did_anything_change = true;
                        result += 1;
                        if is_part1_done {
                            grid[y][x] = 0;
                        }
                    }
                }
            }
        }

        if !is_part1_done {
            println!("Day 04 Part 1: {result}");
            result = 0;
            is_part1_done = true;
        }
    }

    println!("Day 04 Part 2: {result}");
}
