CREATE TABLE IF NOT EXISTS genre
(
    idgen varchar,
    tconst (50)
);

COPY genre (idgen, tconst)  FROM 'SQL_FILE' DELIMITER E'|' CSV HEADER;