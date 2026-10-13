#' irdastyle: IRDA Visual Identity Themes
#'
#' The `irdastyle` package provides a consistent set of colours, palettes and
#' themes that apply the visual identity of the IRDA to common R outputs:
#' `ggplot2` plots, `gt` and `flextable` tables, `echarts4r` charts and `DT`
#' data tables.
#'
#' @section Core helpers:
#' * [irda_colors()] and [irda_palette()] expose the shared colour palette.
#' * [palette_gen()] builds palette functions used by the scales.
#'
#' @section Themes and scales:
#' * [theme_irda()], [scale_color_irda()] and [scale_fill_irda()] for
#'   `ggplot2`.
#' * [theme_gt_irda()] for `gt`, [flextable_irda()] for `flextable`,
#'   [e_theme_irda()] for `echarts4r` and [datatable_irda()] for `DT`.
#'
#' @section Reports:
#' * [create_irda_report()] instantiates the bundled paginated report
#'   template, [irda_paged()] is the matching R Markdown output format and
#'   [render_irda_pdf()] exports a report to PDF.
#'
#' @keywords internal
"_PACKAGE"
