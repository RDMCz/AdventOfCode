local day07 = {}

local util = require("util")

function day07.parts1and2()
    local expected_value, numbers
    local result1 = 0
    local result2 = 0
    for line in util.get_input_lines("day07") do
        expected_value = nil
        numbers = {}
        for match in string.gmatch(line, "[^: ]+") do
            if expected_value == nil then
                expected_value = tonumber(match)
            else
                table.insert(numbers, tonumber(match))
            end
        end
        if day07.parts1and2impl(numbers, numbers[1], 2, expected_value, false) > 0 then
            result1 = result1 + expected_value
        end
        if day07.parts1and2impl(numbers, numbers[1], 2, expected_value, true) > 0 then
            result2 = result2 + expected_value
        end
    end
    print("Part 1: " .. result1)
    print("Part 2: " .. result2)
end

function day07.parts1and2impl(numbers, current_value, index, expected_value, is_part2)
    local result = 0
    if index <= #numbers then
        result = result + day07.parts1and2impl(numbers, current_value + numbers[index], index + 1, expected_value, is_part2)
        result = result + day07.parts1and2impl(numbers, current_value * numbers[index], index + 1, expected_value, is_part2)
        if is_part2 then
            result = result + day07.parts1and2impl(numbers, tonumber(tostring(current_value) .. tostring(numbers[index])), index + 1, expected_value, is_part2)
        end
    elseif current_value == expected_value then
        result = result + 1
    end
    return result
end

return day07
