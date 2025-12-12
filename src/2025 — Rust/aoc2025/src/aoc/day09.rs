use crate::aoc::util;
use std::collections::{BTreeSet, HashMap};

pub fn part1() {
    let input: Vec<_> = util::read_input("day09.txt")
        .lines()
        .map(|line| {
            line.split(",")
                .map(|number| number.parse().unwrap())
                .collect()
        })
        .map(|vec: Vec<i64>| (vec[0], vec[1]))
        .collect();

    let n_points = input.len();

    let mut result = -1;

    for i in 0..n_points {
        let p = input[i];
        for j in i + 1..n_points {
            let q = input[j];
            let area = ((p.0 - q.0).abs() + 1) * ((p.1 - q.1).abs() + 1);
            if area > result {
                result = area;
            }
        }
    }

    println!("Day 09 Part 1: {result}");
}

pub fn part2() {
    // I shrink my input down: non-lineary, closing the gap between each point as much as possible.
    // Thanks to that I can work with it as with 2D array; in this array I check if the rectangle is red/green tiles only.
    // Then I use original input to determine the largest area.

    /* THIS SOLUTION IS SLOPPY */

    // Lower means faster, however:
    // * 1 does not work for example, have to use 2
    // * 1 is enough for my input
    // → When you shrink down example too much (by using 1), corner detector won't work properly.
    //   It's ok for my input; I don't know if that's true for any input, but setting this number higher should make it work eventually.
    const TINY_INCR: usize = 1;

    // If I shrink my input as much as possible without modifying the shape, I get 247x248; so I will use 248x248 grid later
    const TINY_DIM: usize = 248 * TINY_INCR;

    // Parse input to Vec<(i64,i64)>
    let input: Vec<_> = util::read_input("day09.txt")
        .lines()
        .map(|line| {
            line.split(",")
                .map(|number| number.parse().unwrap())
                .collect()
        })
        .map(|vec: Vec<i64>| (vec[0], vec[1]))
        .collect();

    // Ordered unique x and y coordinates
    let mut x_coors: BTreeSet<i64> = BTreeSet::new();
    let mut y_coors: BTreeSet<i64> = BTreeSet::new();

    for pair in &input {
        x_coors.insert(pair.0);
        y_coors.insert(pair.1);
    }

    // Functions to transform x and y coordinates back and forth between normal space and the shrinked one ("tiny")
    let mut x_og2tiny: HashMap<i64, usize> = HashMap::new();
    let mut x_tiny2og: HashMap<usize, i64> = HashMap::new();
    let mut y_og2tiny: HashMap<i64, usize> = HashMap::new();
    let mut y_tiny2og: HashMap<usize, i64> = HashMap::new();

    let mut tiny = 0;
    for x_coor in &x_coors {
        x_og2tiny.insert(*x_coor, tiny);
        x_tiny2og.insert(tiny, *x_coor);
        tiny += TINY_INCR;
    }

    tiny = 0;
    for y_coor in &y_coors {
        y_og2tiny.insert(*y_coor, tiny);
        y_tiny2og.insert(tiny, *y_coor);
        tiny += TINY_INCR;
    }

    let mut tiny_input: Vec<(usize, usize)> = Vec::new();

    let mut grid = [[0u8; TINY_DIM]; TINY_DIM]; // Ths grid is used to determine if rectangle is all red/green tiles

    // "Draw" corners and lines between them into grid
    let mut prev_tiny_pair = input
        .last()
        .map(|pair| (x_og2tiny[&pair.0], y_og2tiny[&pair.1]))
        .unwrap();

    for pair in &input {
        let tiny_x = x_og2tiny[&pair.0];
        let tiny_y = y_og2tiny[&pair.1];

        tiny_input.push((tiny_x, tiny_y));

        if tiny_y != prev_tiny_pair.1 {
            let mut curr_y = tiny_y;
            let is_direction_positive = prev_tiny_pair.1 > tiny_y;
            while curr_y != prev_tiny_pair.1 {
                grid[curr_y][tiny_x] = 1;
                if is_direction_positive {
                    curr_y += 1;
                } else {
                    curr_y -= 1;
                }
            }
        } else {
            let mut curr_x = tiny_x;
            let is_direction_positive = prev_tiny_pair.0 > tiny_x;
            while curr_x != prev_tiny_pair.0 {
                grid[tiny_y][curr_x] = 2;
                if is_direction_positive {
                    curr_x += 1;
                } else {
                    curr_x -= 1;
                }
            }
        }

        prev_tiny_pair = (tiny_x, tiny_y);
    }

    // I use my algorithm from [AoC 2023 Day 10 Part 2] to fill the area
    // ( | ↔ 1 ) ( - ↔ 2 ) ( F ↔ 6 ) ( 7 ↔ 7 ) ( J ↔ 8 ) ( L ↔ 9 )

    // Identify corner types (this is where it breaks if we "shrink it too much" (in certain cases))
    for tiny_pair in &tiny_input {
        let y = tiny_pair.1;
        let x = tiny_pair.0;
        let up = grid
            .get(y - 1)
            .unwrap_or(&[0u8; TINY_DIM])
            .get(x)
            .unwrap_or(&0);
        let down = grid
            .get(y + 1)
            .unwrap_or(&[0u8; TINY_DIM])
            .get(x)
            .unwrap_or(&0);
        let left = grid
            .get(y)
            .unwrap_or(&[0u8; TINY_DIM])
            .get(x - 1)
            .unwrap_or(&0);
        let right = grid
            .get(y)
            .unwrap_or(&[0u8; TINY_DIM])
            .get(x + 1)
            .unwrap_or(&0);

        if *down != 0 {
            if *right != 0 {
                grid[y][x] = 6
            } else if *left != 0 {
                grid[y][x] = 7
            }
        } else if *up != 0 {
            if *right != 0 {
                grid[y][x] = 9
            } else if *left != 0 {
                grid[y][x] = 8
            }
        }
    }

    // Fill the area
    for y in 0..TINY_DIM {
        let mut is_outside = true;
        let mut last_corner = 0u8;
        for x in 0..TINY_DIM {
            let curr = grid[y][x];

            if curr == 0 && !is_outside {
                grid[y][x] = 1;
            } else if curr == 1 {
                is_outside = !is_outside;
            } else if curr == 6 || curr == 9 {
                last_corner = curr;
            } else if (last_corner == 6 && curr == 8) || (last_corner == 9 && curr == 7) {
                is_outside = !is_outside
            }
        }
    }

    let n_points = tiny_input.len();

    // Find the best area same way as in part 1, but only for rectangles that are red/green tiles only
    let mut result = -1;

    for i in 0..n_points {
        let p = tiny_input[i];
        'point: for j in i + 1..n_points {
            let q = tiny_input[j];

            let y_start = if p.1 < q.1 { p.1 } else { q.1 };
            let y_end = if p.1 < q.1 { q.1 } else { p.1 };
            let x_start = if p.0 < q.0 { p.0 } else { q.0 };
            let x_end = if p.0 < q.0 { q.0 } else { p.0 };

            for y in y_start..=y_end {
                for x in x_start..=x_end {
                    if grid[y][x] == 0 {
                        continue 'point;
                    }
                }
            }

            let p = input[i];
            let q = input[j];
            let area = ((p.0 - q.0).abs() + 1) * ((p.1 - q.1).abs() + 1);
            if area > result {
                result = area;
            }
        }
    }

    println!("Day 09 Part 2: {result}");
}
