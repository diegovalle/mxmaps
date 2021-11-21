#' An R6 object for creating municipio-level choropleths.
#'
#' @export
#' @importFrom R6 R6Class
#' @param show_states draw state borders
#' @importFrom stringr str_sub
#' @importFrom ggplot2 ggplot aes geom_polygon scale_fill_brewer ggtitle theme theme_grey element_blank geom_text coord_map
#' @importFrom ggplot2 scale_fill_continuous scale_colour_brewer ggplotGrob annotation_custom
#'
#' @examples
#' library(viridis)
#' library(scales)
#'
#' df_mxmunicipio_2020$value <-  df_mxmunicipio_2020$indigenous_language / df_mxmunicipio_2020$pop
#' gg = MXMunicipioChoropleth$new(df_mxmunicipio_2020)
#' gg$title <- "Percentage of the population that self-identifies as indigenous"
#' gg$set_num_colors(1)
#' gg$ggplot_scale <- scale_fill_viridis("percent", labels = percent)
#' gg$render()

MXMunicipioChoropleth = R6Class("MXMunicipioChoropleth",
                                inherit = choroplethr:::Choropleth,
                                public = list(
                                  #' @field show_states boolean, draw state borders
                                  show_states = TRUE,
                                  #' @description
                                  #' Render the map of Mexico
                                  #' @param user.df df
                                  #' @return A new ggplot2 object with a map of Mexico.
                                  render = function()
                                  {
                                    self$prepare_map()

                                    gg <- ggplot(self$choropleth.df, aes(long, lat, group = group)) +
                                      geom_polygon(aes(fill = value), color = "dark grey", size = 0.08) +
                                      self$get_scale() +
                                      self$theme_clean() +
                                      ggtitle(self$title)
                                    state_zoom <- unique(str_sub(private$zoom, start = 1, end = 2))
                                    if(self$show_states) {
                                      data(mxstate.map, package="mxmaps", envir=environment())
                                      gg <- gg + geom_polygon(
                                        data = subset(mxstate.map, region %in% state_zoom),
                                        fill = "transparent",
                                        color = "#333333",
                                        size = .15)
                                    }
                                    xmin <- min(self$choropleth.df$long)
                                    xmax <- max(self$choropleth.df$long)
                                    ymin <- min(self$choropleth.df$lat)
                                    ymax <- max(self$choropleth.df$lat)
                                    xpad <- (xmax - xmin) * .05
                                    ypad <- (ymax - ymin) * .05
                                    return(gg + coord_map(xlim = c(xmin - xpad,
                                                                   xmax + xpad),
                                                          ylim = c(ymin - ypad,
                                                                   ymax + ypad)
                                    )
                                    )
                                  },

                                  #' @description
                                  #' Initialize the map of Mexico
                                  #' @param user.df df
                                  #' @return A new `MXMunicipioChoropleth` object.
                                  initialize = function(user.df)
                                  {
                                    #if (!requireNamespace("mxmapsData", quietly = TRUE)) {
                                    #  stop("Package mxmapsData is needed for this function to work. Please install it.", call. = FALSE)
                                    #}

                                    data(mxmunicipio.map, package="mxmaps", envir=environment())
                                    super$initialize(mxmunicipio.map, user.df)

                                    if (private$has_invalid_regions)
                                    {
                                      warning("Please see df_mxmunicipio for a list of mappable regions")
                                    }
                                  }
                                )
)

#' Create a municipio-level choropleth
#'
#' The map used is mxmunicipio.map. See ?mxmunicipio.map for
#' more information.
#'
#' @param df A data.frame with a column named "region" and a column named "value".  Elements in
#' the "region" column must match the numeric codes in the "region" column of ?df_mxmunicipio
#' either with a leading zero or without one (e.g. 01001 or 1001 are both fine)
#' @param title An optional title for the map.
#' @param legend An optional name for the legend.
#' @param num_colors The number of colors to use on the map.  A value of 1
#' will use a continuous scale, and a value in [2, 9] will use that many colors.
#' @param zoom An optional vector of countries to zoom in on. Elements of this vector must exactly
#' match the names of countries as they appear in the "region" column of ?country.regions
#' @param show_states Wether to draw state borders.
#' @examples
#' df <- df_mxmunicipio_2020
#' df$value <- df$indigenous_language
#' mxmunicipio_choropleth(df)

#' @export
mxmunicipio_choropleth  <-  function(df, title="", legend="", num_colors=7, zoom=NULL,
                                     show_states = TRUE)
{
  if("region" %in% colnames(df)) {
    df$region <- str_mxmunicipio(df$region)
  }
  if(!is.null(zoom)) {
    zoom <- str_mxmunicipio(zoom)
  }
  c = MXMunicipioChoropleth$new(df)
  c$title  = title
  c$legend = legend
  c$set_num_colors(num_colors)
  c$set_zoom(zoom)
  c$show_states = show_states
  c$render()
}
