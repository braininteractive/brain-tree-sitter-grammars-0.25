let squares = (1..10 | each { |n| $n * $n } | where $it > 20)
print ($squares | length)
