proc fastAdd(a, b: int): int {.inline.} = a + b

proc callback(x: int) {.cdecl.} =
  echo x

var handler: proc(x: int) {.cdecl.} = callback

proc deprecatedThing() {.deprecated: "use newThing".} =
  discard

func pure(a: int): int = a * 2

echo fastAdd(1, 2), pure(3)
