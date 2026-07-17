import std/[tables, sets, sequtils]

var scores = initTable[string, int]()
scores["alice"] = 10
scores["bob"] = 7

let names = @["a", "b", "c"]
let doubled = names.mapIt(it & it)
let unique = toHashSet([1, 2, 2, 3])

for k, v in scores.pairs:
  echo k, "=", v
