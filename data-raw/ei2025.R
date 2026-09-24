library(tidyverse)
library(mxmaps)

df_mxstate_2025 <- read.csv("data-raw/censo/2025.csv",
                            fileEncoding = "utf-8",
                            na.strings = c("NA", "MI")
)
df_mxstate_2025$PCN_POB_IND_M <- NULL
df_mxstate_2025$PCN_POB_IND_F <- NULL
df_mxstate_2025$PCN_POB_AFRO_M <- NULL
df_mxstate_2025$PCN_POB_AFRO_F <- NULL
df_mxstate_2025$CVEGEO <- NULL
df_mxstate_2025$CVE_MUN <- NULL
df_mxstate_2025$CVE_LOC <- NULL
df_mxstate_2025$ESTIMADOR <- NULL
df_mxstate_2025$NOM_LOC <- NULL
df_mxstate_2025$NOM_ENT <- NULL
df_mxstate_2025$year <- 2025
#df_mxstate_2025$NOM_MUN <- NULL

df_mxstate_2025 <- df_mxstate_2025 |>
  filter(NOM_MUN == "Total de la entidad") |>
  select(-NOM_MUN) |>
  rename(region = CVE_ENT,
         pop = POBTOT,
         pop_male = POBMAS,
         pop_female = POBFEM,
         afromexican = PCN_POB_AFRO,
         indigenous = PCN_POB_IND) |>
  mutate(region = str_mxstate(region)) |>
  left_join(df_mxstate[, c(1:5)], by = "region") |>
  select(region, state_name, state_name_official, state_abbr,
         state_abbr_official, year, pop, pop_male, pop_female,
         afromexican, indigenous)

Encoding(df_mxstate_2025$state_name) <- "UTF-8"
Encoding(df_mxstate_2025$state_name_official) <- "UTF-8"
Encoding(df_mxstate_2025$state_abbr_official) <- "UTF-8"
save(df_mxstate_2025,
     file = "data/df_mxstate_2025.RData",
     compress = "xz", version = 2
)

###########################


df_mxmunicipio_2025 <- read.csv("data-raw/censo/2025.csv",
                            fileEncoding = "utf-8",
                            na.strings = c("NA", "MI")
)
df_mxmunicipio_2025$PCN_POB_IND_M <- NULL
df_mxmunicipio_2025$PCN_POB_IND_F <- NULL
df_mxmunicipio_2025$PCN_POB_AFRO_M <- NULL
df_mxmunicipio_2025$PCN_POB_AFRO_F <- NULL
df_mxmunicipio_2025$CVEGEO <- NULL
#df_mxmunicipio_2025$CVE_MUN <- NULL
df_mxmunicipio_2025$CVE_LOC <- NULL
df_mxmunicipio_2025$ESTIMADOR <- NULL
df_mxmunicipio_2025$NOM_LOC <- NULL
#df_mxmunicipio_2025$NOM_ENT <- NULL
df_mxmunicipio_2025$year <- 2025

df_mxmunicipio_2025 <- df_mxmunicipio_2025 |>
  filter(!NOM_MUN %in% c("Total de la entidad", "Total del municipio",
                         "Total nacional")) |>
  mutate(region = str_mxmunicipio(CVE_ENT, CVE_MUN)) |>
  rename(state_code = CVE_ENT,
         municipio_code = CVE_MUN,
         state_name = NOM_ENT,
         municipio_name = NOM_MUN,
         pop = POBTOT,
         pop_male = POBMAS,
         pop_female = POBFEM,
         afromexican = PCN_POB_AFRO,
         indigenous = PCN_POB_IND) |>
  mutate(municipio_name =
           str_replace_all(municipio_name, fixed("*"), "")) |>
  left_join(df_mxmunicipio_2020[, c(3, 5:7)], by = "region") |>
  select("state_code", "municipio_code", "region", "state_name", "state_name_official",
         "state_abbr", "state_abbr_official", "municipio_name", "year",
         "pop", "pop_male", "pop_female", "afromexican", "indigenous")

zm <- read.csv("data-raw/metro/2020.csv") |>
  filter(tipo == "Zona metropolitana") |>
  mutate(region = str_mxmunicipio(clave_entidad, clave_municipio)) |>
  rename(metro_area = nombre) |>
  select(region, metro_area)

lats <- read.csv("data-raw/censo/AGEEML_2026910145484.csv.xz",
                 fileEncoding = "windows-1252") %>%
  arrange(CVE_LOC) %>%
  mutate(region = str_mxmunicipio(CVE_ENT, CVE_MUN)) %>%
  group_by(region) %>%
  slice(1) %>%
  select(region, LAT_DECIMAL, LONGITUD) %>%
  # for some reason lat and long are reversed
  rename(long = LAT_DECIMAL, lat = LONGITUD) %>%
  na.omit()

df_mxmunicipio_2025 <- left_join(df_mxmunicipio_2025, zm, by = "region")
df_mxmunicipio_2025 <- left_join(df_mxmunicipio_2025, lats, by = "region")


Encoding(df_mxmunicipio_2025$state_name) <- "UTF-8"
Encoding(df_mxmunicipio_2025$state_name_official) <- "UTF-8"
Encoding(df_mxmunicipio_2025$state_abbr_official) <- "UTF-8"
Encoding(df_mxmunicipio_2025$municipio_name) <- "UTF-8"
save(df_mxmunicipio_2025, file = "data/df_mxmunicipio_2025.RData", compress = "xz", version = 2)


# library(sf)
# df_sf <- st_as_sf(df_mxmunicipio_2025, coords = c("long", "lat"), crs = 4326)
#
# # 3. Plot your points
# ggplot() +
#   geom_sf(data = df_sf, color = "red", size = 3) +
#   theme_minimal()
