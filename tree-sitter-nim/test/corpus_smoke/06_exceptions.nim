type
  ParseError = object of CatchableError

proc parseAge(s: string): int =
  try:
    result = parseInt(s)
  except ValueError:
    raise newException(ParseError, "bad age: " & s)
  finally:
    echo "attempted: ", s

from std/strutils import parseInt

when isMainModule:
  try:
    discard parseAge("abc")
  except ParseError as e:
    echo e.msg
