local day11 = {}

local util = require("util")

function day11.part1iterative()
    local num, str
    local stones = {}
    for line in util.get_input_lines("day11") do
        for match in string.gmatch(line, "[^ ]+") do
            table.insert(stones, tonumber(match))
        end
    end
    for _=1,25 do
        for stone_n=1,#stones do
            num = stones[stone_n]
            -- Rule 1
            if num == 0 then
                stones[stone_n] = 1
            else
                str = tostring(num)
                -- Rule 2
                if #str % 2 == 0 then
                    stones[stone_n] = tonumber(str:sub(1, #str / 2))
                    table.insert(stones, tonumber(str:sub(#str / 2 + 1)))
                -- Rule 3
                else
                    stones[stone_n] = num * 2024
                end
            end
        end
    end
    print("Part 1: " .. #stones)
end

function day11.part1recursive()
    local stones = {}
    for line in util.get_input_lines("day11") do
        for match in string.gmatch(line, "[^ ]+") do
            table.insert(stones, tonumber(match))
        end
    end
    local result = {0}
    local n_blinks_remaining = 25
    for i=1,#stones do
        day11.part1recursive_impl(stones[i], n_blinks_remaining, result)
    end
    print("Part 1: " .. result[1])
end

function day11.part1recursive_impl(number, n_blinks_remaining, result)
    if n_blinks_remaining == 0 then
        result[1] = result[1] + 1
        return
    end
    -- Rule 1
    if number == 0 then
        day11.part1recursive_impl(1, n_blinks_remaining - 1, result)
    else
        local str = tostring(number)
        -- Rule 2
        if #str % 2 == 0 then
            day11.part1recursive_impl(tonumber(str:sub(1, #str / 2)), n_blinks_remaining - 1, result)
            day11.part1recursive_impl(tonumber(str:sub(#str / 2 + 1)), n_blinks_remaining - 1, result)
        -- Rule 3
        else
            day11.part1recursive_impl(number * 2024, n_blinks_remaining - 1, result)
        end
    end
end

return day11
