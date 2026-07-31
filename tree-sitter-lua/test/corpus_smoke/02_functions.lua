local function add(a, b)
  return a + b
end

local mul = function(a, b) return a * b end

local function variadic(...)
  local args = { ... }
  return select("#", ...), args
end

print(add(1, 2), mul(3, 4), variadic("x", "y"))
