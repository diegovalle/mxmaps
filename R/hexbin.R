#' An R6 object for creating state-level hexbin choropleths.
#' @export
#' @importFrom R6 R6Class
#' @examples
#' library(viridis)
#' library(scales)
#'
#' df_mxstate$value <-  df_mxstate$indigenous / df_mxstate$pop
#' gg = MXHexBinChoropleth$new(df_mxstate)
#' gg$title <- "Percentage of the population that self-identifies as indigenous"
#' gg$set_num_colors(1)
#' gg$ggplot_scale <- scale_fill_viridis("percent", labels = percent)
#' gg$render()
MXHexBinChoropleth = R6Class("MXHexBinChoropleth",
                             inherit = choroplethr:::Choropleth,
                             public = list(

                               #' @field label_color color for the state labels
                               #' @field label_size font size for the state labels
                               #' @field show_labels draw the state labels
                               label_color = "black",
                               label_size = 5,
                               show_labels = TRUE,

                               #' @description
                               #' Initialize the map of Mexico
                               #' @param user.df df
                               #' @return A new `MXHexBinChoropleth` object.
                               initialize = function(user.df) {

                                 data(mxhexbin.map, package = "mxmaps", envir = environment())
                                 super$initialize(mxhexbin.map, user.df)

                                 if (private$has_invalid_regions) {
                                   warning("Please see ?df_mxstate for a list of mappable regions")
                                 }
                               },

                               #' @description
                               #' Render a map of Mexico
                               #' @return A ggplot2 object with the map of Mexico.
                               render = function() {
                                 choropleth <- super$render()

                                 # by default, add labels for the lower 48 states
                                 if (self$show_labels) {
                                   df_mxstate_labels = structure(list(long = c(-107.424100471015, -107.424100471015,
                                                                               -104.328059652485, -104.328059652485, -101.232018833956, -101.232018833956,
                                                                               -98.1359780154267, -98.1359780154267, -98.1359780154267, -98.1359780154267,
                                                                               -98.1359780154267, -98.1359780154267, -95.0399371968973, -95.0399371968973,
                                                                               -95.0399371968973, -95.0399371968973, -95.0399371968973, -91.9438963783679,
                                                                               -91.9438963783679, -91.9438963783679, -91.9438963783679, -91.9438963783679,
                                                                               -91.9438963783679, -88.8478555598386, -88.8478555598386, -88.8478555598386,
                                                                               -88.8478555598386, -88.8478555598386, -85.7518147413092, -82.6557739227798,
                                                                               -79.5597331042505, -79.5597331042505),
                                                                      lat = c(11.3870924263946,
                                                                              14.9620924263946, 13.1745924263946, 16.7495924263946, 11.3870924263946,
                                                                              14.9620924263946, -1.12540757360544, 2.44959242639456, 6.02459242639456,
                                                                              9.59959242639456, 13.1745924263946, 16.7495924263946, 0.66209242639456,
                                                                              4.23709242639456, 7.81209242639456, 11.3870924263946, 14.9620924263946,
                                                                              -4.70040757360544, -1.12540757360544, 2.44959242639456, 6.02459242639456,
                                                                              9.59959242639456, 13.1745924263946, -2.91290757360544, 0.66209242639456,
                                                                              4.23709242639456, 7.81209242639456, 11.3870924263946, -1.12540757360544,
                                                                              0.66209242639456, -1.12540757360544, 2.44959242639456),
                                                                      state_abbr = c("BCS",
                                                                                     "BC", "SIN", "SON", "NAY", "DGO", "GRO", "MICH", "COL", "JAL",
                                                                                     "ZAC", "CHIH", "MOR", "MEX", "GTO", "AGS", "COAH", "OAX", "PUE",
                                                                                     "CDMX", "QRO", "SLP", "NL", "CHPS", "TLAX", "HGO", "VER", "TAM",
                                                                                     "TAB", "CAMP", "QROO", "YUC"),
                                                                      id = c("03", "02", "25", "26",
                                                                             "18", "10", "12", "16", "06", "14", "32", "08", "17", "15", "11",
                                                                             "01", "05", "20", "21", "09", "22", "24", "19", "07", "29", "13",
                                                                             "30", "28", "27", "04", "23", "31")),
                                                                 .Names = c("long", "lat",
                                                                            "state_abbr", "id"),
                                                                 row.names = c("0", "1", "2", "3", "4", "5",
                                                                               "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16",
                                                                               "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27",
                                                                               "28", "29", "30", "31"),
                                                                 class = "data.frame")

                                   df_mxstate_labels = df_mxstate_labels[df_mxstate_labels$id %in% private$zoom, ]

                                   choropleth <-  choropleth + geom_text(data = df_mxstate_labels, aes(long, lat, label = state_abbr, group = NULL),
                                                                       color = self$label_color,
                                                                       size = self$label_size)
                                 }

                                 choropleth
                               }
                             )
)

#' Create a state-level hexbin choropleth
#'
#' Hexagonal tiles of the states of Mexico
#'
#' @param df A data.frame with a column named "region" and a column named "value".  Elements in
#' the "region" column must exactly match how regions are named in the "region" column in ?df_mxstate.
#' @param title An optional title for the map.
#' @param legend An optional name for the legend.
#' @param num_colors The number of colors to use on the map.  A value of 1
#' will use a continuous scale, and a value in [2, 9] will use that many colors.
#' @param zoom An optional vector of states to zoom in on. Elements of this vector must exactly
#' match the names of countries as they appear in the "region" column of ?country.regions
#' @param label_color An optional color for the state abbreviation labels
#' @param label_size An optional size for the state abbrevition labels
#' @examples
#' data(df_mxstate)
#' df_mxstate$value <- df_mxstate$pop
#' mxhexbin_choropleth(df_mxstate, num_colors = 1)
#' @export
mxhexbin_choropleth  <-  function(df, title="", legend="", num_colors=7, zoom=NULL,
                               label_color = "black", label_size = 4.5)
{
  if("region" %in% colnames(df)) {
    df$region <- str_mxstate(df$region)
  }
  if(!is.null(zoom)) {
    zoom <- str_mxstate(zoom)
  }
  c <-  MXHexBinChoropleth$new(df)
  c$title  <-  title
  c$legend <- legend
  c$set_num_colors(num_colors)
  c$set_zoom(zoom)
  c$label_color <-  label_color
  c$label_size <-  label_size
  c$render()
}
