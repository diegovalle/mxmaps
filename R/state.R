#' An R6 object for creating state-level choropleths.
#' @export
#' @importFrom R6 R6Class
MXStateChoropleth = R6Class("MXStateChoropleth",
                                inherit = choroplethr:::Choropleth,
                                public = list(

                                  # initialize with a world map
                                  initialize = function(user.df)
                                  {
                                    #if (!requireNamespace("mxmapsData", quietly = TRUE)) {
                                    #  stop("Package mxmapsData is needed for this function to work. Please install it.", call. = FALSE)
                                    #}

                                    data(mxstate.map, package="mxmaps", envir=environment())
                                    super$initialize(mxstate.map, user.df)

                                    if (private$has_invalid_regions)
                                    {
                                      warning("Please see df_mxstate for a list of mappable regions")
                                    }
                                  }
                                )
)

#' Create a state-level choropleth
#'
#' The map used is mxstate.map in the mxmapsData package. See mxstate.map for
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
#' @examples
#' # demonstrate default options
#' @export
mxstate_choropleth = function(df, title="", legend="", num_colors=7, zoom=NULL)
{
  if("region" %in% colnames(df)) {
    df$region <- str_mxstate(df$region)
  }
  if(!is.null(zoom)) {
    zoom <- str_mxstate(zoom)
  }
  c = MXStateChoropleth$new(df)
  c$title  = title
  c$legend = legend
  c$set_num_colors(num_colors)
  c$set_zoom(zoom)
  c$render()
}
