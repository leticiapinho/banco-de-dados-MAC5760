CREATE TABLE IF NOT EXISTS writers
(
    tconst varchar (50) NOT NULL,
    nconst varchar (50)
);

\copy writers (tconst, nconst) FROM 'SQL_FILE' DELIMITER E'|' CSV HEADER;
