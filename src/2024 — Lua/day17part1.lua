local day17 = {}

local util = require("util")

function day17.part1()
    local row_n = 0
    local registers = {}
    local program = {}
    for line in util.get_input_lines("day17") do
        row_n = row_n + 1
        if row_n < 4 then
            table.insert(registers, tonumber(line:match("Register %u: (%d+)")))
        elseif row_n == 5 then
            for i=10,#line,2 do
                table.insert(program, tonumber(line:sub(i, i)))
            end
        end
    end

    local output = ""
    local pointer = 1
    local opcode, operand

    repeat
        opcode = program[pointer]
        operand = program[pointer + 1]
        if opcode == 0 then -- ADV:
            registers[1] = math.floor(registers[1] / 2 ^ day17.combo(operand, registers))
        elseif opcode == 1 then -- BXL:
            registers[2] = registers[2] ~ operand
        elseif opcode == 2 then -- BST:
            registers[2] = day17.combo(operand, registers) % 8
        elseif opcode == 3 then -- JNZ:
            if registers[1] ~= 0 then pointer = (operand - 2) + 1 end
        elseif opcode == 4 then -- BXC:
            registers[2] = registers[2] ~ registers[3]
        elseif opcode == 5 then -- OUT:
            output = output .. day17.combo(operand, registers) % 8 .. ","
        elseif opcode == 6 then -- BDV:
            registers[2] = math.floor(registers[1] / 2 ^ day17.combo(operand, registers))
        elseif opcode == 7 then -- CDV:
            registers[3] = math.floor(registers[1] / 2 ^ day17.combo(operand, registers))
        end
        pointer = pointer + 2
    until pointer > #program

    print("Part 1: " .. output:sub(1, -2))
end

function day17.combo(value, registers)
    if value <= 3 then return value end
    return registers[value - 3]
end

return day17
