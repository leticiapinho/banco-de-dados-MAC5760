## Repositório para desenvolvimento do Projeto: Avaliacão de Desempenho de Bancos de Dados

### Ambiente

#### Modelo Relacional
SGBD: PostgreSQL
PostgreSQL Version: 14.5
Download em: https://www.postgresql.org/

#### Modelo Não Relacional
SGBD: MongoDB 6.0.2

#### Máquina
- OS: Manjaro Linux
- CPU: Intel Core i5-2320, 4 cores
- RAM: 8GB DDR3
- SSD: KINGSTON SA400S3, 438GB
- FS: ext4

### Dados utilizados - Bases do IMDb

Fonte para download dos datasets: https://datasets.imdbws.com/

#### Modelagem do Banco
https://drive.google.com/file/d/1rulzfgW2jZFhm0yDkpzMd0wRiV2wmEOM/view?usp=sharing

#### Modelo de relatório
https://docs.google.com/document/d/1yVv-ferbsFldos_-aGuokpbWDEqwhp9BiPoEi6JghIg/edit?usp=sharing

### Execução

#### Dependências

- `psql`
- `pymongo`
- `wget`

Arch/Manjaro:
~~~bash
sudo pacman -S postgresql-client python-pymongo wget
~~~

Debian/Ubuntu/Mint/WSL com Debian:
~~~bash
sudo apt install postgresql-client python3-pymongo wget
~~~

Mac OS (supondo `brew` e `pip3` instalados):
~~~bash
brew install postgres-client
pip3 install pymongo
~~~

#### SGBDs

É necessário que seja possível conectar aos bancos nas seguintes portas:

Postgres: localhost:5432
Mongo: localhost:27017

No caso do Postgres, é necessário ter um usuário do SGBD com o nome `postgres` e
um banco de dados também de nome `postgres`.

#### Instruções para a execução dos scripts/programas criados

A partir da raiz do repositório, execute:

1. Para download e limpeza de dados: `./fetch_tsv.sh`
2. Para população do banco relacional: `./populate_postgres.sh`
3. Para população do banco NoSQL: `./populate_mongo.sh`
