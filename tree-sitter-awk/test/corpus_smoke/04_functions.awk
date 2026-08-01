function max(a, b) {
  return a > b ? a : b
}
{ peak = max(peak, $3) }
END { print peak }
