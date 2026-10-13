#' Apply the IRDA Theme to 'gt' Tables
#'
#' Styles a [gt::gt()] table with the IRDA visual identity: Calibri Light
#' typography, a dark-blue header, zebra striping in light grey and a green
#' row-group background.
#'
#' @param x A `gt_tbl` object, typically created with [gt::gt()].
#' @param font Font family used for the table. Defaults to `"Calibri Light"`.
#' @param ... Additional arguments passed to [gt::tab_options()], allowing any
#'   of the default options to be overridden.
#'
#' @return The themed `gt_tbl` object.
#'
#' @examples
#' if (requireNamespace("gt", quietly = TRUE)) {
#'   gt::gt(head(iris)) |>
#'     theme_gt_irda()
#' }
#'
#' @seealso [theme_irda()], [flextable_irda()]
#' @export
theme_gt_irda <- function(x, font = "Calibri Light", ...) {
  .irda_require("gt")

  if (!inherits(x, "gt_tbl")) {
    stop("`x` must be a `gt_tbl` object, e.g. created with gt::gt().", call. = FALSE)
  }

  x |>
    gt::opt_table_font(font = font) |>
    gt::opt_row_striping() |>
    gt::tab_options(
      column_labels.background.color = colors["darkblue"],
      column_labels.font.weight = "bold",
      row_group.font.weight = "bold",
      row.striping.background_color = colors["lightgrey"],
      row_group.background.color = colors["green"],
      column_labels.font.size = 16,
      row_group.font.size = 22,
      table.font.names = font,
      table.font.weight = "bold",
      ...
    )
}
