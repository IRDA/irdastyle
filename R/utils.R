# Internal helpers --------------------------------------------------------

#' Fail informatively when an optional package is missing
#'
#' @param pkg Name of the required package.
#' @return Invisibly `TRUE` when the package is available.
#' @noRd
.irda_require <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    stop(
      "Package \"", pkg, "\" is required for this function.\n",
      "Install it with install.packages(\"", pkg, "\").",
      call. = FALSE
    )
  }
  invisible(TRUE)
}

#' Resolve the IRDA font family in a platform-safe way
#'
#' On Windows, the "Calibri Light" family is aliased to the generic `"sans"`
#' family so that it is picked up by on-screen devices while remaining a valid
#' family name on every other device (PDF, PostScript, ...). This avoids the
#' "font family not found" / "invalid font type" errors that occur when a
#' device does not know a custom family. On other platforms `"sans"` simply
#' resolves to the default sans-serif family.
#'
#' @param family Requested font family, or `NULL` for the package default.
#' @return A character string naming a usable font family.
#' @noRd
.irda_font <- function(family = NULL) {
  if (is.null(family)) {
    if (.Platform$OS.type == "windows") {
      try(
        grDevices::windowsFonts(sans = grDevices::windowsFont("Calibri Light")),
        silent = TRUE
      )
    }
    return("sans")
  }

  if (!is.character(family) || length(family) != 1L || is.na(family)) {
    stop("`base_family` must be a single character string or NULL.", call. = FALSE)
  }

  family
}
