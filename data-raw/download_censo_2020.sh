#!/usr/bin/env bash
####################################################
# Make sure `rename` is available on your system
####################################################
# Exit on error, undefined and prevent pipeline errors,
# use '|| true' on commands that intentionally exit non-zero
set -euo pipefail
# The directory from which the script is running
readonly LOCALDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
readonly TARGET_DIR="$LOCALDIR/censo2020"
IFS=$'\n\t'

# index starts at zero and that's why there's and empty string at the beginning
declare -a states=("" "ags" "bc" "bcs" "camp" "coah" "col"
                   "chis" "chih" "cdmx" "dgo" "gto" "gro" "hgo" "jal"
                   "mex" "mich" "mor" "nay" "nl" "oax" "pue" "qro"
                   "qroo" "slp" "sin" "son" "tab" "tamps" "tlax" "ver"
                   "yuc" "zac");

# Download Censo 2020 shapefiles from https://www.inegi.org.mx/temas/mg/#Descargas
main() {
    local TEMP_DIR=$TMPDIR
    wget -O "$TEMP_DIR"/censo2020.zip -nc "https://www.inegi.org.mx/contenidos/productos//prod_serv/contenidos/espanol/bvinegi/productos/geografia/marcogeo/889463807469_s.zip" || true
    unzip -o "$TEMP_DIR"/censo2020.zip -d "$TEMP_DIR"/.zip
    for i in {1..32}
    do
        # The INEGI uses a leading zero for all one digit numbers
        if [ "$i" -lt 10 ]
        then
            FILENUM="0$i"
        else
            FILENUM="$i"
        fi
        mkdir -p "$TARGET_DIR/${states[$i]}"
        unzip -o "$TEMP_DIR"/.zip/$FILENUM*.zip -d "$TARGET_DIR/${states[$i]}"
        find "$TARGET_DIR"/${states[$i]}/conjunto_de_datos/"$FILENUM"ent.* -exec rename "s/[0-9]{2}ent/${states[$i]}_estatales/" {} \;
        find "$TARGET_DIR"/${states[$i]}/conjunto_de_datos/"$FILENUM"mun.* -exec rename "s/[0-9]{2}mun/${states[$i]}_municipales/" {} \;
        find "$TARGET_DIR"/${states[$i]}/conjunto_de_datos/"$FILENUM"ar.* -exec rename "s/[0-9]{2}ar/${states[$i]}_ageb_rural/" {} \;
        find "$TARGET_DIR"/${states[$i]}/conjunto_de_datos/"$FILENUM"l.* -exec rename "s/[0-9]{2}l/${states[$i]}_localidades_amanzanadas/" {} \;
        find "$TARGET_DIR"/${states[$i]}/conjunto_de_datos/"$FILENUM"lpr.* -exec rename "s/[0-9]{2}lpr/${states[$i]}_localidades_puntos_rurales/" {} \;
        find "$TARGET_DIR"/${states[$i]}/conjunto_de_datos/"$FILENUM"ti.* -exec rename "s/[0-9]{2}ti/${states[$i]}_territorio_insular/" {} \; || true
        find "$TARGET_DIR"/${states[$i]}/conjunto_de_datos/"$FILENUM"a.* -exec rename "s/[0-9]{2}a/${states[$i]}_ageb_urbanas/" {} \;
        find "$TARGET_DIR"/${states[$i]}/conjunto_de_datos/"$FILENUM"m.* -exec rename "s/[0-9]{2}m/${states[$i]}_manzanas/" {} \;
        find "$TARGET_DIR"/${states[$i]}/conjunto_de_datos/"$FILENUM"fm.* -exec rename "s/[0-9]{2}fm/${states[$i]}_frentes_de_manzana/" {} \;
        find "$TARGET_DIR"/${states[$i]}/conjunto_de_datos/"$FILENUM"e.* -exec rename "s/[0-9]{2}e/${states[$i]}_ejes_viales/" {} \;
        find "$TARGET_DIR"/${states[$i]}/conjunto_de_datos/"$FILENUM"cd.* -exec rename "s/[0-9]{2}cd/${states[$i]}_caserio_disperso/" {} \;
        find "$TARGET_DIR"/${states[$i]}/conjunto_de_datos/"$FILENUM"sia.* -exec rename "s/[0-9]{2}sia/${states[$i]}_servicios_area/" {} \;
        find "$TARGET_DIR"/${states[$i]}/conjunto_de_datos/"$FILENUM"sil.* -exec rename "s/[0-9]{2}sil/${states[$i]}_servicios_linea/" {} \;
        find "$TARGET_DIR"/${states[$i]}/conjunto_de_datos/"$FILENUM"sip.* -exec rename "s/[0-9]{2}sip/${states[$i]}_servicios_punto/" {} \;
        find "$TARGET_DIR"/${states[$i]}/conjunto_de_datos/"$FILENUM"pe.* -exec rename "s/[0-9]{2}pe/${states[$i]}_poligono_externo/" {} \;
        find "$TARGET_DIR"/${states[$i]}/conjunto_de_datos/"$FILENUM"pem.* -exec rename "s/[0-9]{2}pem/${states[$i]}_poligono_externo_manzana/" {} \;
    done
}

merge() {
    # Merge a bunch of shapefiles
    # The filename of the merged file
    local FILEOUT=$1
    # The names of the files to merge, you can change this to
    # "*entidad.shp" or "*eje_vial.shp", etc
    local FILTER=$2
    local PROJECTION="+proj=longlat +ellps=WGS84 +no_defs +towgs84=0,0,0"
    for i in $(find "$TARGET_DIR"  -name "$FILTER")
    do
        if [ -f "$FILEOUT" ]
        then
            echo "adding state $i to $FILEOUT"
            ogr2ogr -f 'ESRI Shapefile' -update -append "$FILEOUT" "$i" -nln "$(basename -s .shp $FILEOUT)"  -t_srs "$PROJECTION"
        else
            echo "startin merge..."
            echo "adding state $i to $FILEOUT"
            ogr2ogr -f 'ESRI Shapefile' "$FILEOUT" "$i"  -t_srs "$PROJECTION"
        fi
    done
}

main
merge municipios.shp "*municipales.shp"
merge estados.shp "*estatales.shp"
