local ok, err = pcall(function()
  error({ code = 42, msg = "boom" })
end)

if not ok then
  print(type(err) == "table" and err.msg or tostring(err))
end

local function safe_div(a, b)
  assert(b ~= 0, "division by zero")
  return a / b
end

print(select(2, pcall(safe_div, 1, 0)))
