#!/bin/bash

# run this as root, i. e. sudo ./populate.sh

TSV_DIR=$PWD/tsv
SQL_DIR=$PWD/sql

POSTGRES_USER='postgres'
POSTGRES_DB='postgres'

TMP_FILE=`mktemp --suffix=.sql`
TMP_DIR=`mktemp -d`

function escape_path() {
    path=$1
    echo $path | sed "s/\//\\\\\//g"
}

sudo cp "$TSV_DIR/"* $TMP_DIR
sudo chown -R postgres:postgres $TMP_DIR

FILE="$TMP_DIR/title.basics.tsv"
ESCAPED_FILE=`escape_path $FILE`
sed "s/SQL_FILE/$ESCAPED_FILE/" sql/create_table_basics.sql > $TMP_FILE
psql -U $POSTGRES_USER $POSTGRES_DB -f $TMP_FILE

FILE="$TMP_DIR/title.ratings.tsv"
ESCAPED_FILE=`escape_path $FILE`
sed "s/SQL_FILE/$ESCAPED_FILE/" sql/create_table_ratings.sql > $TMP_FILE
psql -U $POSTGRES_USER $POSTGRES_DB -f $TMP_FILE

sudo rm $TMP_FILE
sudo rm -rf $TMP_DIR

