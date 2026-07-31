macro timeit(expr)
    quote
        t0 = time()
        result = $(esc(expr))
        println("took ", time() - t0, "s")
        result
    end
end

@timeit sum(1:1000)

@assert 1 + 1 == 2 "math is broken"

vals = [1, 2, 3]
@show length(vals)
