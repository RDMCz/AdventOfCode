local day13 = {}

local util = require("util")

--[[
Gauss-Jordan: ax + by = e && cx + dy = f
I did this on paper:

[ a   b | e ]     [ a       b    |     e    ]     [ a       0    | (e-(bf-(bec)/a)/(d-(bc)/a)) ]     [ 1   0 | (e-(bf-(bec)/a)/(d-(bc)/a))/a ]
[       |   ]  ~  [              |          ]  ~  [              |                             ]  ~  [       |                               ]
[ c   d | f ]     [ 0   d-(bc)/a | f-(ec)/a ]     [ 0   d-(bc)/a |           f-(ec)/a          ]     [ 0   1 |     (f-(ec)/a)/(d-(bc)/a)     ]

x = (e - (bf - (bec) / a) / (d - (bc) / a)) / a
y = (f - (ec) / a) / (d - (bc) / a)
]]

function day13.part1or2(is_part1)
    local x, y
    local line_n_modulo_4 = 1
    local machines = {}
    local machine = {}
    -- Two empty lines must be at the end of the input file
    for line in util.get_input_lines("day13") do
        if line == "" then
            line_n_modulo_4 = 0
            table.insert(machines, machine)
            machine = {}
        else
            if line_n_modulo_4 == 1 then
                x, y = line:match("Button A: X%+(%d+), Y%+(%d+)")
            elseif line_n_modulo_4 == 2 then
                x, y = line:match("Button B: X%+(%d+), Y%+(%d+)")
            else --line_n_modulo_4 == 3 then
                x, y = line:match("Prize: X=(%d+), Y=(%d+)")
            end
            table.insert(machine, tonumber(x))
            table.insert(machine, tonumber(y))
        end
        line_n_modulo_4 = line_n_modulo_4 + 1
    end
    local a, b, c, d, e, f
    local result = 0
    for i=1,#machines do
        a, c, b, d, e, f = table.unpack(machines[i])
        if not is_part1 then
            e = e + 10000000000000
            f = f + 10000000000000
        end
        x = (e - (b * f - (b * e * c) / a) / (d - (b * c) / a)) / a
        y = (f - (e * c) / a) / (d - (b * c) / a)
        if tostring(x):sub(-2) == ".0" and tostring(y):sub(-2) == ".0" then
            result = result + (3 * x + y)
        end
    end
    print("Part 1/2: " .. tostring(result):sub(0, -3))
end

return day13
