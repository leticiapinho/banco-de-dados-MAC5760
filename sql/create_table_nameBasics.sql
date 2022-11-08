CREATE TABLE IF NOT EXISTS nameBasics
(
	nconst varchar(50),
	primaryName varchar(100),
	birthYears varchar,
	deathYear varchar 
);

COPY nameBasics (nconst, primaryName, birthYears, deathYear) FROM 'SQL_FILE' DELIMITER E'|' CSV HEADER;
