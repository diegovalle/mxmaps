df_mxmunicipio_2020 <- read.csv("data-raw/censo/2020.csv", fileEncoding = "windows-1252",
                      skip = 3)
#December 2020 list of localidades
lats <- read.csv("data-raw/censo/AGEEML_20211271312276.csv.xz",
                 fileEncoding = "windows-1252") %>%
  arrange(cve_loc) %>%
  mutate(region = str_mxmunicipio(cve_ent, cve_mun)) %>%
  group_by(region) %>%
  slice(1) %>%
  select(region, lat_decimal, longitud) %>%
  rename(lat = lat_decimal, long = longitud) %>%
  na.omit()
names(df_mxmunicipio_2020) <- c("region", "municipio_name", "Total", "Male",
                      "Female")
df_mxmunicipio_2020 <- df_mxmunicipio_2020[ ,1:5]
df_mxmunicipio_2020 <- df_mxmunicipio_2020 %>%
  filter(str_detect(region, "CONCATENAR", negate = TRUE)) %>%
  filter(municipio_name != "Total") %>%
  filter(municipio_name != "") %>%
  mutate(region = str_replace_all(region, " ", "")) %>%
  pivot_longer(Total:Female) %>%
  rename(sex = name, population = value) %>%
  mutate(year = 2020) %>%
  mutate(population = as.integer(str_replace_all(population, ",", ""))) %>%
  left_join(lats, by = "region") %>%
  select(region, municipio_name, sex, year, lat, long, population) %>%
  arrange(region, year, sex) %>%
  pivot_wider(names_from = sex, values_from = population) %>%
  mutate(state_code = str_mxstate(floor(as.numeric(region) / 1000))) %>%
  mutate(municipio_code = str_pad(floor(as.numeric(region) %% 1000),
                                  3, "left", pad = "0")) %>%
  left_join(df_mxstate[, c("region", "state_name", "state_name_official",
                           "state_abbr",
                           "state_abbr_official")], by = c("state_code" = "region"))


afro <- read.csv("data-raw/censo/afro.csv", fileEncoding = "windows-1252", skip = 3)
names(afro) <- c("region", "municipio_name", "Total", "afromexican",
                 "nonafro", "NA", "em")
afro <- afro %>%
  filter(str_detect(region, "CONCATENAR", negate = TRUE)) %>%
  filter(municipio_name != "Total") %>%
  filter(municipio_name != "") %>%
  mutate(region = str_replace_all(region, " ", "")) %>%
  mutate(afromexican = as.numeric(str_replace_all(afromexican, ",", ""))) %>%
  mutate(afromexican = if_else(is.na(afromexican), 0, afromexican)) %>%
  mutate(afromexican = as.integer(afromexican)) %>%
  select(region, afromexican)

df_mxmunicipio_2020 <- left_join(df_mxmunicipio_2020, afro, by = "region")

ind <- read.csv("data-raw/censo/indi.csv", fileEncoding = "windows-1252", skip = 3)
names(ind) <- c("region", "municipio_name", "Total", "indigenous_language",
                "NonAfro", "NA", "em")
ind <- ind %>%
  filter(str_detect(region, "CONCATENAR", negate = TRUE)) %>%
  filter(municipio_name != "Total") %>%
  filter(municipio_name != "") %>%
  mutate(region = str_replace_all(region, " ", ""))  %>%
  mutate(indigenous_language =
           as.numeric(str_replace_all(indigenous_language, ",", ""))) %>%
  mutate(indigenous_language = if_else(is.na(indigenous_language), 0,
                                       indigenous_language)) %>%
  mutate(indigenous_language = as.integer(indigenous_language)) %>%
  select(region, indigenous_language)

df_mxmunicipio_2020 <- left_join(df_mxmunicipio_2020, ind, by = "region")

stopifnot(sum(df_mxmunicipio_2020$Total) == 126014024)
stopifnot(nrow(df_mxmunicipio_2020) == nrow(lats))

df_mxmunicipio_2020 <- df_mxmunicipio_2020 %>%
  rename(pop = Total, pop_male = Male, pop_female = Female) %>%
  select(state_code, municipio_code, region, state_name, state_name_official,
         state_abbr, state_abbr_official, municipio_name, year, pop,
         pop_male, pop_female, afromexican,
         indigenous_language, long, lat)%>%
  mutate(state_name_official = str_replace(state_name_official,
                                           "Distrito Federal",
                                           "Ciudad de México")) %>%
  mutate(state_abbr_official = str_replace(state_abbr_official,
                                           "DF",
                                           "CDMX"))

save(df_mxmunicipio_2020, file = "data/df_mxmunicipio_2020.RData",
     compress = "xz", version = 2)
