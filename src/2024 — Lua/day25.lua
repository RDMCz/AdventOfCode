local day25 = {}

local util = require("util")

function day25.part1()
    -- Parse the input
    local locks_and_keys = {}
    local lock_or_key = {}
    local char
    -- Input has to have two empty lines at the end
    for line in util.get_input_lines("day25") do
        if line == "" then
            table.insert(locks_and_keys, lock_or_key)
            lock_or_key = {}
        else
            for i=1,#line do
                char = line:sub(i, i)
                if char == "#" then
                    table.insert(lock_or_key, 1)
                else
                    table.insert(lock_or_key, 0)
                end
            end
        end
    end

    -- Classify locks and keys
    local locks = {}
    local keys = {}
    for _,item in ipairs(locks_and_keys) do
        if item[1] == 1 then
            table.insert(locks, item)
        else
            table.insert(keys, item)
        end
        -- "Trim" – remove table's first and last five elements (first and last row of lock/key is not necessary)
        for _=1,5 do
            table.remove(item, 1)
            table.remove(item, #item)
        end
    end

    -- Try all lock/key combinations
    local result = 0
    for _,lock in ipairs(locks) do
        for _,key in ipairs(keys) do
            for i=1,#key do
                if lock[i] + key[i] == 2 then
                    goto continue
                end
            end
            result = result + 1
            ::continue::
        end
    end
    print("Part 1: " .. result)
end

return day25
