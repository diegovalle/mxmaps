[![Travis-CI Build Status](https://travis-ci.org/diegovalle/mxmaps.svg?branch=master)](https://travis-ci.org/diegovalle/mxmaps)

Mexico Choropleths
======================


Based on the choroplethr pakage


```{r}
library(viridis)
library(devtools)
install_github('diegovalle/mxmapsData')
install_github('diegovalle/mxmaps')
library(mxmaps)

data(mxmunicipio.map)
df_mun = data.frame(region=unique(mxmunicipio.map$region),
                value=sample(as.numeric(unique(mxmunicipio.map$region))))
df_mun$region <- as.character(df_mun$region)
mxmunicipio_choropleth(df_mun, 
                       title = "Municipios",
                       legend = "random\nvalue",
                       num_colors = 1) +
  scale_fill_viridis()
  
data(mxstate.map)
df_state = data.frame(region=unique(mxstate.map$region),
                value=sample(as.numeric(unique(mxstate.map$region))))
df_state$region <- as.character(df_state$region)
mxstate_choropleth(df_state,
                       title = "States",
                       legend = "random\nvalue",
                       num_colors = 9)     
```
