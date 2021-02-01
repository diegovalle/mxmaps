#' Map of Mexican States
#'
#' A data.frame which contains a map of all 32 Mexican states. The shapefile
#' was modified using QGIS in order to remove
#' the Maria islands, Socorro island, Arrecife Alacran and
#' Guadalupe Island, then simplified with http://www.mapshaper.org/
#'
#' @docType data
#' @name mxstate.map
#' @usage data(mxstate.map)
#' @references Downloaded from the "Marco Geoestadístico. Censo de Población y Vivienda 2020" shapefiles
#' (https://www.inegi.org.mx/app/biblioteca/ficha.html?upc=889463807469)
#' @examples
#' # render the map with ggplot2
#' library(ggplot2)
#'
#' data(mxstate.map)
#' ggplot(mxstate.map, aes(long, lat, group=group)) +
#'   geom_polygon(fill = "white", color = "black", size = .2) +
#'   coord_map()
NULL
