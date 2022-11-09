CREATE TABLE IF NOT EXISTS knownForTitles
(
	nconst varchar(50) NOT NULL,
	tconst varchar(50) NOT NULL,
	PRIMARY KEY (nconst),
	FOREIGN KEY (tconst) REFERENCES titleBasics(tconst)
);

\copy knownForTitles (nconst, tconst) FROM 'SQL_FILE' DELIMITER E'|' CSV HEADER;
