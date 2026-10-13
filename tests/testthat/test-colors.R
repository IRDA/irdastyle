test_that("irda_colors() returns the full named palette", {
  cols <- irda_colors()
  expect_type(cols, "character")
  expect_length(cols, 12L)
  expect_named(cols)
  expect_true(all(grepl("^#[0-9A-Fa-f]{6}$", cols)))
})

test_that("irda_colors() subsets by name", {
  expect_equal(unname(irda_colors("darkblue")), "#002752")
  expect_named(irda_colors(c("darkblue", "green")), c("darkblue", "green"))
})

test_that("irda_colors() rejects unknown names", {
  expect_error(irda_colors("chartreuse"), "Unknown IRDA colour")
})
