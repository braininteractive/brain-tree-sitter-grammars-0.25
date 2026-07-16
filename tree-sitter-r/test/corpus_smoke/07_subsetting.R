v <- c(a = 1, b = 2, c = 3)
first <- v[1]
named <- v["b"]
several <- v[c(1, 3)]

lst <- list(x = 1:3, y = letters)
inner <- lst[[1]]
by_name <- lst[["y"]]
dollar <- lst$x

df <- data.frame(a = 1:3, b = 4:6)
cell <- df[2, "b"]
col <- df$a

p <- new("Person", name = "Ada", age = 36)
slot_value <- p@name
