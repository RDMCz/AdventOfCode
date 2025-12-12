// Used everyday for reading my input from the text file
pub fn read_input(filename: &str) -> String {
    let path = std::env::current_dir().unwrap();

    let input_file_content = std::fs::read_to_string(path.join("input").join(filename)).unwrap();

    input_file_content.replace("\r\n", "\n")
}

// Used only in Day 4, yay!
pub fn get_grid_with_added_border(
    grid: &Vec<&str>,
    border_char: &str,
    border_thickness: usize,
) -> Vec<String> {
    let orginal_width = grid.get(0).unwrap().len();
    let original_height = grid.len();

    let mut result: Vec<String> = Vec::with_capacity(original_height + 2 * border_thickness);

    let top_bot = border_char.repeat(orginal_width + 2 * border_thickness);

    for _ in 0..border_thickness {
        result.push(format!("{top_bot}"));
    }

    let side = border_char.repeat(border_thickness);

    for line in grid {
        result.push(format!("{side}{line}{side}"));
    }

    for _ in 0..border_thickness {
        result.push(format!("{top_bot}"));
    }

    result
}
