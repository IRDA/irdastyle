# IRDA visual identity colours -------------------------------------------
#
# Internal named vector holding the reference colours of the IRDA visual
# identity. Package functions index it by name (e.g. `colors["darkblue"]`).
# The values are exposed to users through [irda_colors()].
colors <- c(
  black      = "#324653",
  grey       = "#E7E6E6",
  lightgrey  = "#F2F2F2",
  bluegrey   = "#44546A",
  brown      = "#833C0B",
  darkblue   = "#002752",
  blue       = "#0062A1",
  darkgreen  = "#74A941",
  lightgreen = "#B7CE02",
  green      = "#AED136",
  yellow     = "#D1AC05",
  red        = "#D5785A"
)

#' IRDA Reference Colours
#'
#' Returns the reference colours of the IRDA visual identity as a named
#' character vector of hexadecimal colour codes.
#'
#' @param names Optional character vector of colour names to return. When
#'   `NULL` (the default) every colour is returned.
#'
#' @return A named character vector of hexadecimal colour codes. When `names`
#'   is supplied, only the requested colours are returned.
#'
#' @examples
#' irda_colors()
#' irda_colors(c("darkblue", "green"))
#'
#' @seealso [irda_palette()]
#' @export
irda_colors <- function(names = NULL) {
  if (is.null(names)) {
    return(colors)
  }

  names <- as.character(names)
  unknown <- setdiff(names, base::names(colors))
  if (length(unknown) > 0L) {
    stop(
      "Unknown IRDA colour(s): ",
      paste(unknown, collapse = ", "),
      ".\nAvailable colours: ",
      paste(base::names(colors), collapse = ", "),
      call. = FALSE
    )
  }

  colors[names]
}
