# irdastyle

<!-- badges: start -->
<!-- badges: end -->

`irdastyle` applique l'identité visuelle de l'IRDA à vos sorties R :
graphiques `ggplot2`, tableaux `gt` et `flextable`, graphiques `echarts4r`
et tables interactives `DT`. Tous les thèmes partagent une même palette de
couleurs, exposée par `irda_colors()` et `irda_palette()`.

## Installation

```r
# Depuis GitHub
devtools::install_github("IRDA/irdastyle")
```

## Couleurs et palettes

```r
library(irdastyle)

irda_colors()                       # tous les noms de couleurs
irda_colors(c("darkblue", "green")) # une sélection
irda_palette()                      # palette qualitative "main"
irda_palettes()                     # palettes disponibles
palette_gen()(10)                   # interpolation si > 7 couleurs
```

## ggplot2

```r
library(ggplot2)
ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point() +
  theme_irda() +
  scale_color_irda()
```

<img src="man/figures/README-ggplot2-1.png" width="100%" />

`scale_fill_irda()` est également disponible (et `scale_colour_irda()` est
un alias de `scale_color_irda()` pour l'orthographe britannique). Les deux
échelles acceptent `direction = -1` pour inverser l'ordre des couleurs.

## echarts4r

```r
library(echarts4r)
iris |>
  dplyr::group_by(Species) |>
  e_charts(Sepal.Length) |>
  e_scatter(Sepal.Width) |>
  e_theme_irda()
```

![](./man/figures/README-echarts4r-1.png)

## gt

```r
library(gt)
gt(iris |> head()) |>
  theme_gt_irda()
```

![](./man/figures/README-gt-1.png)

## flextable

```r
library(flextable)
flextable(iris |> head()) |>
  flextable_irda()
```

<img src="man/figures/README-flextable-1.png" width="100%" />

## DT

```r
datatable_irda(iris |> head())

# Personnaliser tout en gardant le thème
datatable_irda(iris |> head(), options = list(pageLength = 5))
```

![](./man/figures/README-DT-1.png)

## Rapports paginés

`irdastyle` fournit un gabarit de rapport complet (page de couverture,
en-têtes/pieds de page, table des matières, encadrés, sauts de section) basé
sur `pagedown`. Créez un nouveau rapport en une commande :

```r
# Copie le gabarit (Rmd + CSS + JS + images) dans mon_rapport/
create_irda_report(path = ".", name = "mon_rapport")

# Rend le HTML, puis exporte le PDF via Chrome
rmarkdown::render("mon_rapport/mon_rapport.Rmd")
render_irda_pdf("mon_rapport/mon_rapport.Rmd")
```

Le YAML du rapport pilote les en-têtes/pieds de page et la position du numéro
de page, et `output: irdastyle::irda_paged` applique automatiquement le thème.
Voir la vignette « Rapports IRDA » pour la liste des composants.

## Notes

- Les thèmes de tableaux dépendent de paquets optionnels (`gt`, `flextable`,
  `DT`, `echarts4r`) : installez uniquement ceux que vous utilisez. Un
  message d'erreur explicite est renvoyé si le paquet requis est absent.
- `theme_irda()` utilise la police Calibri Light sur Windows et bascule
  proprement vers une police sans-serif sur les autres plateformes.
