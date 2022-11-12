#!/usr/bin/env python3

from sys import argv
from random import randint, seed

_, divider, *__ = argv

divider = int(divider)

seed(1)

input()

while True:
    try:
        if randint(0, divider - 1) == 0:
            print(input().strip().split('|')[0])
        else:
            input()

    except EOFError:
        break
