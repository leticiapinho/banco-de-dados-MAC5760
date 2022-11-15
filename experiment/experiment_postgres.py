#!/usr/bin/env python3

import postgres_queries
from time import sleep

queries = [
    postgres_queries.insert_1000_movies,
    # postgres_queries.remove_before_1950_actors,
    postgres_queries.change_birth,
    postgres_queries.find_1000_actors_by_pk,
    postgres_queries.find_actors_between_1940_1990_starting_with_d,
    postgres_queries.tom_hanks_tom_cruise,
    postgres_queries.marlon_brando
]

results = []

for query in queries:
    result = query()
    results.append(result)
    sleep(2)

for result in results:
    print(*result, sep=',')
