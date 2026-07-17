import std/asyncdispatch

proc fetchData(id: int): Future[string] {.async.} =
  await sleepAsync(10)
  return "data" & $id

proc main() {.async.} =
  let a = fetchData(1)
  let b = fetchData(2)
  echo await a
  echo await b

waitFor main()
