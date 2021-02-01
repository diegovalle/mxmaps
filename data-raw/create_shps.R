library(rgdal)
library(ggplot2)
library(rgeos)
library(choroplethr)
library(choroplethrMaps)
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

mxstate.map.spdf <- readOGR("data-raw/simpl/entidades.shp", "entidades")
head(mxstate.map.spdf@data)
mxstate.map.spdf@data$id <- as.character(mxstate.map.spdf@data$CVEGEO)
mxstate.map.spdf@data$CVEGEO <- NULL
#save(mxstate.map, file = "data/state.spdf.RData",
#     compress = "xz")
mxstate.map <- fortify(mxstate.map.spdf, region = "id")
mxstate.map$region <- mxstate.map$id
save(mxstate.map, file = "data/mxstate.map.RData",
     compress = "xz", version = 2)


mxmunicipio.map.spdf <- readOGR("data-raw/simpl/municipios.shp", "municipios")
head(mxmunicipio.map.spdf@data)
mxmunicipio.map.spdf@data$id <- as.character(mxmunicipio.map.spdf@data$CVEGEO)
mxmunicipio.map.spdf@data$CVEGEO <- NULL
#save(mxstate.map, file = "data/state.spdf.RData",
#     compress = "xz")
mxmunicipio.map <- fortify(mxmunicipio.map.spdf, region = "id")
mxmunicipio.map$region <- mxmunicipio.map$id
save(mxmunicipio.map, file = "data/mxmunicipio.map.RData",
     compress = "xz", version = 2)

