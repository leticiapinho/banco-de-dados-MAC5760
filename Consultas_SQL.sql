--Op. de insercao de 1000 filmes sem elenco--
--CREATE TABLE titulos
--\copy usa from '/Users/EDB1/Downloads/usa.csv' delimiter ',' csv header;
INSERT INTO titleBasics(primaryTitle) 
SELECT 
	titulos
FROM novos

--Op. de alterar profissao miscellanious para outros--
UPDATE profession
SET profession = 'outros'
WHERE profession = 'miscellanious'

--Op. de busca com ChP (nconst) atores comece com b ou m --
SELECT primaryName
FROM nameBasics
WHERE primaryName like 'B%' or primaryName like 'M%' 

--Op. de busca selecao composta atores nascidos entre 1940 e 1990 nome comece com C--
SELECT primaryName
FROM nameBasics 
WHERE (birthYears >= 1940 AND birthYeras <= 1990 AND primaryName like 'C%')

--Op. de consulta juncao nota filmes lancados entre 1990 e 2015 com atuacao do Tom Hanks--
SELECT averageRating, primaryTitle
FROM (titleRatings INNER JOIN titleBasics ON tconst)
WHERE (startYear >= 1990 AND startYear <= 2015)
INNER JOIN (SELECT tconst
			FROM (nameBasics INNER JOIN knownForTitles ON nconst)
			WHERE (primaryName like 'Tom Hanks')

--Op. de busca com agrupamento 10 filmes com mais avaliacoes que tenha Pamela Anderosn--
SELECT primaryTitle
FROM (titleRatings INNER JOIN titleBasics ON tconst)
WHERE (select * from titleRatings AS tr1
			join titleRating AS tr2
			ON r1.numVotes = r2numVotes AND r1.numVotes <= r2.numVotes
			GROUP BY r1.tconst
			HAVING COUNT(*) <=10)
INNER JOIN (SELECT tconst
			FROM (nameBasics INNER JOIN knownForTitles ON nconst)
			WHERE (primaryName like 'Pamela Anderson')
			





