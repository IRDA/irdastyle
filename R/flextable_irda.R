#' Apply the IRDA Theme to 'flextable' Objects
#'
#' Styles a `flextable::flextable()` object with the IRDA visual identity: Calibri
#' Light typography, a dark-blue header with white bold text, light-grey zebra
#' striping, French number formatting and thin dark inner borders.
#'
#' Unlike earlier versions, this function no longer modifies the package-wide
#' flextable defaults with `flextable::set_flextable_defaults()`; every change
#' is applied locally to `x`, so it has no global side effect.
#'
#' @param x A `flextable` object, typically created with
#'   `flextable::flextable()`.
#' @param font Font family used for the table. Defaults to `"Calibri Light"`.
#' @param digits Number of decimal places for double columns.
#' @param big.mark Thousands separator used when formatting doubles.
#' @param decimal.mark Decimal separator used when formatting doubles.
#' @param ... Reserved for future use.
#'
#' @return The themed `flextable` object.
#'
#' @examples
#' if (requireNamespace("flextable", quietly = TRUE)) {
#'   flextable::flextable(head(iris)) |>
#'     flextable_irda()
#' }
#'
#' @seealso [theme_gt_irda()], [datatable_irda()]
#' @export
flextable_irda <- function(x,
                           font = "Calibri Light",
                           digits = 1,
                           big.mark = " ",
                           decimal.mark = ",",
                           ...) {
  .irda_require("flextable")
  .irda_require("officer")

  if (!inherits(x, "flextable")) {
    stop(
      "`x` must be a `flextable` object, e.g. created with flextable::flextable().",
      call. = FALSE
    )
  }

  x <- flextable::theme_zebra(x, odd_body = unname(colors["lightgrey"]))
  x <- flextable::colformat_double(
    x, big.mark = big.mark, decimal.mark = decimal.mark, digits = digits
  )
  x <- flextable::set_table_properties(x, layout = "fixed")
  x <- flextable::border_remove(x)
  x <- flextable::bg(x, bg = unname(colors["darkblue"]), part = "head")
  x <- flextable::bold(x, part = "all")
  x <- flextable::color(x, color = unname(colors["darkblue"]))
  x <- flextable::color(x, color = "white", part = "head")

  std_border <- officer::fp_border(width = 1, color = unname(colors["black"]))
  x <- flextable::border_inner_h(x, border = std_border, part = "all")
  x <- flextable::border_inner_v(x, border = std_border, part = "all")
  x <- flextable::hline_bottom(x, border = std_border)
  x <- flextable::hline_top(x, border = std_border)

  x <- flextable::font(x, fontname = font, part = "all")
  flextable::autofit(x)
}
