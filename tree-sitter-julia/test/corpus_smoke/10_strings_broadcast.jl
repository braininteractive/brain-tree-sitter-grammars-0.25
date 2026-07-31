name = "julia"
greeting = "hello $name, sum=$(1 + 2)"
multi = """
multi "quoted" line
$(uppercase(name))
"""
raw = raw"C:\path\no$interp"

xs = [1, 2, 3]
ys = xs .* 2 .+ 1
zs = sqrt.(xs)

println(greeting, multi, raw, ys, zs)
