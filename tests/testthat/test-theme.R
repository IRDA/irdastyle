test_that("theme_irda() returns a ggplot2 theme", {
  th <- theme_irda()
  expect_s3_class(th, "theme")
  expect_s3_class(th, "ggplot2::theme")
})

test_that("theme_irda() accepts a base size and overrides", {
  th <- theme_irda(base_size = 20, legend.position = "none")
  expect_identical(th$legend.position, "none")
  expect_identical(th$text$size, 20)
})

test_that("theme_irda() works on a real plot", {
  p <- ggplot2::ggplot(iris, ggplot2::aes(Sepal.Length, Sepal.Width)) +
    ggplot2::geom_point() +
    theme_irda()
  expect_silent(ggplot2::ggplot_build(p))
})
