CREATE TABLE IF NOT EXISTS titlePrincipals
(
	tconst varchar(50),
	ordering integer,
	nconst varchar(50),
	category varchar,
    job varchar,
    characters varchar
);

COPY titlePrincipals (tconst, ordering, nconst, category, job, characters) FROM 'SQL_FILE' DELIMITER E'|' CSV HEADER;