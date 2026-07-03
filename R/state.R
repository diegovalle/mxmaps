#' An R6 object for creating state-level choropleths.
#'
#' @export
#' @importFrom R6 R6Class
#' @return An R6 Class
#' @examples
#' library(viridis)
#' library(scales)
#'
#' df_mxstate$value <- df_mxstate$indigenous / df_mxstate$pop
#' gg <- MXStateChoropleth$new(df_mxstate)
#' gg$title <- "Percentage of the population that self-identifies as indigenous"
#' gg$set_num_colors(1)
#' gg$ggplot_scale <- scale_fill_viridis("percent", labels = percent)
#' gg$render()
MXStateChoropleth <- R6Class("MXStateChoropleth", # nolint
  inherit = Choropleth2,
  public = list(
    #' @description
    #' Initialize the map of Mexico
    #' @param user.df df
    #' @return A new `MXStateChoropleth` object.
    initialize = function(user.df) {
      # if (!requireNamespace("mxmapsData", quietly = TRUE)) {
      #  stop("Package mxmapsData is needed for this function to work. Please install it.", call. = FALSE)
      # }

      data(mxstate.map, package = "mxmaps", envir = environment())
      super$initialize(mxstate.map, user.df)

      if (private$has_invalid_regions) {
        warning("Please see df_mxstate for a list of mappable regions")
      }
    }
  )
)

#' Create a state-level choropleth
#'
#' The map used is mxstate.map. See ?mxstate.map for
#' for more information.
#'
#' @param df A data.frame with a column named "region" and a column named "value".  Elements in
#' the "region" column must match the state numeric codes in the "region" column of ?df_mxstate.
#' either with a leading zero or without one (e.g. "01" or "1")
#' @param title An optional title for the map.
#' @param legend An optional name for the legend.
#' @param num_colors The number of colors to use on the map.  A value of 1
#' will use a continuous scale, and a value in [2, 9] will use that many colors.
#' @param zoom An optional vector of countries to zoom in on. Elements of this vector must exactly
#' match the names of countries as they appear in the "region" column of ?country.regions
#' @param background_color Background color of the map and legend.
#' @param state_border_color Border color of polygons.
#' @param state_border_size Border line width.
#' @param title_color Title text color.
#' @param title_align Horizontal justification of title.
#' @param title_position Either "plot" or "panel".
#' @param scale_bar Logical; draw a scale bar.
#' @param scale_bar_position Position of scale bar:
#'   "bl", "br", "tl", or "tr".
#' @param scale_bar_length Scale bar length in kilometers.
#' @param scale_bar_segments Number of scale bar segments.
#' @param scale_bar_height Height of scale bar.
#' @param scale_bar_color Scale bar outline and fill color.
#' @param scale_bar_text_color Scale bar text color.
#' @return A ggplot object representing an state map of Mexico
#' @examples
#' df <- df_mxstate
#' df$value <- df$indigenous
#' mxstate_choropleth(df)
#' @export
#'
# -------------------------------------------------------------------------
# mxmaps extensions
#
# Added support for:
#   - customizable borders
#   - configurable backgrounds
#   - title styling
#   - optional scale bars
#
# -------------------------------------------------------------------------
mxstate_choropleth <- function(
  df,
  title = "",
  legend = "",
  num_colors = 7,
  zoom = NULL,
  # mxmaps extensions
  background_color = "white",
  state_border_color = "dark grey",
  state_border_size = 0.2,
  title_color = "black",
  title_align = 0.5,
  title_position = "plot",
  scale_bar = FALSE,
  scale_bar_position = "bl",
  scale_bar_length = 500,
  scale_bar_segments = 5,
  scale_bar_height = 0.5,
  scale_bar_color = "black",
  scale_bar_text_color = "black"
) {
  stopifnot(title_position %in% c("panel", "plot"))

  if ("region" %in% colnames(df)) {
    df$region <- str_mxstate(df$region)
  }
  if (!is.null(zoom)) {
    zoom <- str_mxstate(zoom)
  }
  c <- MXStateChoropleth$new(df)
  c$title <- title
  c$legend <- legend
  c$state_border_color <- state_border_color
  c$state_border_size <- state_border_size
  c$background_color <- background_color
  c$title_color <- title_color
  c$title_align <- title_align
  c$title_position <- title_position
  c$scale_bar <- scale_bar
  c$scale_bar_position <- scale_bar_position
  c$scale_bar_length <- scale_bar_length
  c$scale_bar_segments <- scale_bar_segments
  c$scale_bar_height <- scale_bar_height
  c$scale_bar_color <- scale_bar_color
  c$scale_bar_text_color <- scale_bar_text_color
  c$set_num_colors(num_colors)
  c$set_zoom(zoom)
  c$render()
}
