#' IRDA Colour Scales for 'ggplot2'
#'
#' Discrete colour scales using the IRDA palettes. `scale_color_irda()` (and
#' its alias `scale_colour_irda()`) target the `colour` aesthetic while
#' `scale_fill_irda()` targets the `fill` aesthetic. Both accept the same
#' arguments.
#'
#' @param palette Name of the palette to use, defaults to `"main"`. See
#'   [irda_palette()].
#' @param direction Direction of the colour sequence: `1` (default) keeps the
#'   palette order, `-1` reverses it.
#' @param ... Additional arguments passed on to
#'   [ggplot2::discrete_scale()], such as `name`, `na.value` or `guide`.
#'
#' @return A `ggplot2` scale object.
#'
#' @examples
#' library(ggplot2)
#' ggplot(iris, aes(Sepal.Length, Sepal.Width, colour = Species)) +
#'   geom_point() +
#'   scale_color_irda()
#'
#' ggplot(iris, aes(Species, fill = Species)) +
#'   geom_bar() +
#'   scale_fill_irda(direction = -1)
#'
#' @seealso [palette_gen()], [theme_irda()]
#' @rdname scale_irda
#' @export
scale_color_irda <- function(palette = "main", direction = 1, ...) {
  ggplot2::discrete_scale(
    "colour",
    palette = palette_gen(palette, direction),
    ...
  )
}

#' @rdname scale_irda
#' @export
scale_colour_irda <- scale_color_irda

#' @rdname scale_irda
#' @export
scale_fill_irda <- function(palette = "main", direction = 1, ...) {
  ggplot2::discrete_scale(
    "fill",
    palette = palette_gen(palette, direction),
    ...
  )
}
