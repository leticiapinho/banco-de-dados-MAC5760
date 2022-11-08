CREATE TABLE IF NOT EXISTS primaryProfessionID
(
	idprof varchar(50),
	profession varchar(150)
);

COPY primaryProfession (idprof, profession) FROM 'SQL_FILE' DELIMITER E'|' CSV HEADER;