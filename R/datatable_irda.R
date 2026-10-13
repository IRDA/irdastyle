# French interface strings for DataTables ---------------------------------
.irda_dt_language <- function() {
  list(
    sProcessing = "Traitement en cours...", sSearch = "Rechercher&nbsp;:",
    sLengthMenu = "Afficher _MENU_ &eacute;l&eacute;ments",
    sInfo = "Affichage de l'&eacute;l&eacute;ment _START_ &agrave; _END_ sur _TOTAL_ &eacute;l&eacute;ments",
    sInfoEmpty = "Affichage de l'&eacute;l&eacute;ment 0 &agrave; 0 sur 0 &eacute;l&eacute;ment",
    sInfoFiltered = "(filtr&eacute; de _MAX_ &eacute;l&eacute;ments au total)",
    sInfoPostFix = "", sLoadingRecords = "Chargement en cours...",
    sZeroRecords = "Aucun &eacute;l&eacute;ment &agrave; afficher",
    sEmptyTable = "Aucune donn&eacute;e disponible dans le tableau",
    oPaginate = list(
      sFirst = "Premier", sPrevious = "Pr&eacute;c&eacute;dent",
      sNext = "Suivant", sLast = "Dernier"
    ),
    oAria = list(
      sSortAscending = ": activer pour trier la colonne par ordre croissant",
      sSortDescending = ": activer pour trier la colonne par ordre d&eacute;croissant"
    )
  )
}

#' Apply the IRDA Theme to 'DT' Data Tables
#'
#' Creates a [DT::datatable()] styled with the IRDA visual identity and a
#' French interface. The header gets a dark-blue background with white bold
#' text and the body uses Calibri Light in dark blue.
#'
#' @param x A data frame (or matrix) to display.
#' @param options A list of DataTables options that are merged on top of the
#'   IRDA defaults. Use this to override any of the default options (for
#'   example `pageLength` or `dom`) without losing the theme.
#' @param ... Additional arguments passed on to [DT::datatable()], such as
#'   `class`, `rownames` or `filter`.
#'
#' @return A `datatable` HTML widget.
#'
#' @examples
#' if (requireNamespace("DT", quietly = TRUE)) {
#'   datatable_irda(head(iris))
#'   # override a default option while keeping the theme
#'   datatable_irda(head(iris), options = list(pageLength = 5))
#' }
#'
#' @seealso [theme_gt_irda()], [flextable_irda()]
#' @export
datatable_irda <- function(x, options = list(), ...) {
  .irda_require("DT")

  if (!is.list(options)) {
    stop("`options` must be a list of DataTables options.", call. = FALSE)
  }

  default_options <- list(
    language = .irda_dt_language(),
    initComplete = DT::JS(
      "function(settings, json) {",
      paste0(
        "$(this.api().table().container()).css({'font-family': 'Calibri'});"
      ),
      paste0(
        "$(this.api().table().header()).css({'background-color': '",
        unname(colors["darkblue"]),
        "', 'color': '#fff', 'font-family': 'Calibri', 'font-weight': 'bold'});"
      ),
      paste0(
        "$(this.api().table().body()).css({'color': '",
        unname(colors["darkblue"]),
        "', 'font-family': 'Calibri Light', 'font-weight': 'bold'});"
      ),
      "}"
    )
  )

  opts <- utils::modifyList(default_options, options)
  DT::datatable(x, ..., options = opts)
}
