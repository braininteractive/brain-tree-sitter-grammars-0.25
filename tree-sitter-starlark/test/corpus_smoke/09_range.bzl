def ranges():
    xs = range(10)
    total = 0
    for i in xs:
        if i % 2 == 0:
            continue
        total += i
    return total
