#!/bin/bash

# run this as root, i. e. sudo ./populate.sh

TSV_DIR="${PWD}/tsv"
SQL_DIR="${PWD}/sql"

POSTGRES_USER='postgres'
POSTGRES_DB='postgres'

function escape_path() {
    path=$1
    echo "$path" | sed "s/\//\\\\\//g"
}

function insert() {
    echo "Inserting $1"

    FILE="${TSV_DIR}/$1"
    SQL="${SQL_DIR}/$2"

    ESCAPED_FILE=$(escape_path "$FILE")
    sed "s/SQL_FILE/${ESCAPED_FILE}/" "$SQL" | psql -h localhost -U "$POSTGRES_USER" "$POSTGRES_DB"
}

psql -h localhost -U $POSTGRES_USER $POSTGRES_DB -f sql/clear.sql

insert title.basics.tsv create_table_titleBasics.sql
insert title.ratings.tsv create_table_titleRatings.sql
insert title.principals.tsv create_table_titlePrincipals.sql
insert name.basics.tsv create_table_nameBasics.sql

insert genre_id.tsv create_table_genreID.sql
insert genre.tsv create_table_genre.sql

insert directors.tsv create_table_directors.sql
insert writers.tsv create_table_writers.sql
insert known_for_titles.tsv create_table_knownForTitles.sql

insert primary_profession_id.tsv create_table_primaryProfessionID.sql
insert primary_profession.tsv create_table_primaryProfession.sql

psql -h localhost -U $POSTGRES_USER $POSTGRES_DB -f sql/add_foreign_key_constraints.sql
