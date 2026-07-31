module Geometry

export area, Circle

struct Circle
    r::Float64
end

area(c::Circle) = π * c.r^2

module Internal
helper() = 42
end

end

using .Geometry
import .Geometry.Internal: helper

println(area(Circle(1.0)), " ", helper())
