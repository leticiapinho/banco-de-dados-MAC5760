#!/bin/bash

# run this as root, i. e. sudo ./populate.sh

TSV_DIR=$PWD/tsv
SQL_DIR=$PWD/sql

POSTGRES_USER='postgres'
POSTGRES_DB='postgres'

function escape_path() {
    path=$1
    echo $path | sed "s/\//\\\\\//g"
}

FILE="$TSV_DIR/title.basics.tsv"
ESCAPED_FILE=`escape_path $FILE`
sed "s/SQL_FILE/$ESCAPED_FILE/" sql/create_table_titleBasics.sql | psql -h localhost -U $POSTGRES_USER $POSTGRES_DB

FILE="$TSV_DIR/title.ratings.tsv"
ESCAPED_FILE=`escape_path $FILE`
sed "s/SQL_FILE/$ESCAPED_FILE/" sql/create_table_titleRatings.sql | psql -h localhost -U $POSTGRES_USER $POSTGRES_DB

FILE="$TSV_DIR/genre.tsv"
ESCAPED_FILE=`escape_path $FILE`
sed "s/SQL_FILE/$ESCAPED_FILE/" sql/create_table_genre.sql | psql -h localhost -U $POSTGRES_USER $POSTGRES_DB

FILE="$TSV_DIR/genre_id.tsv"
ESCAPED_FILE=`escape_path $FILE`
sed "s/SQL_FILE/$ESCAPED_FILE/" sql/create_table_genreID.sql | psql -h localhost -U $POSTGRES_USER $POSTGRES_DB
