CREATE TABLE IF NOT EXISTS knownForTitles
(
	nconst varchar(50),
	tconst varchar(50)
);

COPY knownForTitles (nconst, tconst) FROM 'SQL_FILE' DELIMITER E'|' CSV HEADER;