single <- 'single quoted'
double <- "double quoted"
escaped <- "line one\nline two\t\"quoted\""

raw1 <- r"(no \escapes needed here)"
raw2 <- r"[brackets (inside) are fine]"
raw3 <- R"{curly raw string}"

multi <- "first line
second line"

glued <- sprintf("%s scored %.1f", "team", 99.5)
