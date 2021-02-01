df_mxstate$year <- 2015
df_mxstate <- df_mxstate %>%
  select(region, state_name, state_name_official, state_abbr,
         state_abbr_official, year, pop, pop_male, pop_female, afromexican,
         part_afromexican, indigenous, part_indigenous)
save(df_mxstate, file = "data/df_mxstate.RData",
     compress = "xz", version = 2)

df_mxstate_2015 <- df_mxstate
save(df_mxstate_2015, file = "data/df_mxstate_2015.RData",
     compress = "xz", version = 2)

df_mxmunicipio$year <- 2015
df_mxmunicipio <- df_mxmunicipio %>%
  select(state_code, municipio_code, region, state_name, state_name_official,
         state_abbr, state_abbr_official, municipio_name, year, pop,
         pop_male, pop_female, afromexican, part_afromexican,
         indigenous, part_indigenous, metro_area, long, lat)
save(df_mxmunicipio, file = "data/df_mxmunicipio.RData",
     compress = "xz", version = 2)

df_mxmunicipio_2015 <- df_mxmunicipio
save(df_mxmunicipio_2015, file = "data/df_mxmunicipio_2015.RData",
     compress = "xz", version = 2)

