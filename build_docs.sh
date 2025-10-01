#!/usr/bin/env bash
# Exit on error, undefined and prevent pipeline errors,
# use '|| true' on commands that intentionally exit non-zero
set -euox pipefail
# The directory from which the script is running
readonly LOCALDIR="$( cd "." && pwd )"
IFS=$'\n\t'

main() {
	#Rscript -e "tryCatch({install.packages(c('RJSONIO', 'ggpubr', 'viridis', 'scales', 'sf', 'geojsonio','ggrepel', 'leaflet', 'jsonlite'), type = 'source');install.packages('V8', repos = 'http://cran.r-project.org'); remotes::install_github('r-lib/pkgdown')})"
	Rscript -e "rmarkdown::render('index.Rmd')"
	#Rscript -e "rmarkdown::render('README.Rmd')"
    Rscript -e "pkgdown::clean_site();pkgdown::build_site()"
    cp header.png docs/
    mv index_files/ docs/
}

main
