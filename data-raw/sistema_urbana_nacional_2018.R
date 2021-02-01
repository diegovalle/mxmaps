library(mxmaps)
library(readr)
library(tidyverse)
library(stringr)


## files downloaded from https://www.gob.mx/conapo/documentos/sistema-urbano-nacional-2018
df <- read_csv("data-raw/Base_SUN_2018_municipios.csv",
               col_types = cols(
                 CVE_ENT = col_character(),
                 NOM_ENT = col_character(),
                 CVE_MUN = col_character(),
                 NOM_MUN = col_character(),
                 CVE_LOC = col_character(),
                 NOM_LOC = col_character(),
                 CVE_SUN = col_character(),
                 NOM_SUN = col_character(),
                 POB_2018 = col_integer()),
               locale = readr::locale(encoding = "windows-1252")) %>%
  mutate(type = str_sub(CVE_SUN, 1, 1)) %>%
  recode(df$type, M = " Zona metropolitana", C = "Conurbación",
         P = "Centro urbano")
