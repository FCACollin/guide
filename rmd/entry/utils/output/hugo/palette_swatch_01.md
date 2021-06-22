---
author: 'FCA Collin, Ph.D.'
date: 'Wednesday, June 16, 2021'
title: Palette Swatch
weight: '-210311'
---

*2021-03-19, FCA Collin*

------------------------------------------------------------------------

<!--more-->
Definition `R/`
---------------

``` r
#' Palette Swatch
#'
#' Represent a color palette.
#'
#' @param ... (`atomic`)\cr valid color(s) (according to grid)
#' @param draw (`logical`)
#' @export
#' @examples
#'
#' palette_swatch("gray", "red", "gray", NA, "blue")
#'
palette_swatch <- function(..., draw = TRUE) {

  colors <- list(...)
  lapply(colors, function(x) assertthat::assert_that(is.atomic(x)))

  colors <- unlist(colors)
  nm <- paste(colors, seq_along(colors), sep = "_")
  vp <- grid::vpTree(
    parent = grid::viewport(name = "page", width = 0.95, height = 0.95),
    children = do.call(
      grid::vpList,
      Map(
        nm = nm,
        x = seq_along(colors) / (length(colors)),
        width = 1 / length(colors),
        f = function(nm, x, width) {
          grid::viewport(
            name = nm,
            x = x,
            width = width,
            just = "right"
          )
        }
      )
    )
  )

  gr <- do.call(
    grid::gList,
    Map(
      colors,
      nm,
      f = function(colors, nm) {
        grid::gTree(
          vp = nm,
          children = grid::gList(
            grid::rectGrob(gp = grid::gpar(fill = colors, col = colors))
          )
        )
      }
    )
  )

  gr <- grid::gTree(
    childrenvp = vp,
    children = grid::gList(
      grid::gTree(
        vp = "page",
        children = gr
      )
    )
  )

  if (draw) {
    grid::grid.newpage()
    grid::grid.draw(gr)
  } else {
    invisible()
  }
}
```

``` r
sessionInfo()
```

    ## R version 4.0.4 (2021-02-15)
    ## Platform: x86_64-pc-linux-gnu (64-bit)
    ## Running under: Debian GNU/Linux 10 (buster)
    ## 
    ## Matrix products: default
    ## BLAS:   /usr/lib/x86_64-linux-gnu/openblas/libblas.so.3
    ## LAPACK: /usr/lib/x86_64-linux-gnu/libopenblasp-r0.3.5.so
    ## 
    ## locale:
    ##  [1] LC_CTYPE=en_GB.UTF-8       LC_NUMERIC=C              
    ##  [3] LC_TIME=en_GB.UTF-8        LC_COLLATE=en_GB.UTF-8    
    ##  [5] LC_MONETARY=en_GB.UTF-8    LC_MESSAGES=en_GB.UTF-8   
    ##  [7] LC_PAPER=en_GB.UTF-8       LC_NAME=C                 
    ##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
    ## [11] LC_MEASUREMENT=en_GB.UTF-8 LC_IDENTIFICATION=C       
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] compiler_4.0.4    magrittr_2.0.1    tools_4.0.4       htmltools_0.5.1.1
    ##  [5] yaml_2.2.1        stringi_1.5.3     rmarkdown_2.6     knitr_1.33       
    ##  [9] stringr_1.4.0     xfun_0.22         digest_0.6.27     rlang_0.4.11     
    ## [13] evaluate_0.14
