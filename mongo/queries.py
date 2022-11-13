#!/usr/bin/env python3

from pymongo import MongoClient, UpdateOne, DeleteOne
from time import time
from random import seed, randint, sample
from itertools import permutations
from pprint import pprint

MONGO_HOST = 'localhost'
MONGO_PORT = 27017
MONGO_DB = 'imdb'
BUF_SIZE = 32768

client = MongoClient(MONGO_HOST, MONGO_PORT)
db = client[MONGO_DB]
title_basics = db['title_basics']
name_basics = db['name_basics']
start_year = db['start_year']
birth_year = db['birth_year']

genres = [
    'Documentary',
    'Short',
    'Animation',
    'News',
    'Comedy',
    'Sport',
    'Fantasy',
    'Horror',
    'Action',
    'Drama',
    'Adventure',
    'Western',
    'Crime',
    'Family',
    'History',
    'Romance',
    'Sci-Fi',
    'War',
    'Biography',
    'Thriller',
    'Mystery',
    'Music',
    'Musical',
    'Film-Noir',
    'Game-Show',
    'Talk-Show',
    'Adult',
    'Reality-TV'
]

seed(2)

def insert_1000_movies():
    payload_title_basics = [
        {
            '_id': f'_tt{i}',
            'title_type': 'movie',
            'primary_title': ''.join(title),
            'original_title': ''.join(title),
            'is_adult': False,
            'start_year': randint(1890, 2022),
            'end_year': 2022,
            'runtime_minutes': 120,
            'genres': ', '.join(sample(genres, randint(1, 5))),
            'principals': []
        }
        for i, title in enumerate(permutations('abcdefgh'))
    ]

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

    start = time()
    title_basics.insert_many(payload_title_basics)
    start_year.bulk_write(payload_start_year)
    finish = time()

    return start, finish

def remove_before_1950_actors():
    birth_year_aggregate = [
        {
            '$match':
            {
                '_id':
                {
                    '$lt': 1950
                }
            }
        },

        {
            '$unwind':
            {
                'path': '$persons'
            }
        },

        {
            '$group':
            {
                '_id': None,
                'persons':
                {
                    '$addToSet': '$persons'
                }
            }
        },
    ]
    start = time()
    persons = [*birth_year.aggregate(birth_year_aggregate)][0]['persons']

    birth_year.delete_many({'_id': {'$lt': 1950}})

    name_basics.bulk_write(
        [
            DeleteOne({'_id': person})
            for person in persons
        ]
    )

    finish = time()

    return start, finish

def find_1000_actors_by_pk():
    pks = [person['_id'] for person in name_basics.find(limit=1000)]

    start = time()
    x = [*name_basics.find({'_id': {'$in': pks}})]
    finish = time()

    return start, finish

def find_actors_between_1940_1990_starting_with_d():
    birth_year_aggregate = [
        {
            '$match':
            {
                '_id':
                {
                    '$gt': 1940,
                    '$lt': 1990
                }
            }
        },

        {
            '$unwind':
            {
                'path': '$persons'
            }
        },

        {
            '$group':
            {
                '_id': None,
                'persons':
                {
                    '$addToSet': '$persons'
                }
            }
        },
        {
            '$lookup':
            {
                'from': 'name_basics',
                'localField': 'persons',
                'foreignField': '_id',
                'as': 'persons'
            }
        },
        {
            '$unwind':
            {
                'path': '$persons'
            }
        },
        {
            '$match':
            {
                'persons.primary_name':
                {
                    '$regex': '^[Dd]'
                }
            }
        }

    ]

    a = time()
    persons = [*birth_year.aggregate(birth_year_aggregate)]
    b = time()

    return a, b

def tom_hanks_tom_cruise():
    pass

def marlon_brando():
    payload = [
        {
            '$match':
            {
                'primary_name':
                {
                    '$eq': 'Marlon Brando'
                }
            }
        },

        {
            '$unwind':
            {
                'path': '$known_for_titles'
            }
        },

        {
            '$group':
            {
                '_id': None,
                'known_for_titles':
                {
                    '$addToSet': '$known_for_titles'
                }
            }
        },

        {
            '$lookup':
            {
                'from': 'title_basics',
                'localField': 'known_for_titles',
                'foreignField': '_id',
                'as': 'movies'
            }
        },

        {
            '$unwind':
            {
                'path': '$movies'
            }
        },

        {
            '$group':
            {
                '_id': None,
                'ratings':
                {
                    '$addToSet': '$movies.ratings'
                }
            }
        },

        {
            '$unwind':
            {
                'path': '$ratings'
            }
        },

        {
            '$group':
            {
                '_id': None,
                'avg':
                {
                    '$avg': '$ratings.averate_rating'
                }
            }
        }
    ]

    start = time()
    x = [*name_basics.aggregate(payload)]
    finish = time()

    return start, finish

if __name__ == '__main__':
    # title_basics.delete_many({})
    # start_year.delete_many({})


    # start_year.insert_many(
    #     {
    #         '_id': y,
    #         'movies': []
    #     }
    #     for y in range(1890, 2030)
    # )

    # print(insert_1000_movies())
    # print(remove_before_1950_actors())


    print(find_1000_actors_by_pk())
    print(find_actors_between_1940_1990_starting_with_d())
    print(marlon_brando())
