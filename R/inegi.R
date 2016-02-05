get_inegi_data <- function(token, region, indicator) {
  url <- str_c("http://www3.inegi.org.mx//sistemas/api/indicadores/v1//Indicador/",
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

get_regions_inegi <- function(token, regions, indicator, silent) {
  df <- data.frame()
  cat("\rDownloading data from the INEGI API")
  #flush.console()
  if(length(regions) > 1)
    pb <- txtProgressBar(min = 0, max = length(regions), initial = 0, style = 3)
  i <- 0
  for(region in regions){
    tmp <- get_inegi_data(token, region, indicator)
    tmp$Datos$region <- region
    df <- rbind(df, tmp$Datos)
    if(length(regions) > 1)
      setTxtProgressBar(pb, i)
    i <- i + 1
  }
  names(df) <- c("value", "date", "region")
  list(data = df, title = tmp$MetaData$Nombre, indicator = tmp$MetaData$Indicador)
}


#' choropleth_inegi
#'
#' @param token
#' @param regions
#' @param indicator
#' @param title
#' @param zoom
#'
#' @return
#' @export
#' @examples
choropleth_inegi <- function(token, regions, indicator, title){
  inegi_data <-  get_regions_inegi(token, regions, indicator)
  if(missing("title")) {
    title = str_c(inegi_data$title,
                  " (", inegi_data$data$date, ")")
  }
  if(all(str_length(regions)== 5) ) {
    mxmunicipio_choropleth(inegi_data$data, num_colors = 1,
                           title = title,
                           zoom = mxc_regions)
  } else if(all(str_length(regions) == 2)) {
    mxstate_choropleth(inegi_data$data, num_colors = 1,
                           title = title,
                           zoom = regions)
  }
}

#' hexbin_inegi
#'
#' @param token
#' @param regions
#' @param indicator
#' @param title
#' @param zoom
#'
#' @return
#' @export
#' @examples
hexbin_inegi <- function(token, regions, indicator, title){
  inegi_data <-  get_regions_inegi(token, regions, indicator)
  if(missing("title")) {
    title = str_c(inegi_data$title,
                  " (", inegi_data$data$date, ")")
  }
  if(all(str_length(regions)== 2) ) {
    mxhexbin_choropleth(inegi_data$data, num_colors = 1,
                           title = title,
                           zoom = regions)
  } else {
    stop("")
  }
}


