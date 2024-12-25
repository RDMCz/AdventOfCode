local day01 = {}

local util = require("util")

function day01.parts1and2()
    local left = {}
    local right = {}
    local is_left_or_right

    -- Make two number tables (one for each column) and sort them
    for line in util.get_input_lines("day01") do
        is_left_or_right = true
        for number in string.gmatch(line, "[^ ]+") do
            if is_left_or_right then table.insert(left, tonumber(number)) else table.insert(right, tonumber(number)) end
            is_left_or_right = false
        end
    end
    table.sort(left)
    table.sort(right)

    -- Part1: Sum the differences between table items
    local result1 = 0
    for i=1,#left do
        result1 = result1 + math.abs(right[i] - left[i])
    end
    print("Part 1: " .. result1)

    -- Part2: Tables are sorted → only two vars are needed for cache
    local result2 = 0
    local last_number
    local last_score
    for i=1,#left do
        local number = left[i]
        if number ~= last_number then
            local score = 0
            for j=1,#right do
                if right[j] == number then score = score + number end
            end
            result2 = result2 + score
            last_number = number
            last_score = score
        else
            result2 = result2 + last_score
        end
    end
    print("Part 2: " .. result2)
end

return day01
