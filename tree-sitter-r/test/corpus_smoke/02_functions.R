add <- function(a, b) {
  a + b
}

greet <- function(name = "world", ...) {
  paste("hello", name)
}

square <- \(x) x^2
compose <- \(f, g) \(x) f(g(x))

result <- add(1, 2)
