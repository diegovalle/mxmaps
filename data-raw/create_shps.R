
library(ggplot2)

library(R6)
library(Hmisc)
library(stringr)
library(dplyr)
library(scales)
library(ggplot2)
library(viridis)
library(rbenchmark)
library(leaflet)
library(jsonlite)
library(readr)
library(tidyr)
library(mxmaps)
library(sf)

mxstate.map.spdf <- readOGR("data-raw/simpl2025/entidades.shp", "entidades")
head(mxstate.map.spdf)
mxstate.map.spdf$id <- as.character(mxstate.map.spdf$CVEGEO)
mxstate.map.spdf$CVEGEO <- NULL
mxstate.map.spdf$CVE_ENT <- NULL
# save(mxstate.map, file = "data/state.spdf.RData",
#     compress = "xz")
mxstate.map <- fortify(mxstate.map.spdf, region = "id")
mxstate.map$region <- mxstate.map$id
save(mxstate.map,
  file = "data/mxstate.map.RData",
  compress = "xz", version = 2
)


mxmunicipio.map.spdf <- readOGR("data-raw/simpl2025/municipios.shp", "municipios")
head(mxmunicipio.map.spdf)
mxmunicipio.map.spdf$id <- as.character(mxmunicipio.map.spdf$CVEGEO)
mxmunicipio.map.spdf$CVEGEO <- NULL
mxmunicipio.map.spdf$CVE_ENT <- NULL
mxmunicipio.map.spdf$CVE_MUN <- NULL
# save(mxstate.map, file = "data/state.spdf.RData",
#     compress = "xz")
mxmunicipio.map <- fortify(mxmunicipio.map.spdf, region = "id")
mxmunicipio.map$region <- mxmunicipio.map$id
save(mxmunicipio.map,
  file = "data/mxmunicipio.map.RData",
  compress = "xz", version = 2
)

mxstate.topoJSON <- read_sf("data-raw/simpl2025/entidades.topojson")
mxstate.topoJSON$CVE_ENT <- mxstate.topoJSON$NOMGEO <- NULL
save(mxstate.topoJSON,
     file = "data/mxstate.topoJSON.RData",
     compress = "xz", version = 2
)

# mxstate.topoJSON <- readLines("data-raw/simpl2025/entidades.json") %>%
#   paste(collapse = "\n") %>%
#   fromJSON(simplifyVector = FALSE)
# #stopifnot(length(mxstate.topoJSON$objects$state) > 1)
# stopifnot(mxstate.topoJSON$objects$entidades$geometries[[32]]$properties[["id"]] == 32)
# save(mxstate.topoJSON,
#   file = "data/mxstate.topoJSON.RData",
#   compress = "xz", version = 2
# )

mxmunicipio.topoJSON <- read_sf("data-raw/simpl2025/municipios.json")
stopifnot(identical(names(mxmunicipio.topoJSON), c("id", "geometry")))
save(mxmunicipio.topoJSON,
     file = "data/mxmunicipio.topoJSON.RData",
     compress = "xz", version = 2
)

# mxmunicipio.topoJSON <- readLines("data-raw/simpl2025/municipios.json") %>%
#   paste(collapse = "\n") %>%
#   fromJSON(simplifyVector = FALSE)
# stopifnot(length(mxmunicipio.topoJSON$objects$municipios) > 1)
# save(mxmunicipio.topoJSON,
#   file = "data/mxmunicipio.topoJSON.RData",
#   compress = "xz", version = 2
# )
#
