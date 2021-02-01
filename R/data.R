#' Mexican states dataset
#'
#' A data.frame containing population estimates for all the Mexican states in 2015.
#'
#' \describe{
#'   \item{region}{INEGI code of the state}
#'   \item{state_name}{short state name (e.g. Coahuila)}
#'   \item{state_name_official}{Official state name (e.g. Coahuila de Zaragoza)}
#'   \item{state_abbr}{state abbreviation}
#'   \item{state_abbr_official}{official state abbreviation (it can be awkward to use Chis for Chiapas)
#'   according to the INEGI.}
#'   \item{year}{2015, the year of the Conteo from which the data is sourced}
#'   \item{pop}{total state population according to the Encuesta Intercensal 2015}
#'   \item{pop_male}{male population according to the Encuesta Intercensal 2015}
#'   \item{pop_female}{female population according to the Encuesta Intercensal 2015}
#'   \item{afromexican}{afromexican population according to the Encuesta Intercensal 2015}
#'   \item{part_afromexican}{part afromexican population according to the Encuesta Intercensal 2015}
#'   \item{indigenous}{indigenous population according to the Encuesta Intercensal 2015}
#'   \item{part_indigenous}{part indigenous population according to the Encuesta Intercensal 2015}
#' }
#' @name df_mxstate
#' @docType data
#' @references Population estimates taken from the \href{https://www.inegi.org.mx/programas/intercensal/2015/}{Encuesta Intercensal.}
#'
#' @keywords data
#' @examples
#' data("df_mxstate")
#' head(df_mxstate)
"df_mxstate"

#' Mexican municipio dataset
#'
#' A data.frame containing population estimates for all the Mexican municipios in 2015.
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
#'   \item{pop}{total municipio population according to the Encuesta Intercensal 2015}
#'   \item{pop_male}{male population according to the Encuesta Intercensal 2015}
#'   \item{pop_female}{female population according to the Encuesta Intercensal 2015}
#'   \item{afromexican}{afromexican population according to the Encuesta Intercensal 2015}
#'   \item{part_afromexican}{part afromexican population according to the Encuesta Intercensal 2015}
#'   \item{indigenous}{indigenous population according to the Encuesta Intercensal 2015}
#'   \item{part_indigenous}{part indigenous population according to the Encuesta Intercensal 2015}
#'   \item{metro_area}{metro area to which each municipio belongs}
#'   \item{long}{longitude of the localidad cabecera of each municipio}
#'   \item{lat}{latitude of the localidad cabecera of each municipio}
#' }
#' @name df_mxmunicipio
#' @docType data
#' @references Population estimates taken from the \href{https://www.inegi.org.mx/programas/intercensal/2015/}{Encuesta Intercensal}.
#' The latitude and longitude of the localidad cabecera of each municipio come from the
#' \href{http://www.inegi.org.mx/est/contenidos/proyectos/aspectosmetodologicos/clasificadoresycatalogos/catalogo_entidades.aspx}{Catálogo de entidades federativas, municipios y localidades} and the
#' metro areas from the \href{http://www.conapo.gob.mx/en/CONAPO/Delimitacion_de_Zonas_Metropolitanas}{CONAPO}
#'
#' @keywords data
#' @examples
#' data("df_mxmunicipio")
#' head(df_mxmunicipio)
"df_mxmunicipio"

#' Mexican states dataset
#'
#' A data.frame containing population estimates for all the Mexican states in 2015.
#'
#' \describe{
#'   \item{region}{INEGI code of the state}
#'   \item{state_name}{short state name (e.g. Coahuila)}
#'   \item{state_name_official}{Official state name (e.g. Coahuila de Zaragoza)}
#'   \item{state_abbr}{state abbreviation}
#'   \item{state_abbr_official}{official state abbreviation (it can be awkward to use Chis for Chiapas)
#'   according to the INEGI.}
#'   \item{year}{2015, the year of the Conteo from which the data is sourced}
#'   \item{pop}{total state population according to the Encuesta Intercensal 2015}
#'   \item{pop_male}{male population according to the Encuesta Intercensal 2015}
#'   \item{pop_female}{female population according to the Encuesta Intercensal 2015}
#'   \item{afromexican}{afromexican population according to the Encuesta Intercensal 2015}
#'   \item{part_afromexican}{part afromexican population according to the Encuesta Intercensal 2015}
#'   \item{indigenous}{indigenous population according to the Encuesta Intercensal 2015}
#'   \item{part_indigenous}{part indigenous population according to the Encuesta Intercensal 2015}
#' }
#' @name df_mxstate
#' @docType data
#' @references Population estimates taken from the \href{https://www.inegi.org.mx/programas/intercensal/2015/}{Encuesta Intercensal.}
#'
#' @keywords data
#' @examples
#' data("df_mxstate")
#' head(df_mxstate)
"df_mxstate"

#' Mexican municipio dataset
#'
#' A data.frame containing population estimates for all the Mexican municipios in 2015.
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
#'   \item{pop}{total municipio population according to the Encuesta Intercensal 2015}
#'   \item{pop_male}{male population according to the Encuesta Intercensal 2015}
#'   \item{pop_female}{female population according to the Encuesta Intercensal 2015}
#'   \item{afromexican}{afromexican population according to the Encuesta Intercensal 2015}
#'   \item{part_afromexican}{part afromexican population according to the Encuesta Intercensal 2015}
#'   \item{indigenous}{indigenous population according to the Encuesta Intercensal 2015}
#'   \item{part_indigenous}{part indigenous population according to the Encuesta Intercensal 2015}
#'   \item{metro_area}{metro area to which each municipio belongs}
#'   \item{long}{longitude of the localidad cabecera of each municipio}
#'   \item{lat}{latitude of the localidad cabecera of each municipio}
#' }
#' @name df_mxmunicipio
#' @docType data
#' @references Population estimates taken from the \href{https://www.inegi.org.mx/programas/intercensal/2015/}{Encuesta Intercensal}.
#' The latitude and longitude of the localidad cabecera of each municipio come from the
#' \href{http://www.inegi.org.mx/est/contenidos/proyectos/aspectosmetodologicos/clasificadoresycatalogos/catalogo_entidades.aspx}{Catálogo de entidades federativas, municipios y localidades} and the
#' metro areas from the \href{http://www.conapo.gob.mx/en/CONAPO/Delimitacion_de_Zonas_Metropolitanas}{CONAPO}
#'
#' @keywords data
#' @examples
#' data("df_mxmunicipio")
#' head(df_mxmunicipio)
"df_mxmunicipio"
