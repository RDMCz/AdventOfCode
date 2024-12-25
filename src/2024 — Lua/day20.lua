local day20 = {}

local util = require("util")

function day20.parts1and2()
    -- Parse the input
    local grid = {}
    local row, char, start_position, end_position
    local row_n = 0
    for line in util.get_input_lines("day20") do
        row_n = row_n + 1
        row = {}
        for i=1,#line do
            char = line:sub(i, i)
            if start_position == nil and char == "S" then
                char = "0"
                start_position = { row_n, i }
            end
            if end_position == nil and char == "E" then
                char = "."
                end_position = { row_n, i }
            end
            table.insert(row, char)
        end
        table.insert(grid, row)
    end

    -- Add border, we will be looking two chars around our current position
    util.grid_add_border(grid, 1, "#")
    start_position = { start_position[1] + 1, start_position[2] + 1 }
    end_position = { end_position[1] + 1, end_position[2] + 1 }

    -- First pass :: Number the track tiles
    local position = start_position
    local step_counter = 0
    local directions = { { -1, 0 }, { 0, 1 }, { 1, 0 }, { 0, -1 } }
    local lookahead
    repeat
        step_counter = step_counter + 1
        for _,dir in ipairs(directions) do
            lookahead = { position[1] + dir[1], position[2] + dir[2] }
            if grid[lookahead[1]][lookahead[2]] == "." then
                position = { lookahead[1], lookahead[2] }
                grid[position[1]][position[2]] = step_counter
                break
            end
        end
    until position[1] == end_position[1] and position[2] == end_position[2]

    -- Second pass :: Find the shortcuts
    position = start_position
    step_counter = 0
    local directions2 = { { -2, 0 }, { 0, 2 }, { 2, 0 }, { 0, -2 } }
    local lookahead2, next_position, shortcut_length
    local shortcuts = {}
    repeat
        step_counter = step_counter + 1
        for i=1,#directions do
            lookahead = { position[1] + directions[i][1], position[2] + directions[i][2] }
            lookahead2 = { position[1] + directions2[i][1], position[2] + directions2[i][2] }
            if grid[lookahead[1]][lookahead[2]] == step_counter then
                next_position = { lookahead[1], lookahead[2] }
            end
            if grid[lookahead[1]][lookahead[2]] == "#" and type(grid[lookahead2[1]][lookahead2[2]]) == "number" then
                shortcut_length = (grid[lookahead2[1]][lookahead2[2]] - (step_counter - 1)) - 2
                if shortcut_length > 0 then
                    if shortcuts[shortcut_length] == nil then shortcuts[shortcut_length] = 0 end
                    shortcuts[shortcut_length] = shortcuts[shortcut_length] + 1
                end
            end
        end
        position = { next_position[1], next_position[2] }
    until position[1] == end_position[1] and position[2] == end_position[2]

    -- Count the >=100 cheats
    local result = 0
    for k,v in pairs(shortcuts) do
        --print("There are " .. v .. " cheats that save " .. k .. " picoseconds.")
        if k >= 100 then
            result = result + v
        end
    end
    print("Part 1: " .. result)

    -- #JustPart2Things
    -- More border !!!
    util.grid_add_border(grid, 20, "#")
    start_position = { start_position[1] + 20, start_position[2] + 20 }
    end_position = { end_position[1] + 20, end_position[2] + 20 }

    -- Third pass :: Check everything within 20 manhattan distance
    position = start_position
    step_counter = 0
    shortcuts = {}
    local number, distance
    repeat
        step_counter = step_counter + 1
        for y=-20,20 do
            for x=-20,20 do
                distance = math.abs(y) + math.abs(x)
                if distance <= 20 then
                    number = grid[position[1] + y][position[2] + x]
                    if type(number) == "number" then
                        if number == step_counter then
                            next_position = { position[1] + y, position[2] + x }
                        end
                        shortcut_length = (number - (step_counter - 1)) - distance
                        if shortcut_length > 0 then
                            if shortcuts[shortcut_length] == nil then shortcuts[shortcut_length] = 0 end
                            shortcuts[shortcut_length] = shortcuts[shortcut_length] + 1
                        end
                    end
                end
            end
        end
        position = { next_position[1], next_position[2] }
    until position[1] == end_position[1] and position[2] == end_position[2]

    -- Count the >=100 cheats
    result = 0
    for k,v in pairs(shortcuts) do
        --print("There are " .. v .. " cheats that save " .. k .. " picoseconds.")
        if k >= 100 then
            result = result + v
        end
    end
    print("Part 2: " .. result)
end

return day20
