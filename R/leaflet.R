

str_mxstate <- function(x) {
  stringr::str_pad(x, 2, "left", "0")
}

str_mxmunicipio <- function(x) {
  stringr::str_pad(x, 3, "left", "0")
}

setStyle <- function(topoJSON, weight, color, opacity , fillOpacity){
 topoJSON$style = list(
    weight = .2,
    color = "#555555",
    opacity = .8,
    fillOpacity = 0.8
  )
 topoJSON
}

resolveFormula = function(f, data) {
  if (!inherits(f, 'formula')) return(f)
  if (length(f) != 2L) stop("Unexpected two-sided formula: ", deparse(f))

  doResolveFormula(data, f)
}

doResolveFormula = function(data, f) {
  UseMethod("doResolveFormula")
}

doResolveFormula.data.frame = function(data, f) {
  eval(f[[2]], data, environment(f))
}

setGeometry <- function(topoJSON.geometries, df, zoom) {
  # Add a properties$style list and popupto each feature
  lapply(topoJSON.geometries, function(feat) {
      idx <- which(df$region == feat$properties$id)
      if(!is.null(zoom)) {
        if(!feat$properties$id %in% zoom) {
          feat$properties$style <- list(
            fillColor = "transparent"
          )
          return(feat)
        }
      }
      feat$properties$style <- list(
        fillColor = df$acolors[idx]
      )
      feat$properties$popup <- df$apopups[idx]
      return(feat)
    }
  )
}

draw_mxleaflet <- function(topoJSON, lat, lng, mapzoom) {
  m <- leaflet::leaflet()
  m <- leaflet::addTiles(m)
  m <- leaflet::setView(m, lng, lat, mapzoom)
  leaflet::addTopoJSON(m, topoJSON)
}

#' mxmunicipio_leaflet
#'
#' @param df A data.frame with a column named "region" and a column named "value".  Elements in
#' the "region" column must exactly match how regions are named in the "region" column in ?country.map.
#' @param pal
#' @param fillColor
#' @param popup
#' @param weight
#' @param color
#' @param opacity
#' @param fillOpacity
#' @param lat
#' @param lng
#' @param zoom
#'
#' @return
#' @export
#' @importFrom leaflet colorNumeric
#'
#' @examples
mxmunicipio_leaflet <- function(df, pal,
                                fillColor, popup,
                                weight = .2, color = "#555555", opacity = 1, fillOpacity = .8,
                                lat = 23.8, lng = -102, mapzoom = 5, zoom = NULL) {
  if (!requireNamespace("mxmapsData", quietly = TRUE)) {
    stop("Package mxmapsData is needed for this function to work. Please install it.", call. = FALSE)
  }
  if (missing(df) | missing(fillColor) | missing(popup)){
    stop()
  }
  stopifnot(is.data.frame(df))
  stopifnot(c("region", "value") %in% colnames(df))

  data(mxmunicipio.topoJSON, package="mxmapsData", envir=environment())
  mxmunicipio.topoJSON <- setStyle(mxmunicipio.topoJSON, weight, color, opacity , fillOpacity)


  df$apopups <- resolveFormula(popup, df)
  df$acolors <- resolveFormula(fillColor, df)
  mxmunicipio.topoJSON$objects$municipio$geometries <-
    setGeometry(mxmunicipio.topoJSON$objects$municipio$geometries, df, zoom)

  draw_mxleaflet(mxmunicipio.topoJSON, lat, lng, mapzoom)
}

#' mxstate_leaflet
#'
#' @param df
#' @param pal
#' @param fillColor
#' @param popup
#' @param weight
#' @param color
#' @param opacity
#' @param fillOpacity
#' @param lat
#' @param lng
#' @param zoom
#'
#' @return
#' @export
#' @importFrom leaflet colorNumeric
#'
#' @examples
mxstate_leaflet <- function(df, pal,
                            fillColor, popup,
                            weight = .2, color = "#555555", opacity = 1, fillOpacity = .8,
                            lat = 23.8, lng = -102, mapzoom = 5, zoom = NULL) {
  if (!requireNamespace("mxmapsData", quietly = TRUE)) {
    stop("Package mxmapsData is needed for this function to work. Please install it.", call. = FALSE)
  }

  data(mxstate.topoJSON, package="mxmapsData", envir=environment())
  mxstate.topoJSON <- setStyle(mxstate.topoJSON, weight, color, opacity , fillOpacity)


  df$apopups <- resolveFormula(popup, df)
  df$acolors <- resolveFormula(fillColor, df)
  mxstate.topoJSON$objects$state$geometries <-
    setGeometry(mxstate.topoJSON$objects$state$geometries, df, zoom)

  draw_mxleaflet(mxstate.topoJSON, lat, lng, mapzoom)
}
