CREATE TABLE IF NOT EXISTS genre
(
    idgen varchar (50) NOT NULL,
    tconst varchar (50)
);

\copy genre (idgen, tconst)  FROM 'SQL_FILE' DELIMITER E'|' CSV HEADER;
