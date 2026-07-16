model <- lm(mpg ~ wt + hp, data = mtcars)

interaction_model <- lm(mpg ~ wt * cyl, data = mtcars)

no_intercept <- lm(mpg ~ wt - 1, data = mtcars)

one_sided <- ~ log(x) + z

nested <- y ~ poly(x, 2) + I(x^2)
