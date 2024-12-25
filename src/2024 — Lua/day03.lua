local day03 = {}

local util = require("util")

function day03.parts1and2()
    local one_line = ""
    for line in util.get_input_lines("day03") do
        one_line = one_line .. line
    end
    local do_indexes = util.string_find_all(one_line, "do%(%)", false)
    local dont_indexes = util.string_find_all(one_line, "don't%(%)", false)
    table.insert(do_indexes, math.huge)
    table.insert(dont_indexes, math.huge)
    local result1 = 0
    local result2 = 0
    for index, match in string.gmatch(one_line, "()(mul%(%d+,%d+%))") do
        local mul_result = 1
        for mul_match in string.gmatch(match, "%d+") do
            mul_result = mul_result * tonumber(mul_match)
        end
        result1 = result1 + mul_result
        -- #JustPart2Things
        local nearest_smaller_do_index = 0
        for i=1,#do_indexes do
            if do_indexes[i] > index then
                nearest_smaller_do_index = do_indexes[i - 1]
                break
            end
        end
        if nearest_smaller_do_index == nil then nearest_smaller_do_index = 0 end
        local nearest_smaller_dont_index = 0
        for i=1,#dont_indexes do
            if dont_indexes[i] > index then
                nearest_smaller_dont_index = dont_indexes[i - 1]
                break
            end
        end
        if nearest_smaller_dont_index == nil then nearest_smaller_dont_index = 0 end
        if nearest_smaller_do_index >= nearest_smaller_dont_index then result2 = result2 + mul_result end
    end
    print("Part 1: " .. result1)
    print("Part 2: " .. result2)
end

return day03
