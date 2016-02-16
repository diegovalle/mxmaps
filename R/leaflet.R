

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
#' the "region" column must exactly match how regions are named in the "region" column in ?df_mxstates.
#' @param pal the color palette function, generated from
#'   \code{\link{colorNumeric}()}, \code{colorBin()}, \code{colorQuantile()}, or
#'   \code{colorFactor()}
#' @param fillColor the values used to generate colors from the palette function
#' @param popup The text to show when the user clicks on a map feature
#' @param weight The thickness of map feature borders
#' @param color The border color for the map features
#' @param opacity the opacity of colors.
#' @param fillOpacity The opacity of the colors used to fill the map features
#' @param lat The latitude of the map center
#' @param lng The longitude of the map center
#' @param mapzoom  The zoom level
#' @param zoom  The municipios to zoom into
#'
#' @return A leaflet map
#' @export
#' @importFrom leaflet colorNumeric
#'
#' @examples
#' \dontrun{
#' data(df_mxmunicipio)
#' df_mxmunicipio$value <- df_mxmunicipio$indigenous /df_mxmunicipio$pop
#' magma <- c("#000004FF", "#1D1146FF", "#50127CFF", "#822681FF",
#'            "#B63779FF", "#E65163FF", "#FB8761FF", "#FEC387FF", "#FCFDBFFF")
#' pal <- colorNumeric(magma, domain = df_mxmunicipio$value)
#' mxmunicipio_leaflet(df_mxmunicipio,
#' pal,
#' ~ pal(value),
#' ~ sprintf("State: %s<br/>Municipio : %s<br/>Value: %s%%",
#'           state_name, municipio_name, round(value * 100, 1))) %>%
#'   addLegend(position = "bottomright", pal = pal, values = df_mxmunicipio$value) %>%
#'   addProviderTiles("CartoDB.Positron")
#' }
mxmunicipio_leaflet <- function(df, pal,
                                fillColor, popup = "",
                                weight = .2, color = "#555555", opacity = 1, fillOpacity = .8,
                                lat = 23.8, lng = -102, mapzoom = 5, zoom = NULL) {
  if (!requireNamespace("mxmapsData", quietly = TRUE)) {
    stop("Package mxmapsData is needed for this function to work. Please install it.", call. = FALSE)
  }
  if (missing(df)){
    stop("missing data.frame")
  }
  if (missing(fillColor)){
    stop("missing fillColor")
  }
  stopifnot(is.data.frame(df))
  stopifnot(c("region", "value") %in% colnames(df))
  df$region <- str_mxmunicipio(df$region)

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
#' @param df A data.frame with a column named "region" and a column named "value".  Elements in
#' the "region" column must exactly match how regions are named in the "region" column in ?df_mxstates.
#' @param pal the color palette function, generated from
#'   \code{\link{colorNumeric}()}, \code{colorBin()}, \code{colorQuantile()}, or
#'   \code{colorFactor()}
#' @param fillColor the values used to generate colors from the palette function
#' @param popup The text to show when the user clicks on a map feature
#' @param weight The thickness of map feature borders
#' @param color The border color for the map features
#' @param opacity the opacity of colors.
#' @param fillOpacity The opacity of the colors used to fill the map features
#' @param lat The latitude of the map center
#' @param lng The longitude of the map center
#' @param mapzoom  The zoom level
#' @param zoom  The municipios to zoom into
#'
#' @return A leaflet map
#' @export
#' @importFrom leaflet colorNumeric
#'
#' @examples
#' \dontrun{
#' data(df_mxstate)
#' df_mxstate$value <- df_mxstate$afromexican / df_mxstate$pop
#' pal <- colorNumeric("Blues", domain = df_mxstate$value)
#' mxstate_leaflet(df_mxstate,
#'                 pal,
#'                 ~ pal(value),
#'                 ~ sprintf("State: %s<br/>Value: %s",
#'                           state_name, comma(value)),
#'                 zoom = c("09", "10")) %>%
#'   addLegend(position = "bottomright", pal = pal, values = df_mxstate$value) %>%
#'   addProviderTiles("CartoDB.Positron")
#' }
mxstate_leaflet <- function(df, pal,
                            fillColor, popup,
                            weight = .2, color = "#555555", opacity = 1, fillOpacity = .8,
                            lat = 23.8, lng = -102, mapzoom = 5, zoom = NULL) {
  if (!requireNamespace("mxmapsData", quietly = TRUE)) {
    stop("Package mxmapsData is needed for this function to work. Please install it.", call. = FALSE)
  }

  data(mxstate.topoJSON, package="mxmapsData", envir=environment())
  mxstate.topoJSON <- setStyle(mxstate.topoJSON, weight, color, opacity , fillOpacity)
  if (missing(df)){
    stop("missing data.frame")
  }
  if (missing(fillColor)){
    stop("missing fillColor")
  }
  stopifnot(is.data.frame(df))
  stopifnot(c("region", "value") %in% colnames(df))
  df$region <- str_mxstate(df$region)

  df$apopups <- resolveFormula(popup, df)
  df$acolors <- resolveFormula(fillColor, df)
  mxstate.topoJSON$objects$state$geometries <-
    setGeometry(mxstate.topoJSON$objects$state$geometries, df, zoom)

  draw_mxleaflet(mxstate.topoJSON, lat, lng, mapzoom)
}
