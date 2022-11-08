CREATE TABLE IF NOT EXISTS genreID
(
    idgen varchar,
    genre varchar (50)
);

COPY genreID (idgen, genre) FROM 'SQL_FILE' DELIMITER E '|' CSV HEADER;
