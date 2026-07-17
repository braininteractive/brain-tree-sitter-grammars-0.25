echo "Hello, world!"

proc greet(name: string): string =
  result = "hi " & name

echo greet("nim")
