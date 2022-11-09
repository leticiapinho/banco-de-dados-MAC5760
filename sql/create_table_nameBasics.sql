CREATE TABLE IF NOT EXISTS nameBasics
(
	nconst varchar(50) NOT NULL,
	primaryName varchar(100),
	birthYears varchar,
	deathYear varchar,
	PRIMARY KEY (nconst) 
);

\copy nameBasics (nconst, primaryName, birthYears, deathYear) FROM 'SQL_FILE' DELIMITER E'|' CSV HEADER;
