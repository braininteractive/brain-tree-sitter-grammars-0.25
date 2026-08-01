def greet [name: string, --loud] {
  if $loud {
    print ($name | str upcase)
  } else {
    print $name
  }
}

greet "world" --loud
