CREATE TABLE IF NOT EXISTS writers
(
    tconst varchar (50),
    nconst varchar (50)
);

COPY writers (tconst, nconst) FROM 'SQL_FILE' DELIMITER E '|' CSV HEADER;