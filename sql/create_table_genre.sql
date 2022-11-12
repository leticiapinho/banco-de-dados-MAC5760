CREATE TABLE IF NOT EXISTS genre
(
    idgen varchar (50) NOT NULL,
    tconst varchar (50),
    FOREIGN KEY (tconst) REFERENCES titleBasics(tconst)
);

\copy genre (idgen, tconst)  FROM 'SQL_FILE' DELIMITER E'|' CSV HEADER;
