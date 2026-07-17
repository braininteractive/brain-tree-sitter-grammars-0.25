proc biggest[T](a, b: T): T =
  if a > b: a else: b

type
  Stack[T] = object
    items: seq[T]

proc push[T](s: var Stack[T], item: T) =
  s.items.add(item)

proc pop[T](s: var Stack[T]): T =
  result = s.items[^1]
  s.items.setLen(s.items.len - 1)

var s: Stack[int]
s.push(1)
echo biggest(2, 3)
