CREATE TABLE IF NOT EXISTS nameBasics
(
	nconst varchar(50) NOT NULL,
	primaryName varchar(300),
	birthYear varchar,
	deathYear varchar,
        primaryProfession varchar(100),
        knownForTitles varchar(100),
	PRIMARY KEY (nconst) 
);

\copy nameBasics (nconst, primaryName, birthYear, deathYear, primaryProfession, knownForTitles) FROM 'SQL_FILE' DELIMITER E'|' CSV HEADER;

ALTER TABLE nameBasics DROP COLUMN primaryProfession;
ALTER TABLE nameBasics DROP COLUMN knownForTitles;
