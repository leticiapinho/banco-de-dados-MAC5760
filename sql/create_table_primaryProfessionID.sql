CREATE TABLE IF NOT EXISTS primaryProfessionID
(
	idprof varchar(50) NOT NULL,
	profession varchar(150),
	PRIMARY KEY (idprof)
);

COPY primaryProfession (idprof, profession) FROM 'SQL_FILE' DELIMITER E'|' CSV HEADER;