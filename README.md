Mexico Choropleths
================
Diego Valle-Jones
June 03, 2020

  - [What does it do?](#what-does-it-do)
  - [Installation](#installation)
  - [Quick Example](#quick-example)
  - [Municipios](#municipios)

Master: [![Travis-CI Build
Status](https://travis-ci.org/diegovalle/mxmaps.svg?branch=master)](https://travis-ci.org/diegovalle/mxmaps)
[![Coverage
Status](https://coveralls.io/repos/github/diegovalle/mxmaps/badge.svg?branch=master)](https://coveralls.io/github/diegovalle/mxmaps?branch=master)

|              |                                                                    |
| ------------ | ------------------------------------------------------------------ |
| **Author:**  | Diego Valle-Jones                                                  |
| **License:** | [BSD\_3](https://opensource.org/licenses/BSD-3-Clause)             |
| **Website:** | <https://www.diegovalle.net/mxmaps/>                               |
| **Forum:**   | [https://groups.google.com/forum/\#\!forum/mxmaps](Google%20Group) |

## What does it do?

This package is based on
[choroplethr](https://cran.r-project.org/web/packages/choroplethr/index.html)
and can be used to easily create maps of Mexico at both the state and
municipio levels. It also includes functions to create interactive maps
using the leaflet package, map INEGI data from its
[API](https://cran.r-project.org/web/packages/inegiR/inegiR.pdf), and
format strings so they match the INEGI state and municipio codes. Be
sure to visit the [official
website](https://www.diegovalle.net/mxmaps/).

## Installation

For the moment this package is only available from github. For the
development version:

``` r
if (!require(devtools)) {
    install.packages("devtools")
}
devtools::install_github('diegovalle/mxmaps')
```

## Quick Example

``` r
library(mxmaps)

data("df_mxstate")
df_mxstate$value <- df_mxstate$pop
mxstate_choropleth(df_mxstate,
                    title = "Total population, by state") 
```

![](README_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

\#\#Data

The data.frame that you provide to the plotting functions must have one
column named “region” and one column named “value”. The entries for
“region” must match the INEGI codes for states (“01”, “02”, etc) and
municipios (“01001”, “01002”, etc) either as a string with or without a
leading “0” or as numerics. The functions `str_mxstate` and
`str_mxmunicipio` are provided to easily format codes to the INEGI
specification. Also, two example data.frames, `df_mxstate` and
`df_mxmunicipio`, are provided with demographic variables from the
Encuesta Intercensal 2015.

``` r
data("df_mxstate")
knitr::kable(head(df_mxstate))
```

| region | state\_name         | state\_name\_official | state\_abbr | state\_abbr\_official |     pop | pop\_male | pop\_female | afromexican | part\_afromexican | indigenous | part\_indigenous |
| :----- | :------------------ | :-------------------- | :---------- | :-------------------- | ------: | --------: | ----------: | ----------: | ----------------: | ---------: | ---------------: |
| 01     | Aguascalientes      | Aguascalientes        | AGS         | Ags.                  | 1312544 |    640091 |      672453 |         653 |              4559 |     153395 |            18716 |
| 02     | Baja California     | Baja California       | BC          | BC                    | 3315766 |   1650341 |     1665425 |        7445 |             10432 |     283055 |            38391 |
| 03     | Baja California Sur | Baja California Sur   | BCS         | BCS                   |  712029 |    359137 |      352892 |       11032 |              5132 |     103034 |            11728 |
| 04     | Campeche            | Campeche              | CAMP        | Camp.                 |  899931 |    441276 |      458655 |        3554 |              6833 |     400811 |            13140 |
| 05     | Coahuila            | Coahuila de Zaragoza  | COAH        | Coah.                 | 2954915 |   1462612 |     1492303 |        2761 |              8137 |     204890 |            28588 |
| 06     | Colima              | Colima                | COL         | Col.                  |  711235 |    350791 |      360444 |         762 |              3314 |     145297 |            12373 |

``` r
data("df_mxmunicipio")
knitr::kable(head(df_mxmunicipio))
```

| state\_code | municipio\_code | region | state\_name    | state\_name\_official | state\_abbr | state\_abbr\_official | municipio\_name     |    pop | pop\_male | pop\_female | afromexican | part\_afromexican | indigenous | part\_indigenous | metro\_area    |       long |      lat |
| :---------- | :-------------- | :----- | :------------- | :-------------------- | :---------- | :-------------------- | :------------------ | -----: | --------: | ----------: | ----------: | ----------------: | ---------: | ---------------: | :------------- | ---------: | -------: |
| 01          | 001             | 01001  | Aguascalientes | Aguascalientes        | AGS         | Ags.                  | Aguascalientes      | 877190 |    425731 |      451459 |         532 |              2791 |     104125 |            14209 | Aguascalientes | \-102.2960 | 21.87982 |
| 01          | 002             | 01002  | Aguascalientes | Aguascalientes        | AGS         | Ags.                  | Asientos            |  46464 |     22745 |       23719 |           3 |               130 |       1691 |               92 | NA             | \-102.0893 | 22.23832 |
| 01          | 003             | 01003  | Aguascalientes | Aguascalientes        | AGS         | Ags.                  | Calvillo            |  56048 |     27298 |       28750 |          10 |               167 |       7358 |             2223 | NA             | \-102.7188 | 21.84691 |
| 01          | 004             | 01004  | Aguascalientes | Aguascalientes        | AGS         | Ags.                  | Cosío               |  15577 |      7552 |        8025 |           0 |                67 |       2213 |              191 | NA             | \-102.3000 | 22.36641 |
| 01          | 005             | 01005  | Aguascalientes | Aguascalientes        | AGS         | Ags.                  | Jesús María         | 120405 |     60135 |       60270 |          32 |               219 |       8679 |              649 | Aguascalientes | \-102.3434 | 21.96127 |
| 01          | 006             | 01006  | Aguascalientes | Aguascalientes        | AGS         | Ags.                  | Pabellón de Arteaga |  46473 |     22490 |       23983 |           3 |                74 |       6232 |              251 | NA             | \-102.2765 | 22.14920 |

## Municipios

Here’s another example showing Mexican municipios (similar to counties):

``` r
data("df_mxmunicipio")
df_mxmunicipio$value <-  df_mxmunicipio$indigenous / df_mxmunicipio$pop 
mxmunicipio_choropleth(df_mxmunicipio, num_colors = 1,
                       title = "Percentage of the population that self-identifies as indigenous")
```

![](README_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->
