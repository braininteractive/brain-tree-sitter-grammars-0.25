BEGIN {
  while ((getline line < "input.txt") > 0)
    total += line
  close("input.txt")
  print total | "sort -n"
}
