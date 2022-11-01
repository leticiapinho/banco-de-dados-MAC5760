-- Table: basics
DROP TABLE IF EXISTS basics;
CREATE TABLE IF NOT EXISTS basics
(
	tconst varchar(50),
	titleType varchar(200),
	primaryTitle varchar(200),
	originalTitle varchar(200),
	isAdult boolean,
	startYear varchar,
	endYear varchar,
	runtimeMinutes numeric,
	genres varchar(300)    
);

SELECT * FROM basics;

COPY basics (tconst, titleType, primaryTitle, originalTitle, isAdult, startYear, endYear, runtimeMinutes, genres) FROM 'C:\Temp\basics.tsv' DELIMITER E'\t' CSV HEADER;


SELECT * FROM basics
LIMIT 10;