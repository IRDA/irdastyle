#' Apply the IRDA Theme to 'ggplot2' Plots
#'
#' A complete [ggplot2::theme()] implementing the IRDA visual identity:
#' Calibri Light typography, bold dark-blue axis text, light horizontal major
#' grid lines, no minor grid, a borderless panel and a bottom legend.
#'
#' @param base_size Base font size, in points, for all text elements.
#' @param base_family Base font family. Defaults to `NULL`, which resolves to
#'   the generic `"sans"` family; on Windows `"sans"` is aliased to
#'   "Calibri Light" (see the *Details* section).
#' @param legend.position Position of the legend. Passed to
#'   [ggplot2::theme()]; use `"none"` to hide the legend.
#' @param ... Additional theme elements passed to [ggplot2::theme()], allowing
#'   any part of the theme to be overridden.
#'
#' @return A `ggplot2` theme object.
#'
#' @details
#' On Windows the "Calibri Light" family is aliased to the generic `"sans"`
#' family (via `grDevices::windowsFonts()`) so that it is used on screen while
#' remaining valid on non-screen devices such as PDF or PostScript. On other
#' platforms `"sans"` resolves to the default sans-serif family, so the theme
#' degrades gracefully without emitting missing-font warnings. Pass an explicit
#' `base_family` to use another font, keeping in mind that the chosen family
#' must be available to the device you render with.
#'
#' @examples
#' library(ggplot2)
#' ggplot(iris, aes(Sepal.Length, Sepal.Width, colour = Species)) +
#'   geom_point() +
#'   theme_irda() +
#'   scale_color_irda()
#'
#' @seealso [scale_color_irda()], [scale_fill_irda()]
#' @export
theme_irda <- function(base_size = 12,
                       base_family = NULL,
                       legend.position = "bottom",
                       ...) {
  base_family <- .irda_font(base_family)

  ggplot2::theme(
    # plotting components

    ## drop minor gridlines
    panel.grid.minor = ggplot2::element_blank(),
    # change grid lines to gray
    panel.grid.major = ggplot2::element_line(color = colors["darkblue"]),
    panel.grid.major.x = ggplot2::element_blank(),
    # fill the plot and panel spaces with grey and remove border
    panel.background = ggplot2::element_rect(fill = NA, color = NA),
    plot.background = ggplot2::element_rect(fill = NA, color = NA),
    panel.border = ggplot2::element_blank(),
    # remove strip background
    strip.background = ggplot2::element_blank(),
    # adjust the margins of plots and remove axis ticks
    plot.margin = ggplot2::margin(0.5, 1, 0.5, 1, unit = "cm"),
    axis.ticks = ggplot2::element_blank(),
    # change text family, size, and adjust position of titles
    text = ggplot2::element_text(family = base_family, size = base_size),
    legend.position = legend.position,
    legend.text.align = 0,
    legend.background = ggplot2::element_blank(),
    legend.title = ggplot2::element_blank(),
    legend.key = ggplot2::element_blank(),
    legend.text = ggplot2::element_text(size = ggplot2::rel(1.4)),
    axis.text = ggplot2::element_text(
      face = "bold", color = colors["black"], size = base_size
    ),
    axis.title = ggplot2::element_text(face = "bold", size = ggplot2::rel(1.2)),
    axis.title.x = ggplot2::element_text(
      margin = ggplot2::margin(0.5, 0, 0, 0, unit = "cm")
    ),
    axis.title.y = ggplot2::element_text(
      margin = ggplot2::margin(0, 0.5, 0, 0, unit = "cm"), angle = 90
    ),
    plot.title = ggplot2::element_text(
      face = "bold", size = ggplot2::rel(1.67), hjust = 0
    ),
    plot.title.position = "plot",
    plot.subtitle = ggplot2::element_text(
      size = ggplot2::rel(1.3333),
      margin = ggplot2::margin(0.2, 0, 1, 0, unit = "cm"),
      hjust = 0
    ),
    plot.caption = ggplot2::element_text(
      color = colors["green"],
      size = ggplot2::rel(0.8),
      margin = ggplot2::margin(1, 0, 0, 0, unit = "cm"),
      hjust = 1
    ),
    strip.text = ggplot2::element_text(size = ggplot2::rel(1.33), face = "bold"),
    ...
  )
}
