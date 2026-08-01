$1 == "ERROR" { errors[$2]++ }
END {
  for (host in errors)
    printf "%s: %d\n", host, errors[host]
}
