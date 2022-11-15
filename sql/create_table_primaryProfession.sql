CREATE TABLE IF NOT EXISTS primaryProfession
(
	nconst varchar(50) NOT NULL,
        idprof varchar(50) NOT NULL,
	FOREIGN KEY (nconst) REFERENCES nameBasics(nconst) ON DELETE CASCADE
);

\copy primaryProfession (nconst, idprof) FROM 'SQL_FILE' DELIMITER E'|' CSV HEADER;
