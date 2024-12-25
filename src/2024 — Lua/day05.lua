local day05 = {}

local util = require("util")

function day05.parts1and2()
    local rules_update = true -- true == parsing first part of input; false == parsing second part of input
    local rules = {}
    local prior_pages, prior_pages_pseudo_set, numbers_that_must_be_after_this
    local result1 = 0
    local incorrects = {}
    for line in util.get_input_lines("day05") do
        if rules_update and line == "" then
            rules_update = false
        elseif rules_update then
            local left, right = line:match("(%d+)|(%d+)")
            table.insert(rules, { left, right })
        else
            prior_pages = {}
            prior_pages_pseudo_set = {}
            for match in line:gmatch("[^,]+") do
                if #prior_pages ~= 0 then
                    numbers_that_must_be_after_this = {}
                    for i=1,#rules do
                        if rules[i][1] == match then table.insert(numbers_that_must_be_after_this, rules[i][2]) end
                    end
                    for i=1,#numbers_that_must_be_after_this do
                        if prior_pages_pseudo_set[numbers_that_must_be_after_this[i]] then
                            table.insert(incorrects, line)
                            goto continue_outer
                        end
                    end
                end
                table.insert(prior_pages, match)
                prior_pages_pseudo_set[match] = true
            end
            result1 = result1 + prior_pages[math.ceil(#prior_pages / 2)]
        end
        ::continue_outer::
    end
    print("Part 1: " .. result1)
    -- #JustPart2Things
    local result2 = 0
    local line_t
    for _,line_str in ipairs(incorrects) do
        line_t = {}
        for match in line_str:gmatch("[^,]+") do table.insert(line_t, match) end
        ::try_again::
        prior_pages = {}
        prior_pages_pseudo_set = {}
        for _,number in ipairs(line_t) do
            if #prior_pages ~= 0 then
                numbers_that_must_be_after_this = {}
                for i=1,#rules do
                    if rules[i][1] == number then table.insert(numbers_that_must_be_after_this, rules[i][2]) end
                end
                for _,number_that_must_be_after_this in ipairs(numbers_that_must_be_after_this) do
                    if prior_pages_pseudo_set[number_that_must_be_after_this] then
                        -- Incorrect: number_that_must_be_after_this cannot be before number:
                        -- We need to get indexes of number and number_that_must_be_after_this
                        local index_t = {}
                        for index,value in pairs(line_t) do index_t[value] = index end
                        local number_index = index_t[number]
                        local number_that_must_be_after_this_index = index_t[number_that_must_be_after_this]
                        -- And put number_that_must_be_after_this after number
                        local new_line_t = {}
                        for i=1,#line_t do
                            if i == number_that_must_be_after_this_index then
                                -- Do nothing
                            elseif i == number_index then
                                table.insert(new_line_t, line_t[i])
                                table.insert(new_line_t, line_t[number_that_must_be_after_this_index])
                            else
                                table.insert(new_line_t, line_t[i])
                            end
                        end
                        line_t = new_line_t
                        goto try_again
                    end
                end
            end
            table.insert(prior_pages, number)
            prior_pages_pseudo_set[number] = true
        end
        result2 = result2 + prior_pages[math.ceil(#prior_pages / 2)]
    end
    print("Part 2: " .. result2)
end

return day05
