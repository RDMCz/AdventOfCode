local day15 = {}

local util = require("util")

function day15.part1()
    -- Parse the input
    local is_warehouse_or_movement = true
    local grid = {}
    local row_n = 0
    local row, char, position
    local movement = ""
    for line in util.get_input_lines("day15") do
        if line == "" then
            is_warehouse_or_movement = false
        elseif is_warehouse_or_movement then
            row_n = row_n + 1
            row = {}
            for col_n=1,#line do
                char = line:sub(col_n, col_n)
                if position == nil and char == "@" then position = { row_n, col_n } end
                table.insert(row, char)
            end
            table.insert(grid, row)
        else
            movement = movement .. line
        end
    end
    -- Sokoban
    local b_position, b_char -- "Boomerang"
    for i=1,#movement do
        char = movement:sub(i, i)
        b_position = { position[1], position[2] }
        b_char = "@"
        if char == "^" then
            repeat
                b_position = { b_position[1] - 1, b_position[2] }
                b_char = grid[b_position[1]][b_position[2]]
            until b_char == "." or b_char == "#"
            if b_char == "." then
                repeat
                    grid[b_position[1]][b_position[2]] = grid[b_position[1] + 1][b_position[2]]
                    b_position = { b_position[1] + 1, b_position[2] }
                    b_char = grid[b_position[1]][b_position[2]]
                until b_char == "@"
                grid[position[1]][position[2]] = "."
                position = { position[1] - 1, position[2] }
            end
        elseif char == ">" then
            repeat
                b_position = { b_position[1], b_position[2] + 1 }
                b_char = grid[b_position[1]][b_position[2]]
            until b_char == "." or b_char == "#"
            if b_char == "." then
                repeat
                    grid[b_position[1]][b_position[2]] = grid[b_position[1]][b_position[2] - 1]
                    b_position = { b_position[1], b_position[2] - 1 }
                    b_char = grid[b_position[1]][b_position[2]]
                until b_char == "@"
                grid[position[1]][position[2]] = "."
                position = { position[1], position[2] + 1 }
            end
        elseif char == "v" then
            repeat
                b_position = { b_position[1] + 1, b_position[2] }
                b_char = grid[b_position[1]][b_position[2]]
            until b_char == "." or b_char == "#"
            if b_char == "." then
                repeat
                    grid[b_position[1]][b_position[2]] = grid[b_position[1] - 1][b_position[2]]
                    b_position = { b_position[1] - 1, b_position[2] }
                    b_char = grid[b_position[1]][b_position[2]]
                until b_char == "@"
                grid[position[1]][position[2]] = "."
                position = { position[1] + 1, position[2] }
            end
        elseif char == "<" then
            repeat
                b_position = { b_position[1], b_position[2] - 1 }
                b_char = grid[b_position[1]][b_position[2]]
            until b_char == "." or b_char == "#"
            if b_char == "." then
                repeat
                    grid[b_position[1]][b_position[2]] = grid[b_position[1]][b_position[2] + 1]
                    b_position = { b_position[1], b_position[2] + 1 }
                    b_char = grid[b_position[1]][b_position[2]]
                until b_char == "@"
                grid[position[1]][position[2]] = "."
                position = { position[1], position[2] - 1 }
            end
        end
    end
    -- Count the crate score
    local result = 0
    for i=1,#grid do
        for j=1,#(grid[i]) do
            if grid[i][j] == "O" then
                result = result + (100 * (i - 1) + (j - 1))
            end
        end
    end
    print("Part 1: " .. result)
end

