CREATE TABLE IF NOT EXISTS titleRatings
(
	tconst varchar(50),
    averageRating numeric,
    numVotes integer
);

COPY titleRatings (tconst, averageRating, numVotes) FROM 'SQL_FILE' DELIMITER E'|' CSV HEADER;