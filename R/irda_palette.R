# Palette registry --------------------------------------------------------
#
# Single source of truth for the palettes shipped with the package. Keeping
# the definitions in one place avoids the drift that previously existed
# between duplicated `irda_palette()` implementations.
.irda_palettes <- function() {
  list(
    main = unname(colors[c(
      "darkblue", "green", "red", "blue", "yellow", "bluegrey", "brown"
    )])
  )
}

#' Retrieve IRDA Colour Palettes
#'
#' Returns an ordered vector of IRDA colours. The `"main"` palette is the
#' default qualitative palette used across the package and is ordered so that
#' the most visually distinct colours come first.
#'
#' @param palette Name of the palette to retrieve. Currently only `"main"`
#'   is available. Use [irda_palettes()] to list the available palettes.
#'
#' @return A character vector of hexadecimal colour codes.
#'
#' @examples
#' irda_palette()
#' irda_palette("main")
#'
#' @seealso [irda_colors()], [scale_color_irda()], [scale_fill_irda()]
#' @export
irda_palette <- function(palette = "main") {
  palettes <- .irda_palettes()

  if (!is.character(palette) || length(palette) != 1L || is.na(palette)) {
    stop("`palette` must be a single character string.", call. = FALSE)
  }

  if (!palette %in% base::names(palettes)) {
    stop(
      "Unknown palette: \"", palette, "\".\nAvailable palettes: ",
      paste(base::names(palettes), collapse = ", "), ".",
      call. = FALSE
    )
  }

  palettes[[palette]]
}

#' List Available IRDA Palettes
#'
#' Returns the names of the palettes shipped with the package.
#'
#' @return A character vector of palette names.
#'
#' @examples
#' irda_palettes()
#'
#' @seealso [irda_palette()]
#' @export
irda_palettes <- function() {
  base::names(.irda_palettes())
}
