local day12 = {}

local util = require("util")

function day12.part1()
    -- Parse input, add border to grid
    local grid = {}
    local row
    for line in util.get_input_lines("day12") do
        row = {}
        for col=1,#line do table.insert(row, line:sub(col, col)) end
        table.insert(grid, row)
    end
    util.grid_add_border(grid, 1, ".")

    local grid_height = #grid
    local grid_width = #(grid[1])
    local char, temp_pseudo_set, results, yx_t
    local final_result = 0

    -- Iterate through grid until we find some letter
    ::iterate::
    for y=2,grid_height-1 do
        for x=2,grid_width-1 do
            char = grid[y][x]
            if char ~= "." then
                -- Letter found, find all its (same letter) neighbours via "spill" recursion
                -- We can already count the area (results[1]) and the perimeter (results[2]) while finding the neighbours
                temp_pseudo_set = {}
                results = { 0, 0 }
                day12.spill_recursion(grid, y, x, char, temp_pseudo_set, results)
                final_result = final_result + (results[1] * results[2])
                -- Remove the area (replace currently observed letters by dots) and repeat until grid is nothing but dots
                for key,_ in pairs(temp_pseudo_set) do
                    yx_t = day12.unkey(key)
                    grid[yx_t[1]][yx_t[2]] = "."
                end
                goto iterate
            end
        end
    end

    print("Part 1: " .. final_result)
end

function day12.part2()
    -- Parse input, add border to grid
    local grid = {}
    local row
    for line in util.get_input_lines("day12") do
        row = {}
        for col=1,#line do table.insert(row, line:sub(col, col)) end
        table.insert(grid, row)
    end
    util.grid_add_border(grid, 1, ".")

    local grid_height = #grid
    local grid_width = #(grid[1])
    local char, temp_pseudo_set, results, yx_t, grid2
    local final_result = 0

    -- Iterate through grid until we find some letter
    ::iterate::
    for y=2,grid_height-1 do
        for x=2,grid_width-1 do
            char = grid[y][x]
            if char ~= "." then
                -- Letter found, find all its (same letter) neighbours via "spill" recursion
                -- We can already count the area (results[1]) while finding the neighbours
                temp_pseudo_set = {}
                results = { 0, 0 }
                day12.spill_recursion(grid, y, x, char, temp_pseudo_set, results)
                -- #JustPart2Things
                -- Create empty grid with only currently observed area ("region")
                grid2 = {}
                for grow=1,grid_height do
                    row = {}
                    for gcol=1,grid_width do
                        if temp_pseudo_set[day12.key(grow, gcol)] then
                            table.insert(row, "#")
                        else
                            table.insert(row, ".")
                        end
                    end
                    table.insert(grid2, row)
                end
                -- Count region's sides
                local n_sides = 0
                local current_char, prev_char
                local enter_indexes, leave_indexes, prev_enter_indexes, prev_leave_indexes
                -- -- Every row from left to right:
                -- -- (If we enter the region on row `n` at index `i` and we did not enter the region on row `n-1` at index `i`, we count it as a new side
                -- -- same goes for leaving the region; this will count all vertical sides)
                prev_enter_indexes = {}
                prev_leave_indexes = {}
                for grow=1,grid_height do
                    enter_indexes = {}
                    leave_indexes = {}
                    prev_char = "."
                    for gcol=1,grid_width do
                        current_char = grid2[grow][gcol]
                        if current_char ~= prev_char then
                            if current_char == "#" then
                                enter_indexes[gcol] = true
                                if not prev_enter_indexes[gcol] then n_sides = n_sides + 1 end
                            else
                                leave_indexes[gcol] = true
                                if not prev_leave_indexes[gcol] then n_sides = n_sides + 1 end
                            end
                        end
                        prev_char = current_char
                    end
                    prev_enter_indexes = day12.set_clone(enter_indexes)
                    prev_leave_indexes = day12.set_clone(leave_indexes)
                end
                -- -- Every column from top to bottom:
                -- -- (Same as before; this will count all horizontal sides)
                prev_enter_indexes = {}
                prev_leave_indexes = {}
                for gcol=1,grid_width do
                    enter_indexes = {}
                    leave_indexes = {}
                    prev_char = "."
                    for grow=1,grid_height do
                        current_char = grid2[grow][gcol]
                        if current_char ~= prev_char then
                            if current_char == "#" then
                                enter_indexes[grow] = true
                                if not prev_enter_indexes[grow] then n_sides = n_sides + 1 end
                            else
                                leave_indexes[grow] = true
                                if not prev_leave_indexes[grow] then n_sides = n_sides + 1 end
                            end
                        end
                        prev_char = current_char
                    end
                    prev_enter_indexes = day12.set_clone(enter_indexes)
                    prev_leave_indexes = day12.set_clone(leave_indexes)
                end
                final_result = final_result + (results[1] * n_sides)
                -- Remove the area (replace currently observed letters by dots) and repeat until grid is nothing but dots
                for key,_ in pairs(temp_pseudo_set) do
                    yx_t = day12.unkey(key)
                    grid[yx_t[1]][yx_t[2]] = "."
                end
                goto iterate
            end
        end
    end

    print("Part 2: " .. final_result)
end

function day12.spill_recursion(grid, y, x, letter, set, results)
    set[day12.key(y, x)] = true
    results[1] = results[1] + 1
    -- Up
    if grid[y - 1][x] == letter then
        if not set[day12.key(y - 1, x)] then day12.spill_recursion(grid, y - 1, x, letter, set, results) end
    else
        results[2] = results[2] + 1
    end
    -- Right
    if grid[y][x + 1] == letter then
        if not set[day12.key(y, x + 1)] then day12.spill_recursion(grid, y, x + 1, letter, set, results) end
    else
        results[2] = results[2] + 1
    end
    -- Down
    if grid[y + 1][x] == letter then
        if not set[day12.key(y + 1, x)] then day12.spill_recursion(grid, y + 1, x, letter, set, results) end
    else
        results[2] = results[2] + 1
    end
    -- Left
    if grid[y][x - 1] == letter then
        if not set[day12.key(y, x - 1)] then day12.spill_recursion(grid, y, x - 1, letter, set, results) end
    else
        results[2] = results[2] + 1
    end
end

function day12.key(y, x)
    return y * 1000 + x
end

function day12.unkey(key)
    local y = math.floor(key / 1000)
    local x = key - (y * 1000)
    return { y, x }
end

function day12.set_clone(set)
    local clone = {}
    for key,_ in pairs(set) do clone[key] = true end
    return clone
end

return day12
