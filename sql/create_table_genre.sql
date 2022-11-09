CREATE TABLE IF NOT EXISTS genre
(
    idgen varchar (50) NOT NULL,
    tconst (50),
    PRIMARY KEY (idgen)
);

COPY genre (idgen, tconst)  FROM 'SQL_FILE' DELIMITER E'|' CSV HEADER;