x <- 10

if (x > 5) {
  print("big")
} else if (x > 0) {
  print("small")
} else {
  print("non-positive")
}

for (i in 1:5) {
  if (i == 3) next
  if (i == 5) break
  print(i)
}

while (x > 0) {
  x <- x - 1
}

repeat {
  x <- x + 1
  if (x >= 3) break
}
