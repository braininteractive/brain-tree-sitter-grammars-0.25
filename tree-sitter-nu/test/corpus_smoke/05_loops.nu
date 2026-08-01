for i in 1..5 {
  if ($i mod 2) == 0 {
    continue
  }
  print $i
}

mut total = 0
while $total < 10 {
  $total = $total + 3
}
