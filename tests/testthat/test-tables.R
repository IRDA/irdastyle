test_that("theme_gt_irda() themes a gt table", {
  skip_if_not_installed("gt")
  x <- theme_gt_irda(gt::gt(head(iris)))
  expect_s3_class(x, "gt_tbl")
})

test_that("theme_gt_irda() rejects non-gt input", {
  skip_if_not_installed("gt")
  expect_error(theme_gt_irda(data.frame(x = 1)), "gt_tbl")
})

test_that("datatable_irda() returns a datatable and merges options", {
  skip_if_not_installed("DT")
  dt <- datatable_irda(head(iris), options = list(pageLength = 5))
  expect_s3_class(dt, "datatables")
  expect_identical(dt$x$options$pageLength, 5)
  expect_false(is.null(dt$x$options$language))
})

test_that("datatable_irda() validates options", {
  skip_if_not_installed("DT")
  expect_error(datatable_irda(head(iris), options = 1), "list")
})

test_that("e_theme_irda() applies the cached theme", {
  skip_if_not_installed("echarts4r")
  e <- e_theme_irda(echarts4r::e_charts(iris, Sepal.Length))
  expect_s3_class(e, "echarts4r")
})

test_that("flextable_irda() themes a flextable", {
  skip_if_not_installed("flextable")
  ft <- flextable_irda(flextable::flextable(head(iris)))
  expect_s3_class(ft, "flextable")
})
