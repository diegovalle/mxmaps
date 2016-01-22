[![Travis-CI Build Status](https://travis-ci.org/diegovalle/mxmaps.svg?branch=master)](https://travis-ci.org/diegovalle/mxmaps) [![Coverage Status](https://coveralls.io/repos/github/diegovalle/mxmaps/badge.svg?branch=master)](https://coveralls.io/github/diegovalle/mxmaps?branch=master)

__Author:__ Diego Valle-Jones<br/>
__License:__ [BSD_3](https://opensource.org/licenses/BSD-3-Clause)<br/>
__Status:__ alpha

Mexico Choropleths
======================

### Installation

For the development version:

    library(devtools)
    install_github(c('diegovalle/mxmapsData', 'diegovalle/mxmaps'))

Based on the choroplethr pakage

### Quick Example

```r
library(mxmaps)
df_mxstate$value <- df_mxstate$afromexican / df_mxstate$pop
mxhexbin_choropleth(df_mxstate, 
                    num_colors = 1,
                    title = "Percentage of the population that is Afro-Mexican") 
```
