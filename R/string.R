#' Format state codes with leading zeroes
#'
#' @param code The state code according to the INEGI's Catalogo de entidades federativas, municipios y localidades
#' @seealso \url{https://www.inegi.org.mx/app/ageeml/}
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
  code <- as.numeric(as.character(code))
  if(any(code > 32)) {
    warning("Invalid state codes detected")
  }
  return(str_pad(code, 2, "left", pad = "0"))
}

#' Format municipio codes with leading zeroes
#'
#' @param code The sate or combined state and municipio code if the municipio_code variable is missing
#' @param municipio_code The municipio code
#' @seealso \url{https://www.inegi.org.mx/app/ageeml/}
#'
#' @return The state and municipio code in the format required by the plotting functions
#' @export
#' @importFrom stringr str_pad str_c
#' @importFrom utils data
#'
#' @examples
#' # Format the concatenated string of state code + municipio code
#' str_mxmunicipio(c("1006", "2003"))
#' # Format the state and municipio code separately
#' str_mxmunicipio(c(10, 6), c(20, 3))
#'
#' \dontrun{
#' # warning about invalid code
#' str_mxmunicipio(33, 999)
#' }
str_mxmunicipio <- function(code, municipio_code){
  if(missing(code)) {
    stop("missing state code to convert")
  }
  df_mxmunicipio_2020 <- NULL
  data(df_mxmunicipio_2020, package="mxmaps", envir=environment())
  if(missing(municipio_code)) {
    code <- str_pad(code, 5, "left", pad = "0")

    if(any(!code %in% df_mxmunicipio_2020$region)) {
      warning("Invalid codes detected")
    }
    return(code)
  }
  code <- str_c(str_pad(code, 2, "left", pad = "0"),
        str_pad(municipio_code, 3, "left", pad = "0"))

  if(any(!code %in% df_mxmunicipio_2020$region)) {
    warning("Invalid codes detected")
  }
  return(code)
}
