DROP INDEX IF EXISTS ratings_idx;

CREATE INDEX IF NOT EXISTS ratings_idx ON titleRatings USING btree
  ( averageRating ASC NULLS LAST );
