#!/bin/bash

# Dowload TSV file from imbd, and extract them

TSV_DIR="$PWD/tsv"
BASE_URL="https://datasets.imdbws.com/"
TSV_FILES='title.basics.tsv title.ratings.tsv title.principals.tsv name.basics.tsv'
TCONST_REGEX='tt2[0-9]{7}'

[ "$(uname)" == Darwin ]
IS_MAC=$?

rm -f tsv/*

pushd "$TSV_DIR" > /dev/null || exit
for tsv_file in $TSV_FILES
do
    echo "downloading $tsv_file"
    wget "${BASE_URL}${tsv_file}.gz" -O "temp_file.tsv.gz"
    yes | gzip -d temp_file.tsv.gz

    # replace invalid characters
    if [ "$IS_MAC" -eq 0 ]; then
        # mac os needs a '' after -i
        sed -i '' -e "s/|/_/g" -e "s/\\\\N//g" -e 's/\t/|/g' -e "s/\"//g" temp_file.tsv
    else
        # linux (and wsl) doesn't need it
        sed -i -e "s/|/_/g" -e "s/\\\\N//g" -e 's/\t/|/g' -e "s/\"//g" temp_file.tsv
    fi;

    first_line="$(head -n1 temp_file.tsv)"

    echo "$first_line" > "$tsv_file"

    if [[ "$first_line" =~ ^tconst ]]; then
        grep -E "^${TCONST_REGEX}\|.*$" temp_file.tsv >> "$tsv_file"
        rm temp_file.tsv
    else
        mv temp_file.tsv "$tsv_file"
    fi
done
popd > /dev/null || exit

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
