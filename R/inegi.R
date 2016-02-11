#' Title
#'
#' @param token The INEGI registration token available from http://www3.inegi.org.mx/sistemas/api/denue/v1/tokenVerify.aspx
#' @param region Region to download data
#' @param indicator Numeric indicator
#'
#' @importFrom inegiR serie_inegi
get_inegi_data <- function(token, region, indicator) {
  url <- paste0("http://www3.inegi.org.mx//sistemas/api/indicadores/v1//Indicador/",
               indicator,
               "/",
               region,
               "/es/true/xml/")
  s <- serie_inegi(url, token, metadata = TRUE)
  if (s$MetaData$Frecuencia == "Anual" | s$MetaData$Frecuencia == "Yearly" |
      s$MetaData$Frecuencia == "Annual" | s$MetaData$Frecuencia == "Quinquenal") {
    s$Datos$Fechas <- year(s$Datos$Fechas)
  }
  s
}

#' Title
#'
#' @param token The INEGI registration token available from http://www3.inegi.org.mx/sistemas/api/denue/v1/tokenVerify.aspx
#' @param regions Region to download data
#' @param indicator Numeric indicator
#' @param silent print progress
#'
#' @importFrom dplyr progress_estimated
get_regions_inegi <- function(token, regions, indicator, silent = TRUE) {
  df <- data.frame()
  cat("\rDownloading data from the INEGI API")
  #flush.console()
  if(!silent) {
    if(length(regions) > 1) {
      p <- progress_estimated(length(regions), min_time = 2)
    }
  }
  i <- 0
  for(region in regions){
    tmp <- get_inegi_data(token, region, indicator)
    tmp$Datos$region <- region
    df <- rbind(df, tmp$Datos)
    if(!silent) {
      if(length(regions) > 1) {
        p$tick()$print()
      }
    }
    i <- i + 1
  }
  names(df) <- c("value", "date", "region")
  list(data = df, title = tmp$MetaData$Nombre, indicator = tmp$MetaData$Indicador)
}


#' choropleth_inegi
#'
#' @param token The INEGI registration token available from http://www3.inegi.org.mx/sistemas/api/denue/v1/tokenVerify.aspx
#' @param regions A vector of states to zoom in on. Elements of this vector must exactly match the names of states as they appear in the "region" column of ?df_mxstates.
#' @param indicator Numeric indicator
#' @param title An optional title for the map.
#' @param legend	An optional name for the legend.
#' @param silent Print a text progress bar with estimated time remaining
#'
#' @return A choropleth
#' @export
#' @importFrom lubridate year
#' @examples
#' \dontrun{
#' data(df_mxstates)
#' state_regions <- df_mxstate$region
#' choropleth_inegi(token, state_regions, "3101008001")
#' }
choropleth_inegi <- function(token, regions, indicator, title, legend ="", silent = FALSE){
  inegi_data <-  get_regions_inegi(token, regions, indicator, silent)
  if(missing("title")) {
    title = paste0(inegi_data$title,
                  " (", inegi_data$data$date, ")")
  }
  if(all(str_length(regions)== 5L) ) {
    mxmunicipio_choropleth(inegi_data$data, num_colors = 1,
                           title = title,
                           legend = legend,
                           zoom = regions)
  } else if(all(str_length(regions) == 2L)) {
    mxstate_choropleth(inegi_data$data, num_colors = 1,
                       title = title,
                       legend = legend,
                       zoom = regions)
  } else {
    stop("region format not recognized")
  }
}

#' hexbin_inegi
#'
#' @param token The INEGI registration token available from http://www3.inegi.org.mx/sistemas/api/denue/v1/tokenVerify.aspx
#' @param regions A vector of states to zoom in on. Elements of this vector must exactly match the names of states as they appear in the "region" column of ?df_mxstates.
#' @param indicator Numeric indicator
#' @param title An optional title for the map.
#' @param legend	An optional name for the legend.
#' @param silent Print a text progress bar with estimated time remaining
#'
#' @return A choropleth
#' @export
#' @importFrom stringr str_length
#' @examples
#' \dontrun{
#' data(df_mxstates)
#' state_regions <- df_mxstate$region
#' hexbin_inegi(token, state_regions, "3101008001")
#' }
hexbin_inegi <- function(token, regions, indicator, title, legend = "", silent = FALSE){
  inegi_data <-  get_regions_inegi(token, regions, indicator, silent)
  if(missing("title")) {
    title = paste0(inegi_data$title,
                  " (", inegi_data$data$date, ")")
  }
  if(all(str_length(regions)== 2L) ) {
    mxhexbin_choropleth(inegi_data$data, num_colors = 1,
                           title = title,
                        legend = legend,
                           zoom = regions)
  } else {
    stop("")
  }
}


