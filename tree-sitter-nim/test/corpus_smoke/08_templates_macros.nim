template withLock(body: untyped) =
  echo "lock"
  try:
    body
  finally:
    echo "unlock"

template square(x: untyped): untyped = x * x

withLock:
  echo "critical"

echo square(4)

macro dump(x: typed): untyped =
  result = x

import std/macros
