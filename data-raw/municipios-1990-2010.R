df_mxmunicipio_1990_2010 <- read.csv("data-raw/censo/1990-2010.csv",
                                     fileEncoding = "windows-1252",
                      skip = 3)
names(df_mxmunicipio_1990_2010) <- c("region", "municipio_name", "sex", "pop1990",
                      "pop1995", "pop2000", "pop2005", "pop2010")
df_mxmunicipio_1990_2010 <- df_mxmunicipio_1990_2010[ ,1:8]
df_mxmunicipio_1990_2010 <- df_mxmunicipio_1990_2010 %>%
  filter(str_detect(region, "CONCATENAR", negate = TRUE)) %>%
  filter(municipio_name != "Total") %>%
  filter(municipio_name != "") %>%
  mutate(region = str_replace_all(region, " ", "")) %>%
  pivot_longer(pop1990:pop2010) %>%
  rename(year = name, pop = value) %>%
  mutate(pop = as.integer(str_replace_all(pop, ",", ""))) %>%
  mutate(year = as.integer(str_replace_all(year, "pop", ""))) %>%
  mutate(sex = str_replace_all(sex, c("Hombre" = "Male", "Mujer" = "Female"))) %>%
  select(region, municipio_name, year, sex, pop)


Encoding(df_mxmunicipio_1990_2010$municipio_name) <- "UTF-8"
save(df_mxmunicipio_1990_2010, file = "data/df_mxmunicipio_1990_2010.RData",
     compress = "xz", version = 2)


df_mxstate_1990_2010 <- read.csv("data-raw/censo/1990-2010.csv",
                                     fileEncoding = "windows-1252",
                                     skip = 3)
names(df_mxstate_1990_2010) <- c("region", "municipio_name", "sex", "pop1990",
                                     "pop1995", "pop2000", "pop2005", "pop2010")
df_mxstate_1990_2010 <- df_mxstate_1990_2010[ ,1:8]
df_mxstate_1990_2010 <- df_mxstate_1990_2010 %>%
  filter(str_detect(region, "CONCATENAR")) %>%
  filter(municipio_name != "") %>%
  mutate(region = str_replace_all(region, "=CONCATENAR\\([0 ]?,|\\)", "")) %>%
  mutate(region = str_replace_all(region, " ", "")) %>%
  pivot_longer(pop1990:pop2010) %>%
  rename(year = name, pop = value) %>%
  mutate(pop = as.integer(str_replace_all(pop, ",", ""))) %>%
  mutate(year = as.integer(str_replace_all(year, "pop", ""))) %>%
  mutate(sex = str_replace_all(sex, c("Hombre" = "Male", "Mujer" = "Female"))) %>%
  rename(state_name_official = municipio_name) %>%
  select(region, state_name_official, year, sex, pop)


Encoding(df_mxstate_1990_2010$state_name_official) <- "UTF-8"
save(df_mxstate_1990_2010, file = "data/df_mxstate_1990_2010.RData",
     compress = "xz", version = 2)



