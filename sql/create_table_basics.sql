-- Table: basics
DROP TABLE IF EXISTS basics;
CREATE TABLE IF NOT EXISTS basics
(
	tconst varchar(50),
	titleType varchar(1000),
	primaryTitle varchar(1000),
	originalTitle varchar(1000),
	isAdult boolean,
	startYear varchar,
	endYear varchar,
	runtimeMinutes numeric,
	genres varchar(300)    
);

SELECT * FROM basics;

COPY basics (tconst, titleType, primaryTitle, originalTitle, isAdult, startYear, endYear, runtimeMinutes, genres) FROM 'SQL_FILE' DELIMITER E'|' CSV HEADER;
