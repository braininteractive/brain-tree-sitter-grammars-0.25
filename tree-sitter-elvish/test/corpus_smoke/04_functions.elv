fn greet {|name|
  echo hello $name
}

fn add {|a b|
  put (+ $a $b)
}

greet world
add 1 2
