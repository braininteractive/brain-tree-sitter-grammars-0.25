local function counter()
  local count = 0
  return function()
    count = count + 1
    return count
  end
end

local next_id = counter()
print(next_id(), next_id())

local memo = {}
local function fib(n)
  if memo[n] then return memo[n] end
  local r = n < 2 and n or fib(n - 1) + fib(n - 2)
  memo[n] = r
  return r
end
print(fib(20))
