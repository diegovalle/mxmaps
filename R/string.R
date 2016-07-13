#' str_mxstate
#'
#' @param code The state code according to the INEGI's Catalogo de entidades federativas, municipios y localidades
#' @seealso \url{http://www.inegi.org.mx/est/contenidos/proyectos/aspectosmetodologicos/clasificadoresycatalogos/catalogo_entidades.aspx}
#'
#' @return The state code in the format required by the plotting functions
#' @export
#' @importFrom stringr str_pad
#'
#' @examples
#' str_mxstate(c("12", "2"))
#' str_mxstate(c(32, 5))
#'
#' \dontrun{
#' # warning about invalid state code
#' str_mxstate("35")
#' }
str_mxstate <- function(code){
  if(missing(code)) {
    stop("missing state code to convert")
  }
  code <- as.numeric(code)
  if(any(code > 32)) {
    warning("Invalid state codes detected")
  }
  return(str_pad(code, 2, "left", pad = "0"))
}

#' str_mxmunicipio
#'
#' @param code The sate or combined state and municipio code if the municipio_code variable is missing
#' @param municipio_code The municipio code
#' @seealso \url{http://www.inegi.org.mx/est/contenidos/proyectos/aspectosmetodologicos/clasificadoresycatalogos/catalogo_entidades.aspx}
#'
#' @return The state and municipio code in the format required by the plotting functions
#' @export
#' @importFrom stringr str_pad str_c
#' @importFrom utils data
#'
#' @examples
#' str_mxmunicipio(c("1006", "2003"))
#' str_mxmunicipio(c(32, 5), c(9, 18))
#'
#' \dontrun{
#' # warning about invalid code
#' str_mxmunicipio(33, 999)
#' }
str_mxmunicipio <- function(code, municipio_code){
  if(missing(code)) {
    stop("missing state code to convert")
  }
  df_mxmunicipio <- NULL
  data(df_mxmunicipio, package="mxmaps", envir=environment())
  if(missing(municipio_code)) {
    code <- str_pad(code, 5, "left", pad = "0")

    if(any(!code %in% df_mxmunicipio$region)) {
      warning("Invalid codes detected")
    }
    return(code)
  }
  code <- str_c(str_pad(code, 2, "left", pad = "0"),
        str_pad(municipio_code, 3, "left", pad = "0"))

  if(any(!code %in% df_mxmunicipio$region)) {
    warning("Invalid codes detected")
  }
  return(code)
}


