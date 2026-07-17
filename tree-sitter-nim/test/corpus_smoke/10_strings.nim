import std/strformat

let name = "nim"
let greeting = fmt"hello {name}, {1 + 2}"
let raw = r"C:\Users\path"
let multi = """
first line
second "quoted" line
"""

echo greeting, raw, multi
echo "concat" & " " & "works"
