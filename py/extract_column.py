#!/usr/bin/env python3

# uso
# python3 extract_column.py <input_file> <output_file> <key> <extracted>
#
# input_file: o arquivo de onde queremos extrair a coluna
# output_file: o arquivo para onde queremos extrair a coluna
# key: nome da coluna que é a chave primária do arquivo input_file
# extracted: nome da coluna que queremos extrair
# 
# exemplo:
#
# python3 extract_column.py name.basics.tsv known_for_titles.tsv nconst knownForTitles
#
# Extrai a coluna knownForTitles de name.basics.tsv, cuja chave primaria é
# nconst, e constroi o arquivo known_for_titles.tsv mapeando o valores de nconst
# para os valores de knownForTitle.


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

    for value in filter(None, values.split(SEP)):
        extracted_file.write(f'{key}{OFS}{value}\n')

input_file.close()
extracted_file.close()
