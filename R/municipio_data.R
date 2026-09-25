#' Map of the all Mexican municipios and alcaldías
#'
#' A fortified data.frame which contains a map of all Mexican municipios plus
#' boroughs of the Federal District.  The shapefile
#' was modified using QGIS in order to remove
#' the Maria islands, Socorro island, Arrecife Alacran and
#' Guadalupe Island, then simplified with http://www.mapshaper.org/
#'
#' @docType data
#' @name mxmunicipio.map
#' @usage data(mxmunicipio.map)
#' @references Downloaded from the "Marco Geoestadístico, Encuesta Intercensal 2025" shapefiles
#' (https://www.inegi.org.mx/app/biblioteca/ficha.html?upc=794551196649)
#' @examples
#' # render the map with ggplot2
#' library(ggplot2)
#'
#' data(mxmunicipio.map)
#' ggplot(mxmunicipio.map, aes(long, lat, group = group)) +
#'   geom_polygon(fill = "white", color = "#666666", linewidth = .05) +
#'   coord_map()
NULL
