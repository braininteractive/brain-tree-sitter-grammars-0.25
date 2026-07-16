stats::median(c(1, 2, 3))

utils::head(mtcars, 3)

internal <- stats:::C_rnorm

tidy <- dplyr::filter(mtcars, cyl == 4)

pkg_fun <- getExportedValue("base", "sum")
