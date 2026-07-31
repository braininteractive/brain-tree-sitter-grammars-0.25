local producer = coroutine.create(function()
  for i = 1, 3 do
    coroutine.yield(i * 100)
  end
  return "done"
end)

while true do
  local ok, value = coroutine.resume(producer)
  if not ok or coroutine.status(producer) == "dead" then
    print(value)
    break
  end
  print(value)
end
