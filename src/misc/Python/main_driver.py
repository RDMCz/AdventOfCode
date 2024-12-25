import pathlib

import ultraimport

__PATH = pathlib.Path(__file__).parent / "input"


def get_input_lines(day_id):
    with open(__PATH / (day_id + ".txt"), "r", encoding="utf-8") as file:
        return [line.rstrip() for line in file]


if __name__ == "__main__":
    # Year 2024 Day 07 Part 2
    print("\n== Year 2024 Day 07 ==")
    ultraimport("__dir__/year2024day07part2.py").run(get_input_lines("year2024day07"))

    # Year 2024 Day 13 Part 2
    print("\n== Year 2024 Day 13 ==")
    ultraimport("__dir__/year2024day13part2.py").run(get_input_lines("year2024day13"))

    # Year 2024 Day 19 Part 2
    print("\n== Year 2024 Day 19 ==")
    ultraimport("__dir__/year2024day19part2.py").run(get_input_lines("year2024day19"))

    pass
