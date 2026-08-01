{
  gsub(/[[:space:]]+/, " ")
  n = split($0, parts, " ")
  if (n >= 2) print toupper(parts[1]), length(parts[2])
  else if (n == 1) print "single"
  else print "empty"
}
