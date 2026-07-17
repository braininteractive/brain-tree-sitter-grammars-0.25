iterator countdown2(n: int): int =
  var i = n
  while i > 0:
    yield i
    dec i

iterator pairsOf[T](s: seq[T]): (int, T) =
  for i in 0 ..< s.len:
    yield (i, s[i])

for v in countdown2(3):
  echo v

for i, x in pairsOf(@["a", "b"]):
  echo i, ":", x
