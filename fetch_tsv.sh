#!/bin/bash

# Dowload TSV file from imbd, and extract them

TSV_DIR="$PWD/tsv"
BASE_URL="https://datasets.imdbws.com/"
TSV_FILES='title.basics.tsv title.ratings.tsv title.principals.tsv name.basics.tsv'

[ "$(uname)" == Darwin ]
IS_MAC=$?

rm -f tsv/*

pushd "$TSV_DIR" > /dev/null || exit
for tsv_file in $TSV_FILES
do
    echo "downloading $tsv_file"
    wget "${BASE_URL}${tsv_file}.gz" -O "${tsv_file}.gz"
    yes | gzip -d "${tsv_file}.gz"

    # replace invalid characters
    if [ "$IS_MAC" -eq 0 ]; then
        # mac os needs a '' after -i
        sed -i '' -e "s/|/_/g" -e "s/\\\\N//g" -e 's/\t/|/g' -e "s/\"//g" "$tsv_file"
    else
        # linux (and wsl) doesn't need it
        sed -i -e "s/|/_/g" -e "s/\\\\N//g" -e 's/\t/|/g' -e "s/\"//g" "$tsv_file"
    fi;

done
popd > /dev/null || exit

# take a sample of the database
python3 py/sample_keys.py 1 < tsv/title.basics.tsv > tsv/tconst.tsv
python3 py/sample_keys.py 1 < tsv/name.basics.tsv > tsv/nconst.tsv

tmp_file=$(mktemp)
for tsv_file in title.basics.tsv title.ratings.tsv
do
    echo "reducing $tsv_file"
    python3 py/fix_keys.py tsv/tconst.tsv tconst < "$TSV_DIR/$tsv_file" > $tmp_file
    cp $tmp_file "$TSV_DIR/$tsv_file"
done

echo "reducing name.basics.tsv"
python3 py/fix_keys.py tsv/nconst.tsv nconst < "$TSV_DIR/name.basics.tsv" > $tmp_file
cp $tmp_file "$TSV_DIR/name.basics.tsv"

echo "reducing title.principals.tsv"
python3 py/fix_keys.py tsv/nconst.tsv nconst < "$TSV_DIR/title.principals.tsv" | python3 py/fix_keys.py tsv/tconst.tsv tconst > $tmp_file
cp $tmp_file "$TSV_DIR/title.principals.tsv"


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

# remove inconsistent registers

echo "reducing genre.tsv"
python3 py/fix_keys.py tsv/tconst.tsv tconst < "$TSV_DIR/genre.tsv" > $tmp_file
cp $tmp_file "$TSV_DIR/genre.tsv"

echo "reducing primary_profession.tsv"
python3 py/fix_keys.py tsv/nconst.tsv nconst < "$TSV_DIR/primary_profession.tsv" > $tmp_file
cp $tmp_file "$TSV_DIR/primary_profession.tsv"

echo "reducing known_for_titles.tsv"
python3 py/fix_keys.py tsv/nconst.tsv nconst < "$TSV_DIR/known_for_titles.tsv" | python3 py/fix_keys.py tsv/tconst.tsv knownForTitles > $tmp_file
cp $tmp_file "$TSV_DIR/known_for_titles.tsv"

rm $tmp_file
