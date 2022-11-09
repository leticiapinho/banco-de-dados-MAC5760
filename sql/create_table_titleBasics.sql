CREATE TABLE IF NOT EXISTS titleBasics
(
	tconst varchar(50) NOT NULL,
	titleType varchar(300),
	primaryTitle varchar(500),
	originalTitle varchar(500),
	isAdult boolean,
	startYear varchar,
	endYear varchar,
	runtimeMinutes numeric,
    genres varchar(1000),
	PRIMARY KEY (tconst)  
);

\copy titleBasics (tconst, titleType, primaryTitle, originalTitle, isAdult, startYear, endYear, runtimeMinutes, genres) FROM 'SQL_FILE' DELIMITER E'|' CSV HEADER;

ALTER TABLE titleBasics DROP COLUMN genres;
