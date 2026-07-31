local Vector = {}
Vector.__index = Vector

function Vector.new(x, y)
  return setmetatable({ x = x, y = y }, Vector)
end

function Vector.__add(a, b)
  return Vector.new(a.x + b.x, a.y + b.y)
end

function Vector:len()
  return math.sqrt(self.x ^ 2 + self.y ^ 2)
end

local v = Vector.new(3, 4) + Vector.new(1, 0)
print(v:len())
