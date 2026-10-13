test_that("create_irda_report() copies the template", {
  skip_if_not_installed("rmarkdown")
  tmp <- file.path(tempdir(), paste0("irda-report-", as.integer(runif(1, 1, 1e9))))
  on.exit(unlink(tmp, recursive = TRUE), add = TRUE)

  rmd <- create_irda_report(tmp, name = "rapport", edit = FALSE)
  expect_true(file.exists(rmd))
  files <- list.files(file.path(tmp, "rapport"))
  expect_true(all(c(
    "brochure.css", "header_overrides.html",
    "logo.png", "image_couverture.png", "bandeaugauche.png"
  ) %in% files))
})

test_that("create_irda_report() refuses to overwrite by default", {
  skip_if_not_installed("rmarkdown")
  tmp <- file.path(tempdir(), paste0("irda-report-", as.integer(runif(1, 1, 1e9))))
  on.exit(unlink(tmp, recursive = TRUE), add = TRUE)

  create_irda_report(tmp, name = "rapport", edit = FALSE)
  expect_error(
    create_irda_report(tmp, name = "rapport", edit = FALSE),
    "already exists"
  )
  expect_silent(create_irda_report(tmp, name = "rapport", edit = FALSE, overwrite = TRUE))
})

test_that("irda_paged() returns an R Markdown output format", {
  skip_if_not_installed("pagedown")
  skip_if_not_installed("rmarkdown")
  fmt <- irda_paged()
  expect_true(inherits(fmt, "rmarkdown_output_format"))
})

test_that("render_irda_pdf() validates its input", {
  skip_if_not_installed("pagedown")
  expect_error(render_irda_pdf("does-not-exist.Rmd"), "not found")
})
