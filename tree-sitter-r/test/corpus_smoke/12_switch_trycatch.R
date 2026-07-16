describe_type <- function(x) {
  switch(class(x)[1],
    numeric = "a number",
    character = "a string",
    logical = "a boolean",
    "something else"
  )
}

safe_log <- function(x) {
  tryCatch(
    log(x),
    warning = function(w) NA_real_,
    error = function(e) NULL,
    finally = message("done")
  )
}

on.exit(cat("cleanup\n"))
stopifnot(is.function(safe_log))
