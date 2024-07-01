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
