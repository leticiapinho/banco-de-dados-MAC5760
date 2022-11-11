ALTER TABLE directors         ADD FOREIGN KEY (nconst) REFERENCES nameBasics(nconst);
ALTER TABLE genre             ADD FOREIGN KEY (tconst) REFERENCES titleBasics(tconst);
ALTER TABLE knownForTitles    ADD FOREIGN KEY (tconst) REFERENCES titleBasics(tconst);
ALTER TABLE primaryProfession ADD FOREIGN KEY (nconst) REFERENCES nameBasics(nconst)
ALTER TABLE titlePrincipals   ADD FOREIGN KEY (nconst) REFERENCES nameBasics(nconst)
ALTER TABLE titleRatings      ADD FOREIGN KEY (tconst) REFERENCES titleBasics(tconst)
ALTER TABLE writers           ADD FOREIGN KEY (nconst) REFERENCES nameBasics(nconst)


