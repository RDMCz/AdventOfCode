local day10 = {}

local util = require("util")

function day10.parts1and2()
    -- Parse input into a grid, get all trailhead locations, add border to grid
    local grid = {}
    local zero_positions = {}
    local row_n = 0
    local row, char
    for line in util.get_input_lines("day10") do
        row_n = row_n + 1
        row = {}
        for col_n=1,#line do
            char = line:sub(col_n, col_n)
            table.insert(row, char)
            if char == "0" then table.insert(zero_positions, { row_n + 1, col_n + 1 }) --[[Will be padded so add one to y&x]] end
        end
        table.insert(grid, row)
    end
    util.grid_add_border(grid, 1, ".")
    -- Do the hikin'
    local result1 = 0
    local result2 = 0
    local reachable_nine_positions_pseudo_set, n_distinct_hiking_trails
    for i=1,#zero_positions do
        reachable_nine_positions_pseudo_set = {}
        n_distinct_hiking_trails = {0} -- "Integer" passed by reference
        day10.parts1and2impl(grid, zero_positions[i], 1, reachable_nine_positions_pseudo_set, n_distinct_hiking_trails)
        for _ in pairs(reachable_nine_positions_pseudo_set) do result1 = result1 + 1 end
        result2 = result2 + n_distinct_hiking_trails[1]
    end
    print("Part 1: " .. result1)
    print("Part 2: " .. result2)
end

function day10.parts1and2impl(grid, position, next_value, set, n_trails)
    local char, number, y, x
    for y_or_x=-1,1,2 do
        for value=-1,1,2 do
            if y_or_x == -1 then
                y = value
                x = 0
            else
                y = 0
                x = value
            end
            char = grid[position[1] + y][position[2] + x]
            if char ~= "." then
                number = tonumber(char)
                if number == next_value then
                    if number == 9 then
                        set[(position[1] + y) * 100 + (position[2] + x)] = true
                        n_trails[1] = n_trails[1] + 1
                    else
                        day10.parts1and2impl(grid, { position[1] + y, position[2] + x }, next_value + 1, set, n_trails)
                    end
                end
            end
        end
    end
end

return day10
