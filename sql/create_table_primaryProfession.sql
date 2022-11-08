CREATE TABLE IF NOT EXISTS primaryProfession
(
	idprof varchar(50),
	nconst varchar(50)
);

COPY primaryProfession (idprof, nconst) FROM 'SQL_FILE' DELIMITER E'|' CSV HEADER;