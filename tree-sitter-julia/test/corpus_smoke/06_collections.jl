nums = [1, 2, 3, 4, 5]
evens = filter(iseven, nums)
doubled = map(x -> 2x, nums)
squares = [x^2 for x in nums if x > 2]
matrix = [1 2; 3 4]

d = Dict("a" => 1, "b" => 2)
d["c"] = 3

t = (1, "two", 3.0)
nt = (name="julia", version=1.11)

println(evens, doubled, squares, matrix[2, 1], d["c"], t[2], nt.name)
