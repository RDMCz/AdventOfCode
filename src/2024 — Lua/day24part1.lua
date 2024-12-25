local day24 = {}

local util = require("util")

function day24.part1()
    local a, b, c, d
    local is_first_or_second_section = true
    local values = {}
    local rules = {}
    for line in util.get_input_lines("day24") do
        if line == "" then
            is_first_or_second_section = false
        elseif is_first_or_second_section then
            table.insert(values, { line:sub(1, 3), tonumber(line:sub(-1)) })
        else
            a, b, c, d = line:match("^([^ ]+) (%u+) ([^ ]+) %-> ([^ ]+)$")
            table.insert(rules, { a, b, c, d })
        end
    end

    local done
    repeat
        done = true
        for _,item in ipairs(rules) do
            if not day24.is_id_in_values(item[4], values) then
                done = false
                if day24.is_id_in_values(item[1], values) and day24.is_id_in_values(item[3], values) then
                    a = day24.get_id_value(item[1], values)
                    b = day24.get_id_value(item[3], values)
                    if item[2] == "AND" then
                        c = a & b
                    elseif item[2] == "OR" then
                        c = a | b
                    else
                        c = a ~ b
                    end
                    table.insert(values, { item[4], c })
                end
            end
        end
    until done

    local result = 0
    for _,item in ipairs(values) do
        if (item[1]):sub(1, 1) == "z" and item[2] == 1 then
            result = result + (2 ^ tonumber((item[1]):sub(2)))
        end
    end
    print("Part 1: " .. tostring(result):sub(1, -3))
end

function day24.is_id_in_values(id, values)
    for _,item in ipairs(values) do
        if item[1] == id then
            return true
        end
    end
    return false
end

function day24.get_id_value(id, values)
    for _,item in ipairs(values) do
        if item[1] == id then
            return item[2]
        end
    end
end

return day24
