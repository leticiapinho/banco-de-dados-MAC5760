#!/usr/bin/env python3

import pymongo

from sys import argv
from os import path
from pymongo import MongoClient, UpdateOne
from pprint import pprint
from itertools import count

MONGO_HOST = 'localhost'
MONGO_PORT = 27017
MONGO_DB = 'imdb'
BUF_SIZE = 32768

_, tsv_path, *__ = argv

client = MongoClient(MONGO_HOST, MONGO_PORT)
db = client[MONGO_DB]

def chunks(iterator, size):
    buf = [None] * size

    for i, x in enumerate(iterator):
        j = i % size
        buf[j] = x

        if j == size - 1:
            buf_ = buf
            buf = [None] * size
            yield buf_

    buf = [*filter(None, buf)]
    if buf: yield buf

def insert_title_basics():
    with open(path.join(tsv_path, 'title.basics.tsv')) as f:
        file_iter = iter(f)
        next(file_iter)

        title_basics = db['title_basics']
        start_year = db['start_year']

        title_basics.delete_many({})
        start_year.delete_many({})

        start_year.insert_many(
            {
                '_id': y,
                'movies': []
            }
            for y in range(1890, 2030)
        )

        for chunk in chunks(file_iter, BUF_SIZE):
            chunk_registers = map(lambda x: x.split('|'), chunk)

            payload_title_basics = [
                {
                    '_id': tconst,
                    'title_type': title_type,
                    'primary_title': primary_title,
                    'original_title': original_title,
                    'is_adult': bool(is_adult == '1'),
                    'start_year': int(start_year or 0),
                    'end_year': int(end_year or 0),
                    'runtime_minutes': int(runtime_minutes or 0),
                    'genres': genres.strip().split(',')
                }

                for
                (
                    tconst,
                    title_type,
                    primary_title,
                    original_title,
                    is_adult,
                    start_year,
                    end_year,
                    runtime_minutes,
                    genres
                ) in chunk_registers
            ]

            title_basics.insert_many(payload_title_basics)

            start_years_lists = dict()

            for title in payload_title_basics:
                year = title['start_year']
                tconst = title['_id']

                start_years_lists[year] = start_years_lists.get(year, [])
                start_years_lists[year].append(tconst)

            payload_start_year = [
                UpdateOne(
                    {'_id': year},
                    {'$push': {'movies': {'$each': movies}}}
                )
                for year, movies in start_years_lists.items()
            ]

            start_year.bulk_write(payload_start_year)

            for year, movies in start_years_lists.items():
                start_year.update_one(
                    {'_id': year},
                    {'$push': {'movies': {'$each': movies}}}
                )

            del payload_title_basics
            del start_years_lists
            del chunk_registers

def insert_name_basics():
    with open(path.join(tsv_path, 'name.basics.tsv')) as f:
        file_iter = iter(f)
        next(file_iter)

        name_basics = db['name_basics']
        birth_year = db['birth_year']

        name_basics.delete_many({})
        birth_year.delete_many({})

        birth_year.insert_many(
            {
                '_id': y,
                'persons': []
            }
            for y in range(1800, 2030)
        )

        for chunk in chunks(file_iter, BUF_SIZE):
            chunk_registers = map(lambda x: x.split('|'), chunk)

            payload_name_basics = [
                {
                    '_id': nconst,
                    'primary_name': primary_name,
                    'birth_year': birth_year and int(birth_year),
                    'death_year': death_year and int(death_year),
                    'primary_profession': primary_profession.strip().split(','),
                    'known_for_titles': known_for_titles.strip().split(',')
                }
                for
                (
                    nconst,
                    primary_name,
                    birth_year,
                    death_year,
                    primary_profession,
                    known_for_titles
                ) in chunk_registers
            ]

            name_basics.insert_many(payload_name_basics)

            birth_years_lists = dict()

            for person in payload_name_basics:
                birth = person['birth_year']
                nconst = person['_id']

                birth_years_lists[birth] = birth_years_lists.get(birth, [])
                birth_years_lists[birth].append(nconst)

            payload_birth_year = [
                UpdateOne(
                    {'_id': year},
                    {'$push': {'persons': {'$each': persons}}}
                )
                for year, persons in birth_years_lists.items()
            ]

            birth_year.bulk_write(payload_birth_year)

            del payload_name_basics
            del birth_years_lists
            del chunk_registers

if __name__ == '__main__':
    insert_title_basics()
