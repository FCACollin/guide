library(grid)
library(assertthat)

xaxisGrob
linesGrob

cell_name <- function(row, col) {
  paste(row, col, sep = "//")
}

#' Forest Plot: Viewport
fp_vp <- function (x, ...) {
  UseMethod("fp_vp", x)
}

fp_vp.row <- function(x, y, nm, ...) {
  vpTree(
    parent = viewport(
      name = nm,
      x = 0,
      y = unit(1, "npc") - unit(y, "lines"),
      height = unit(attr(x, "height"), "lines"),
      just = c("left", "bottom")
      ),
    children = do.call(
      vpList,
      Map(
        x,
        nm = names(x),
        x_pos = (1 + 1:length(x))/ (length(x) + 1),
        f = fp_vp
      )
    )
  )
}

fp_vp.col <- function(x, nm, x_pos, ...) {
  vpTree(
    parent = viewport(
      name = nm,
      width = unit(attr(x, "width"), "npc"),
      x = x_pos,
      just = "right"
      ),
    children = do.call(
      vpList,
      Map(
        x,
        nm = names(x),
        y_pos = 1:length(x) -1,
        f = fp_vp
      )
    )
  )
}

fp_vp.default <- function(x, nm, y_pos, ...) {
  viewport(
    name = nm,
    y = unit(y_pos, "lines"),
    height = unit(1, "lines"),
    just = "bottom"
  )
}

fp_vp.grob <- function(x, nm, y_pos, ...) {
  viewport(
    name = nm,
    y = unit(y_pos, "lines"),
    height = unit(1, "lines"),
    just = "bottom",
    xscale = attr(x, "range")
  )
}

#' Forest Plot: Grob
fp_grob <- function (x, ...) {
  UseMethod("fp_grob", x)
}


fp_grob.row <- function(x, nm, ...) {
  gTree(
    vp = nm,
    children = do.call(
      gList,
      Map(x = x, nm = names(x), f = fp_grob)
    )
  )
}

fp_grob.col <- function(x, nm, ...) {
  gTree(
    vp = nm,
    children = do.call(
      gList,
      Map(x = x, nm = names(x), f = fp_grob)
    )
  )
}

fp_grob.default <- function(x, nm, ...) {
  gTree(
    vp = nm,
    children = gList(
      #       rectGrob(),
      textGrob(x)
    )
  )
}

fp_grob.grob <- function(x, nm, ...) {
  gTree(
    vp = nm,
    children = gList(
      x
    )
  )
}




iris$Species_2 <- sample(iris$Species)
range_fp <- function(x, yval) {
  # paste(range(x), collapse = " - ")
  y <- gTree(
    children = gList(
      linesGrob(x = unit(range(x), "native"), y = .5 ),
      circleGrob(x = unit(mean(x), "native"), y = .5),
      pointsGrob(x = unit(mean(x), "native"), y = .5, pch = 3)
    )
  )
  attr(y, "range") <- range(yval)
  y
}
mean_sd <- function(x, ...) paste0(mean(x), " (", signif(sd(x), 2), ")")
max_fp <- function(x, ...) max(x)
min_fp <- function(x, ...) min(x)


