CREATE TABLE IF NOT EXISTS directors
(
    tconst varchar (50) NOT NULL,
    nconst varchar (50)
);

\copy directors (tconst, nconst) FROM 'SQL_FILE' DELIMITER E'|' CSV HEADER;
