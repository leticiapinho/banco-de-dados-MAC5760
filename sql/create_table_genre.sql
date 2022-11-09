CREATE TABLE IF NOT EXISTS genre
(
    idgen varchar (50) NOT NULL,
    tconst (50),
    PRIMARY KEY (idgen)
);

\copy genre (idgen, tconst)  FROM 'SQL_FILE' DELIMITER E'|' CSV HEADER;
