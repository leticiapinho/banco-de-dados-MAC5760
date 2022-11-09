CREATE TABLE IF NOT EXISTS titlePrincipals
(
	tconst varchar(50) NOT NULL,
	ordering integer,
	nconst varchar(50),
	category varchar,
    job varchar,
    characters varchar,
	PRIMARY KEY (tconst),
	FOREIGN KEY (nconst) REFERENCES nameBasics(nconst)
);

\copy titlePrincipals (tconst, ordering, nconst, category, job, characters) FROM 'SQL_FILE' DELIMITER E'|' CSV HEADER;
