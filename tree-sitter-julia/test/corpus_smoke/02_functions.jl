function add(a::Int, b::Int)::Int
    return a + b
end

mul(a, b) = a * b

function variadic(args...; scale=1, kwargs...)
    sum(args) * scale
end

square = x -> x^2
composed = square ∘ add

println(add(1, 2), " ", variadic(1, 2, 3; scale=2), " ", composed(1, 2))
