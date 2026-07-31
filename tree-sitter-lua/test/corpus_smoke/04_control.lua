local function classify(n)
  if n < 0 then
    return "negative"
  elseif n == 0 then
    return "zero"
  else
    return "positive"
  end
end

for i = 1, 10, 2 do
  print(i)
end

local t = { "a", "b" }
for idx, val in ipairs(t) do
  print(idx, val)
end

local n = 3
while n > 0 do n = n - 1 end
repeat n = n + 1 until n >= 3

print(classify(5))
