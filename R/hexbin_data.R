#' Hexbin map of Mexican states
#'
#' A fortified data.frame which contains an hexagonal bin map of all 32 Mexican states
#'
#' @docType data
#' @name mxhexbin.map
#' @usage data(mxhexbin.map)
#' @examples
#' ## render the map with ggplot2
#' library(ggplot2)
#'
#' data(mxhexbin.map)
#' ggplot(mxhexbin.map, aes(long, lat, group=group)) +
#'   geom_polygon(color = "black") +
#'   coord_map()
NULL
