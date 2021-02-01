#' Mexican 2020 states dataset
#'
#' A data.frame containing population estimates for all the Mexican states in 2020
#'
#' \describe{
#'   \item{region}{INEGI code of the state}
#'   \item{state_name}{short state name (e.g. Coahuila)}
#'   \item{state_name_official}{Official state name (e.g. Coahuila de Zaragoza)}
#'   \item{state_abbr}{state abbreviation}
#'   \item{state_abbr_official}{official state abbreviation (it can be awkward to use Chis for Chiapas)
#'   according to the INEGI.}
#'   \item{year}{2015, the year of the Conteo from which the data is sourced}
#'   \item{pop}{total state population according to the Censo 2020}
#'   \item{pop_male}{male population according to the Censo 2020}
#'   \item{pop_female}{female population according to the Censo 2020}
#'   \item{afromexican}{afromexican population according to the Censo 2020}
#'   \item{indigenous_language}{Number of persons who speak an indigenous language according to the Censo 2020}
#' }
#' @name df_mxstate
#' @docType data
#' @references Population estimates taken from the \href{https://www.inegi.org.mx/programas/ccpv/2020/default.html#Tabulados}{Censo 2020.}
#'
#' @keywords data
#' @examples
#' data("df_mxstate_2020")
#' head(df_mxstate_2020)
"df_mxstate_2020"

#' Mexican 2020 municipio dataset
#'
#' A data.frame containing population estimates for all the Mexican municipios in 2020
#'
#' \describe{
#'   \item{state_code}{INEGI code of each state}
#'   \item{municipio_code}{INEGI code of each municipio}
#'   \item{region}{INEGI code of the state}
#'   \item{state_name}{short state name (e.g. Coahuila)}
#'   \item{state_name_official}{Official state name (e.g. Coahuila de Zaragoza)}
#'   \item{state_abbr}{state abbreviation}
#'   \item{state_abbr_official}{official state abbreviation (it can be awkward to use Chis for Chiapas)
#'   according to the INEGI.}
#'   \item{municipio_name}{official name of each municipio}
#'   \item{year}{2015, the year of the Conteo from which the data is sourced}
#'   \item{pop}{total municipio population according to the Censo 2020}
#'   \item{pop_male}{male population according to the Censo 2020}
#'   \item{pop_female}{female population according to the Censo 2020}
#'   \item{afromexican}{afromexican population according to the Censo 2020}
#'   \item{indigenous_language}{Number of persons who speak an indigenous language according to the Censo 2020}
#'   \item{long}{longitude of the localidad cabecera of each municipio}
#'   \item{lat}{latitude of the localidad cabecera of each municipio}
#' }
#' @name df_mxmunicipio
#' @docType data
#' @references Population estimates taken from the \href{https://www.inegi.org.mx/programas/ccpv/2020/default.html#Tabulados}{Censo 2020}.
#' The latitude and longitude of the localidad cabecera of each municipio come from the
#' \href{https://www.inegi.org.mx/app/ageeml/}{Catálogo Único de Claves de Áreas Geoestadísticas Estatales, Municipales y Localidades}
#'
#' @keywords data
#' @examples
#' data("df_mxmunicipio_2020")
#' head(df_mxmunicipio_2020)
"df_mxmunicipio_2020"
