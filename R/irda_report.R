# Report template helpers -------------------------------------------------

# Directory holding the bundled IRDA report template skeleton.
.irda_template_dir <- function() {
  system.file("rmarkdown/templates/irda-report/skeleton", package = "irdastyle")
}

# Resolve an asset, preferring a file in the current directory (so users can
# customise it) and falling back to the bundled copy.
.irda_asset <- function(file) {
  if (length(file) == 1L && file.exists(file)) {
    return(normalizePath(file, mustWork = FALSE))
  }
  bundled <- file.path(.irda_template_dir(), file)
  if (file.exists(bundled)) {
    return(bundled)
  }
  file
}

# Data URI for an asset, preferring a local file in the working directory
# and falling back to the bundled copy in the template skeleton. Data URIs are
# used (rather than `file://` URLs) because they are always loadable, including
# from headless Chrome and browser iframes without triggering 404s or local
# file security restrictions.
.irda_asset_data_uri <- function(file) {
  path <- if (length(file) == 1L && file.exists(file)) {
    normalizePath(file, winslash = "/", mustWork = FALSE)
  } else {
    file.path(.irda_template_dir(), file)
  }
  if (!file.exists(path)) {
    return(NA_character_)
  }
  if (!requireNamespace("knitr", quietly = TRUE)) {
    return(NA_character_)
  }
  knitr::image_uri(path)
}

# Build the inline script that tells header_overrides.html where the cover
# images live. Assets are embedded as data URIs so the report is fully
# self-contained and avoids 404 errors during headless Chrome printing.
.irda_assets_script <- function() {
  files <- c(
    logo = "logo.png",
    cover = "image_couverture.png",
    bandeau = "bandeaugauche.png"
  )
  uris <- vapply(files, .irda_asset_data_uri, character(1))
  uris <- uris[!is.na(uris)]
  if (length(uris) == 0L) {
    return(NULL)
  }

  entries <- paste(
    sprintf("%s: %s", base::names(uris), vapply(uris, function(u) {
      sprintf("'%s'", u)
    }, character(1))),
    collapse = ", "
  )
  paste0("<script>window.IRDA_ASSETS = {", entries, "};</script>")
}

#' IRDA Paged Report Output Format
#'
#' An R Markdown output format that produces a paginated HTML report using the
#' IRDA visual identity (via [pagedown::html_paged()]). It bundles the IRDA
#' `brochure.css` stylesheet, the header/footer and footnote JavaScript and the
#' cover images, so a report only needs the template content.
#'
#' Use `irdastyle::irda_paged` in the `output` field of your YAML header, or
#' start from the ready-made template with [create_irda_report()].
#'
#' @param ... Additional arguments passed on to [pagedown::html_paged()].
#' @param css Additional CSS files appended to the bundled IRDA stylesheet.
#' @param includes Additional includes merged with the bundled
#'   `header_overrides.html`.
#' @param toc Logical; include a table of contents (default `TRUE`).
#' @param toc_title Title of the table of contents.
#' @param number_sections Logical; number section headings (default `FALSE`).
#'
#' @return An R Markdown output format definition.
#'
#' @examples
#' \dontrun{
#' if (requireNamespace("pagedown", quietly = TRUE)) {
#'   irda_paged()
#' }
#' }
#'
#' @seealso [create_irda_report()], [render_irda_pdf()]
#' @export
irda_paged <- function(...,
                       css = NULL,
                       includes = NULL,
                       toc = TRUE,
                       toc_title = "Table des mati\u00e8res",
                       number_sections = FALSE) {
  .irda_require("pagedown")
  .irda_require("rmarkdown")

  bundled_css <- c(
    "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css",
    "default-page",
    "default",
    .irda_asset("brochure.css")
  )
  if (!is.null(css)) {
    bundled_css <- c(bundled_css, css)
  }

  in_header <- .irda_asset("header_overrides.html")
  assets_script <- .irda_assets_script()
  if (!is.null(assets_script)) {
    script_file <- tempfile(fileext = ".html")
    writeLines(assets_script, script_file)
    in_header <- c(in_header, script_file)
  }
  if (!is.null(includes) && !is.null(includes$in_header)) {
    in_header <- c(in_header, includes$in_header)
  }

  pagedown::html_paged(
    css = bundled_css,
    includes = rmarkdown::includes(in_header = in_header),
    toc = toc,
    toc_title = toc_title,
    number_sections = number_sections,
    ...
  )
}

