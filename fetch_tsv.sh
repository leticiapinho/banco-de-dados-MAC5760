#!/bin/bash

# Dowload TSV file from imbd, and extract them

TSV_DIR="$PWD/tsv"
BASE_URL="https://datasets.imdbws.com/"
TSV_FILES='title.basics.tsv title.ratings.tsv title.principals.tsv title.crew.tsv name.basics.tsv'

[ "$(uname)" == Darwin ]
IS_MAC=$?

rm -f tsv/*

for tsv_file in $TSV_FILES
do
    pushd "$TSV_DIR" > /dev/null || exit
    echo "downloading $tsv_file"
    wget "${BASE_URL}${tsv_file}.gz" -O "${tsv_file}.gz"
    gzip -d "${tsv_file}.gz"

    # replace invalid characters
    if [ "$IS_MAC" -eq 0 ]; then
        # mac os needs a '' after -i
        sed -i '' -e "s/|/_/g" -e "s/\\\\N//g" -e 's/\t/|/g' -e "s/\"//g" "$tsv_file"
    else
        # linux (and wsl) doesn't need it
        sed -i -e "s/|/_/g" -e "s/\\\\N//g" -e 's/\t/|/g' -e "s/\"//g" "$tsv_file"
    fi;

    popd > /dev/null || exit
done

# extract the arrays to new tsv files

# genre / genreID
python3 py/extract_column_with_constants.py \
        tsv/title.basics.tsv \
        tsv/genre.tsv \
        tsv/genre_id.tsv \
        tconst \
        genres \
        idgen \
        genre

# directors
python3 py/extract_column.py \
        tsv/title.crew.tsv \
        tsv/directors.tsv \
        tconst \
        directors

# writers
python3 py/extract_column.py \
        tsv/title.crew.tsv \
        tsv/writers.tsv \
        tconst \
        writers

# primary profession
python3 py/extract_column_with_constants.py \
        tsv/name.basics.tsv \
        tsv/primary_profession.tsv \
        tsv/primary_profession_id.tsv \
        nconst \
        primaryProfession \
        idprof \
        profession

# known for titles
python3 py/extract_column.py \
        tsv/name.basics.tsv \
        tsv/known_for_titles.tsv \
        nconst \
        knownForTitles
