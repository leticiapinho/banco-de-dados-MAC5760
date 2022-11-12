#!/usr/bin/env python3

from sys import argv
from os import path

_, tsv_dir, column, *__ = argv

valid_pks = None

with open(path.join(tsv_dir, 'title.basics.tsv')) as f:
    it = iter(f)
    columns = next(it).strip().split('|')

    idx = columns.index(column)

    valid_pks = {
        reg[idx]
        for reg in map(lambda x: x.split('|'), it)
    }

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