#' Create an IRDA Report from the Template
#'
#' Copies the bundled IRDA report template into `path` and optionally opens it.
#' The generated directory contains the `.Rmd` source, the `brochure.css`
#' stylesheet, the `header_overrides.html` script and the cover images, so the
#' report is self-contained.
#'
#' @param path Directory in which to create the report.
#' @param name Name of the report (without extension). A directory of this name
#'   is created inside `path`.
#' @param edit Logical; open the created file for editing (default `TRUE` in an
#'   interactive session).
#' @param overwrite Logical; overwrite the destination directory if it already
#'   exists (default `FALSE`).
#'
#' @return Invisibly, the path to the created `.Rmd` file.
#'
#' @examples
#' \dontrun{
#' create_irda_report(tempdir(), name = "mon_rapport", edit = FALSE)
#' }
#'
#' @seealso [irda_paged()], [render_irda_pdf()]
#' @export
create_irda_report <- function(path = ".",
                               name = "rapport",
                               edit = interactive(),
                               overwrite = FALSE) {
  .irda_require("rmarkdown")

  dest <- file.path(path, name)
  if (dir.exists(dest)) {
    if (!overwrite) {
      stop(
        "Directory already exists: ", dest,
        ".\nUse `overwrite = TRUE` to replace it.",
        call. = FALSE
      )
    }
    unlink(dest, recursive = TRUE)
  }

  if (!dir.exists(path)) {
    dir.create(path, recursive = TRUE, showWarnings = FALSE)
  }

  rmarkdown::draft(
    file = dest,
    template = "irda-report",
    package = "irdastyle",
    edit = edit,
    create_dir = TRUE
  )

  invisible(normalizePath(file.path(dest, paste0(name, ".Rmd")), mustWork = FALSE))
}

#' Render an IRDA Report to PDF
#'
#' Renders an R Markdown report (or a rendered HTML file) to PDF using
#' [pagedown::chrome_print()], which relies on a local installation of Chrome
#' or Chromium.
#'
#' @param input Path to the `.Rmd` or `.html` file to render.
#' @param output Path of the PDF to produce. Defaults to `input` with the
#'   extension replaced by `.pdf`.
#' @param timeout Maximum time, in seconds, to wait for Chrome to print the
#'   document. Long reports with many images can take a while to lay out, so
#'   the default is deliberately generous (300 seconds). Increase it further
#'   if needed.
#' @param ... Additional arguments passed on to [pagedown::chrome_print()].
#'
#' @return Invisibly, the path to the generated PDF.
#'
#' @examples
#' \dontrun{
#' create_irda_report(tempdir(), name = "mon_rapport", edit = FALSE)
#' render_irda_pdf(file.path(tempdir(), "mon_rapport", "mon_rapport.Rmd"))
#' }
#'
#' @seealso [create_irda_report()], [irda_paged()]
#' @export
render_irda_pdf <- function(input, output = NULL, timeout = 300, ...) {
  .irda_require("pagedown")

  if (!file.exists(input)) {
    stop("Input file not found: ", input, call. = FALSE)
  }
  if (is.null(output)) {
    output <- sub("\\.(Rmd|rmd|html)$", ".pdf", input)
  }

  chrome <- tryCatch(pagedown::find_chrome(), error = function(e) NULL)
  if (length(chrome) == 0L || !nzchar(chrome[[1]])) {
    stop(
      "Chrome or Chromium could not be found.\n",
      "Install Google Chrome, or set the CHROME_PATH environment variable, ",
      "then try again.",
      call. = FALSE
    )
  }

  pagedown::chrome_print(input, output = output, timeout = timeout, ...)
  invisible(output)
}
