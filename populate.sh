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

function insert() {
    echo "Inserting $1"

    FILE="$TSV_DIR/$1"
    SQL="$SQL_DIR/$2"

    ESCAPED_FILE=`escape_path $FILE`
    sed "s/SQL_FILE/$ESCAPED_FILE/" $SQL | psql -h localhost -U $POSTGRES_USER $POSTGRES_DB
}

insert title.basics.tsv create_table_titleBasics.sql
insert title.ratings.tsv create_table_titleRatings.sql
insert genre.tsv create_table_genre.sql
insert genre_id.tsv create_table_genreID.sql
insert directors.tsv create_table_directors.sql
insert writers.tsv create_table_writers.sql
