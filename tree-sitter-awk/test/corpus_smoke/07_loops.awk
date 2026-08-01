BEGIN {
  for (i = 1; i <= 10; i++) {
    if (i % 2) continue
    sum += i
  }
  do { sum-- } while (sum > 20)
  print sum
}
