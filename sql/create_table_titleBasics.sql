CREATE TABLE IF NOT EXISTS titleBasics
(
	tconst varchar(50),
	titleType varchar(300),
	primaryTitle varchar(300),
	originalTitle varchar(200),
	isAdult boolean,
	startYear varchar,
	endYear varchar,
	runtimeMinutes numeric   
);

COPY titleBasics (tconst, titleType, primaryTitle, originalTitle, isAdult, startYear, endYear, runtimeMinutes) FROM 'SQL_FILE' DELIMITER E'|' CSV HEADER;