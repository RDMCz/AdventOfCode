def run(lines):
    result = 0
    for line in lines:
        splitted = line.split(" ")
        expected_value = int(splitted[0][:-1])
        numbers = [int(number) for number in splitted[1:]]
        if impl(numbers, numbers[0], 1, expected_value) > 0:
            result += expected_value
    print(f"Part 2: {result}")


def impl(numbers, current_value, index, expected_value):
    result = 0
    if index < len(numbers):
        result += impl(numbers, current_value + numbers[index], index + 1, expected_value)
        result += impl(numbers, current_value * numbers[index], index + 1, expected_value)
        result += impl(numbers, int(f"{current_value}{numbers[index]}"), index + 1, expected_value)
    elif current_value == expected_value:
        result += 1
    return result
