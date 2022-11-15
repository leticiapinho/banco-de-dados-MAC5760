DROP INDEX IF EXISTS cast_names_idx;

CREATE INDEX IF NOT EXISTS cast_names_idx ON nameBasics USING btree
  ( primaryName ASC NULLS LAST );
