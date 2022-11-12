CREATE TABLE IF NOT EXISTS titleRatings
(
    tconst varchar(50) NOT NULL,
    averageRating numeric NOT NULL,
    numVotes integer,
    PRIMARY KEY (tconst),
    FOREIGN KEY (tconst) REFERENCES titleBasics(tconst)
);

\copy titleRatings (tconst, averageRating, numVotes) FROM 'SQL_FILE' DELIMITER E'|' CSV HEADER;
