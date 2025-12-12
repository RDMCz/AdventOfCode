use crate::aoc::util;
use std::collections::{HashMap, HashSet};

pub fn part1() {
    let input = util::read_input("day11.txt");

    let mut id_you = 0;
    let id_out = 0;

    let mut id = 0;
    let mut conv: HashMap<String, u16> = HashMap::new();

    conv.insert(String::from("out"), id_out);

    for line in input.lines() {
        let id_str = &line[..=2];
        id += 1;
        conv.insert(id_str.to_string(), id);

        if id_str == "you" {
            id_you = id;
        }
    }

    let mut paths: HashMap<u16, Vec<u16>> = HashMap::new();

    for line in input.lines() {
        let parts: Vec<_> = line.split(" ").collect();
        let key = conv[&parts[0].trim_end_matches(":").to_string()];
        let mut value: Vec<u16> = Vec::new();
        for element in parts.iter().skip(1) {
            value.push(conv[&element.to_string()]);
        }
        paths.insert(key, value);
    }

    let mut been_there: HashSet<u16> = HashSet::new();

    println!(
        "Day 11 Part 1: {}",
        crawl(id_you, id_out, &paths, &mut been_there)
    );
}

fn crawl(
    curr: u16,
    goal: u16,
    paths: &HashMap<u16, Vec<u16>>,
    been_there: &mut HashSet<u16>,
) -> u32 {
    let mut result = 0;

    if curr == goal {
        return 1;
    }

    if been_there.contains(&curr) {
        return 0;
    }

    been_there.insert(curr);

    for element in &paths[&curr] {
        result += crawl(*element, goal, paths, &mut been_there.clone());
    }

    result
}
