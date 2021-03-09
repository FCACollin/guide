library(grid)
library(assertthat)


cell_name <- function(row, col) {
  paste(row, col, sep = "//")
}

iris$Species_2 <- iris$Species
range_fp <- function(x) paste(range(x), collapse = " - ")

forestplot <- function(
  data = iris,
  group = c("Species", "Species_2"),
  response = "Sepal.Length",
  stat = c("range_fp", "max", "min")) {

  group <- setNames(nm = group)
  assert_that(is.string(response))

  context <- lapply(
    X = group,
    data = data,
    FUN = function(grp, data) {
      list(
        rowname = as.list(setNames(nm = levels(data[[grp]])))
      )
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
        FUN = function(stat, data, response, group) {
          y <- tapply(
            data[[response]],
            data[[group]],
            function(val) {
              y <- eval(call(stat, val))
              class(y) <- "cell"
              y
            },
            simplify = FALSE
          )
          class(y) <- "col"
          y
        }
        )
      class(y) <- "row"
      y
    }
  )

  print(val)
  grp_lvl <- lapply(
    X = setNames(nm = group),
    data = data,
    FUN = function(x, data) levels(data[[x]])
  )

  grp_vspace <- lapply(grp_lvl, length)
  grp_vspace <- unlist(grp_vspace) + 1
  grp_vspace <- cumsum(grp_vspace) - grp_vspace[1]

  vp_tree <- grid::vpTree(
    parent = grid::viewport(name = "page", width = 0.95, height = 0.95),
    children = vpList(
      viewport(
        name = "header",
        x = .5, y = 1, just = c("center", "top"),
        width = unit(1, "npc"), height = unit(1, "line")
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
            row = group,
            grp_lvl = grp_lvl,
            grp_vspace = grp_vspace,
            function(row, grp_lvl, grp_vspace, col_nm = stat) {
              cell_width <- 1/(length(stat) + 1)
              col_x <- (1:length(stat) + 1) / (length(stat) + 1)
              vpTree(
                parent = viewport(
                  name = row,
                  x = 0, y = unit(1, "npc") - unit(grp_vspace, "line"),
                  just = c("left", "top"),
                  height = unit(length(grp_lvl) + 1, "line")
                  ),
                children = do.call(
                  vpList,
                  Map(
                    col_nm = col_nm,
                    col_x = col_x,
                    row = row,
                    f = function(
                      col_nm,
                      col_x,
                      col_width = cell_width,
                      row
                      ) {
                      viewport(
                        name = cell_name(row, col_nm),
                        x = unit(col_x, "npc"),
                        width = unit(col_width, "npc"),
                        just = "right"
                      )
                    }
                  )
                )
              )
            }
          )
        )
      )
    )
  )

    val <- Map(
      ls = val,
      nm = names(val),
      f = function(ls, nm) {
        names(ls) <- cell_name(nm, names(ls))
        ls
      }
    )
  print(val)

  gg <- gTree(
    childrenvp = vp_tree,
    children = gList(
      rectGrob(vp = "page"),
      rectGrob(vp = "page::header"),
      rectGrob(vp = "page::body"),
      gTree(
        vp = "page::body",
        children = do.call(
          gList,
          Map(
            val = val,
            nm = names(val),
            f = function(val, nm) {
              gTree(
                vp = nm,
                children = do.call(
                  gList,
                  Map(
                    val = val,
                    nm = names(val),
                    f = function(val, nm) {
                      gTree(
                        children = gList(
                          rectGrob(vp = nm),
                          textGrob(
                            paste(val, collapse = "\n"),
                            vp = nm,
                            y = 0, just = "bottom"
                          )
                        )
                      )
                    }
                  )
                )
              )
            }
          )
        )
      )
    )
  )

  print(grid.ls(x = vp_tree, grob = FALSE, viewport = TRUE))
  grid.draw(gg)
}

grid::grid.newpage()
forestplot()



