use crate::aoc::util;
use std::collections::HashSet;

pub fn part1() {
    let input = util::read_input("day10.txt");

    let mut result = 0;

    for line in input.lines() {
        let mut parts = line.split(" ");
        let leds_str = parts
            .next()
            .unwrap()
            .trim_start_matches("[")
            .trim_end_matches("]");
        let mut buttons_str: Vec<_> = parts
            .map(|part| part.trim_start_matches("(").trim_end_matches(")"))
            .collect();
        buttons_str.truncate(buttons_str.len() - 1);

        let mut goal: Vec<bool> = Vec::new();
        for char in leds_str.chars() {
            goal.push(char == '#');
        }
        let n_leds = goal.len();

        let mut og_buttons: Vec<Vec<bool>> = Vec::new();

        for button_str in buttons_str {
            let mut og_button = vec![false; n_leds];
            for index in button_str.split(",") {
                og_button[index.parse::<usize>().unwrap()] = true;
            }
            og_buttons.push(og_button.clone());
        }

        let mut results: Vec<u32> = Vec::new();

        let pushed_indexes: HashSet<usize> = HashSet::new();

        push_buttons(
            &vec![false; n_leds],
            0,
            &goal,
            &og_buttons,
            &pushed_indexes,
            &mut results,
            n_leds,
        );

        result += results.last().unwrap();
    }

    println!("Day 10 Part 1: {result}");
}

fn push_buttons(
    curr: &Vec<bool>,
    n_pushes: u32,
    goal: &Vec<bool>,
    og_buttons: &Vec<Vec<bool>>,
    pushed_indexes: &HashSet<usize>,
    results: &mut Vec<u32>,
    n_leds: usize,
) {
    if !results.is_empty() && &n_pushes == results.last().unwrap() {
        return; // Number of presses is >= than previous attempt so there's no need to continue this branch
    }

    if curr == goal {
        results.push(n_pushes);
        return;
    }

    for (index, og_button) in og_buttons.iter().enumerate() {
        // Pushing the same button more than once won't help anything
        if !pushed_indexes.contains(&index) {
            let mut next: Vec<bool> = Vec::with_capacity(n_leds);
            for i in 0..n_leds {
                next.push(curr[i] ^ og_button[i]);
            }

            let mut pushed_indexes_next = pushed_indexes.clone();
            pushed_indexes_next.insert(index);

            push_buttons(
                &next,
                n_pushes + 1,
                goal,
                og_buttons,
                &mut pushed_indexes_next,
                results,
                n_leds,
            );
        }
    }
}
