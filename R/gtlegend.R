# Constructor -------------------------------------------------------------

#' Legend based on gt table
#'
#' Takes a table formatted by the {gt} package and adds a column of legend keys.
#'
#' @param table Either a `<data.frame>` or object created by [`gt()`][gt::gt] to
#'   display as table.
#' @param title A character string indicating the title to serve as table header.
#'   If `NULL`, the title is not shown. By default (`waiver()`), the name of the
#'   scale object or name specified in [`labs()`][ggplot2::labs] is used for the
#'   title. The title set via the [`tab_header()`][gt::tab_header] overrules
#'   titles set via the scale or via `labs()`.
#' @param key_after Placement of the key column. When `-Inf` (default), the
#'   key column becomes the first column. When `Inf`, it becomes the last
#'   column. Any other values are passed on to
#'   [`cols_add(.after)`][gt::cols_add].
#' @param key_colname A character string to use as column label for the key
#'   column.
#' @param theme A [`theme`][ggplot2::theme] object to style the guide
#'   individually or differently from the plot's theme settings. The `theme`
#'   argument in the guide overrides, and is combined with, the plot's theme.
#' @param position A character string indicating where the legend should be
#'   placed relative to the plot panels.
#' @param override.aes A list specifying aesthetic parameters of legend keys.
#'   See the details and examples in [`guide_legend()`][ggplot2::guide_legend].
#' @param order Positive integer less than 99 that specifies the order of this
#'   guide among multiple guides. This controls the order in which multiple
#'   guides are displayed, not the contents of the guide itself. If 0 (default),
#'   the order is determined by a secret algorithm.
#'
#' @return A `<Guide>` object that can be used in a non-position scale function
#'   or in the [`guides()`][ggplot2::guides] function.
#' @export
#'
#' @examples
#' # A standard plot
#' p <- ggplot(mpg, aes(displ, hwy, colour = drv)) +
#'   geom_point()
#'
#' # Make small summary table
#' summary <- mpg |>
#'   subset(select = c(drv, cty, hwy)) |>
#'   aggregate(by = . ~ drv, FUN = mean)
#'
#' # Using plain data.frame as guide
#' p + guides(colour = guide_gtlegend(summary))
#'
#' # Using a formatted gt-table as guide
#' formatted <- summary |>
#'   gt::gt() |>
#'   gt::fmt_number(c(cty, hwy)) |>
#'   gt::tab_spanner("mpg", c(cty, hwy)) |>
#'   gt::tab_style(
#'     gt::cell_fill("orange"),
#'     gt::cells_body(cty, 2)
#'   ) |>
#'   gt::tab_style(
#'     gt::cell_text(color = "red"),
#'     gt::cells_body(drv, 3)
#'   ) |>
#'   gt::tab_header("Custom title") |>
#'   guide_gtlegend()
#' p + guides(colour = formatted)
#'
#' # Using theme for style options
#' p + guides(colour = formatted) +
#'   theme(
#'     legend.title = element_text(face = "bold"),
#'     legend.text  = element_text(colour = "grey50"),
#'     legend.key   = element_blank(),
#'     legend.key.size = unit(1, "cm")
#'   )
guide_gtlegend <- function(
  table,
  title = waiver(),
  key_after = -Inf,
  key_colname = "",
  theme = NULL,
  position = NULL,
  override.aes = list(),
  order = 0
) {
  if (!inherits(table, "gt_tbl")) {
    table <- gt::gt(table)
  }
  check_string(key_colname)

  new_guide(
    table = table,
    key_after = key_after,
    key_colname = key_colname,
    title = title,
    theme = theme,
    position = position,
    override.aes = override.aes,
    order = order,
    super = GuideGtlegend
  )
}

# Class -------------------------------------------------------------------

