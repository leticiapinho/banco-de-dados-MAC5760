--Op. de busca com ChP (nconst) atores comece com b ou m --
SELECT primaryName
FROM nameBasics
WHERE primaryName like 'B%' or primaryName like 'M%';

--Op. de busca selecao composta atores nascidos entre 1940 e 1990 nome comece com C--
SELECT primaryName
FROM nameBasics
WHERE (birthYear >= '1940' AND birthYear <= '1990' AND primaryName like 'C%');

--Op. de consulta juncao nota filmes lancados entre 1990 e 2015 com atuacao do Tom Hanks--
SELECT DISTINCT averageRating, primaryTitle
FROM (titleRatings NATURAL JOIN titleBasics NATURAL JOIN knownForTitles NATURAL JOIN nameBasics)
WHERE startYear >= '1960' AND startYear <= '2015' AND primaryName LIKE 'Tom Hanks';

--Op. de alterar profissao miscellanious para outros--
UPDATE primaryProfessionID
SET profession = 'outros'
WHERE profession = 'miscellaneous';

--Op. de busca com agrupamento 10 testei com 2 filmes com mais avaliacoes que tenha Pamela Anderosn--
SELECT primaryTitle
FROM (titleRatings NATURAL JOIN titleBasics NATURAL JOIN knownForTitles NATURAL JOIN nameBasics)
WHERE primaryName LIKE 'Pamela Anderson'
ORDER BY numVotes DESC LIMIT 10;

--Op. de insercao de 1000 filmes sem elenco--
CREATE TABLE novos;
--\copy usa from '/Users/EDB1/Downloads/usa.csv' delimiter ',' csv header;

INSERT INTO titleBasics(primaryTitle)
SELECT nomefilme
FROM novos;
