CREATE TABLE IF NOT EXISTS primaryProfession
(
	nconst varchar(50) NOT NULL,
        idprof varchar(50) NOT NULL,
	PRIMARY KEY (idprof)
);

\copy primaryProfession (nconst, idprof) FROM 'SQL_FILE' DELIMITER E'|' CSV HEADER;

DELETE FROM primaryProfession WHERE nconst NOT IN (SELECT nconst FROM nameBasics);