GuideGtlegend <- ggproto(
  "GuideGtlegend", GuideLegend,

  params = list(
    table = NULL,
    key_after = 0,
    key_colname = "",
    title = waiver(),
    theme = NULL,
    override.aes = list(),
    hash = character(),
    position = NULL,
    direction = NULL,
    order = 0,
    name = "gt_legend"
  ),

  extract_params = function(scale, params, title = waiver(), ...) {
    n_key <- nrow(params$key)
    n_tab <- nrow(params$table$`_data`)
    if (n_key != n_tab) {
      cli::cli_abort(
        "The number of rows in {.arg table} ({n_tab}) must match \\
        the number of valid breaks in the scale ({n_key})."
      )
    }
    params$title <- scale$make_title(
      params$title %|W|% params$table$`_heading`$title %||%
        scale$name %|W|% title
    )
    GuideLegend$extract_params(scale, params, title, ...)
  },

  setup_params = function(params) {
    params$table <- gt::tab_header(params$table, params$title)
    GuideLegend$setup_params(params)
  },

  build_decor = function(decor, grobs, elements, params) {
    keys <- GuideLegend$build_decor(decor, grobs, elements, params)
    split_idx <- rep(seq_len(params$n_breaks), each = params$n_key_layers)
    keys <- split(keys, split_idx)

    size <- convertUnit(unit(elements$title$size %||% 0, "pt"), "cm", valueOnly = TRUE)
    size <- max(size, elements$width_cm)

    keys <- lapply(keys, function(key) {
      width <- lapply(key, attr, which = "width")
      width[lengths(width) != 1] <- 0
      width <- max(unlist(width))

      height <- lapply(key, attr, which = "height")
      height[lengths(height) != 1] <- 0
      height <- max(unlist(height))

      gTree(
        width = max(width, size), height = max(height, size),
        children = inject(gList(!!!key)),
        cl = "keygrob"
      )
    })
    names(keys) <- lapply(keys, hash)
    keys
  },

  assemble_drawing = function(self, grobs, layout, sizes, params, elements) {

    keys <- grobs$decor
    renderer <- render_text_or_key(keys, elements$text)
    table <- dress_table_legend(params$table, elements)

    # Insert key column
    after <- params$key_after
    if (after == -Inf) {
      table <- gt::cols_add(table, "_x" = names(keys))
      table <- gt::cols_move_to_start(table, "_x")
    } else {
      after[after == Inf] <- ncol(table$`_data`)
      table <- gt::cols_add(table, "_x" = names(keys), .after = after)
    }
    table <- gt::cols_label(table, `_x` = params$key_colname)
    table <- gt::as_gtable(table, text_grob = renderer)
    table <- gtable::gtable_add_grob(
      table, t = 1, b = -1, l = 1, r = -1,
      elements$background, name = "background", z = -Inf
    )
    table$layout$z[table$layout$name == "title"] <- max(table$layout$z) + 1
    table
  }
)

# Helpers -----------------------------------------------------------------

dress_table_legend <- function(table, elements) {

  table <- gt::tab_options(table, table.background.color = elements$background$gp$fill)

  text <- elements$text
  if (!inherits(text, "element_blank")) {
    text$face <- gpar(fontface = text$face)$font
    if (text$family == "") text$family <- NULL

    table <- gt::tab_options(
      table,
      table.font.color = text$colour,
      table.font.names = text$family,
      table.font.size  = text$size / 0.75,
      table.font.style  = if (text$face %in% c(3, 4)) "italic" else "normal",
      table.font.weight = if (text$face %in% c(2, 4)) "bold"   else "normal"
    )
  }

  text <- elements$title
  if (inherits(text, "element_blank")) {
    table <- gt::tab_header(table, title = NULL)
    return(table)
  }

  if (!"title" %in% table$`_styles`$locname) {
    text$face <- gpar(fontface = text$face)$font
    if (text$family == "") text$family <- NULL

    title <- gt::cell_text(
      color = text$colour,
      font = text$family,
      size  = gt::px(text$size / 0.75),
      align   = switch(as.character(text$hjust), "0" = "left", "1" = "right", "center"),
      v_align = switch(as.character(text$vjust), "0" = "bottom", "1" = "top", "middle"),
      style   = if (text$face %in% c(3, 4)) "italic" else "normal",
      weight  = if (text$face %in% c(2, 4)) "bold" else "normal"
    )

    table <- gt::tab_style(table, title, gt::cells_title("title"))
  }

  table
}

render_text_or_key <- function(grobs = list(), element) {
  force(grobs)
  force(element)
  function(label, x, y, hjust, vjust, gp) {
    if (label %in% names(grobs)) {
      margin <- evalq(margin, parent.frame())
      grob <- grobs[[label]]
      grob$width  <- unit(grob$width, "cm")  - sum(margin[c(2, 4)])
      grob$height <- unit(grob$height, "cm") - sum(margin[c(1, 3)])
      return(grob)
    }
    element_grob(
      element, label = label, x = x, y = y, hjust = hjust, vjust = vjust,
      family = gp$fontfamily, size = gp$fontsize, colour = gp$col,
      face = gp$font
    )
  }
}

#' @export
widthDetails.keygrob <- function(x) {
  x$width
}
#' @export
heightDetails.keygrob <- function(x) {
  x$height
}

`%|W|%` <- function(a, b) if (!inherits(a, "waiver")) a else b
