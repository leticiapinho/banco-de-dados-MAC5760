CREATE TABLE IF NOT EXISTS titleRatings
(
	tconst varchar(50) NOT NULL,
    averageRating numeric,
    numVotes integer,
    PRIMARY KEY (tconst)
);

COPY titleRatings (tconst, averageRating, numVotes) FROM 'SQL_FILE' DELIMITER E'|' CSV HEADER;