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
df = data.frame(region=unique(mxmunicipio.map$region),
                value=sample(as.numeric(unique(mxmunicipio.map$region))))
df$region <- as.character(df$region)
mxmunicipio_choropleth(df, num_colors = 1) +
  scale_fill_viridis()
```
