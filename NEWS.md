# mxmaps 2020.3.0

* Add options for showing a scale bar (provide a visual indication of distance 
  and feature size on the map) to `mxstate_choropleth` and 
  `mxmunicipio_choropleth` with the options: `scale_bar_position`, 
  `scale_bar_length`, `scale_bar_segments`, `scale_bar_height`, 
  `scale_bar_color`, and `scale_bar_text_color` 

```R
df_mxstate_2020$value <- df_mxstate_2020$pop
mxstate_choropleth(df_mxstate_2020,
  title = "Total population, by state",
  title_color = "#635147",
  scale_bar = TRUE,
  scale_bar_position = "bl",
  scale_bar_length = 1000,
  scale_bar_segments = 4
)
```
* Add options `background_color` `state_border_size` `state_border_color` to 
  `mxstate_choropleth`, `mxhexbin_choropleth`, and `mxmunicipio_choropleth`

```R
df_mxstate_2020$value <- df_mxstate_2020$pop
mxstate_choropleth(df_mxstate_2020,
  title = "Total population, by state",
  background_color = "#e3dac9",
  state_border_size=2,
  state_border_color="red"
)
```
* Add options `municipio_border_size` `municipio_border_color` to 
  `mxmunicipio_choropleth`

```R
df_mxmunicipio_2020$value <- df_mxmunicipio_2020$indigenous_language /
  df_mxmunicipio_2020$pop * 100
mxmunicipio_choropleth(df_mxmunicipio_2020,
  num_colors = 1,
  title = "Percentage of the population that speaks\nan indigenous language",
  scale_bar = TRUE,
  scale_bar_position = "bl",
  scale_bar_length = 1000,
  scale_bar_segments = 4,
  background_color = "#e3dac9",
  title_color = "#635147",
  municipio_border_color = "gold",
  municipio_border_size = 0.01,
  state_border_color = "red",
  state_border_size = .5,
  legend = "%"
)
```
* Add options`title_color`, `title_align`, and `title_position`  to 
  `mxstate_choropleth`, `mxhexbin_choropleth` and `mxmunicipio_choropleth`

```R
df_mxstate_2020$value <- df_mxstate_2020$pop
mxstate_choropleth(df_mxstate_2020,
  title = "Total population, by state",
  title_color = "green"
)
```

# mxmaps 2020.2.3

* Exlude images in man/figures by adding it to .Rbuildignore
* Update lifecycle badge to stable since maturing was deprecated from the lifecyle
package

# mxmaps 2020.2.2

* Rename Choroplet R6 class to Choropleth2 to avoid interfering with the 
choroplethr package
* Update documentation to use bootstrap 5

# mxmaps 2020.2.1

* Remove dependency on deprecated package choropletr
* Fix state labels in the state vignette

# mxmaps 2020.2.0

* Remove the functions that use the INEGI API since it doesn't work anymore and 
correct to a major release version

# mxmaps 2020.1.3

* Remove the functions that use the INEGI API since it doesn't work anymore

# mxmaps 2020.1.2

* Switches Universal Analytics to Google Analytics 4 in the pkgdown website
* Fixes the municipios examaples to use the df_mxmunicipio_2020 data.frame and
  avoid the missing municipios warning
* Adds `auto_contrast` option to `mxhexbin_choropleth`

# mxmaps 2020.1.1

## Bug fixes and improvements

* Fixes the zoom argument of `mxmunicipio_leaflet` and `mxstate_leaflet`
  so that municipios/states that aren't zoomed to are not shown on the map

# mxmaps 2020.1.0

## New feature

* New argument to `mxhexbin_choropleth` called shadow_color to add a 
  background shadow to the state abbreviation labels

# mxmaps 2020.0.0

## New features

* Maps are now based on those of the 2020 Mexican Census
* New data frames `df_mxmunicipio_2020` and `df_mxstate_2020` with population
  data from the 2020 Census
* New data.frames `df_mxmunicipio_1990_2010` and `df_mxstate_1990_2010` with
  population data from the 1990-2010 censuses and conteos
* Alias the `df_mxmunicipio` and `df_mxstate` data.frames to 
 `df_mxmunicipio_2015` and `df_mxstate_2015` to indicate the year their data is 
  from
* Changed the versioning scheme to include the year the shapefiles the maps are
  based on were published

# mxmaps 0.6.1

## New features

* Change the progress bar used when downloading from the INEGI API since
  `progress_estimated()` from the dplyr package was deprecated

# mxmaps 0.6.0

## New features

* Reintroduces `choropleth_inegi()` and `hexbin_inegi()` as they now work with the INEGI API v2

# mxmaps 0.5.5

## Bug fixes and improvements

* Removes all the functions that depend on inegiR


# mxmaps 0.5.4

## Bug fixes and improvements

* Adds mapproj to imports
* Removes INEGI API documentation since it doesn't work anymore

# mxmaps 0.5.3

## Bug fixes and improvements

* Require choroplethr 3.6.3 to fix a ggplot2 incompatibility

# mxmaps 0.5.2

## Bug fixes and improvements

* Require specific versions of ggplot and choroplethr to fix a bug when used with old versions

# mxmaps 0.5.1

## Bug fixes and improvements

* Better documentation
* pkgdown website [https://www.diegovalle.net/mxmaps/](https://www.diegovalle.net/mxmaps/)

# mxmaps 0.5.0

## New features

* latitude and longitude of the head locality of each municipio added to the df_mxmunicipio data.frame
