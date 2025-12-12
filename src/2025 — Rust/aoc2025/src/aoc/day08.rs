use crate::aoc::util;
use std::collections::{HashMap, HashSet};

pub fn part1() {
    let is_example = false;
    let n_connections = if is_example { 10 } else { 1000 };
    let file_name = if is_example {
        "day08example.txt"
    } else {
        "day08.txt"
    };

    // Parse into (f64, f64, f64) tuples
    let input: Vec<_> = util::read_input(file_name)
        .lines()
        .map(|line| {
            line.split(",")
                .map(|number| number.parse().unwrap())
                .collect()
        })
        .map(|vec: Vec<f64>| (vec[0], vec[1], vec[2]))
        .collect();

    let n_points = input.len();

    // Calculate distances for each possible pair of points; points (p,q) with indexes (i,j)
    let mut distances: Vec<(f64, usize, usize)> = Vec::with_capacity(n_points * n_points);

    for i in 0..n_points {
        let p = input[i];

        for j in i + 1..n_points {
            let q = input[j];
            let dist = ((p.0 - q.0).powi(2) + (p.1 - q.1).powi(2) + (p.2 - q.2).powi(2)).sqrt();
            distances.push((dist, i, j));
        }
    }

    // Sort by distance (shortest first)
    distances.sort_by(|a, b| a.0.total_cmp(&b.0));

    // Take 10 (example) or 1000 (raw) shortest connections, and group them accordingly
    let mut point_to_group: HashMap<usize, i32> = HashMap::new();
    let mut current_id = 0;

    for dist in distances.iter().take(n_connections) {
        let mut found_ids: Vec<i32> = Vec::with_capacity(2);

        for (key, value) in &point_to_group {
            if key == &dist.1 || key == &dist.2 {
                found_ids.push(*value);
            }
        }

        match found_ids.len() {
            0 => {
                // Both points are not in any group yet; create a group with new id for them
                current_id += 1;
                point_to_group.insert(dist.1, current_id);
                point_to_group.insert(dist.2, current_id);
            }
            1 => {
                // One point is already in some group, add the other to the same group
                point_to_group.insert(dist.1, found_ids[0]);
                point_to_group.insert(dist.2, found_ids[0]);
            }
            2 => {
                // One points is in group 'a' and the other in group 'b' → regroup everything from 'a' and 'b' under a new id
                current_id += 1;
                point_to_group.insert(dist.1, current_id);
                point_to_group.insert(dist.2, current_id);

                for (_, value) in &mut point_to_group {
                    if value == &found_ids[0] || value == &found_ids[1] {
                        *value = current_id;
                    }
                }
            }
            _ => unreachable!(),
        }
    }

    // Count how many points are there in each group
    let mut group_occurences: HashMap<i32, i32> = HashMap::new();

    for (_, value) in &point_to_group {
        let value_occurence = group_occurences.entry(*value).or_insert(0);
        *value_occurence += 1;
    }

    // Multiply top 3 occurences
    let mut just_occurences: Vec<_> = group_occurences.iter().map(|(_, value)| *value).collect();
    just_occurences.sort();

    println!(
        "Day 08 Part 1: {}",
        just_occurences.iter().rev().take(3).product::<i32>()
    );
}

pub fn part2() {
    // Parse into (f64, f64, f64) tuples
    let input: Vec<_> = util::read_input("day08.txt")
        .lines()
        .map(|line| {
            line.split(",")
                .map(|number| number.parse().unwrap())
                .collect()
        })
        .map(|vec: Vec<f64>| (vec[0], vec[1], vec[2]))
        .collect();

    let n_points = input.len();

    // Calculate distances for each possible pair of points; points (p,q) with indexes (i,j)
    let mut distances: Vec<(f64, usize, usize)> = Vec::with_capacity(n_points * n_points);

    for i in 0..n_points {
        let p = input[i];

        for j in i + 1..n_points {
            let q = input[j];
            let dist = ((p.0 - q.0).powi(2) + (p.1 - q.1).powi(2) + (p.2 - q.2).powi(2)).sqrt();
            distances.push((dist, i, j));
        }
    }

    // Sort by distance (shortest first)
    distances.sort_by(|a, b| a.0.total_cmp(&b.0));

    // Keep getting connections and group them accordingly
    let mut point_to_group: HashMap<usize, i32> = HashMap::new();
    let mut current_id = 0;

    for dist in distances.iter() {
        let mut all_ids: HashSet<i32> = HashSet::new();
        let mut found_ids: Vec<i32> = Vec::with_capacity(2);

        for (key, value) in &point_to_group {
            if key == &dist.1 || key == &dist.2 {
                found_ids.push(*value);
            }
        }

        match found_ids.len() {
            0 => {
                // Both points are not in any group yet; create a group with new id for them
                current_id += 1;
                point_to_group.insert(dist.1, current_id);
                point_to_group.insert(dist.2, current_id);
            }
            1 => {
                // One point is already in some group, add the other to the same group
                point_to_group.insert(dist.1, found_ids[0]);
                point_to_group.insert(dist.2, found_ids[0]);
            }
            2 => {
                // One points is in group 'a' and the other in group 'b' → regroup everything from 'a' and 'b' under a new id
                current_id += 1;
                point_to_group.insert(dist.1, current_id);
                point_to_group.insert(dist.2, current_id);

                for (_, value) in &mut point_to_group {
                    if value == &found_ids[0] || value == &found_ids[1] {
                        *value = current_id;
                    }
                }
            }
            _ => unreachable!(),
        }

        // How many unique groups do we have?
        for (_, value) in &mut point_to_group {
            all_ids.insert(*value);
        }

        // If all points are connected and there's only one unique group then we're done
        if point_to_group.len() == n_points && all_ids.len() == 1 {
            println!("Day 08 Part 2: {}", input[dist.1].0 * input[dist.2].0);
            return;
        }
    }
}
