#!/usr/bin/env python3

import pymongo

from sys import argv
from os import path
from pymongo import MongoClient
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

with open(path.join(tsv_path, 'title.basics.tsv')) as f:
    file_iter = iter(f)
    next(file_iter)

    title_basics = db['title_basics']
    start_year = db['start_year']

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

            for (
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

        for year, movies in start_years_lists.items():
            start_year.update_one(
                {'_id': year},
                {'$push': {'movies': {'$each': movies}}}
            )
