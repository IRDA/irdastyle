# irdastyle 0.2.0

## New features

* Added IRDA report generation: `create_irda_report()` instantiates a bundled
  paginated report template (pagedown/`html_paged`) with the IRDA stylesheet,
  header/footer JavaScript and cover images; `irda_paged()` is the matching
  R Markdown output format and `render_irda_pdf()` exports a report to PDF via
  Chrome. The template ships under `inst/rmarkdown/templates/irda-report`.
* The report template fixes two issues that affected real-world use: cover
  images (logo, cover, bandeau) are now resolved reliably (data-URI fallback
  when the assets are not next to the document), and table-of-contents page
  numbers are correct for headings containing non-ASCII characters (the
  percent-encoded anchors are decoded before pagination).
* `render_irda_pdf()` now defaults to a 300 second timeout (long reports with
  many images) and reports a clear error when Chrome cannot be found.
* Added a "Rapports IRDA" vignette.

## Documentation

* Filled in the `DESCRIPTION` metadata (title, authors, description, license)
  and enabled Markdown in roxygen comments.
* Documented every exported function with `@param`, `@return`, `@details`,
  `@examples` and `@seealso` cross-references.
* Added a package-level help page, a `README` overview and this changelog.
* Added a "Démarrer avec irdastyle" vignette covering colours, palettes,
  `ggplot2` themes/scales and the `gt`, `flextable`, `echarts4r` and `DT`
  helpers (with `VignetteBuilder: knitr`).
* Added a `testthat` (edition 3) test suite covering colours, palettes,
  scales, themes and table helpers.

## Improvements

* Removed the duplicated definitions of `irda_palette()`, `palette_gen()`,
  `scale_color_irda()` and `scale_fill_irda()` that lived in both
  `ggplot_color.R` and their dedicated files (one copy was broken).
* `palette_gen()` now smoothly interpolates with
  `grDevices::colorRampPalette()` when more colours are requested than the
  palette holds, instead of returning `NULL`, and validates its arguments.
* `irda_palette()` validates the palette name and no longer errors on
  unknown input.
* Added the `irda_colors()` and `irda_palettes()` helpers.
* Added the `scale_colour_irda()` alias for British spelling users.
* `theme_irda()` is now platform-safe (font registration only happens on
  Windows) and exposes `base_size`, `base_family` and `legend.position`.
* `datatable_irda()` merges user-supplied `options` on top of the defaults
  instead of erroring when both are provided, and scopes its JavaScript
  styling to the table container.
* `flextable_irda()` no longer mutates the package-wide flextable defaults
  through `set_flextable_defaults()`.
* Table helpers now fail with an informative message when an optional
  dependency is missing.
* Removed stray non-ASCII axis names from the `echarts4r` theme, which is now
  cached as a package constant.

## Dependency changes

* Moved `DT`, `echarts4r`, `flextable`, `gt` and `officer` from `Imports` to
  `Suggests`; each helper now checks for the package it needs.
