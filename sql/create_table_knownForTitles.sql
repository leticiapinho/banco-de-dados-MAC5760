CREATE TABLE IF NOT EXISTS knownForTitles
(
	nconst varchar(50) NOT NULL,
	tconst varchar(50) NOT NULL
);

\copy knownForTitles (nconst, tconst) FROM 'SQL_FILE' DELIMITER E'|' CSV HEADER;
