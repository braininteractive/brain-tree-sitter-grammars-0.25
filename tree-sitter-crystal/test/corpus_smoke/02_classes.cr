class Point
  getter x : Float64
  getter y : Float64

  def initialize(@x, @y)
  end

  def +(other : Point) : Point
    Point.new(@x + other.x, @y + other.y)
  end
end

struct Vec3
  property x = 0.0, y = 0.0, z = 0.0
end
