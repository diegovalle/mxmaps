#!/usr/bin/env bash
# Exit on error, undefined and prevent pipeline errors,
# use '|| true' on commands that intentionally exit non-zero
set -euo pipefail
# The directory from which the script is running
readonly LOCALDIR="$( cd "." && pwd )"
IFS=$'\n\t'

main() {
	Rscript -e "rmarkdown::render('index.Rmd')"
    Rscript -e "pkgdown::clean_site();pkgdown::build_site()"
    cp header.png docs/
    mv index_files/ docs/
    
    local VAR=123
}

main
