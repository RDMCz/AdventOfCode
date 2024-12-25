local util = {}

-- Used everyday for reading input from txt file
function util.get_input_lines(day_id)
    return io.lines("input/" .. day_id .. ".txt")
end

-- Used in days: 03
function util.string_find_all(input_string, pattern, plain)
    local result = {}
    local index = 1
    while true do
        local fx, fy = string.find(input_string, pattern, index, plain)
        if fx == nil then break end
        table.insert(result, fx)
        index = fy + 1
    end
    return result
end

-- Used in days: 04, 06, 10, 12, 20
function util.grid_add_border(grid, border_thickness, border_char)
    -- Add border to a 2D grid (table). Assuming every grid row has the same length.
    local row
    local new_row_len = #(grid[1]) + (2 * border_thickness)
    for i=1,#grid do
        row = grid[i]
        for _=1,border_thickness do table.insert(row, 1, border_char) end
        for _=1,border_thickness do table.insert(row, border_char) end
    end
    row = {}
    for _=1,new_row_len do table.insert(row, border_char) end
    for _=1,border_thickness do table.insert(grid, 1, row) end
    for _=1,border_thickness do table.insert(grid, row) end
end

-- Debugging purposes
function util._debug_grid_print(grid, highlight_position, highlight_character)
    if highlight_position == nil then highlight_position = { -1, -1 } end
    if highlight_character == nil then highlight_character = "X" end
    for i=1,#grid do
        for j=1,#(grid[i]) do
            if i == highlight_position[1] and j == highlight_position[2] then
                io.write(highlight_character)
            else
                io.write(grid[i][j])
            end
        end
        print()
    end
end

return util
