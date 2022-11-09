#!/usr/bin/env python3

from sys import argv

FS='|'
OFS='|'
SEP=','

(
    _,
    input_file,
    output_extracted_file,
    output_constant_file,
    key,
    extracted,
    id_column,
    name_column,
    *__
) = argv

input_file = open(input_file)
output_extracted_file = open(output_extracted_file, 'w')
output_constant_file = open(output_constant_file, 'w')

input_iterator = iter(input_file)
first_line = next(input_iterator)

columns = first_line.strip().split(FS)

key_column_i = columns.index(key)
extracted_column_i = columns.index(extracted)

types = dict()

output_extracted_file.write(f'{key}{OFS}{extracted}\n')

for line in input_iterator:
    fields = line.strip().split(FS)

    key = fields[key_column_i]
    values = fields[extracted_column_i]

    for value in (values.split(SEP) or ['']):
        if value != '':
            types.setdefault(value, len(types))
            output_extracted_file.write(f'{key}{OFS}{value}\n')
        else:
            output_extracted_file.write(f'{key}{OFS}\n')

output_constant_file.write(f'{id_column}{OFS}{name_column}\n')

for type_, id_ in types.items():
    output_constant_file.write(f'{id_}{OFS}{type_}\n')

input_file.close()
output_extracted_file.close()
output_constant_file.close()
