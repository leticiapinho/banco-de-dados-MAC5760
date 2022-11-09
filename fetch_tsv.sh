#!/bin/bash

# Dowload TSV file from imbd, and extract them

TSV_DIR="$PWD/tsv"
BASE_URL="https://datasets.imdbws.com/"
TSV_FILES='title.basics.tsv title.ratings.tsv title.principals.tsv'

[ $(uname) == Darwin ]
IS_MAC=$?

for tsv_file in $TSV_FILES
do
    pushd "$TSV_DIR" > /dev/null
    echo "downloading $tsv_file"
    wget $BASE_URL$tsv_file.gz -O $tsv_file.gz
    gzip -d $tsv_file.gz

    # replace invalid characters
    if [ $IS_MAC -eq 0 ]; then
        # mac os needs a '' after -i
        sed -i '' -e "s/\\\\N//g" -e 's/\t/|/g' -e "s/\"//g" $tsv_file
    else
        # linux and wsl
        sed -i -e "s/\\\\N//g" -e 's/\t/|/g' -e "s/\"//g" $tsv_file
    fi;

    popd > /dev/null
done
