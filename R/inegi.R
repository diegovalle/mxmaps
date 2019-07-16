#' Title
#'
#' @param token The INEGI registration token available from http://www3.inegi.org.mx/sistemas/api/denue/v1/tokenVerify.aspx
#' @param region Region to download data
#' @param indicator Numeric indicator
#'
#' @importFrom inegiR inegi_series
.get_inegi_data <- function(token, region, indicator, database) {
  s <- inegi_series(indicator, token, geography = region,
                    database = database, lastonly = TRUE)
  # if (s$MetaData$Frecuencia == "Anual" | s$MetaData$Frecuencia == "Yearly" |
  #     s$MetaData$Frecuencia == "Annual" | s$MetaData$Frecuencia == "Quinquenal") {
  #   s$Datos$Fechas <- year(s$Datos$Fechas)
  # }
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
.get_regions_inegi <- function(token, regions, indicator, database, silent = TRUE) {
  df <- data.frame()
  cat("\rDownloading data from the INEGI API")
  #flush.console()
  if (!silent) {
    if (length(regions) > 1) {
      p <- progress_estimated(length(regions), min_time = 2)
    }
  }
  i <- 0
  for (region in regions) {
    tmp <- .get_inegi_data(token, region, indicator, database)
    tmp$region <- region
    df <- rbind(df, tmp)
    if (!silent) {
      if (length(regions) > 1) {
        p$tick()$print()
      }
    }
    i <- i + 1
  }
  names(df) <- c("date", "date_short", "value", "note", "region")
  list(data = df, title = "", indicator = indicator)
}


#' Static maps with INEGI data
#'
#' A state or municipio map of data available from the INEGI API
#'
#' @param token The INEGI registration token available from http://www3.inegi.org.mx/sistemas/api/denue/v1/tokenVerify.aspx
#' @param regions A vector of states to zoom in on. Elements of this vector must exactly match the names of states as they appear in the "region" column of ?df_mxstates.
#' @param indicator Numeric indicator from the \href{http://www.beta.inegi.org.mx/servicios/api_biinegi.html}{INEGI API}
#' @param title An optional title for the map.
#' @param legend	An optional name for the legend.
#' @param database The database to query. BIE (Banco de Informacion Economica) or BISE (Banco de Indicadores). Defaults to BIE.
#' @param silent Wether to print a text progress bar while downloading the INEGI API data
#'
#' @return A choropleth
#' @export
#' @importFrom lubridate year
#'
#' @examples
#' \dontrun{
#' data(df_mxstates)
#' ## Insert token here
#' ## If you don't have a token you can get one from:
#' ## http://www3.inegi.org.mx//sistemas/api/indicadores/v1/tokenVerify.aspx
#' token <- "INSERT_TOKEN_HERE"
#' state_regions <- df_mxstate$region
#' ## You can look up the numeric indicator codes at
#' ## http://www.beta.inegi.org.mx/servicios/api_biinegi.html
#' choropleth_inegi(token, state_regions, "1002000003")
#' }
choropleth_inegi <- function(token, regions, indicator, title, legend ="",
                             database = "BISE",
                             silent = FALSE){
  inegi_data <-  .get_regions_inegi(token, regions, indicator, database, silent)
  if (missing("title")) {
    title = paste0("Indicator: ", indicator, " (",
                   inegi_data$data$date, ")")
  }
  if (all(str_length(regions) == 5L) ) {
    mxmunicipio_choropleth(inegi_data$data, num_colors = 1,
                           title = title,
                           legend = legend,
                           zoom = regions)
  } else if (all(str_length(regions) == 2L)) {
    mxstate_choropleth(inegi_data$data, num_colors = 1,
                       title = title,
                       legend = legend,
                       zoom = regions)
  } else {
    stop("region format not recognized")
  }
}

#' Hexbin map with INEGI data
#'
#' A state hexbin map of data available from the INEGI API
#'
#' @param token The INEGI registration token available from http://www3.inegi.org.mx/sistemas/api/denue/v1/tokenVerify.aspx
#' @param regions A vector of states to zoom in on. Elements of this vector must exactly match the names of states as they appear in the "region" column of ?df_mxstates.
#' @param indicator Numeric indicator from the \href{http://www.beta.inegi.org.mx/servicios/api_biinegi.html}{INEGI API}
#' @param title An optional title for the map.
#' @param legend	An optional name for the legend.
#' @param database The database to query. BIE (Banco de Informacion Economica) or BISE (Banco de Indicadores). Defaults to BIE.
#' @param silent Wether to print a text progress bar while downloading the INEGI API data
#'
#' @return A choropleth
#' @export
#' @importFrom stringr str_length
#'
#' @examples
#' \dontrun{
#' data(df_mxstates)
#' ## Insert token here
#' ## If you don't have a token you can get one from:
#' ## http://www3.inegi.org.mx//sistemas/api/indicadores/v1/tokenVerify.aspx
#' token <- "INSERT_TOKEN_HERE"
#' state_regions <- df_mxstate$region
#' ## You can look up the numeric indicator codes at
#' ## http://www.beta.inegi.org.mx/servicios/api_biinegi.html
#' hexbin_inegi(token, state_regions, "6200205259")
#' }
hexbin_inegi <- function(token, regions, indicator, title, legend = "",
                         database = "BISE",
                         silent = FALSE){
  inegi_data <-  .get_regions_inegi(token, regions, indicator, database, silent)
  if (missing("title")) {
    title = paste0("Indicator: ", indicator, " (",
                   inegi_data$data$date, ")")
  }
  if (all(str_length(regions) == 2L) ) {
    mxhexbin_choropleth(inegi_data$data, num_colors = 1,
                        title = title,
                        legend = legend,
                        zoom = regions)
  } else {
    stop("")
  }
}


