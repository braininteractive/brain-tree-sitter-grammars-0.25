## Module documentation comment.
## Multi-line doc.

import std/os
export os.getEnv

const Version* = "1.0"

var counter {.threadvar.}: int

proc visible*(x: int): int =
  ## Doc comment for a proc.
  runnableExamples:
    doAssert visible(1) == 2
  x + 1

# plain comment
discard existsEnv("HOME")