forestplot <- function(
  data = iris,
  group = c("Species", "Species_2"),
  response = "Sepal.Width",
  stat = c("range_fp", "max_fp", "min_fp", "mean_sd")[c(1, 4)]) {

  group <- setNames(nm = group)
  assert_that(is.string(response))

  context <- lapply(
    X = group,
    data = data,
    nstat = length(stat),
    FUN = function(grp, data, nstat) {
      y <- list(
        rowname = as.list(setNames(nm = levels(data[[grp]])))
      )
      y <- lapply(
        y,
        function(y) {
          attr(y, "width") <- 1 / (nstat + 1)
          class(y)  <- "col"
          y
        }
      )
      attr(y, "height") <- max(sapply(y, length) + 1)
      class(y) <- "row"
      y
    }
  )
  val <- lapply(
    X = group,
    data = data,
    stat = setNames(nm = stat),
    response = response,
    FUN = function(group, data, stat, response) {
      y <- lapply(
        X = stat,
        data = data,
        response = response,
        group = group,
        nstat = length(stat),
        yval = data[[response]],
        FUN = function(stat, data, response, group, nstat, yval) {
          y <- tapply(
            data[[response]],
            data[[group]],
            function(val) {
              y <- eval(call(stat, val, yval))
              y
            },
            simplify = FALSE
          )
          attr(y, "width") <- 1 / (nstat + 1)

          class(y) <- "col"
          y
        }
      )

      attr(y, "height") <- max(sapply(y, length) + 1)
      class(y) <- "row"
      y
    }
  )

  grp_lvl <- lapply(
    X = setNames(nm = group),
    data = data,
    FUN = function(x, data) levels(data[[x]])
  )

  grp_vspace <- lapply(grp_lvl, length)
  grp_vspace <- unlist(grp_vspace) + 1
  grp_vspace <- cumsum(grp_vspace) - grp_vspace[1]

  print(str(context))
  #   print(str(val))
  vp_tree <- grid::vpTree(
    parent = grid::viewport(name = "page", width = 0.95, height = 0.95),
    children = vpList(
      vpTree(
        parent = viewport(
          name = "header",
          x = .5, y = 1, just = c("center", "top"),
          width = unit(1, "npc"), height = unit(1, "line")
          ),
        children = do.call(
          vpList,
          Map(
            stat = stat,
            x = (1:length(stat)) / (1 + length(stat)),
            width = 1 / (length(stat)  + 1),
            f = function(stat, x, width) {
              viewport(
                name = stat,
                x = x,
                width = width,
                just = "left"
              )
            }
          )
        )
        ),
      vpTree(
        parent = viewport(
          name = "body",
          x = 0, y = 0,
          just = c("left", "bottom"),
          height = unit(1, "npc") - unit(1, "line")
          ),
        children = do.call(
          vpList,
          Map(
            x = val,
            nm = names(val),
            y = cumsum(sapply(val, attr, which = "height")),
            f = fp_vp
        )
        )
      )
    )
  )



  gg <- gTree(
    childrenvp = vp_tree,
    children =  gList(
      rectGrob(vp = "page"),
      rectGrob(vp = "page::header"),
      gTree(
        vp = "page::header",
        children = do.call(
          gList,
          Map(
            stat,
            f = function(stat) {
              gTree(
                vp = stat,
                children = gList(
                  rectGrob(),
                  textGrob(stat)
                )
              )
            }
          )
        )
        ),
      rectGrob(vp = "page::body"),
      gTree(
        vp = "page::body",
        children = do.call(
          gList,
          Map(
            x = val,
            nm = names(val),
            fp_grob
          )
        )
      )
    )
  )
  #       gTree(
  #         vp = "page::body"
  #   gg <- gTree(
  #     childrenvp = vp_tree,
  #     children = gList(
  #       rectGrob(vp = "page"),
  #       rectGrob(vp = "page::header"),
  #       rectGrob(vp = "page::body"),
  #       gTree(
  #         vp = "page::body",
  #         children = do.call(
  #           gList,
  #           Map(
  #             val = val,
  #             nm = names(val),
  #             f = function(val, nm) {
  #               gTree(
  #                 vp = nm,
  #                 children = do.call(
  #                   gList,
  #                   Map(
  #                     val = val,
  #                     nm = names(val),
  #                     f = function(val, nm) {
  #                       gTree(
  #                         children = gList(
  #                           rectGrob(vp = nm),
  #                           textGrob(
  #                             paste(val, collapse = "\n"),
  #                             vp = nm,
  #                             y = 0, just = "bottom"
  #                           )
  #                         )
  #                       )
  #                     }
  #                   )
  #                 )
  #               )
  #             }
  #           )
  #         )
  #       )
  #     )
  #   )


  grid.ls(vp_tree, view=TRUE, print=pathListing)
  grid.draw(gg)
}

grid::grid.newpage()
forestplot()



