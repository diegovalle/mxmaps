df_mxstate_2020 <- read.csv("data-raw/censo/2020.csv", fileEncoding = "windows-1252",
                                skip = 3)
names(df_mxstate_2020) <-  c("region", "state_name_official", "Total", "Male",
                             "Female")
df_mxstate_2020 <- df_mxstate_2020[ ,1:5]
df_mxstate_2020 <- df_mxstate_2020 %>%
  filter(str_detect(region, "CONCATENAR")) %>%
  filter(state_name_official != "") %>%
  mutate(region = str_replace_all(region, "=CONCATENAR\\([0 ]?,|\\)", "")) %>%
  mutate(region = str_replace_all(region, " ", "")) %>%
  rename(pop = Total, pop_male = Male, pop_female = Female) %>%
  mutate(pop = as.integer(str_replace_all(pop, ",", ""))) %>%
  mutate(pop_male = as.integer(str_replace_all(pop_male, ",", ""))) %>%
  mutate(pop_female = as.integer(str_replace_all(pop_female, ",", "")))


afro <- read.csv("data-raw/censo/afro.csv", fileEncoding = "windows-1252", skip = 3)
names(afro) <- c("region", "municipio_name", "Total", "afromexican",
                 "nonafro", "NA", "em")
afro <- afro %>%
  filter(str_detect(region, "CONCATENAR")) %>%
  filter(municipio_name != "") %>%
  mutate(region = str_replace_all(region, "=CONCATENAR\\([0 ]?,|\\)", "")) %>%
  mutate(region = str_replace_all(region, " ", "")) %>%
  select(region, afromexican) %>%
  mutate(afromexican = as.numeric(str_replace_all(afromexican, ",", ""))) %>%
  mutate(afromexican = if_else(is.na(afromexican), 0, afromexican)) %>%
  mutate(afromexican = as.integer(afromexican))


ind <- read.csv("data-raw/censo/indi.csv", fileEncoding = "windows-1252", skip = 3)
names(ind) <- c("region", "municipio_name", "Total", "indigenous_language",
                "NonAfro", "NA", "em")
ind <- ind %>%
  filter(str_detect(region, "CONCATENAR")) %>%
  filter(municipio_name != "") %>%
  mutate(region = str_replace_all(region, "=CONCATENAR\\([0 ]?,|\\)", "")) %>%
  mutate(region = str_replace_all(region, " ", "")) %>%
  select(region, indigenous_language) %>%
  mutate(indigenous_language =
           as.numeric(str_replace_all(indigenous_language, ",", ""))) %>%
  mutate(indigenous_language = if_else(is.na(indigenous_language), 0,
                                       indigenous_language)) %>%
  mutate(indigenous_language = as.integer(indigenous_language))

df_mxstate_2020 <- df_mxstate_2020 %>%
  left_join(ind, by ="region") %>%
  left_join(afro, by = "region") %>%
  left_join(df_mxstate[ , c(1:2, 4:5)], by = "region") %>%
  mutate(year = 2020) %>%
  select(region, state_name, state_name_official, state_abbr,
         state_abbr_official, year, pop, pop_male, pop_female,
         afromexican, indigenous_language) %>%
  mutate(state_name_official = str_replace(state_name_official,
                                           "Distrito Federal",
                                           "Ciudad de México")) %>%
  mutate(state_abbr_official = str_replace(state_abbr_official,
                                           "DF",
                                           "CDMX")) %>%
save(df_mxstate_2020, file = "data/df_mxstate_2020.RData",
     compress = "xz", version = 2)
