local day14 = {}

local util = require("util")

function day14.part1()
    local grid_height = 103
    local grid_width = 101
    local p_y, p_x, v_y, v_x, is_up, is_right, is_down, is_left
    local q1, q2, q3, q4 = 0, 0, 0, 0

    for line in util.get_input_lines("day14") do
        p_x, p_y, v_x, v_y = line:match("^p=([-]?%d+),([-]?%d+) v=([-]?%d+),([-]?%d+)$")
        p_x, p_y, v_x, v_y = tonumber(p_x), tonumber(p_y), tonumber(v_x), tonumber(v_y)

        for _=1,100 do
            p_y = p_y + v_y
            p_x = p_x + v_x
        end

        p_y = p_y % grid_height
        p_x = p_x % grid_width

        is_up = p_y > ((grid_height - 1) / 2)
        is_right = p_x > ((grid_width - 1) / 2)
        is_down = p_y < ((grid_height - 1) / 2)
        is_left = p_x < ((grid_width - 1) / 2)

        if is_right and is_up then q1 = q1 + 1
        elseif is_left and is_up then q2 = q2 + 1
        elseif is_right and is_down then q3 = q3 + 1
        elseif is_left and is_down then q4 = q4 + 1 end
    end

    print("Part 1: " .. q1 * q2 * q3 * q4)
end

function day14.part2()
    local grid_height = 103
    local grid_width = 101
    local p_y, p_x, v_y, v_x, grid, row, pseudo_set_x, n_non_empty_columns, pseudo_set_y, n_non_empty_rows
    local robots = {}

    for line in util.get_input_lines("day14") do
        p_x, p_y, v_x, v_y = line:match("^p=([-]?%d+),([-]?%d+) v=([-]?%d+),([-]?%d+)$")
        table.insert(robots, { tonumber(p_y), tonumber(p_x), tonumber(v_y), tonumber(v_x) })
    end

    for second_n=1,math.huge do
        -- Do one sec movement for each robot
        pseudo_set_x = {}
        pseudo_set_y = {}
        for i=1,#robots do
            p_y, p_x, v_y, v_x = table.unpack(robots[i])
            robots[i][1] = (p_y + v_y) % grid_height
            robots[i][2] = (p_x + v_x) % grid_width
            pseudo_set_y[robots[i][1]] = true
            pseudo_set_x[robots[i][2]] = true
        end
        -- If there's a picture, then there shouldn't be that many rows and columns with atleast one robot in them
        n_non_empty_rows = 0
        n_non_empty_columns = 0
        for _ in pairs(pseudo_set_y) do n_non_empty_rows = n_non_empty_rows + 1 end
        for _ in pairs(pseudo_set_x) do n_non_empty_columns = n_non_empty_columns + 1 end
        -- Fine-tuned values from observing common/rare n_non_empty_columns/n_non_empty_rows values:
        if n_non_empty_columns < 89  and n_non_empty_rows < 90 then
            print("Part 2: " .. second_n)
            --[[
            -- Prepare a grid for printing to terminal
            grid = {}
            for _=1,grid_height do
                row = {}
                for _=1,grid_width do
                    table.insert(row, ".")
                end
                table.insert(grid, row)
            end
            -- Mark robot locations and print the grid
            for i=1,#robots do
                grid[robots[i][1] + 1][robots[i][2] + 1] = "#"
            end
            util._debug_grid_print(grid)
            --]]
            break
        end
    end
end

return day14
