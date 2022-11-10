#!/usr/bin/env python3

# uso
# python3 <input_file> <output_extracted_file> <output_id_file> <key> <extracted> <id_column> <name_column>
#
# input_file: o arquivo de onde queremos extrair a coluna
# output_extracted_file: o arquivo para onde queremos extrair a coluna
# output_id_file: o arquivo para onde será feito o mapeamento de id para nome
# key: nome da coluna que é a chave primária do arquivo input_file
# extracted: nome da coluna que quermos extrair do input_file
# <id_column>: nome da coluna em no ouput_id_file que vai conter os ids únicos dos valores
# <name_column>: nome da coluna em output_id_file que vai conter os valores
#
# exemplo:
#
# python3 extract_column_with_constants.py \
#         title.basics.tsv \
#         title_genres.tsv \
#         genres.tsv \
#         tconst \
#         genres \
#         idgen \
#         genre
#
# Constrói o arquivo genres.tsv, mapeando um id para cada valor único na coluna
# genres de title.basics.tsv.
#
# Também extrai a coluna genres de title.basics.tsv, cuja chave primaria é
# tconst, e constroi o arquivo title_genres.tsv, mapeando o valores de tconst
# para os ids correspondentes aos valores da coluna genres.

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
            id_ = types.setdefault(value, len(types))
            output_extracted_file.write(f'{key}{OFS}{id_}\n')
        else:
            output_extracted_file.write(f'{key}{OFS}\n')

output_constant_file.write(f'{id_column}{OFS}{name_column}\n')

for type_, id_ in types.items():
    output_constant_file.write(f'{id_}{OFS}{type_}\n')

input_file.close()
output_extracted_file.close()
output_constant_file.close()
