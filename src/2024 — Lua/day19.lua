local day19 = {}

local util = require("util")

function day19.part1()
    local result = 0
    local towels = {}
    local row_n = 0
    local impossible_pseudo_set = {}
    for line in util.get_input_lines("day19") do
        row_n = row_n + 1
        if row_n == 1 then
            for towel in string.gmatch(line, "[^, ]+") do
                table.insert(towels, towel)
            end
        elseif row_n >= 3 then
            if day19.part1impl(line, towels, impossible_pseudo_set) then
                result = result + 1
            end
        end
    end
    print("Part 1: " .. result)
end

function day19.part1impl(pattern, towels, impossible)
    if impossible[pattern] then return false end

    if pattern == "" then return true end

    for _,towel in ipairs(towels) do
        if towel == pattern:sub(1, #towel) then
            if day19.part1impl(pattern:sub(#towel + 1), towels, impossible) then
                return true
            end
        end
    end

    impossible[pattern] = true
    return false
end

function day19.part2()
    local result = 0
    local towels = {}
    local row_n = 0
    local cache = {}
    for line in util.get_input_lines("day19") do
        row_n = row_n + 1
        if row_n == 1 then
            for towel in string.gmatch(line, "[^, ]+") do
                table.insert(towels, towel)
            end
        elseif row_n >= 3 then
            result = result + day19.part2impl(line, towels, cache)
        end
    end
    print("Part 2: " .. result)
end

function day19.part2impl(pattern, towels, cache)
    if pattern == "" then return 1 end

    if cache[pattern] then return cache[pattern] end

    local result = 0

    for _,towel in ipairs(towels) do
        if towel == pattern:sub(1, #towel) then
            result = result + day19.part2impl(pattern:sub(#towel + 1), towels, cache)
        end
    end

    cache[pattern] = result
    return result
end

return day19
