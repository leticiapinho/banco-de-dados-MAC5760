CREATE TABLE IF NOT EXISTS knownForTitles
(
	nconst varchar(50) NOT NULL,
	tconst varchar(50) NOT NULL,
	PRIMARY KEY (nconst)
);

\copy knownForTitles (nconst, tconst) FROM 'SQL_FILE' DELIMITER E'|' CSV HEADER;

DELETE FROM knownForTitles WHERE tconst NOT IN (SELECT tconst FROM titleBasics);
