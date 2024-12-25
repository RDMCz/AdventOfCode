local day04 = {}

local util = require("util")

function day04.parts1and2()
    local grid = {}
    local row
    for line in util.get_input_lines("day04") do
        row = {}
        for i=1,#line do table.insert(row, line:sub(i, i)) end
        table.insert(grid, row)
    end
    util.grid_add_border(grid, 3, "?")
    local result1 = 0
    local result2 = 0
    local n_cols = #(grid[1])
    for row_n=1,#grid do
        for col_n=1,n_cols do
            if grid[row_n][col_n] == "X" then
                if grid[row_n][col_n+1] .. grid[row_n][col_n+2] .. grid[row_n][col_n+3] == "MAS" then result1 = result1 + 1 end
                if grid[row_n+1][col_n+1] .. grid[row_n+2][col_n+2] .. grid[row_n+3][col_n+3] == "MAS" then result1 = result1 + 1 end
                if grid[row_n+1][col_n] .. grid[row_n+2][col_n] .. grid[row_n+3][col_n] == "MAS" then result1 = result1 + 1 end
                if grid[row_n+1][col_n-1] .. grid[row_n+2][col_n-2] .. grid[row_n+3][col_n-3] == "MAS" then result1 = result1 + 1 end
                if grid[row_n][col_n-1] .. grid[row_n][col_n-2] .. grid[row_n][col_n-3] == "MAS" then result1 = result1 + 1 end
                if grid[row_n-1][col_n-1] .. grid[row_n-2][col_n-2] .. grid[row_n-3][col_n-3] == "MAS" then result1 = result1 + 1 end
                if grid[row_n-1][col_n] .. grid[row_n-2][col_n] .. grid[row_n-3][col_n] == "MAS" then result1 = result1 + 1 end
                if grid[row_n-1][col_n+1] .. grid[row_n-2][col_n+2] .. grid[row_n-3][col_n+3] == "MAS" then result1 = result1 + 1 end
            elseif grid[row_n][col_n] == "A" then
                local x_letters =  grid[row_n-1][col_n-1] .. grid[row_n-1][col_n+1] .. grid[row_n+1][col_n+1] .. grid[row_n+1][col_n-1]
                if x_letters == "MMSS" or x_letters == "SMMS" or x_letters == "SSMM" or x_letters == "MSSM" then result2 = result2 + 1 end
            end
        end
    end
    print("Part 1: " .. result1)
    print("Part 2: " .. result2)
end

return day04