function day15.part2()
    -- Parse the input
    local is_warehouse_or_movement = true
    local grid = {}
    local row_n = 0
    local row, char, position
    local movement = ""
    for line in util.get_input_lines("day15") do
        if line == "" then
            is_warehouse_or_movement = false
        elseif is_warehouse_or_movement then
            row_n = row_n + 1
            row = {}
            for col_n=1,#line do
                char = line:sub(col_n, col_n)
                if char == "#" then
                    table.insert(row, "#")
                    table.insert(row, "#")
                elseif char == "O" then
                    table.insert(row, "[")
                    table.insert(row, "]")
                elseif char == "." then
                    table.insert(row, ".")
                    table.insert(row, ".")
                else
                    table.insert(row, "@")
                    table.insert(row, ".")
                    position = { row_n, 2 * col_n - 1 }
                end
            end
            table.insert(grid, row)
        else
            movement = movement .. line
        end
    end
    -- Wide Sokoban
    -- -- Moving left and right has the same logic as Part 1
    local b_position, b_char -- "Boomerang"
    -- -- When moving crates up or down, we have to check crates behind that crate recursively
    local set, y, x1, x2
    for i=1,#movement do
        char = movement:sub(i, i)
        b_position = { position[1], position[2] }
        b_char = "@"
        if char == ">" then
            repeat
                b_position = { b_position[1], b_position[2] + 1 }
                b_char = grid[b_position[1]][b_position[2]]
            until b_char == "." or b_char == "#"
            if b_char == "." then
                repeat
                    grid[b_position[1]][b_position[2]] = grid[b_position[1]][b_position[2] - 1]
                    b_position = { b_position[1], b_position[2] - 1 }
                    b_char = grid[b_position[1]][b_position[2]]
                until b_char == "@"
                grid[position[1]][position[2]] = "."
                position = { position[1], position[2] + 1 }
            end
        elseif char == "<" then
            repeat
                b_position = { b_position[1], b_position[2] - 1 }
                b_char = grid[b_position[1]][b_position[2]]
            until b_char == "." or b_char == "#"
            if b_char == "." then
                repeat
                    grid[b_position[1]][b_position[2]] = grid[b_position[1]][b_position[2] + 1]
                    b_position = { b_position[1], b_position[2] + 1 }
                    b_char = grid[b_position[1]][b_position[2]]
                until b_char == "@"
                grid[position[1]][position[2]] = "."
                position = { position[1], position[2] - 1 }
            end
        elseif char == "v" then
            if grid[position[1] + 1][position[2]] == "#" then
                -- Wall, do nothing
            elseif grid[position[1] + 1][position[2]] == "." then
                -- Free move
                grid[position[1]][position[2]] = "."
                position = { position[1] + 1, position[2] }
                grid[position[1]][position[2]] = "@"
            else
                -- Uh oh
                set = {} -- This will contain all the crates that are "affected" by this move
                if day15.is_crate_move_possible(grid, { position[1] + 1, position[2] }, false, set) then
                    for key,_ in pairs(set) do
                        y, x1, x2 = table.unpack(key)
                        grid[y][x1] = "."
                        grid[y][x2] = "."
                    end
                    for key,_ in pairs(set) do
                        y, x1, x2 = table.unpack(key)
                        grid[y + 1][x1] = "["
                        grid[y + 1][x2] = "]"
                    end
                    grid[position[1]][position[2]] = "."
                    position = { position[1] + 1, position[2] }
                    grid[position[1]][position[2]] = "@"
                end
            end
        elseif char == "^" then
            if grid[position[1] - 1][position[2]] == "#" then
                -- Wall, do nothing
            elseif grid[position[1] - 1][position[2]] == "." then
                -- Free move
                grid[position[1]][position[2]] = "."
                position = { position[1] - 1, position[2] }
                grid[position[1]][position[2]] = "@"
            else
                -- Uh oh
                set = {} -- This will contain all the crates that are "affected" by this move
                if day15.is_crate_move_possible(grid, { position[1] - 1, position[2] }, true, set) then
                    for key,_ in pairs(set) do
                        y, x1, x2 = table.unpack(key)
                        grid[y][x1] = "."
                        grid[y][x2] = "."
                    end
                    for key,_ in pairs(set) do
                        y, x1, x2 = table.unpack(key)
                        grid[y - 1][x1] = "["
                        grid[y - 1][x2] = "]"
                    end
                    grid[position[1]][position[2]] = "."
                    position = { position[1] - 1, position[2] }
                    grid[position[1]][position[2]] = "@"
                end
            end
        end
    end
    -- Count the crate score
    local result = 0
    for i=1,#grid do
        for j=1,#(grid[i]) do
            if grid[i][j] == "[" then
                result = result + (100 * (i - 1) + (j - 1))
            end
        end
    end
    print("Part 2: " .. result)
end

function day15.is_crate_move_possible(grid, position, is_direction_up, set)
    local xs
    if grid[position[1]][position[2]] == "[" then xs = { position[2], position[2] + 1 } else xs = { position[2] - 1, position[2] } end
    set[{ position[1], xs[1], xs[2] }] = true
    if is_direction_up then
        if grid[position[1] - 1][xs[1]] == "#" or grid[position[1] - 1][xs[2]] == "#" then return false end
        if grid[position[1] - 1][xs[1]] == "." and grid[position[1] - 1][xs[2]] == "." then return true end
        if grid[position[1] - 1][xs[1]] == "[" or grid[position[1] - 1][xs[1]] == "]" then
            if not day15.is_crate_move_possible(grid, { position[1] - 1, xs[1] }, is_direction_up, set) then return false end
        end
        if grid[position[1] - 1][xs[2]] == "[" or grid[position[1] - 1][xs[2]] == "]" then
            if not day15.is_crate_move_possible(grid, { position[1] - 1, xs[2] }, is_direction_up, set) then return false end
        end
        return true
    else
        if grid[position[1] + 1][xs[1]] == "#" or grid[position[1] + 1][xs[2]] == "#" then return false end
        if grid[position[1] + 1][xs[1]] == "." and grid[position[1] + 1][xs[2]] == "." then return true end
        if grid[position[1] + 1][xs[1]] == "[" or grid[position[1] + 1][xs[1]] == "]" then
            if not day15.is_crate_move_possible(grid, { position[1] + 1, xs[1] }, is_direction_up, set) then return false end
        end
        if grid[position[1] + 1][xs[2]] == "[" or grid[position[1] + 1][xs[2]] == "]" then
            if not day15.is_crate_move_possible(grid, { position[1] + 1, xs[2] }, is_direction_up, set) then return false end
        end
        return true
    end
end

return day15
