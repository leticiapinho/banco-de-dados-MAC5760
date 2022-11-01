-- Table: ratings
-- DROP TABLE IF EXISTS ratings;

CREATE TABLE IF NOT EXISTS ratings
(
	tconst varchar(50),
    averageRating numeric,
    numVotes integer
);

SELECT * FROM ratings;

COPY ratings (tconst, averageRating, numVotes) FROM 'C:\Temp\ratings.tsv' DELIMITER E'\t' CSV HEADER;


SELECT * FROM ratings
LIMIT 10;