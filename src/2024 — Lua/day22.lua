local day22 = {}

local util = require("util")

function day22.part1()
    local result = 0
    local number
    for line in util.get_input_lines("day22") do
        number = tonumber(line)
        for _=1,2000 do
            number = day22.mix_and_prune(number, number * 64)
            number = day22.mix_and_prune(number, math.floor(number / 32))
            number = day22.mix_and_prune(number, number * 2048)
        end
        result = result + number
    end
    print("Part 1: " .. result)
end

function day22.part2()
    local total_sequence_prices = {}
    local number, prev_last_digit, last_digit, diff, diffs, key, used_sequences
    for line in util.get_input_lines("day22") do
        number = tonumber(line)
        prev_last_digit = number % 10
        diffs = {}
        used_sequences = {}
        for _=1,2000 do
            number = day22.mix_and_prune(number, number * 64)
            number = day22.mix_and_prune(number, math.floor(number / 32))
            number = day22.mix_and_prune(number, number * 2048)

            last_digit = number % 10
            diff = last_digit - prev_last_digit
            prev_last_digit = last_digit

            table.insert(diffs, diff)
            if #diffs >= 4 then
                key = day22.key(diffs)
                if not used_sequences[key] then
                    if not total_sequence_prices[key] then
                        total_sequence_prices[key] = 0
                    end
                    total_sequence_prices[key] = total_sequence_prices[key] + last_digit
                    used_sequences[key] = true
                end
            end
        end
    end
    local result = 0
    for _,v in pairs(total_sequence_prices) do
        if v > result then
            result = v
        end
    end
    print("Part 2: " .. result)
end

function day22.mix_and_prune(a, b)
    return (a ~ b) % 16777216
end

function day22.key(diffs)
    local d, c, b, a = diffs[#diffs] + 10, diffs[#diffs - 1] + 10, diffs[#diffs - 2] + 10, diffs[#diffs - 3] + 10
    return a + b * 100 + c * 100^2 + d * 100^3
end

return day22
