import parse


def run(lines):
    lines = (";".join(lines)).split(";;") # This way every array item will be one claw machine
    result = 0
    epsilon = 0.01 # For comparing floats
    for line in lines:
        a, c, b, d, e, f = parse.parse("Button A: X+{:d}, Y+{:d};Button B: X+{:d}, Y+{:d};Prize: X={:d}, Y={:d}", line)
        e += 10000000000000
        f += 10000000000000
        # Gauss-Jordan
        x = (e - (b * f - (b * e * c) / a) / (d - (b * c) / a)) / a
        y = (f - (e * c) / a) / (d - (b * c) / a)
        # If result is whole numbers, prize can be won from this claw machine
        if abs(x - round(x)) < epsilon and abs(y - round(y)) < epsilon:
            result += 3 * x + y
    print(f"Part 2: {round(result)}")
