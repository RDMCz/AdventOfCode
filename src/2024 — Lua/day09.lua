local day09 = {}

local util = require("util")

function day09.part1()
    -- Parse the input diskmap
    local numbers_diskmap = {}
    for line in util.get_input_lines("day09") do
        for i=1,#line do
            table.insert(numbers_diskmap, tonumber(line:sub(i, i)))
        end
    end
    -- Convert to individual blocks
    local numbers_blocks = {}
    local id = 0
    for i=1,#numbers_diskmap do
        if i % 2 == 1 then
            for _=1,numbers_diskmap[i] do table.insert(numbers_blocks, id) end
            id = id + 1
        else
            for _=1,numbers_diskmap[i] do table.insert(numbers_blocks, -1) end
        end
    end
    -- Compress
    local numbers_compressed = {}
    local pointer_left = 1
    local pointer_right = #numbers_blocks
    local number
    while true do
        number = numbers_blocks[pointer_left]
        if number ~= -1 then
            table.insert(numbers_compressed, number)
        else
            number = numbers_blocks[pointer_right]
            while number == -1 do
                pointer_right = pointer_right - 1
                number = numbers_blocks[pointer_right]
            end
            if pointer_right < pointer_left then break end
            table.insert(numbers_compressed, numbers_blocks[pointer_right])
            numbers_blocks[pointer_right] = -1
        end
        pointer_left = pointer_left + 1
    end
    -- Update the filesystem checksum
    local result = 0
    for i=1,#numbers_compressed do
        result = result + ((i - 1) * numbers_compressed[i])
    end
    print("Part 1: " .. result)
end

function day09.part2()
    -- Parse the input diskmap
    local numbers_diskmap = {}
    for line in util.get_input_lines("day09") do
        for i=1,#line do
            table.insert(numbers_diskmap, tonumber(line:sub(i, i)))
        end
    end
    -- Convert to individual blocks
    local numbers_blocks = {}
    local id = 0
    for i=1,#numbers_diskmap do
        if i % 2 == 1 then
            for _=1,numbers_diskmap[i] do table.insert(numbers_blocks, id) end
            id = id + 1
        else
            for _=1,numbers_diskmap[i] do table.insert(numbers_blocks, -1) end
        end
    end
    -- Compress
    local moved_or_checked_numbers_pseudo_set = {}
    moved_or_checked_numbers_pseudo_set[-1] = true -- So we don't try to move empty space
    local number, lookahead_from_right, file_length, pointer_left, empty_space_start, usable_empty_space_start, lookahead_from_left, empty_space_length
    for pointer_right=#numbers_blocks,1,-1 do
        number = numbers_blocks[pointer_right]
        if not moved_or_checked_numbers_pseudo_set[number] then
            -- Lookahead: determine file length
            file_length = 0
            lookahead_from_right = pointer_right
            while numbers_blocks[lookahead_from_right] == number do
                file_length = file_length + 1
                lookahead_from_right = lookahead_from_right - 1
                if lookahead_from_right == 0 then break end -- Lookahead out of range
            end
            -- Try to find big enough empty space
            pointer_left = 0
            usable_empty_space_start = -1
            while true do
                pointer_left = pointer_left + 1
                if pointer_left > lookahead_from_right then break end -- Did not find any big enough empty space
                if numbers_blocks[pointer_left] == -1 then
                    empty_space_start = pointer_left
                    -- Lookahead: determine empty space length
                    empty_space_length = 0
                    lookahead_from_left = pointer_left
                    while numbers_blocks[lookahead_from_left] == -1 do
                        empty_space_length = empty_space_length + 1
                        lookahead_from_left = lookahead_from_left + 1
                        -- Lookahead out of range should not happen here
                    end
                    -- Is it big enough?
                    if empty_space_length >= file_length then
                        usable_empty_space_start = empty_space_start
                        break
                    end
                    -- If not, set left pointer after the end of empty space, so we don't check it again
                    pointer_left = lookahead_from_left -- It will be immeadetly increased next round of while loop, shouldn't matter
                end
            end
            -- Move file if big enough empty space has been found
            if usable_empty_space_start ~= -1 then
                -- Fill empty space with file
                for i=0,file_length-1 do numbers_blocks[usable_empty_space_start + i] = number end
                -- Replace file's old location with empty space
                for i=0,file_length-1 do numbers_blocks[pointer_right - i] = -1 end
            end
            -- Do not check this number again
            moved_or_checked_numbers_pseudo_set[number] = true
        end
    end
    -- Update the filesystem checksum
    local result = 0
    for index,value in ipairs(numbers_blocks) do
        if value ~= -1 then
            result = result + ((index - 1) * value)
        end
    end
    print("Part 2: " .. result)
end

return day09
