def run(lines):
    towels = lines[0].split(", ")
    lines = lines[2:]
    result = 0
    cache = {}
    for line in lines:
        result += impl(line, towels, cache)
    print(f"Part 2: {result}")


def impl(pattern, towels, cache):
    if pattern in cache:
        return cache[pattern]
    result = 0
    for towel in towels:
        if pattern.startswith(towel):
            if pattern == towel:
                result += 1
            else:
                result += impl(pattern[len(towel):], towels, cache)
    cache[pattern] = result
    return result
