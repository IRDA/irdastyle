# Cached IRDA theme for 'echarts4r' ---------------------------------------
#
# Stored as a package-level constant so the (fairly large) JSON payload is
# parsed only once at build time rather than being rebuilt on every call to
# `e_theme_irda()`.
irda_echarts_theme <- '{
        "seriesCnt": "7",
        "backgroundColor": "rgba(0, 0, 0, 0)",
        "titleColor": "#002752",
        "subtitleColor": "#002752",
        "textColorShow": false,
        "textColor": "#333",
        "markTextColor": "#f2f2f2",
        "color": [
            "#002752",
            "#aed136",
            "#d5785a",
            "#0062a1",
            "#d1ac05",
            "#44546a",
            "#833c0b"
        ],
        "borderColor": "#002752",
        "borderWidth": "1",
        "visualMapColor": [
            "#aed136",
            "#0062a1",
            "#002752"
        ],
        "legendTextColor": "#002752",
        "kColor": "#d5785a",
        "kColor0": "#aed136",
        "kBorderColor": "#d1ac05",
        "kBorderColor0": "#b7ce02",
        "kBorderWidth": 1,
        "lineWidth": 2,
        "symbolSize": "6",
        "symbol": "emptyCircle",
        "symbolBorderWidth": 1,
        "lineSmooth": false,
        "graphLineWidth": 1,
        "graphLineColor": "#e7e6e6",
        "mapLabelColor": "#000",
        "mapLabelColorE": "rgb(100,0,0)",
        "mapBorderColor": "#444",
        "mapBorderColorE": "#444",
        "mapBorderWidth": 0.5,
        "mapBorderWidthE": 1,
        "mapAreaColor": "#eee",
        "mapAreaColorE": "rgba(255,215,0,0.8)",
        "axes": [
            {
                "type": "all",
                "axisLineShow": true,
                "axisLineColor": "#6E7079",
                "axisTickShow": true,
                "axisTickColor": "#6E7079",
                "axisLabelShow": true,
                "axisLabelColor": "#6E7079",
                "splitLineShow": true,
                "splitLineColor": [
                    "#E0E6F1"
                ],
                "splitAreaShow": false,
                "splitAreaColor": [
                    "rgba(250,250,250,0.2)",
                    "rgba(210,219,238,0.2)"
                ]
            },
            {
                "type": "category",
                "axisLineShow": true,
                "axisLineColor": "#002752",
                "axisTickShow": true,
                "axisTickColor": "#002752",
                "axisLabelShow": true,
                "axisLabelColor": "#002752",
                "splitLineShow": false,
                "splitLineColor": [
                    "#002752"
                ],
                "splitAreaShow": false,
                "splitAreaColor": [
                    "rgba(250,250,250,0.2)",
                    "rgba(210,219,238,0.2)"
                ]
            },
            {
                "type": "value",
                "axisLineShow": false,
                "axisLineColor": "#6E7079",
                "axisTickShow": false,
                "axisTickColor": "#6E7079",
                "axisLabelShow": true,
                "axisLabelColor": "#002752",
                "splitLineShow": true,
                "splitLineColor": [
                    "#e7e6e6"
                ],
                "splitAreaShow": false,
                "splitAreaColor": [
                    "rgba(250,250,250,0.2)",
                    "rgba(210,219,238,0.2)"
                ]
            },
            {
                "type": "log",
                "axisLineShow": false,
                "axisLineColor": "#6E7079",
                "axisTickShow": false,
                "axisTickColor": "#6E7079",
                "axisLabelShow": true,
                "axisLabelColor": "#002752",
                "splitLineShow": true,
                "splitLineColor": [
                    "#e7e6e6"
                ],
                "splitAreaShow": false,
                "splitAreaColor": [
                    "rgba(250,250,250,0.2)",
                    "rgba(210,219,238,0.2)"
                ]
            },
            {
                "type": "time",
                "axisLineShow": true,
                "axisLineColor": "#e7e6e6",
                "axisTickShow": true,
                "axisTickColor": "#002752",
                "axisLabelShow": true,
                "axisLabelColor": "#002752",
                "splitLineShow": false,
                "splitLineColor": [
                    "#E0E6F1"
                ],
                "splitAreaShow": false,
                "splitAreaColor": [
                    "rgba(250,250,250,0.2)",
                    "rgba(210,219,238,0.2)"
                ]
            }
        ],
        "axisSeperateSetting": true,
        "toolboxColor": "#324653",
        "toolboxEmphasisColor": "#0062a1",
        "tooltipAxisColor": "#aed136",
        "tooltipAxisWidth": "2",
        "timelineLineColor": "#002752",
        "timelineLineWidth": 2,
        "timelineItemColor": "#0062a1",
        "timelineItemColorE": "#aed136",
        "timelineCheckColor": "#aed136",
        "timelineCheckBorderColor": "#f2f2f2",
        "timelineItemBorderWidth": 1,
        "timelineControlColor": "#0062a1",
        "timelineControlBorderColor": "#0062a1",
        "timelineControlBorderWidth": 1,
        "timelineLabelColor": "#002752"
    }
'

#' Apply the IRDA Theme to 'echarts4r' Charts
#'
#' Applies a custom [echarts4r::e_theme_custom()] theme built from the IRDA
#' colour palette. The theme is stored as a package constant, so repeated
#' calls do not rebuild the underlying JSON payload.
#'
#' @param x An `echarts4r` chart object.
#' @param ... Additional arguments passed on to
#'   [echarts4r::e_theme_custom()].
#'
#' @return The `echarts4r` chart object with the IRDA theme applied.
#'
#' @examples
#' if (requireNamespace("echarts4r", quietly = TRUE)) {
#'   iris |>
#'     echarts4r::e_charts(Sepal.Length) |>
#'     echarts4r::e_scatter(Sepal.Width) |>
#'     e_theme_irda()
#' }
#'
#' @seealso [theme_irda()], [irda_palette()]
#' @export
e_theme_irda <- function(x, ...) {
  .irda_require("echarts4r")
  echarts4r::e_theme_custom(x, irda_echarts_theme, ...)
}
