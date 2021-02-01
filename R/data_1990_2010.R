#' Mexican 1990-2010 states population dataset
#'
#' A data.frame containing population estimates for all the Mexican states in
#' 1990, 1995, 2000, 2005, and 2010
#'
#' \describe{
#'   \item{region}{INEGI code of the state}
#'   \item{state_name_official}{Official state name (e.g. Coahuila de Zaragoza)}
#'   \item{year}{2015, the year of the Conteo from which the data is sourced}
#'   \item{sex}{Sex of the person}
#'   \item{pop}{total state population}
#' }
#' @name df_mxstate
#' @docType data
#' @references Population estimates taken from the \href{https://www.inegi.org.mx/programas/ccpv/2020/default.html#Tabulados}{INEGI Census Page.}
#'
#' @keywords data
#' @examples
#' data("df_mxstate_1990_2010")
#' head(df_mxstate_1990_2010)
"df_mxstate_1990_2010"

#' Mexican 1990-2010 municipio population dataset
#'
#' A data.frame containing population estimates for all the Mexican municipios in
#' 1990, 1995, 2000, 2005, and 2010
#'
#' \describe{
#'   \item{region}{INEGI code of the state}
#'   \item{municipio_name}{official name of each municipio}
#'   \item{year}{2015, the year of the Conteo from which the data is sourced}
#'   \item{sex}{Sex of the person}
#'   \item{pop}{total municipio population}
#' }
#' @name df_mxmunicipio
#' @docType data
#' @references Population estimates taken from the \href{https://www.inegi.org.mx/programas/ccpv/2020/default.html#Tabulados}{INEGI Census Page}
#'
#' @keywords data
#' @examples
#' data("df_mxmunicipio_1990_2010")
#' head(df_mxmunicipio_1990_2010)
"df_mxmunicipio_1990_2010"
