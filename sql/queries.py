#!/usr/bin/env python3

import psycopg2
from time import time
from random import seed, randint, sample
from itertools import permutations, takewhile
from pprint import pprint

seed(2)

connection = psycopg2.connect(
  user='postgres',
  password='postgres',
  host='localhost',
  port='',
  dbname='postgres'
)
connection.autocommit = True

cursor = connection.cursor()

def insert_1000_movies():
  sql_command = 'INSERT INTO titleBasics (tconst,titleType,primaryTitle,originalTitle,isAdult,startYear,endYear,runtimeMinutes) VALUES '
  values = ''

  for i in range(1000):
    values += f"('_tt{i}','movie','pTitle{i}','oTitle{i}',false,'2015','2016',{randint(15,120)}),"

  sql_command += values[:-1] + ';'

  start = time()
  cusor.execute(sql_command)
  results = cursor.fecthall()
  end = time()

  return start, end

def remove_before_1950_actors():
  sql_command = 'DELETE FROM nameBasics WHERE birthYear < "1950";'

  start = time()
  cusor.execute(sql_command)
  results = cursor.fecthall()
  end = time()

  return start, end

def find_1000_actors_by_pk():
  cursor.execute('SELECT nconst FROM nameBasics;')
  a = cursor.fetchall()
  b = random.sample(b, 1000)
  c = str(list(map(lambda v: v[0], b))).replace('[', '(').replace(']', ')')

  sql_command = f'SELECT * FROM nameBasics WHERE nconst IN {c};'

  start = time()
  cursor.execute(sql_command)
  results = cursor.fetchall()
  end = time()

  return start, end

def find_actors_between_1940_1990_starting_with_d():
  sql_command = 'SELECT * FROM nameBasics '
  sql_command += 'WHERE (birthYear >= "1940" AND birthYear <= "1990" AND (primaryName LIKE "D%" OR primaryName LIKE "d%"));'

  start = time()
  cursor.execute(sql_command)
  results = cursor.fetchall()
  end = time()

  return start, end

def tom_hanks_tom_cruise():
  sql_command = "SELECT DISTINCT averageRating, primaryTitle "
  sql_command += "FROM (titleRatings NATURAL JOIN titleBasics NATURAL JOIN knownForTitles NATURAL JOIN nameBasics) "
  sql_command += "WHERE startYear >= '1960' AND startYear <= '2015' AND (primaryName LIKE 'Tom Hanks' OR primaryName LIKE 'Tom Cruise');"

  start = time()
  cursor.execute(sql_command)
  results = cursor.fetchall()
  end = time()

  return start, end

def marlon_brando():
  sql_command = "SELECT avg(averageRating) FROM (titleRatings NATURAL JOIN knownForTitles NATURAL JOIN nameBasics) WHERE primaryName LIKE 'Marlon Brando';"

  start = time()
  cursor.execute(sql_command)
  results = cursor.fetchall()
  end = time()

  return start, end

