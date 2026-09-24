#' Mexican 2025 states dataset
#'
#' A data.frame containing population estimates for all the Mexican states in 2025
#'
#' \describe{
#'   \item{region}{INEGI code of the state}
#'   \item{state_name}{short state name (e.g. Coahuila)}
#'   \item{state_name_official}{Official state name (e.g. Coahuila de Zaragoza)}
#'   \item{state_abbr}{state abbreviation}
#'   \item{state_abbr_official}{official state abbreviation (it can be awkward to use Chis for Chiapas)
#'   according to the INEGI.}
#'   \item{year}{2015, the year of the Conteo from which the data is sourced}
#'   \item{pop}{total state population according to the EIC 2025}
#'   \item{pop_male}{male population according to the EIC 2025}
#'   \item{pop_female}{female population according to the EIC 2025}
#'   \item{afromexican}{afromexican population according to the EIC 2025}
#'   \item{indigenous}{Number of persons who describe themselves as indigenous}
#' }
#' @name df_mxstate_2025
#' @docType data
#' @references Population estimates taken from the
#' \href{https://www.inegi.org.mx/app/scitel/Default?ev=12}{EIC 2025.}
#'
#' @keywords data
#' @examples
#' data("df_mxstate_2025")
#' head(df_mxstate_2025)
"df_mxstate_2025"

#' Mexican 2025 municipio dataset
#'
#' A data.frame containing population estimates for all the Mexican municipios in 2025
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
#'   \item{pop}{total municipio population according to the EIC 2025}
#'   \item{pop_male}{male population according to the EIC 2025}
#'   \item{pop_female}{female population according to the EIC 2025}
#'   \item{afromexican}{afromexican population according to the EIC 2025}
#'   \item{indigenous}{Number of persons describe themselves as indigenous
#'   according to the EIC 2025}
#'   \item{long}{longitude of the localidad cabecera of each municipio}
#'   \item{lat}{latitude of the localidad cabecera of each municipio}
#' }
#' @name df_mxmunicipio_2025
#' @docType data
#' @references Population estimates taken from the
#' \href{https://www.inegi.org.mx/app/scitel/Default?ev=12}{EIC 2025}.
#' The latitude and longitude of the localidad cabecera of each municipio come from the
#' \href{https://www.inegi.org.mx/app/ageeml/}{Catálogo Único de Claves
#' de Áreas Geoestadísticas Estatales, Municipales y Localidades} 2026/AGO
#' The metro areas come from Las metrópolis de México, 2020. Tipificación de municipios
#' \href{https://www.datos.gob.mx/dataset/metropolis_mexico_2020/resource/e7284215-f596-4025-9b5d-67c12eb84a4f?utm_source=chatgpt.com}{CONAPO}
#'
#' @keywords data
#' @examples
#' data("df_mxmunicipio_2025")
#' head(df_mxmunicipio_2025)
"df_mxmunicipio_2025"
