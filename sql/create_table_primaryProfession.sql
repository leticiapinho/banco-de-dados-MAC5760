CREATE TABLE IF NOT EXISTS primaryProfession
(
	idprof varchar(50) NOT NULL,
	nconst varchar(50) NOT NULL,
	PRIMARY KEY (idprof),
	FOREIGN KEY (nconst) REFERENCES nameBasics(nconst)
);

\copy primaryProfession (idprof, nconst) FROM 'SQL_FILE' DELIMITER E'|' CSV HEADER;
