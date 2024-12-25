local day08 = {}

local util = require("util")

function day08.part1()
    local char, n_cols, n_rows, x_diff, y_diff, antinode
    local char_positions = {}
    local row_n = 0
    for line in util.get_input_lines("day08") do
        row_n = row_n + 1
        n_cols = #line
        for col_n=1,n_cols do
            char = line:sub(col_n, col_n)
            if char ~= "." then
                if char_positions[char] == nil then char_positions[char] = {} end
                table.insert(char_positions[char], { row_n, col_n })
            end
        end
    end
    n_rows = row_n
    local in_bounds_pseudo_set = {}
    for _,values in pairs(char_positions) do
        for i=1,#values-1 do
            for j=i+1,#values do
                y_diff = values[i][1] - values[j][1]
                x_diff = values[i][2] - values[j][2]
                antinode = { values[i][1] + y_diff, values[i][2] + x_diff }
                if antinode[1] >= 1 and antinode[1] <= n_rows and antinode[2] >= 1 and antinode[2] <= n_cols then
                    in_bounds_pseudo_set[day08.key(antinode)] = true
                end
                antinode = { values[j][1] - y_diff, values[j][2] - x_diff }
                if antinode[1] >= 1 and antinode[1] <= n_rows and antinode[2] >= 1 and antinode[2] <= n_cols then
                    in_bounds_pseudo_set[day08.key(antinode)] = true
                end
            end
        end
    end
    local result = 0
    for _ in pairs(in_bounds_pseudo_set) do result = result + 1 end
    print("Part 1: " .. result)
end

function day08.part2()
    local char, n_cols, n_rows, x_diff, y_diff, antinode
    local char_positions = {}
    local row_n = 0
    for line in util.get_input_lines("day08") do
        row_n = row_n + 1
        n_cols = #line
        for col_n=1,n_cols do
            char = line:sub(col_n, col_n)
            if char ~= "." then
                if char_positions[char] == nil then char_positions[char] = {} end
                table.insert(char_positions[char], { row_n, col_n })
            end
        end
    end
    n_rows = row_n
    local in_bounds_pseudo_set = {}
    for _,values in pairs(char_positions) do
        for i=1,#values-1 do
            for j=i+1,#values do
                y_diff = values[i][1] - values[j][1]
                x_diff = values[i][2] - values[j][2]
                antinode = { values[i][1], values[i][2] }
                while true do
                    if not (antinode[1] >= 1 and antinode[1] <= n_rows and antinode[2] >= 1 and antinode[2] <= n_cols) then
                        break
                    end
                    in_bounds_pseudo_set[day08.key(antinode)] = true
                    antinode = { antinode[1] + y_diff, antinode[2] + x_diff }
                end
                antinode = { values[j][1], values[j][2] }
                while true do
                    if not (antinode[1] >= 1 and antinode[1] <= n_rows and antinode[2] >= 1 and antinode[2] <= n_cols) then
                        break
                    end
                    in_bounds_pseudo_set[day08.key(antinode)] = true
                    antinode = { antinode[1] - y_diff, antinode[2] - x_diff }
                end
            end
        end
    end
    local result = 0
    for _ in pairs(in_bounds_pseudo_set) do result = result + 1 end
    print("Part 2: " .. result)
end

function day08.key(antinode)
    return antinode[1] * 100 + antinode[2]
end

return day08
