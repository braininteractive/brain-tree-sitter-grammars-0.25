proc classify(n: int): string =
  if n < 0:
    "negative"
  elif n == 0:
    "zero"
  else:
    "positive"

for i in 0 ..< 10:
  if i mod 2 == 0:
    continue
  echo i

var j = 0
while j < 5:
  inc j

case classify(3)
of "positive":
  echo "yes"
of "negative", "zero":
  echo "no"
else:
  discard
