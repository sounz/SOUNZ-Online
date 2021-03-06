-- IF
-- Warning: still requires casts in some instances
CREATE OR REPLACE FUNCTION if(boolean, anyelement, anyelement) 
RETURNS anyelement AS '
  SELECT CASE WHEN $1 THEN $2 ELSE $3 END
' IMMUTABLE LANGUAGE SQL;

--work around bugs in Postgres

-- IF
-- Warning: still requires casts in some instances
CREATE OR REPLACE FUNCTION if(boolean, numeric, numeric) 
RETURNS numeric AS '
  SELECT CASE WHEN $1 THEN $2 ELSE $3 END
' IMMUTABLE LANGUAGE SQL;

-- IF
-- Warning: still requires casts in some instances
CREATE OR REPLACE FUNCTION if(boolean, text, text) 
RETURNS text AS '
  SELECT CASE WHEN $1 THEN $2 ELSE $3 END
' IMMUTABLE LANGUAGE SQL;








-- IFNULL
-- Warning: still requires casts in some instances
CREATE OR REPLACE FUNCTION ifnull(anyelement, anyelement)
RETURNS anyelement AS '
  SELECT COALESCE($1, $2)
' IMMUTABLE LANGUAGE SQL;

