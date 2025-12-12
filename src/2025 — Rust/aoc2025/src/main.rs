mod aoc;

fn main() {
    println!(":====: AoC 2025 :====:\n");

    let now = std::time::Instant::now();

    aoc::day01::part1();
    aoc::day01::part2();

    println!();

    aoc::day02::part1();
    aoc::day02::part2(); // Takes about 2 seconds on release

    println!();

    aoc::day03::part1();
    aoc::day03::part2();

    println!();

    aoc::day04::parts_1_and_2();

    println!();

    aoc::day05::parts_1_and_2();

    println!();

    aoc::day06::part1();
    aoc::day06::part2();

    println!();

    aoc::day07::parts_1_and_2();

    println!();

    aoc::day08::part1();
    aoc::day08::part2();

    println!();

    aoc::day09::part1();
    aoc::day09::part2();

    println!();

    aoc::day10::part1(); // Takes about 36 seconds on release

    println!();

    aoc::day11::part1();

    println!("\nElapsed: {:.2?}", now.elapsed());
    println!("\n:====================:")

    // Total run time (on Xeon from 2013): 48 seconds
    // without "d02p2" and "d10p1": 460 milliseconds

    // Missing:
    // * Day 10 Part 2
    // * Day 11 Part 2
    // * Day 12 Part 1
}
