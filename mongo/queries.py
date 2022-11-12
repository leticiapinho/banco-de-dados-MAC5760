#!/usr/bin/env python3

from pymongo import MongoClient, UpdateOne
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

if __name__ == '__main__':
    print(insert_1000_movies())
