

setStyle <- function(topoJSON, weight, color, opacity, fillOpacity){
 topoJSON$style = list(
    weight = .2,
    color = "transparent",
    opacity = opacity,
    fillOpacity = fillOpacity,
    fillColor = "transparent"
  )
 topoJSON
}

#from the leaflet package
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

setGeometry <- function(topoJSON.geometries, df, zoom, fillOpacity) {
  # Add a properties$style list and popupto each feature
  lapply(topoJSON.geometries, function(feat) {
    idx <- which(df$region == feat$properties$id)
    if(!is.null(zoom)) {
      if(!feat$properties$id %in% zoom) {
        feat$properties$style <- list(
          fillColor = "red",
          fillOpacity = 0,
          color = "transparent"
        )
        return(feat)
      }
    }
    feat$properties$style <- list(
      fillColor = df$acolors[idx],
      fillOpacity = fillOpacity,
      color = "#555555"
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

#' Create a municipio-level interactive map
#'
#' Zoomable municipio maps made with leaflet
#'
#' @param df A data.frame with a column named "region" and a column named
#'   "value".  Elements in the "region" column must exactly match how regions
#'   are named in the "region" column in ?df_mxmunicipio.
#' @param pal the color palette function, generated from
#'   \code{\link{colorNumeric}()}, \code{colorBin()}, \code{colorQuantile()}, or
#'   \code{colorFactor()}
#' @param fillColor the values used to generate colors from the palette function
#' @param popup The text to show when the user clicks on a map feature
#' @param weight The thickness of map feature borders
#' @param color The border color for the map features
#' @param opacity the opacity of colors.
#' @param fillOpacity The opacity of the colors used to fill the map features
#' @param lng The longitude of the map center
#' @param lat The latitude of the map center
#' @param mapzoom  The zoom level
#' @param zoom  The municipios to zoom into
#'
#' @return A leaflet map
#' @export
#' @importFrom leaflet colorNumeric
#' @importFrom  utils data
#'
#' @examples
#' \dontrun{
#' library(leaflet)
#'
#' data(df_mxmunicipio)
#' df_mxmunicipio$value <- df_mxmunicipio$indigenous /df_mxmunicipio$pop
#' magma <- c("#000004FF", "#1D1146FF", "#50127CFF", "#822681FF",
#'            "#B63779FF", "#E65163FF", "#FB8761FF", "#FEC387FF", "#FCFDBFFF")
#' pal <- colorNumeric(magma, domain = df_mxmunicipio$value)
#' mxmunicipio_leaflet(df_mxmunicipio,
#'                     pal,
#'                     ~ pal(value),
#'                     ~ sprintf("State: %s<br/>Municipio : %s<br/>Value: %s%%",
#'                     state_name, municipio_name, round(value * 100, 1))) %>%
#'   addLegend(position = "bottomright", pal = pal,
#'             values = df_mxmunicipio$value) %>%
#'   addProviderTiles("CartoDB.Positron")
#' }
mxmunicipio_leaflet <- function(df, pal,
                                fillColor, popup = "",
                                weight = .2, color = "#555555", opacity = 0.8,
                                fillOpacity = .8,
                                lng = -102, lat = 23.8, mapzoom = 5,
                                zoom = NULL) {
  #if (!requireNamespace("mxmapsData", quietly = TRUE)) {
  #  stop("Package mxmapsData is needed for this function to work. Please install it.", call. = FALSE)
  #}
  if (missing(df)){
    stop("missing data.frame")
  }
  if (missing(fillColor)){
    stop("missing fillColor")
  }
  stopifnot(is.data.frame(df))
  stopifnot(c("region", "value") %in% colnames(df))
  df$region <- str_mxmunicipio(df$region)

  data(mxmunicipio.topoJSON, package="mxmaps", envir=environment())
  mxmunicipio.topoJSON <- setStyle(mxmunicipio.topoJSON, weight, color, opacity,
                                   fillOpacity)


  df$apopups <- resolveFormula(popup, df)
  df$acolors <- resolveFormula(fillColor, df)
  mxmunicipio.topoJSON$objects$municipio$geometries <-
    setGeometry(mxmunicipio.topoJSON$objects$municipio$geometries, df, zoom,
                fillOpacity = fillOpacity)
  if(!is.null(zoom)) {
    zoom <- str_mxmunicipio(zoom)
    df_zoom <- dplyr::filter(df, region %in% zoom)
    if (nrow(df_zoom) == 0)
      stop("No valid municipios in zoom data")
    draw_mxleaflet(mxmunicipio.topoJSON, lat, lng, mapzoom) %>%
      fitBounds(min(df_zoom$long) - .5,
                max(df_zoom$lat) + .5,
                max(df_zoom$long) - .5,
                min(df_zoom$lat) - .5)
  } else {
    draw_mxleaflet(mxmunicipio.topoJSON, lat, lng, mapzoom)
  }

}

#' Create a state-level interactive map
#'
#' Zoomable state maps made with leaflet
#'
#' @param df A data.frame with a column named "region" and a column named "value".  Elements in
#' the "region" column must exactly match how regions are named in the "region" column in ?df_mxstate.
#' @param pal the color palette function, generated from
#'   \code{\link{colorNumeric}()}, \code{colorBin()}, \code{colorQuantile()}, or
#'   \code{colorFactor()}
#' @param fillColor the values used to generate colors from the palette function
#' @param popup The text to show when the user clicks on a map feature
#' @param weight The thickness of map feature borders
#' @param color The border color for the map features
#' @param opacity the opacity of colors.
#' @param fillOpacity The opacity of the colors used to fill the map features
#' @param lng The longitude of the map center
#' @param lat The latitude of the map center
#' @param mapzoom  The zoom level
#' @param zoom  The states to zoom into
#'
#' @return A leaflet map
#' @export
#' @importFrom leaflet colorNumeric
#' @importFrom  utils data
#'
#' @examples
#' \dontrun{
#' library(scales)
#' library(leaflet)
#'
#' data(df_mxstate)
#' df_mxstate$value <- df_mxstate$afromexican / df_mxstate$pop
#' pal <- colorNumeric("Blues", domain = df_mxstate$value)
#' mxstate_leaflet(df_mxstate,
#'                 pal,
#'                 ~ pal(value),
#'                 ~ sprintf("State: %s<br/>Value: %s",
#'                           state_name, comma(value))) %>%
#'   addLegend(position = "bottomright", pal = pal, values = df_mxstate$value) %>%
#'   addProviderTiles("CartoDB.Positron")
#' }
mxstate_leaflet <- function(df, pal,
                            fillColor, popup,
                            weight = .2, color = "#555555", opacity = 1, fillOpacity = .8,
                            lng = -102, lat = 23.8, mapzoom = 5, zoom = NULL) {
  #if (!requireNamespace("mxmapsData", quietly = TRUE)) {
  #  stop("Package mxmapsData is needed for this function to work. Please install it.", call. = FALSE)
  #}

  states_bbox <- data.frame(region = c("05", "29", "19", "25", "10", "27",
                                        "14", "26", "21", "13", "18", "02",
                                        "12", "01", "06", "23", "24",
                                        "20", "28", "15", "09", "04",
                                        "03", "22", "17", "32", "08", "07",
                                        "11", "30", "16", "31"),
                             lng1 = c(-103.960584608, -98.706980842,
                                      -101.207097916, -109.449242116,
                                      -107.211652598, -94.131064488,
                                      -105.694487536, -115.053900172,
                                      -99.070245716, -99.857828384,
                                      -106.686597486, -117.2457,
                                      -102.183944636, -102.873842632,
                                      -104.690167002,
                                      -89.295673224, -102.296892538,
                                      -98.551295896, -100.144777108,
                                      -100.611831946, -99.366352378,
                                      -92.467372418, -115.221795702,
                                      -100.596568716, -99.49456351,
                                      -104.354375942, -109.073766658,
                                      -94.140222426, -102.095417902,
                                      -98.682559674, -103.73774145,
                                      -90.403783722),
                             lat1 = c(24.542978848, 19.104656218,
                                      23.162481565,
                                      22.467685831, 22.345823752,
                                      17.251261315, 18.926410192,
                                      26.296337716,
                                      17.86057171, 19.597561045,
                                      20.603377906, 28.000587985,
                                      16.316379097,
                                      21.621926626, 18.684504871,
                                      17.895129613, 21.159942028,
                                      15.657960103,
                                      22.20759214, 18.366208396,
                                      19.048272271, 17.813281948,
                                      22.871467645,
                                      20.017712392, 18.33346933,
                                      21.041717623, 25.563346405, 14.5321,
                                      19.912219846, 17.136674584,
                                      17.91513682, 19.550271283),
                             lng2 = c(-99.842565154,
                                      -97.626344158, -98.423084764,
                                      -105.392275582, -102.473946006,
                                      -90.986839108, -101.50930987,
                                      -108.42355306, -96.728866234,
                                      -97.986556386,
                                      -103.72247822, -112.297360834,
                                      -98.007924908, -101.835942992,
                                      -103.487424478, -86.722292646,
                                      -98.325400092, -93.868536932,
                                      -97.14402609, -98.597085586,
                                      -98.938981938, -89.121672402,
                                      -109.412610364,
                                      -99.042771902, -98.633717338,
                                      -100.743095724, -103.307318364,
                                      -90.370204616, -99.671616978,
                                      -93.609062022, -100.062355666,
                                      -87.534296482),
                             lat2 = c(29.877627769, 19.728517309,
                                      27.798697078,
                                      27.042060886, 26.84562649,
                                      18.651765805, 22.749605566,
                                      32.493115375,
                                      20.839826716, 21.396390838,
                                      23.084271574, 32.718651163,
                                      18.888214615,
                                      22.460410483, 19.512075706,
                                      21.605557093, 24.492051412,
                                      18.669954175,
                                      27.678653836, 20.285081431,
                                      19.592104534, 20.848920901,
                                      28.000587985,
                                      21.667397551, 19.131938773,
                                      25.125006688, 31.783768945,
                                      17.986071463,
                                      21.838368229, 22.471323505,
                                      20.392392814, 21.6255643))


  data(mxstate.topoJSON, package="mxmaps", envir=environment())
  mxstate.topoJSON <- setStyle(mxstate.topoJSON, weight, color, opacity,
                               fillOpacity)
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
    setGeometry(mxstate.topoJSON$objects$state$geometries, df, zoom,
                fillOpacity = fillOpacity)
  if(!is.null(zoom)) {
    zoom <- str_mxstate(zoom)
    states_bbox <- dplyr::filter(states_bbox, region %in% zoom)
    if (nrow(states_bbox) == 0)
      stop("No valid municipios in zoom data")
    draw_mxleaflet(mxstate.topoJSON, lat, lng, mapzoom) %>%
      fitBounds(min(states_bbox$lng1) ,
                max(states_bbox$lat1) ,
                max(states_bbox$lng2) ,
                min(states_bbox$lat2) )
  } else {
    draw_mxleaflet(mxstate.topoJSON, lat, lng, mapzoom)
  }
}
