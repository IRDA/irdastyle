test_that("irda_palette() returns the main palette", {
  pal <- irda_palette()
  expect_type(pal, "character")
  expect_length(pal, 7L)
  expect_false(any(is.na(pal)))
  expect_true(all(grepl("^#[0-9A-Fa-f]{6}$", pal)))
  expect_identical(pal, irda_palette("main"))
})

test_that("irda_palette() validates its input", {
  expect_error(irda_palette("nope"), "Unknown palette")
  expect_error(irda_palette(1), "single character")
  expect_error(irda_palette(NA_character_), "single character")
})

test_that("irda_palettes() lists available palettes", {
  expect_identical(irda_palettes(), "main")
})

test_that("palette_gen() returns the requested number of colours", {
  pal <- palette_gen()
  expect_length(pal(1), 1L)
  expect_length(pal(7), 7L)
  expect_identical(pal(3), irda_palette()[1:3])
})

test_that("palette_gen() interpolates when too many colours are requested", {
  pal <- palette_gen()
  out <- pal(12)
  expect_length(out, 12L)
  expect_true(all(grepl("^#[0-9A-Fa-f]{6}$", out)))
})

test_that("palette_gen() honours direction", {
  expect_identical(
    palette_gen(direction = -1)(3),
    rev(irda_palette())[1:3]
  )
})

test_that("palette_gen() validates its arguments", {
  expect_error(palette_gen(direction = NA), "direction")
  expect_error(palette_gen()(0), "positive")
  expect_error(palette_gen()(NA), "positive")
})
