#' Hex bin map of the 31 Mexican states plus the Federal District
#'
#' A data.frame which contains an hexagonal bin map of all 31 Mexican States plus
#' the Federal District.
#'
#' @docType data
#' @name mxhexbin.map
#' @usage data(mxhexbin.map)
#' @examples
#' \dontrun{
#' # render the map with ggplot2
#' library(ggplot2)
#'
#' data(mxhexbin.map)
#' ggplot(mxhexbin.map, aes(long, lat, group=group)) + geom_polygon(color = "black")
#' }
NULL
