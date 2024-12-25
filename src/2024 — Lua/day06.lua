local day06 = {}

local util = require("util")

function day06.parts1and2()
    local row, char, position, lookahead, lookahead_char, --[[Part2:]] yx_t, obstacle_y, obstacle_x, visited_key
    -- Parse the input into 2D char array and get starting position
    local grid = {}
    local line_n = 1
    for line in util.get_input_lines("day06") do
        row = {}
        for i=1,#line do
            char = line:sub(i, i)
            table.insert(row, char)
            if position == nil and char == "^" then position = { line_n, i } end
        end
        table.insert(grid, row)
        line_n = line_n + 1
    end
    -- Adding a border for easier "out of bounds" checking; x&y starting positions must be increased by thickness of border!
    util.grid_add_border(grid, 1, "?")
    position[2] = position[2] + 1
    position[1] = position[1] + 1
    grid[position[1]][position[2]] = "."                -- No need for "^" symbol anymore
    local start_position = { position[1], position[2] } -- Save for Part2
    -- Do the guard walkin'
    local step = { -1, 0 }
    local visited_pseudo_set = {}
    while true do
        visited_pseudo_set[day06.key(position)] = true
        ::try_again::
        lookahead = { position[1] + step[1], position[2] + step[2] }
        lookahead_char = grid[lookahead[1]][lookahead[2]]
        if lookahead_char == "#" then
            if step[1] == -1 and step[2] == 0 then step = { 0, 1 } elseif step[1] == 0 and step[2] == 1 then step = { 1, 0 } elseif step[1] == 1 and step[2] == 0 then step = { 0, -1 } else step = { -1, 0 } end
            goto try_again
        elseif lookahead_char == "?" then
            break
        else
            position = lookahead
        end
    end
    -- How to get length of dictionary in Lua? Iterate over all keys and increment a counter :-)
    local result1 = 0
    for _ in pairs(visited_pseudo_set) do result1 = result1 + 1 end
    print("Part 1: " .. result1)
    -- #JustPart2Things
    local result2 = 0
    for key,_ in pairs(visited_pseudo_set) do
        yx_t = day06.unkey(key)
        obstacle_y = yx_t[1]
        obstacle_x = yx_t[2]
        position = { start_position[1], start_position[2] }
        step = { -1, 0 }
        visited_pseudo_set = {}
        while true do
            visited_key = day06.key(step) * 100 + day06.key(position)
            if visited_pseudo_set[visited_key] then
                visited_pseudo_set[visited_key] = visited_pseudo_set[visited_key] + 1
                if visited_pseudo_set[visited_key] == 4 --[[idk, magic number]] then
                    result2 = result2 + 1
                    break
                end
            else
                visited_pseudo_set[visited_key] = 1
            end
            ::try_again::
            lookahead = { position[1] + step[1], position[2] + step[2] }
            lookahead_char = grid[lookahead[1]][lookahead[2]]
            if lookahead_char == "#" or (lookahead[1] == obstacle_y and lookahead[2] == obstacle_x) then
                if step[1] == -1 and step[2] == 0 then step = { 0, 1 } elseif step[1] == 0 and step[2] == 1 then step = { 1, 0 } elseif step[1] == 1 and step[2] == 0 then step = { 0, -1 } else step = { -1, 0 } end
                goto try_again
            elseif lookahead_char == "?" then
                break
            else
                position = lookahead
            end
        end
    end
    print("Part 2: " .. result2)
end

function day06.key(position)
    return position[1] * 1000 + position[2]
end

function day06.unkey(key)
    local y = math.floor(key / 1000)
    local x = key - (y * 1000)
    return { y, x }
end

return day06
