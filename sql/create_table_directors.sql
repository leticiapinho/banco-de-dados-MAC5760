CREATE TABLE IF NOT EXISTS directors
(
    tconst varchar (50),
    nconst varchar (50)
);

COPY directors (tconst, nconst) FROM 'SQL_FILE' DELIMITER E '|' CSV HEADER;