CREATE TABLE IF NOT EXISTS primaryProfession
(
	nconst varchar(50) NOT NULL,
        idprof varchar(50) NOT NULL,
	PRIMARY KEY (idprof),
	FOREIGN KEY (nconst) REFERENCES nameBasics(nconst)
);

\copy primaryProfession (nconst, idprof) FROM 'SQL_FILE' DELIMITER E'|' CSV HEADER;
