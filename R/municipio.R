#' An R6 object for creating municipio-level choropleths.
#' @export
#' @importFrom dplyr left_join
#' @importFrom R6 R6Class
#' @importFrom stringr str_sub
#' @importFrom ggplot2 ggplot aes geom_polygon scale_fill_brewer ggtitle theme theme_grey element_blank geom_text coord_map
#' @importFrom ggplot2 scale_fill_continuous scale_colour_brewer ggplotGrob annotation_custom
#
MXMunicipioChoropleth = R6Class("MXMunicipioChoropleth",
                            inherit = choroplethr:::Choropleth,
                            public = list(
                              show_states = FALSE,
                              render = function()
                              {
                                self$prepare_map()

                                gg <- ggplot(self$choropleth.df, aes(long, lat, group = group)) +
                                  geom_polygon(aes(fill = value), color = "dark grey", size = 0.1) +
                                  self$get_scale() +
                                  self$theme_clean() +
                                  ggtitle(self$title)
                                state_zoom <- unique(str_sub(private$zoom, start = 1, end = 2))
                                if(self$show_states) {
                                  data(mxstate.map, package="mxmapsData", envir=environment())
                                  gg <- gg + geom_polygon(
                                    data = subset(mxstate.map, region %in% state_zoom),
                                    fill = "transparent",
                                    color = "black",
                                    size = .15)
                                }
                                return(gg + coord_map(xlim = c(min(self$choropleth.df$long),
                                                               max(self$choropleth.df$long)),
                                                      ylim = c(min(self$choropleth.df$lat),
                                                               max(self$choropleth.df$lat))))
                              },

                              # initialize with a world map
                              initialize = function(user.df)
                              {
                                if (!requireNamespace("mxmapsData", quietly = TRUE)) {
                                  stop("Package mxmapsData is needed for this function to work. Please install it.", call. = FALSE)
                                }

                                data(mxmunicipio.map, package="mxmapsData", envir=environment())
                                super$initialize(mxmunicipio.map, user.df)

                                if (private$has_invalid_regions)
                                {
                                  warning("Please see ?country.regions for a list of mappable regions")
                                }
                              }
                            )
)

#' Create a municipio-level choropleth
#'
#' The map used is mxmunicipio.map in the mxmapsData package. See mxmunicipio.map for
#' an object which can help you coerce your regions into the required format.
#'
#' @param df A data.frame with a column named "region" and a column named "value".  Elements in
#' the "region" column must exactly match how regions are named in the "region" column in ?country.map.
#' @param title An optional title for the map.
#' @param legend An optional name for the legend.
#' @param num_colors The number of colors to use on the map.  A value of 1
#' will use a continuous scale, and a value in [2, 9] will use that many colors.
#' @param zoom An optional vector of countries to zoom in on. Elements of this vector must exactly
#' match the names of countries as they appear in the "region" column of ?country.regions
#' @param show_states An optional vector of countries to zoom in on. Elements of this vector must exactly
#' match the names of countries as they appear in the "region" column of ?country.regions
#' @examples
#' # demonstrate default options

#' @export
#' @importFrom Hmisc cut2
#' @importFrom stringr str_extract_all
#' @importFrom ggplot2 ggplot aes geom_polygon scale_fill_brewer ggtitle theme theme_grey element_blank geom_text
#' @importFrom ggplot2 scale_fill_continuous scale_colour_brewer ggplotGrob annotation_custom
#' @importFrom scales comma
#' @importFrom grid unit grobTree
mxmunicipio_choropleth = function(df, title="", legend="", num_colors=7, zoom=NULL,
                                  show_states = FALSE)
{
  c = MXMunicipioChoropleth$new(df)
  c$title  = title
  c$legend = legend
  c$set_num_colors(num_colors)
  c$set_zoom(zoom)
  c$show_states = show_states
  c$render()
}
