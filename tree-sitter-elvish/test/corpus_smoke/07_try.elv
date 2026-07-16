try {
  fail oops
} catch e {
  echo caught
} finally {
  echo done
}

var err = ?(fail boom)
