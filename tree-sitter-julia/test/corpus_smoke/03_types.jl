abstract type Shape end

struct Circle <: Shape
    radius::Float64
end

mutable struct Counter
    value::Int
    Counter() = new(0)
end

Base.@kwdef struct Config
    name::String = "default"
    retries::Int = 3
end

area(c::Circle) = π * c.radius^2
println(area(Circle(2.0)), " ", Config().retries)
