local day02 = {}

local util = require("util")

function day02.parts1and2()
    local parsed_input = {}
    local incr_decrs = {}
    for line in util.get_input_lines("day02") do
        local parsed_input_part = {}
        local incr_decr = nil
        local first_number = nil
        for number_str in string.gmatch(line, "[^ ]+") do
            local number = tonumber(number_str)
            if first_number == nil then
                first_number = number
            elseif incr_decr == nil then
                incr_decr = (number > first_number)
            end
            table.insert(parsed_input_part, number)
        end
        table.insert(parsed_input, parsed_input_part)
        table.insert(incr_decrs, incr_decr)
    end
    local result1 = 0
    local result2_minus_result1 = 0
    for i=1,#parsed_input do
        local row = parsed_input[i]
        local incr_decr = incr_decrs[i]
        for j=2,#row do
            local difference = row[j] - row[j - 1]
            if not incr_decr then difference = -difference end
            if not (difference >= 1 and difference <= 3) then
                -- #JustPart2Things
                for remove_index=1,#row do
                    local bruteforce_row = {}
                    for k=1,#row do
                        if k ~= remove_index then table.insert(bruteforce_row, row[k]) end
                    end
                    local bruteforce_incr_decr = (bruteforce_row[2] > bruteforce_row[1])
                    for k=2,#bruteforce_row do
                        local bruteforce_difference = bruteforce_row[k] - bruteforce_row[k - 1]
                        if not bruteforce_incr_decr then bruteforce_difference = -bruteforce_difference end
                        if not (bruteforce_difference >= 1 and bruteforce_difference <= 3) then break end
                        if k == #bruteforce_row then
                            result2_minus_result1 = result2_minus_result1 + 1
                            goto bruteforce_stop
                        end
                    end
                end
                ::bruteforce_stop::
                break
            end
            if j == #row then result1 = result1 + 1 end
        end
    end
    print("Part 1: " .. result1)
    print("Part 2: " .. result2_minus_result1 + result1)
end

return day02
