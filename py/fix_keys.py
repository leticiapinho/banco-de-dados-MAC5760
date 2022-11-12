#!/usr/bin/env python3

from sys import argv
from os import path

_, key_file, column, *__ = argv

valid_pks = None

with open(key_file) as f:
    valid_pks = {line.strip() for line in f}

fst_line = input().strip()
columns = fst_line.split('|')

idx = columns.index(column)

print(fst_line)
while True:
    try:
        s = input().strip()
        reg = s.split('|')

        pk = reg[idx]

        if pk in valid_pks:
            print(s)
        
    except EOFError:
        break
