#' Generate an IRDA Palette Function
#'
#' Builds the palette function expected by the `palette` argument of
#' [ggplot2::discrete_scale()]. The returned function takes a single integer
#' `n` and returns `n` colours. When more colours are requested than the
#' palette holds, the palette is smoothly interpolated with
#' [grDevices::colorRampPalette()] instead of failing, so scales stay usable
#' with many groups.
#'
#' @param palette Name of the palette to use, defaults to `"main"`.
#' @param direction Direction of the colour sequence: `1` (default) keeps the
#'   palette order, `-1` reverses it.
#'
#' @return A function of one argument (`n`) returning a character vector of
#'   hexadecimal colour codes.
#'
#' @examples
#' pal <- palette_gen()
#' pal(3)
#' pal(10) # interpolated because the palette holds fewer than 10 colours
#'
#' palette_gen(direction = -1)(3)
#'
#' @seealso [irda_palette()], [scale_color_irda()], [scale_fill_irda()]
#' @export
palette_gen <- function(palette = "main", direction = 1) {
  if (!is.numeric(direction) || length(direction) != 1L || is.na(direction)) {
    stop("`direction` must be a single non-missing number.", call. = FALSE)
  }

  cols <- irda_palette(palette)
  if (direction < 0) {
    cols <- rev(cols)
  }
  n_palette <- length(cols)

  function(n) {
    if (!is.numeric(n) || length(n) != 1L || is.na(n) || n < 1) {
      stop("`n` must be a single positive number.", call. = FALSE)
    }
    n <- as.integer(n)

    if (n <= n_palette) {
      cols[seq_len(n)]
    } else {
      grDevices::colorRampPalette(cols)(n)
    }
  }
}
