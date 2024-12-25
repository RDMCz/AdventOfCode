local day18 = {}

local util = require("util")

function day18.part1or2(is_part1)
    -- == Save the input so we don't have to read from the file every iteration == --
    local lines = {}
    for line in util.get_input_lines("day18") do table.insert(lines, line) end

    -- == Config == --
    local max_index = 70
    local initial_n_bytes = 1024

    local final_key = day18.key_yx(max_index, max_index)
    local how_many_bytes = initial_n_bytes - 1 -- Will be increased every iteration (Part 2)

    while true do
        how_many_bytes = how_many_bytes + 1

        -- == Parse the (part of the) input == --
        local x, y
        local obstacle_pseudo_set = {}
        for row_n,line in ipairs(lines) do
            x, y = line:match("(%d+),(%d+)")
            x, y = tonumber(x), tonumber(y)
            obstacle_pseudo_set[day18.key_yx(y, x)] = true
            if row_n == how_many_bytes then break end
        end

        -- == Dijkstra == --
        local node, key, index
        local on_position, on_key, on_index -- Observed Node
        local nodes = { { 0, 0, 0 } } -- y, x, price
        local nodes_done_pseudo_set = {}
        local precursors_pseudo_set = {}

        repeat
            index = day18.get_index_of_cheapest_node(nodes)
            node = nodes[index]
            y, x = node[1], node[2]
            key = day18.key_yx(y, x)
            -- Up
            if y ~= 0 then
                on_position = { y - 1, x }
                on_key = day18.key_t(on_position)
                if not obstacle_pseudo_set[on_key] and not nodes_done_pseudo_set[on_key] then
                    on_index = day18.get_node_index_or_zero(nodes, on_position)
                    if on_index == 0 then
                        table.insert(nodes, { y - 1, x, math.huge })
                        on_index = #nodes
                    end
                    if node[3] + 1 < nodes[on_index][3] then
                        nodes[on_index][3] = node[3] + 1
                        precursors_pseudo_set[on_key] = key
                    end
                end
            end
            -- Right
            if x ~= max_index then
                on_position = { y, x + 1 }
                on_key = day18.key_t(on_position)
                if not obstacle_pseudo_set[on_key] and not nodes_done_pseudo_set[on_key] then
                    on_index = day18.get_node_index_or_zero(nodes, on_position)
                    if on_index == 0 then
                        table.insert(nodes, { y, x + 1, math.huge })
                        on_index = #nodes
                    end
                    if node[3] + 1 < nodes[on_index][3] then
                        nodes[on_index][3] = node[3] + 1
                        precursors_pseudo_set[on_key] = key
                    end
                end
            end
            -- Down
            if y ~= max_index then
                on_position = { y + 1, x }
                on_key = day18.key_t(on_position)
                if not obstacle_pseudo_set[on_key] and not nodes_done_pseudo_set[on_key] then
                    on_index = day18.get_node_index_or_zero(nodes, on_position)
                    if on_index == 0 then
                        table.insert(nodes, { y + 1, x, math.huge })
                        on_index = #nodes
                    end
                    if node[3] + 1 < nodes[on_index][3] then
                        nodes[on_index][3] = node[3] + 1
                        precursors_pseudo_set[on_key] = key
                    end
                end
            end
            --Left
            if x ~= 0 then
                on_position = { y, x - 1 }
                on_key = day18.key_t(on_position)
                if not obstacle_pseudo_set[on_key] and not nodes_done_pseudo_set[on_key] then
                    on_index = day18.get_node_index_or_zero(nodes, on_position)
                    if on_index == 0 then
                        table.insert(nodes, { y, x - 1, math.huge })
                        on_index = #nodes
                    end
                    if node[3] + 1 < nodes[on_index][3] then
                        nodes[on_index][3] = node[3] + 1
                        precursors_pseudo_set[on_key] = key
                    end
                end
            end

            nodes_done_pseudo_set[day18.key_t(node)] = true
            table.remove(nodes, index)
        until #nodes == 0 or nodes_done_pseudo_set[final_key]

        if is_part1 then
            print("Part 1: " .. node[3])
            break
        end

        if not is_part1 and precursors_pseudo_set[final_key] == nil then
            print("Part 2: " .. lines[how_many_bytes])
            break
        end
    end
end

function day18.key_yx(y, x)
    return y * 100 + x
end

function day18.key_t(t)
    return t[1] * 100 + t[2]
end

function day18.get_index_of_cheapest_node(nodes)
    local min_value = math.huge
    local min_index = 0
    for index,item in ipairs(nodes) do
        if item[3] < min_value then
            min_value = item[3]
            min_index = index
        end
    end
    return min_index
end

function day18.get_node_index_or_zero(nodes, t)
    for index,item in ipairs(nodes) do
        if item[1] == t[1] and item[2] == t[2] then return index end
    end
    return 0
end

return day18
