squares <- lapply(1:5, function(x) x^2)

means <- sapply(mtcars, mean)

mapped <- Map(function(a, b) a + b, 1:3, 4:6)

make_counter <- function() {
  count <- 0
  function() {
    count <<- count + 1
    count
  }
}

tick <- make_counter()
tick()

vapply(letters[1:3], toupper, character(1))
