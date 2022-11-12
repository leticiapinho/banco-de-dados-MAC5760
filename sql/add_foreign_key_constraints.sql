ALTER TABLE genre
      ADD CONSTRAINT genre_tconst
      FOREIGN KEY (tconst) REFERENCES titleBasics(tconst);

ALTER TABLE knownForTitles
      ADD CONSTRAINT knownForTitles_tconst
      FOREIGN KEY (tconst) REFERENCES titleBasics(tconst);

ALTER TABLE primaryProfession
      ADD CONSTRAINT primaryProfession_nconst
      FOREIGN KEY (nconst) REFERENCES nameBasics(nconst);

ALTER TABLE titlePrincipals
      ADD CONSTRAINT titlePrincipals_nconst
      FOREIGN KEY (nconst) REFERENCES nameBasics(nconst);

ALTER TABLE titleRatings
      ADD CONSTRAINT titleRatings_tconst
      FOREIGN KEY (tconst) REFERENCES titleBasics(tconst);
