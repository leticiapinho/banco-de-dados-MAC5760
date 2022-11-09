CREATE TABLE IF NOT EXISTS genreID
(
    idgen varchar (50) NOT NULL,
    genre varchar (50),
    PRIMARY KEY (idgen)
);

COPY genreID (idgen, genre) FROM 'SQL_FILE' DELIMITER E '|' CSV HEADER;
