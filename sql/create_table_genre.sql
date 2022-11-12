CREATE TABLE IF NOT EXISTS genre
(
    tconst varchar (50),
    idgen varchar (50) NOT NULL,
    FOREIGN KEY (tconst) REFERENCES titleBasics(tconst)
);

\copy genre (tconst, idgen)  FROM 'SQL_FILE' DELIMITER E'|' CSV HEADER;
