test_that("IRDA colour scales build without error", {
  p <- ggplot2::ggplot(
    iris, ggplot2::aes(Sepal.Length, Sepal.Width, colour = Species)
  ) +
    ggplot2::geom_point() +
    scale_color_irda()

  built <- ggplot2::ggplot_build(p)
  expect_s3_class(p$scales$scales[[1]], "ScaleDiscrete")
  expect_length(unique(built$data[[1]]$colour), 3L)
})

test_that("scale_fill_irda() uses the fill aesthetic", {
  p <- ggplot2::ggplot(iris, ggplot2::aes(Species, fill = Species)) +
    ggplot2::geom_bar() +
    scale_fill_irda()

  expect_s3_class(p$scales$scales[[1]], "ScaleDiscrete")
  expect_silent(ggplot2::ggplot_build(p))
})

test_that("scale_colour_irda() is an alias of scale_color_irda()", {
  expect_identical(scale_colour_irda, scale_color_irda)
})

test_that("direction reverses the scale colours", {
  fwd <- scale_color_irda(direction = 1)$palette(2)
  rev <- scale_color_irda(direction = -1)$palette(2)
  expect_identical(rev, base::rev(irda_palette())[1:2])
  expect_false(identical(fwd, rev))
})
