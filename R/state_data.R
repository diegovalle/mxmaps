#' Map of the 31 Mexican states plus the Federal District
#'
#' A data.frame which contains a map of all 31 Mexican States plus
#' the Federal District.  The shapefile
#' was modified using QGIS in order to remove
#' the Maria islands, Socorro island, Arrecife Alacran and
#' Guadalupe Island, then simplified with http://www.mapshaper.org/
#'
#' @docType data
#' @name mxstate.map
#' @usage data(mxstate.map)
#' @references Downloaded from the "Cartografia Geoestadistica Urbana y
#' Rural Amanzanada. Planeacion de la Encuesta Intercensal 2015" shapefiles
#' (https://gist.github.com/diegovalle/aa3eef87c085d6ea034f)
#' @examples
#' \dontrun{
#' # render the map with ggplot2
#' library(ggplot2)
#'
#' data(mxstate.map)
#' ggplot(mxstate.map, aes(long, lat, group=group)) + geom_polygon(color = "black")
#' }
NULL
