#!/usr/bin/env python3

import mongo_queries
from time import sleep

queries = [
    mongo_queries.insert_1000_movies,
    # mongo_queries.remove_before_1950_actors,
    mongo_queries.change_birth,
    mongo_queries.find_1000_actors_by_pk,
    mongo_queries.find_actors_between_1940_1990_starting_with_d,
    mongo_queries.tom_hanks_tom_cruise,
    mongo_queries.marlon_brando
]

results = []

for query in queries:
    result = query()
    results.append(result)
    sleep(2)

for result in results:
    print(*result, sep=',')
