local single = 'single "quoted"'
local double = "double 'quoted'"
local long = [[
multi line
with "quotes" and \n literal
]]
local level = [==[
contains ]] inside
]==]
print(single, double, long, level, "concat" .. " works")
