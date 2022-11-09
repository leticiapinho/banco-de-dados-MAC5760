#!/usr/bin/env python3

from sys import argv

FS='|'
OFS='|'
SEP=','

_, input_file, output_file, key, extracted, *__ = argv

input_file = open(input_file)
extracted_file = open(output_file, 'w')

input_iterator = iter(input_file)
first_line = next(input_iterator)

columns = first_line.strip().split(FS)

key_column_i = columns.index(key)
extracted_column_i = columns.index(extracted)

extracted_file.write(f'{key}{OFS}{extracted}\n')

for line in input_iterator:
    fields = line.strip().split(FS)

    key = fields[key_column_i]
    values = fields[extracted_column_i]

    for value in (values.split(SEP) or ['']):
        extracted_file.write(f'{key}{OFS}{value}\n')

input_file.close()
extracted_file.close()
