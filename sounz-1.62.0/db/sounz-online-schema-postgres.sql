--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'Standard public schema';


--
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: -
--

CREATE PROCEDURAL LANGUAGE plpgsql;


SET search_path = public, pg_catalog;

--
-- Name: _and(boolean, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _and(boolean, boolean) RETURNS boolean
    AS $_$
  SELECT $1 AND $2
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: _bit_xor(bigint, bigint); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _bit_xor(bigint, bigint) RETURNS bigint
    AS $_$
  SELECT $1 # COALESCE($2, 0)
$_$
    LANGUAGE sql IMMUTABLE;


--
-- Name: _date_to_integer(date); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _date_to_integer(date) RETURNS integer
    AS $_$
  SELECT
    EXTRACT(YEAR FROM $1)::integer * 10000
    + EXTRACT(MONTH FROM $1)::integer * 100
    + EXTRACT(DAY FROM $1)::integer
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: _group_concat(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _group_concat(text, text) RETURNS text
    AS $_$
  SELECT CASE
    WHEN $2 IS NULL THEN $1
    WHEN $1 IS NULL THEN $2
    ELSE $1 operator(pg_catalog.||) ',' operator(pg_catalog.||) $2
  END
$_$
    LANGUAGE sql IMMUTABLE;


--
-- Name: _interval_to_bigint(interval); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _interval_to_bigint(interval) RETURNS bigint
    AS $_$
  SELECT
    EXTRACT(YEAR FROM $1)::bigint * 10000000000
    + EXTRACT(MONTH FROM $1)::bigint * 100000000
    + EXTRACT(DAY FROM $1)::bigint * 1000000
    + EXTRACT(HOUR FROM $1)::bigint * 10000
    + EXTRACT(MINUTE FROM $1)::bigint * 100
    + EXTRACT(SECONDS FROM $1)::bigint
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: _null_safe_cmp(anyelement, anyelement); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _null_safe_cmp(anyelement, anyelement) RETURNS boolean
    AS $_$
  SELECT NOT ($1 IS DISTINCT FROM $2)
$_$
    LANGUAGE sql IMMUTABLE;


--
-- Name: _or(boolean, boolean); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _or(boolean, boolean) RETURNS boolean
    AS $_$
  SELECT $1 OR $2
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: _soundexcode(character); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _soundexcode(character) RETURNS character
    AS $_$
  SELECT COALESCE(
    (ARRAY['0', '1', '2', '3', '0', 
           '1', '2', '0', '0', '2', 
           '2', '4', '5', '5', '0', 
           '1', '2', '6', '2', '3', 
           '0', '1', '0', '2', '0', '2'])[pg_catalog.ascii($1) - 64],
     '0');
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: _time_to_integer(time with time zone); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _time_to_integer(time with time zone) RETURNS integer
    AS $_$
  SELECT
    EXTRACT(HOUR FROM $1)::integer * 10000
    + EXTRACT(MINUTE FROM $1)::integer * 100
    + EXTRACT(SECONDS FROM $1)::integer
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: _time_to_integer(time without time zone); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _time_to_integer(time without time zone) RETURNS integer
    AS $_$
  SELECT
    EXTRACT(HOUR FROM $1)::integer * 10000
    + EXTRACT(MINUTE FROM $1)::integer * 100
    + EXTRACT(SECONDS FROM $1)::integer
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: _timestamp_to_bigint(timestamp with time zone); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _timestamp_to_bigint(timestamp with time zone) RETURNS bigint
    AS $_$
  SELECT _date_to_integer($1::date)::bigint * 1000000 + _time_to_integer($1::time)
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: _timestamp_to_bigint(timestamp without time zone); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION _timestamp_to_bigint(timestamp without time zone) RETURNS bigint
    AS $_$
  SELECT _date_to_integer($1::date)::bigint * 1000000 + _time_to_integer($1::time)
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: adddate(timestamp without time zone, interval); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION adddate(timestamp without time zone, interval) RETURNS timestamp without time zone
    AS $_$
    SELECT $1 + $2
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: adddate(timestamp without time zone, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION adddate(timestamp without time zone, integer) RETURNS timestamp without time zone
    AS $_$
  SELECT $1 + (INTERVAL '1 day' * $2)
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: addtime(timestamp without time zone, interval); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION addtime(timestamp without time zone, interval) RETURNS timestamp without time zone
    AS $_$
  SELECT $1 + $2
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: addtime(interval, interval); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION addtime(interval, interval) RETURNS interval
    AS $_$
  SELECT $1 + $2
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: atan(double precision, double precision); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION atan(double precision, double precision) RETURNS double precision
    AS $_$
  SELECT pg_catalog.atan2($1, $2)
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: bin(bigint); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION bin(bigint) RETURNS text
    AS $_$ 
  SELECT pg_catalog.ltrim(pg_catalog.textin(pg_catalog.bit_out($1::bit(64))), '0');
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: bit_count(bigint); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION bit_count(bigint) RETURNS integer
    AS $_$
  SELECT pg_catalog.length(pg_catalog.replace(pg_catalog.ltrim(pg_catalog.textin(pg_catalog.bit_out($1::bit(64))), '0'), '0', ''));
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: charset(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION charset(text) RETURNS text
    AS $$
  SELECT pg_catalog.lower(setting) from pg_catalog.pg_settings where name='server_encoding'
$$
    LANGUAGE sql IMMUTABLE;


--
-- Name: coercibility(name); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION coercibility(name) RETURNS integer
    AS $$
  SELECT 3
$$
    LANGUAGE sql IMMUTABLE;


--
-- Name: coercibility(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION coercibility(text) RETURNS integer
    AS $_$
  SELECT CASE
    WHEN $1 IS NULL THEN 5
    ELSE 2
  END
$_$
    LANGUAGE sql IMMUTABLE;


--
-- Name: collation(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION collation(text) RETURNS text
    AS $$
  SELECT pg_catalog.lower(setting) from pg_catalog.pg_settings where name='lc_collate'
$$
    LANGUAGE sql IMMUTABLE;


--
-- Name: concat(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION concat(text) RETURNS text
    AS $_$
  SELECT $1
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: concat(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION concat(text, text) RETURNS text
    AS $_$
  SELECT $1 operator(pg_catalog.||) $2
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: concat(text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION concat(text, text, text) RETURNS text
    AS $_$
  SELECT $1 operator(pg_catalog.||) $2 operator(pg_catalog.||) $3
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: concat_ws(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION concat_ws(text, text) RETURNS text
    AS $_$
  SELECT CASE
    WHEN $1 IS NULL THEN NULL
    ELSE $2
  END
$_$
    LANGUAGE sql IMMUTABLE;


--
-- Name: concat_ws(text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION concat_ws(text, text, text) RETURNS text
    AS $_$
  SELECT CASE
    WHEN $1 IS NULL THEN NULL
    ELSE
      coalesce($2 operator(pg_catalog.||) $1, '') operator(pg_catalog.||) coalesce($3, '')
  END
$_$
    LANGUAGE sql IMMUTABLE;


--
-- Name: concat_ws(text, text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION concat_ws(text, text, text, text) RETURNS text
    AS $_$
  SELECT CASE
    WHEN $1 IS NULL THEN NULL
    ELSE 
      coalesce($2 operator(pg_catalog.||) $1, '') operator(pg_catalog.||) coalesce($3 operator(pg_catalog.||) $1, '') operator(pg_catalog.||) coalesce($4, '')
  END
$_$
    LANGUAGE sql IMMUTABLE;


--
-- Name: connection_id(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION connection_id() RETURNS integer
    AS $$ 
  SELECT pg_catalog.pg_backend_pid()
$$
    LANGUAGE sql IMMUTABLE;


--
-- Name: convert_tz(timestamp without time zone, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION convert_tz(timestamp without time zone, text, text) RETURNS timestamp without time zone
    AS $_$
  SELECT CASE
    WHEN POSITION(':' IN $3) = 0 THEN
      ($1 operator(pg_catalog.||) ' ' operator(pg_catalog.||) $2)::timestamp with time zone AT TIME ZONE $3
    ELSE
      ($1 operator(pg_catalog.||) ' ' operator(pg_catalog.||) $2)::timestamp with time zone AT TIME ZONE $3::interval
    END
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: curdate(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION curdate() RETURNS date
    AS $$
  SELECT CURRENT_DATE
$$
    LANGUAGE sql;


--
-- Name: curtime(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION curtime() RETURNS time without time zone
    AS $$
  SELECT LOCALTIME(0)
$$
    LANGUAGE sql;


--
-- Name: database(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION "database"() RETURNS text
    AS $$
  SELECT pg_catalog.current_database()::text
$$
    LANGUAGE sql IMMUTABLE;


--
-- Name: date_add(timestamp without time zone, interval); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION date_add(timestamp without time zone, interval) RETURNS timestamp without time zone
    AS $_$
  SELECT $1 + $2
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: date_format(timestamp without time zone, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION date_format(timestamp without time zone, text) RETURNS text
    AS $_$
  DECLARE
    i int := 1;
    temp text := '';
    c text;
    n text;
    res text;
  BEGIN
    WHILE i <= pg_catalog.length($2) LOOP
      -- Look at current character
      c := SUBSTRING ($2 FROM i FOR 1);
      -- If it's a '%' and not the last character then process it as a placeholder
      IF c = '%' AND i != pg_catalog.length($2) THEN
        n := SUBSTRING ($2 FROM (i + 1) FOR 1);
        SELECT INTO res CASE
          WHEN n = 'a' THEN pg_catalog.to_char($1, 'Dy')
          WHEN n = 'b' THEN pg_catalog.to_char($1, 'Mon')
          WHEN n = 'c' THEN pg_catalog.to_char($1, 'FMMM')
          WHEN n = 'D' THEN pg_catalog.to_char($1, 'FMDDth')
          WHEN n = 'd' THEN pg_catalog.to_char($1, 'DD')
          WHEN n = 'e' THEN pg_catalog.to_char($1, 'FMDD')
          WHEN n = 'f' THEN pg_catalog.to_char($1, 'US')
          WHEN n = 'H' THEN pg_catalog.to_char($1, 'HH24')
          WHEN n = 'h' THEN pg_catalog.to_char($1, 'HH12')
          WHEN n = 'I' THEN pg_catalog.to_char($1, 'HH12')
          WHEN n = 'i' THEN pg_catalog.to_char($1, 'MI')
          WHEN n = 'j' THEN pg_catalog.to_char($1, 'DDD')
          WHEN n = 'k' THEN pg_catalog.to_char($1, 'FMHH24')
          WHEN n = 'l' THEN pg_catalog.to_char($1, 'FMHH12')
          WHEN n = 'M' THEN pg_catalog.to_char($1, 'FMMonth')
          WHEN n = 'm' THEN pg_catalog.to_char($1, 'MM')
          WHEN n = 'p' THEN pg_catalog.to_char($1, 'AM')
          WHEN n = 'r' THEN pg_catalog.to_char($1, 'HH12:MI:SS AM')
          WHEN n = 'S' THEN pg_catalog.to_char($1, 'SS')
          WHEN n = 's' THEN pg_catalog.to_char($1, 'SS')
          WHEN n = 'T' THEN pg_catalog.to_char($1, 'HH24:MI:SS')
          WHEN n = 'U' THEN pg_catalog.to_char($1, '?')
          WHEN n = 'u' THEN pg_catalog.to_char($1, '?')
          WHEN n = 'V' THEN pg_catalog.to_char($1, '?')
          WHEN n = 'v' THEN pg_catalog.to_char($1, '?')
          WHEN n = 'W' THEN pg_catalog.to_char($1, 'FMDay')
          WHEN n = 'w' THEN EXTRACT(DOW FROM $1)::text
          WHEN n = 'X' THEN pg_catalog.to_char($1, '?')
          WHEN n = 'x' THEN pg_catalog.to_char($1, '?')
          WHEN n = 'Y' THEN pg_catalog.to_char($1, 'YYYY')
          WHEN n = 'y' THEN pg_catalog.to_char($1, 'YY')
          WHEN n = '%' THEN pg_catalog.to_char($1, '%')
          ELSE NULL
        END;
        temp := temp operator(pg_catalog.||) res;
        i := i + 2;
      ELSE
        -- Otherwise just append the character to the string
        temp = temp operator(pg_catalog.||) c;
        i := i + 1;
      END IF;
    END LOOP;
    RETURN temp;
  END
$_$
    LANGUAGE plpgsql IMMUTABLE STRICT;


--
-- Name: date_sub(timestamp without time zone, interval); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION date_sub(timestamp without time zone, interval) RETURNS timestamp without time zone
    AS $_$
  SELECT $1 - $2
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: datediff(date, date); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION datediff(date, date) RETURNS integer
    AS $_$
  SELECT $1 - $2
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: day(date); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION "day"(date) RETURNS integer
    AS $_$
  SELECT EXTRACT(DAY FROM DATE($1))::integer
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: dayname(date); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION dayname(date) RETURNS text
    AS $_$
  SELECT pg_catalog.to_char($1, 'FMDay')
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: dayofmonth(date); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION dayofmonth(date) RETURNS integer
    AS $_$
  SELECT EXTRACT(DAY FROM DATE($1))::integer
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: dayofweek(date); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION dayofweek(date) RETURNS integer
    AS $_$
  SELECT EXTRACT(DOW FROM DATE($1))::integer + 1
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: dayofyear(date); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION dayofyear(date) RETURNS integer
    AS $_$
  SELECT EXTRACT(DOY FROM DATE($1))::integer
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: elt(integer, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION elt(integer, text, text) RETURNS text
    AS $_$
  SELECT CASE
    WHEN $1 < 1 OR $1 > 2 THEN NULL
    WHEN $1 = 1 THEN $2
    ELSE $3
  END 
$_$
    LANGUAGE sql IMMUTABLE;


--
-- Name: elt(integer, text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION elt(integer, text, text, text) RETURNS text
    AS $_$
  SELECT CASE
    WHEN $1 < 1 OR $1 > 3 THEN NULL
    WHEN $1 = 1 THEN $2
    WHEN $1 = 2 THEN $3
    ELSE $4
  END 
$_$
    LANGUAGE sql IMMUTABLE;


--
-- Name: elt(integer, text, text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION elt(integer, text, text, text, text) RETURNS text
    AS $_$
  SELECT CASE
    WHEN $1 < 1 OR $1 > 4 THEN NULL
    WHEN $1 = 1 THEN $2
    WHEN $1 = 2 THEN $3
    WHEN $1 = 3 THEN $4
    ELSE $5
  END 
$_$
    LANGUAGE sql IMMUTABLE;


--
-- Name: export_set(bigint, text, text, text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION export_set(bigint, text, text, text, integer) RETURNS text
    AS $_$
  SELECT pg_catalog.rtrim(pg_catalog.replace(pg_catalog.replace(reverse(pg_catalog.lpad(bin($1), $5, '0')), 1, $2 operator(pg_catalog.||) $4), 0, $3 operator(pg_catalog.||) $4), $4)
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: export_set(bigint, text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION export_set(bigint, text, text, text) RETURNS text
    AS $_$
  SELECT export_set($1, $2, $3, $4, 64)
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: export_set(bigint, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION export_set(bigint, text, text) RETURNS text
    AS $_$
  SELECT export_set($1, $2, $3, ',', 64)
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: field(text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION field(text, text, text) RETURNS integer
    AS $_$
  SELECT CASE
    WHEN $1 = $2 THEN 1
    WHEN $1 = $3 THEN 2
    ELSE 0
  END 
$_$
    LANGUAGE sql IMMUTABLE;


--
-- Name: field(text, text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION field(text, text, text, text) RETURNS integer
    AS $_$
  SELECT CASE
    WHEN $1 = $2 THEN 1
    WHEN $1 = $3 THEN 2
    WHEN $1 = $4 THEN 3
    ELSE 0
  END 
$_$
    LANGUAGE sql IMMUTABLE;


--
-- Name: field(text, text, text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION field(text, text, text, text, text) RETURNS integer
    AS $_$
  SELECT CASE
    WHEN $1 = $2 THEN 1
    WHEN $1 = $3 THEN 2
    WHEN $1 = $4 THEN 3
    WHEN $1 = $5 THEN 4
    ELSE 0
  END 
$_$
    LANGUAGE sql IMMUTABLE;


--
-- Name: format(double precision, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION format(double precision, integer) RETURNS text
    AS $_$
  SELECT pg_catalog.to_char($1, 'FM999,999,999,999,999,999,999.' 
    operator(pg_catalog.||) pg_catalog.repeat('0', $2))
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: from_days(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION from_days(integer) RETURNS date
    AS $_$
  SELECT ('0000-01-01'::date + $1 * INTERVAL '1 day')::date
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: from_unixtime(bigint); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION from_unixtime(bigint) RETURNS timestamp without time zone
    AS $_$
  SELECT pg_catalog.to_timestamp($1)::timestamp without time zone
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: from_unixtime(bigint, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION from_unixtime(bigint, text) RETURNS text
    AS $_$
  SELECT date_format(from_unixtime($1), $2)
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: get_format(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION get_format(text, text) RETURNS text
    AS $_$
  SELECT CASE
    WHEN $1 ILIKE 'DATE' THEN
      CASE WHEN $2 ILIKE 'USA' THEN '%m.%d.%Y'
      WHEN $2 ILIKE 'JIS' OR $2 ILIKE 'ISO' THEN '%Y-%m-%d'
      WHEN $2 ILIKE 'EUR' THEN '%d.%m.%Y'
      WHEN $2 ILIKE 'INTERNAL' THEN '%Y%m%d'
      ELSE NULL
      END
    WHEN $1 ILIKE 'DATETIME' THEN
      CASE WHEN $2 ILIKE 'USA' OR $2 ILIKE 'EUR' THEN '%Y-%m-%d-%H.%i.%s'
      WHEN $2 ILIKE 'JIS' OR $2 ILIKE 'ISO' THEN '%Y-%m-%d %H:%i:%s'
      WHEN $2 ILIKE 'INTERNAL' THEN '%Y%m%d%H%i%s'
      ELSE NULL
      END
    WHEN $1 ILIKE 'TIME' THEN
      CASE WHEN $2 ILIKE 'USA' THEN '%h:%i:%s %p'
      WHEN $2 ILIKE 'JIS' OR $2 ILIKE 'ISO' THEN '%H:%i:%s'
      WHEN $2 ILIKE 'EUR' THEN 'H.%i.%S'
      WHEN $2 ILIKE 'INTERNAL' THEN '%H%i%s'
      ELSE NULL
      END
    ELSE
      NULL
    END
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: hex(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION hex(integer) RETURNS text
    AS $_$
  SELECT pg_catalog.upper(pg_catalog.to_hex($1))
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: hex(bigint); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION hex(bigint) RETURNS text
    AS $_$
  SELECT pg_catalog.upper(pg_catalog.to_hex($1))
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: hour(interval); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION "hour"(interval) RETURNS integer
    AS $_$ 
  SELECT EXTRACT (HOUR FROM $1)::integer
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: if(boolean, anyelement, anyelement); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION "if"(boolean, anyelement, anyelement) RETURNS anyelement
    AS $_$
  SELECT CASE WHEN $1 THEN $2 ELSE $3 END
$_$
    LANGUAGE sql IMMUTABLE;


--
-- Name: if(boolean, numeric, numeric); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION "if"(boolean, numeric, numeric) RETURNS numeric
    AS $_$
  SELECT CASE WHEN $1 THEN $2 ELSE $3 END
$_$
    LANGUAGE sql IMMUTABLE;


--
-- Name: if(boolean, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION "if"(boolean, text, text) RETURNS text
    AS $_$
  SELECT CASE WHEN $1 THEN $2 ELSE $3 END
$_$
    LANGUAGE sql IMMUTABLE;


--
-- Name: ifnull(anyelement, anyelement); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION ifnull(anyelement, anyelement) RETURNS anyelement
    AS $_$
  SELECT COALESCE($1, $2)
$_$
    LANGUAGE sql IMMUTABLE;


--
-- Name: inet_ntoa(bigint); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION inet_ntoa(bigint) RETURNS text
    AS $_$
SELECT CASE WHEN $1 > 4294967295 THEN NULL ELSE
    ((($1::bigint >> 24) % 256) + 256) % 256 operator(pg_catalog.||) '.' operator(pg_catalog.||)
    ((($1::bigint >> 16) % 256) + 256) % 256 operator(pg_catalog.||) '.' operator(pg_catalog.||)
    ((($1::bigint >>  8) % 256) + 256) % 256 operator(pg_catalog.||) '.' operator(pg_catalog.||)
    ((($1::bigint      ) % 256) + 256) % 256 END;
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: insert(text, integer, integer, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION "insert"(text, integer, integer, text) RETURNS text
    AS $_$
  SELECT CASE
    WHEN NOT $2 BETWEEN 1 AND pg_catalog.length($1) THEN $1
    ELSE overlay($1 placing $4 from $2 for $3)
  END
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: instr(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION instr(text, text) RETURNS integer
    AS $_$
  SELECT POSITION($2 IN $1)
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: last_day(timestamp without time zone); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION last_day(timestamp without time zone) RETURNS date
    AS $_$ 
  SELECT CASE
    WHEN EXTRACT(MONTH FROM $1) = 12 THEN
      (((EXTRACT(YEAR FROM $1) + 1) operator(pg_catalog.||) '-01-01')::date - INTERVAL '1 day')::date
    ELSE
      ((EXTRACT(YEAR FROM $1) operator(pg_catalog.||) '-' operator(pg_catalog.||) (EXTRACT(MONTH FROM $1) + 1) operator(pg_catalog.||) '-01')::date - INTERVAL '1 day')::date
    END
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: last_insert_id(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION last_insert_id() RETURNS bigint
    AS $$
  SELECT pg_catalog.lastval()
$$
    LANGUAGE sql;


--
-- Name: lcase(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION lcase(text) RETURNS text
    AS $_$
  SELECT pg_catalog.lower($1)
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: left(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION "left"(text, integer) RETURNS text
    AS $_$
  SELECT substring($1 FOR $2);
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: locate(text, text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION locate(text, text, integer) RETURNS integer
    AS $_$
  SELECT POSITION($1 IN SUBSTRING ($2 FROM $3)) + $3 - 1
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: locate(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION locate(text, text) RETURNS integer
    AS $_$
  SELECT locate($1, $2, 1)
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: log10(numeric); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION log10(numeric) RETURNS numeric
    AS $_$
  SELECT CASE WHEN $1 > 0 THEN pg_catalog.log(10, $1) ELSE NULL END
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: log2(numeric); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION log2(numeric) RETURNS numeric
    AS $_$
  SELECT CASE WHEN $1 > 0 THEN pg_catalog.log(2, $1) ELSE NULL END
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: makedate(integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION makedate(integer, integer) RETURNS date
    AS $_$
  SELECT CASE WHEN $2 > 0 THEN
    (($1 operator(pg_catalog.||) '-01-01')::date + ($2 - 1) * INTERVAL '1 day')::date
  ELSE
    NULL
  END
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: maketime(integer, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION maketime(integer, integer, integer) RETURNS interval
    AS $_$
  SELECT ($1 operator(pg_catalog.||) ':' operator(pg_catalog.||) $2 operator(pg_catalog.||) ':' operator(pg_catalog.||) $3)::interval
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: microsecond(time without time zone); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION microsecond(time without time zone) RETURNS integer
    AS $_$
  SELECT (EXTRACT(MICROSECONDS FROM $1))::integer % 1000000
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: mid(text, integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION mid(text, integer, integer) RETURNS text
    AS $_$
  SELECT pg_catalog.substring($1, $2, $3)
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: minute(time without time zone); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION "minute"(time without time zone) RETURNS integer
    AS $_$
  SELECT EXTRACT(MINUTES FROM $1)::integer
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: month(date); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION "month"(date) RETURNS integer
    AS $_$
  SELECT EXTRACT(MONTH FROM DATE($1))::integer
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: monthname(date); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION monthname(date) RETURNS text
    AS $_$
  SELECT pg_catalog.to_char($1, 'FMMonth')
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: oct(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION oct(integer) RETURNS text
    AS $_$
  SELECT conv($1, 10, 8)
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: ord(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION ord(text) RETURNS integer
    AS $_$
  SELECT pg_catalog.ascii($1)
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: quarter(date); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION quarter(date) RETURNS integer
    AS $_$
  SELECT EXTRACT(QUARTER FROM DATE($1))::integer
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: quote(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION "quote"(text) RETURNS text
    AS $_$
  SELECT CASE
    WHEN $1 IS NULL THEN 'NULL'
    ELSE pg_catalog.quote_literal($1)
  END
$_$
    LANGUAGE sql IMMUTABLE;


--
-- Name: rand(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION rand() RETURNS double precision
    AS $$
  SELECT pg_catalog.random()
$$
    LANGUAGE sql;


--
-- Name: rand(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION rand(integer) RETURNS double precision
    AS $_$
  SELECT pg_catalog.setseed($1); 
  SELECT pg_catalog.random()
$_$
    LANGUAGE sql;


--
-- Name: right(text, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION "right"(text, integer) RETURNS text
    AS $_$
  SELECT substring($1 FROM pg_catalog.length($1) + 1 - $2);
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: schema(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION "schema"() RETURNS text
    AS $$
  SELECT pg_catalog.current_schema()::text
$$
    LANGUAGE sql;


--
-- Name: sec_to_time(bigint); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION sec_to_time(bigint) RETURNS interval
    AS $_$
  SELECT $1 * INTERVAL '1 second'
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: second(interval); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION "second"(interval) RETURNS integer
    AS $_$
  SELECT EXTRACT(SECONDS FROM $1)::integer
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: space(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION space(integer) RETURNS text
    AS $_$
  SELECT pg_catalog.repeat(' ', $1)
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: strcmp(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION strcmp(text, text) RETURNS integer
    AS $_$
  SELECT CASE
    WHEN $1 = $2 THEN 0
    WHEN $1 < $2 THEN -1
    ELSE 1
  END
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: subdate(timestamp without time zone, interval); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION subdate(timestamp without time zone, interval) RETURNS timestamp without time zone
    AS $_$
    SELECT $1 - $2
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: subdate(timestamp without time zone, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION subdate(timestamp without time zone, integer) RETURNS timestamp without time zone
    AS $_$
  SELECT $1 - (INTERVAL '1 day' * $2)
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: subtime(timestamp without time zone, interval); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION subtime(timestamp without time zone, interval) RETURNS timestamp without time zone
    AS $_$
  SELECT $1 - $2
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: subtime(interval, interval); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION subtime(interval, interval) RETURNS interval
    AS $_$
  SELECT $1 - $2
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: sysdate(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION sysdate() RETURNS timestamp without time zone
    AS $$
  SELECT pg_catalog.timeofday()::timestamp(0) without time zone
$$
    LANGUAGE sql;


--
-- Name: system_user(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION system_user() RETURNS text
    AS $$
  SELECT SESSION_USER::text
$$
    LANGUAGE sql;


--
-- Name: time_to_sec(interval); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION time_to_sec(interval) RETURNS bigint
    AS $_$
  SELECT (EXTRACT(HOURS FROM $1) * 3600
    + EXTRACT(MINUTES FROM $1) * 60
    + EXTRACT(SECONDS FROM $1))::bigint
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: timediff(timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION timediff(timestamp without time zone, timestamp without time zone) RETURNS interval
    AS $_$
  SELECT $1 - $2
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: timediff(time without time zone, time without time zone); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION timediff(time without time zone, time without time zone) RETURNS interval
    AS $_$
  SELECT $1 - $2
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: timestampadd(text, integer, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION timestampadd(text, integer, timestamp without time zone) RETURNS timestamp without time zone
    AS $_$
  SELECT $3 + ($2 operator(pg_catalog.||) ' ' operator(pg_catalog.||) $1)::interval
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: to_days(date); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION to_days(date) RETURNS integer
    AS $_$
  SELECT $1 - '0000-01-01'::date
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: truncate(numeric, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION "truncate"(numeric, integer) RETURNS numeric
    AS $_$
  SELECT pg_catalog.trunc($1, $2)
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: ucase(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION ucase(text) RETURNS text
    AS $_$
  SELECT pg_catalog.upper($1)
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: unix_timestamp(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION unix_timestamp() RETURNS bigint
    AS $$
  SELECT EXTRACT(EPOCH FROM LOCALTIMESTAMP)::bigint
$$
    LANGUAGE sql;


--
-- Name: unix_timestamp(timestamp without time zone); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION unix_timestamp(timestamp without time zone) RETURNS bigint
    AS $_$
  SELECT EXTRACT(EPOCH FROM $1)::bigint
$_$
    LANGUAGE sql;


--
-- Name: utc_date(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION utc_date() RETURNS date
    AS $$
  SELECT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC')::date
$$
    LANGUAGE sql;


--
-- Name: utc_time(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION utc_time() RETURNS time without time zone
    AS $$
  SELECT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC')::time(0)
$$
    LANGUAGE sql;


--
-- Name: utc_timestamp(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION utc_timestamp() RETURNS timestamp without time zone
    AS $$
  SELECT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC')::timestamp(0)
$$
    LANGUAGE sql;


--
-- Name: weekday(date); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION weekday(date) RETURNS integer
    AS $_$
  SELECT CASE
    WHEN EXTRACT(DOW FROM $1)::integer = 0 THEN
      6
    ELSE
      EXTRACT(DOW FROM $1)::integer - 1
    END
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: weekofyear(date); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION weekofyear(date) RETURNS integer
    AS $_$
  SELECT EXTRACT(WEEK FROM $1)::integer
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: year(date); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION "year"(date) RETURNS integer
    AS $_$
  SELECT EXTRACT(YEAR FROM $1)::integer
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: yearweek(date); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION yearweek(date) RETURNS text
    AS $_$
  SELECT CASE
    WHEN EXTRACT(WEEK FROM $1)::integer = 53 THEN
      pg_catalog.lpad(EXTRACT(YEAR FROM $1) - 1, 4, '0') || '53'
    ELSE
      pg_catalog.lpad(EXTRACT(YEAR FROM $1) - 1, 4, '0')
        || pg_catalog.lpad(EXTRACT(WEEK FROM $1), 2, '0')
    END
$_$
    LANGUAGE sql IMMUTABLE STRICT;


--
-- Name: bit_xor(bigint); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE bit_xor(bigint) (
    SFUNC = _bit_xor,
    STYPE = bigint,
    INITCOND = '0'
);


--
-- Name: group_concat(text); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE group_concat(text) (
    SFUNC = _group_concat,
    STYPE = text
);


--
-- Name: &&; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR && (
    PROCEDURE = _and,
    LEFTARG = boolean,
    RIGHTARG = boolean,
    COMMUTATOR = &&
);


--
-- Name: <=>; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR <=> (
    PROCEDURE = _null_safe_cmp,
    LEFTARG = anyelement,
    RIGHTARG = anyelement
);


--
-- Name: ||; Type: OPERATOR; Schema: public; Owner: -
--

CREATE OPERATOR || (
    PROCEDURE = _or,
    LEFTARG = boolean,
    RIGHTARG = boolean,
    COMMUTATOR = ||
);


--
-- Name: access_rights_access_right_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE access_rights_access_right_id_seq
    START WITH 7
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: access_rights; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE access_rights (
    access_right_id integer DEFAULT nextval('access_rights_access_right_id_seq'::regclass) NOT NULL,
    access_right_name text NOT NULL,
    access_right_desc text
);


--
-- Name: address_book_address_book_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE address_book_address_book_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: address_book_address_booktest_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE address_book_address_booktest_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: address_format_address_format_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE address_format_address_format_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: admin_activity_log_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE admin_activity_log_log_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: admin_admin_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE admin_admin_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: allowed_ips_allowed_ip_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE allowed_ips_allowed_ip_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: allowed_ips; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE allowed_ips (
    allowed_ip_id integer DEFAULT nextval('allowed_ips_allowed_ip_id_seq'::regclass) NOT NULL,
    login_id integer NOT NULL,
    ip inet NOT NULL
);


--
-- Name: app_control; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE app_control (
    app_version text,
    last_db_patch text,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: attachment_types_attachment_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE attachment_types_attachment_type_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: attachment_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE attachment_types (
    attachment_type_id integer DEFAULT nextval('attachment_types_attachment_type_id_seq'::regclass) NOT NULL,
    attachment_type_desc text NOT NULL,
    display_order integer DEFAULT 0 NOT NULL
);


--
-- Name: authorizenet_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE authorizenet_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: backup_works; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE backup_works (
    work_id integer,
    work_subcategory_id integer,
    superwork_id integer,
    status_id integer,
    work_title text,
    work_description text,
    intended_duration interval,
    duration_varies boolean,
    no_duration boolean,
    difficulty integer,
    difficulty_note text,
    applicable_for_youth boolean,
    year_of_creation integer,
    year_of_revision integer,
    instrumentation text,
    programme_note text,
    text_note text,
    internal_note text,
    dedication_note text,
    commissioned_note text,
    contents_note text,
    iswc_code text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    updated_by integer,
    legacy_4d_identity_code text
);


--
-- Name: banners_banners_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE banners_banners_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: banners_history_banners_history_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE banners_history_banners_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: borrowed_items_borrowed_item_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE borrowed_items_borrowed_item_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: borrowed_items; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE borrowed_items (
    borrowed_item_id integer DEFAULT nextval('borrowed_items_borrowed_item_id_seq'::regclass) NOT NULL,
    item_id integer NOT NULL,
    login_id integer NOT NULL,
    date_borrowed date NOT NULL,
    date_renewed date,
    date_due date,
    date_returned date,
    hired_out boolean DEFAULT false NOT NULL,
    borrowing_note text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    active boolean DEFAULT true,
    reserved boolean
);


--
-- Name: campaign_mailouts_campaign_mailout_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE campaign_mailouts_campaign_mailout_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: campaign_mailouts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE campaign_mailouts (
    campaign_mailout_id integer DEFAULT nextval('campaign_mailouts_campaign_mailout_id_seq'::regclass) NOT NULL,
    marketing_campaign_id integer NOT NULL,
    mailout_type character(1) DEFAULT 'e'::bpchar NOT NULL,
    mailout_description text NOT NULL,
    mailout_status character(1) DEFAULT 'n'::bpchar NOT NULL,
    main_content text,
    secondary_content text,
    general_note text,
    blind_send boolean DEFAULT true NOT NULL,
    mail_merge boolean DEFAULT false NOT NULL,
    sent_timestamp timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    updated_by integer NOT NULL,
    CONSTRAINT ckc_mailout_status_campaign CHECK (((((mailout_status = 'n'::bpchar) OR (mailout_status = 'r'::bpchar)) OR (mailout_status = 'i'::bpchar)) OR (mailout_status = 's'::bpchar))),
    CONSTRAINT ckc_mailout_type_campaign CHECK (((mailout_type = 'e'::bpchar) OR (mailout_type = 'p'::bpchar)))
);


--
-- Name: categories_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE categories_categories_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: cm_content_attachments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cm_content_attachments (
    cm_content_attachment_id integer NOT NULL,
    media_item_id integer NOT NULL,
    cm_content_id integer NOT NULL,
    attachment_type_id integer NOT NULL
);


--
-- Name: cm_content_attachments_cm_content_attachment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cm_content_attachments_cm_content_attachment_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: cm_content_attachments_cm_content_attachment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cm_content_attachments_cm_content_attachment_id_seq OWNED BY cm_content_attachments.cm_content_attachment_id;


--
-- Name: cm_contents; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cm_contents (
    cm_content_id integer NOT NULL,
    status_id integer NOT NULL,
    cm_content_name text NOT NULL,
    cm_content_title text,
    cm_content text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    updated_by integer NOT NULL
);


--
-- Name: cm_contents_cm_content_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cm_contents_cm_content_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: cm_contents_cm_content_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cm_contents_cm_content_id_seq OWNED BY cm_contents.cm_content_id;


--
-- Name: communication_methods_communication_method_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE communication_methods_communication_method_id_seq
    START WITH 7
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: communication_methods; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE communication_methods (
    communication_method_id integer DEFAULT nextval('communication_methods_communication_method_id_seq'::regclass) NOT NULL,
    communication_method_desc text NOT NULL
);


--
-- Name: communication_types_communication_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE communication_types_communication_type_id_seq
    START WITH 23
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: communication_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE communication_types (
    communication_type_id integer DEFAULT nextval('communication_types_communication_type_id_seq'::regclass) NOT NULL,
    communication_type_desc text NOT NULL
);


--
-- Name: communications_communication_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE communications_communication_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: communications; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE communications (
    communication_id integer DEFAULT nextval('communications_communication_id_seq'::regclass) NOT NULL,
    communication_type_id integer NOT NULL,
    role_id integer NOT NULL,
    communication_method_id integer NOT NULL,
    communication_subject text,
    communication_note text,
    priority integer DEFAULT 0 NOT NULL,
    status character(1) DEFAULT 'o'::bpchar NOT NULL,
    closed_at timestamp without time zone,
    internally_initiated boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    updated_by integer NOT NULL,
    CONSTRAINT ckc_priority_communic CHECK (((((((priority = 0) OR (priority = 1)) OR (priority = 2)) OR (priority = 3)) OR (priority = 4)) OR (priority = 5))),
    CONSTRAINT ckc_status_communic CHECK (((status = 'o'::bpchar) OR (status = 'c'::bpchar)))
);


--
-- Name: concept_relationships_concept_relationship_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE concept_relationships_concept_relationship_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: concept_relationships; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE concept_relationships (
    concept_relationship_id integer DEFAULT nextval('concept_relationships_concept_relationship_id_seq'::regclass) NOT NULL,
    relationship_id integer NOT NULL,
    relationship_type_id integer NOT NULL,
    concept_id integer NOT NULL,
    is_dominant_entity boolean DEFAULT true NOT NULL
);


--
-- Name: concept_types_concept_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE concept_types_concept_type_id_seq
    START WITH 4
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: concept_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE concept_types (
    concept_type_id integer DEFAULT nextval('concept_types_concept_type_id_seq'::regclass) NOT NULL,
    concept_type_desc text NOT NULL
);


--
-- Name: concepts_concept_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE concepts_concept_id_seq
    START WITH 875
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: concepts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE concepts (
    concept_id integer DEFAULT nextval('concepts_concept_id_seq'::regclass) NOT NULL,
    concept_type_id integer NOT NULL,
    parent_concept_id integer,
    concept_name text NOT NULL,
    concept_description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    updated_by integer NOT NULL
);


--
-- Name: configuration_configuration_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE configuration_configuration_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: configuration_group_configuration_group_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE configuration_group_configuration_group_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: contactinfos_contactinfo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE contactinfos_contactinfo_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: contactinfos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE contactinfos (
    contactinfo_id integer DEFAULT nextval('contactinfos_contactinfo_id_seq'::regclass) NOT NULL,
    preferred_comm_method integer,
    region_id integer,
    country_id integer,
    building text,
    street text,
    po_box text,
    suburb text,
    locality text,
    postcode text,
    email_1 text,
    email_2 text,
    email_3 text,
    website_urls text,
    phone text,
    phone_prefix text,
    phone_extension text,
    phone_alt text,
    phone_alt_prefix text,
    phone_alt_extension text,
    phone_fax text,
    phone_fax_prefix text,
    phone_fax_extension text,
    phone_mobile text,
    phone_mobile_prefix text,
    phone_mobile_extension text,
    internal_note text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    updated_by integer NOT NULL
);


--
-- Name: contributors_contributor_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE contributors_contributor_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: contributors; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE contributors (
    contributor_id integer DEFAULT nextval('contributors_contributor_id_seq'::regclass) NOT NULL,
    status_id integer NOT NULL,
    role_id integer NOT NULL,
    known_as text,
    photo_credit text,
    apra_member boolean DEFAULT false NOT NULL,
    canz_member boolean DEFAULT false NOT NULL,
    profile text,
    profile_other text,
    profile_source text,
    composer_status integer,
    pull_quote text,
    permission_note text,
    internal_note text,
    legacy4d_identity_code text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    updated_by integer NOT NULL,
    CONSTRAINT ckc_composer_status_contribu CHECK (((composer_status IS NULL) OR (((composer_status = 0) OR (composer_status = 1)) OR (composer_status = 2))))
);


--
-- Name: organisations_organisation_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE organisations_organisation_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: organisations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE organisations (
    organisation_id integer DEFAULT nextval('organisations_organisation_id_seq'::regclass) NOT NULL,
    status_id integer NOT NULL,
    organisation_name text NOT NULL,
    organisation_abbrev text,
    year_of_establishment integer,
    internal_note text,
    legacy4d_identity_code text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    updated_by integer NOT NULL
);


--
-- Name: people_person_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE people_person_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: people; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE people (
    person_id integer DEFAULT nextval('people_person_id_seq'::regclass) NOT NULL,
    status_id integer NOT NULL,
    nomen_id integer,
    last_name text NOT NULL,
    first_names text,
    known_as text,
    salutation text,
    variant_name text,
    gender character(1) DEFAULT 'U'::bpchar,
    year_of_birth integer,
    year_of_death integer,
    deceased boolean DEFAULT false NOT NULL,
    apra_member boolean DEFAULT false NOT NULL,
    canz_member boolean DEFAULT false NOT NULL,
    general_note text,
    internal_note text,
    legacy4d_identity_code text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    updated_by integer NOT NULL,
    CONSTRAINT ckc_gender_people CHECK (((gender IS NULL) OR (((gender = 'M'::bpchar) OR (gender = 'F'::bpchar)) OR (gender = 'U'::bpchar))))
);


--
-- Name: role_contactinfos_role_contactinfo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE role_contactinfos_role_contactinfo_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: role_contactinfos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE role_contactinfos (
    role_contactinfo_id integer DEFAULT nextval('role_contactinfos_role_contactinfo_id_seq'::regclass) NOT NULL,
    role_id integer NOT NULL,
    contactinfo_id integer NOT NULL,
    contactinfo_type text NOT NULL,
    preferred boolean DEFAULT false NOT NULL,
    CONSTRAINT ckc_contactinfo_type_role_con CHECK ((((contactinfo_type = 'postal'::text) OR (contactinfo_type = 'physical'::text)) OR (contactinfo_type = 'billing'::text)))
);


--
-- Name: role_types_role_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE role_types_role_type_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: role_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE role_types (
    role_type_id integer DEFAULT nextval('role_types_role_type_id_seq'::regclass) NOT NULL,
    role_type_desc text NOT NULL,
    display_order integer DEFAULT 0 NOT NULL
);


--
-- Name: roles_role_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE roles_role_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE roles (
    role_id integer DEFAULT nextval('roles_role_id_seq'::regclass) NOT NULL,
    role_type_id integer NOT NULL,
    person_id integer,
    organisation_id integer,
    role_title text,
    general_note text,
    archive boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    updated_by integer NOT NULL
);


--
-- Name: contributor_advanced_search; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW contributor_advanced_search AS
    SELECT c.contributor_id, c.status_id, c.composer_status, c.canz_member AS canz, c.apra_member AS apra, r.role_id, rt.role_type_id, p.person_id, p.year_of_birth, p.gender, p.deceased, o.organisation_id, cis.contactinfo_id, cis.region_id, rt.role_type_desc, p.first_names, p.last_name, o.organisation_name FROM ((((((contributors c LEFT JOIN roles r ON ((c.role_id = r.role_id))) LEFT JOIN role_types rt ON ((rt.role_type_id = r.role_type_id))) LEFT JOIN people p ON ((r.person_id = p.person_id))) LEFT JOIN organisations o ON ((r.organisation_id = o.organisation_id))) LEFT JOIN role_contactinfos rcis ON ((rcis.role_id = r.role_id))) LEFT JOIN contactinfos cis ON ((rcis.contactinfo_id = cis.contactinfo_id))) WHERE (r.organisation_id IS NULL) UNION SELECT c.contributor_id, c.status_id, c.composer_status, c.canz_member AS canz, c.apra_member AS apra, r.role_id, rt.role_type_id, p.person_id, o.year_of_establishment AS year_of_birth, p.gender, p.deceased, o.organisation_id, cis.contactinfo_id, cis.region_id, rt.role_type_desc, p.first_names, p.last_name, o.organisation_name FROM ((((((contributors c LEFT JOIN roles r ON ((c.role_id = r.role_id))) LEFT JOIN role_types rt ON ((rt.role_type_id = r.role_type_id))) LEFT JOIN people p ON ((r.person_id = p.person_id))) LEFT JOIN organisations o ON ((r.organisation_id = o.organisation_id))) LEFT JOIN role_contactinfos rcis ON ((rcis.role_id = r.role_id))) LEFT JOIN contactinfos cis ON ((rcis.contactinfo_id = cis.contactinfo_id))) WHERE (r.person_id IS NULL);


--
-- Name: contributor_attachments_contributor_attachment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE contributor_attachments_contributor_attachment_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: contributor_attachments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE contributor_attachments (
    contributor_attachment_id integer DEFAULT nextval('contributor_attachments_contributor_attachment_id_seq'::regclass) NOT NULL,
    attachment_type_id integer NOT NULL,
    contributor_id integer NOT NULL,
    media_item_id integer NOT NULL
);


--
-- Name: controller_restrictions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE controller_restrictions (
    controller_restriction_id integer NOT NULL,
    privilege_id integer NOT NULL,
    status_id integer,
    controller_name text NOT NULL,
    controller_action text,
    http_verb text DEFAULT 'get'::text NOT NULL,
    CONSTRAINT ckc_http_verb_controll CHECK (((((http_verb = 'get'::text) OR (http_verb = 'post'::text)) OR (http_verb = 'put'::text)) OR (http_verb = 'delete'::text)))
);


--
-- Name: controller_restrictions_controller_restriction_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE controller_restrictions_controller_restriction_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: controller_restrictions_controller_restriction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE controller_restrictions_controller_restriction_id_seq OWNED BY controller_restrictions.controller_restriction_id;


--
-- Name: countries_country_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE countries_country_id_seq
    START WITH 245
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: countries; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE countries (
    country_id integer DEFAULT nextval('countries_country_id_seq'::regclass) NOT NULL,
    country_name text NOT NULL,
    country_abbrev text
);


--
-- Name: countries_countries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE countries_countries_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: coupon_email_track_unique_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE coupon_email_track_unique_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: coupon_gv_queue_unique_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE coupon_gv_queue_unique_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: coupon_redeem_track_unique_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE coupon_redeem_track_unique_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: coupon_restrict_restrict_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE coupon_restrict_restrict_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: coupons_coupon_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE coupons_coupon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: currencies_currencies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE currencies_currencies_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: customers_basket_attributes_customers_basket_attributes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE customers_basket_attributes_customers_basket_attributes_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: customers_basket_customers_basket_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE customers_basket_customers_basket_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: customers_customers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE customers_customers_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: default_contactinfos_default_contactinfo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE default_contactinfos_default_contactinfo_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: default_contactinfos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE default_contactinfos (
    default_contactinfo_id integer DEFAULT nextval('default_contactinfos_default_contactinfo_id_seq'::regclass) NOT NULL,
    contactinfo_id integer NOT NULL,
    d_contactinfo_id integer NOT NULL,
    d_region boolean DEFAULT true NOT NULL,
    d_country boolean DEFAULT true NOT NULL,
    d_building boolean DEFAULT true NOT NULL,
    d_street boolean DEFAULT true NOT NULL,
    d_po_box boolean DEFAULT true NOT NULL,
    d_suburb boolean DEFAULT true NOT NULL,
    d_locality boolean DEFAULT true NOT NULL,
    d_postcode boolean DEFAULT true NOT NULL,
    d_email_1 boolean DEFAULT true NOT NULL,
    d_email_2 boolean DEFAULT true NOT NULL,
    d_email_3 boolean DEFAULT true NOT NULL,
    d_website_urls boolean DEFAULT true NOT NULL,
    d_phone boolean DEFAULT true NOT NULL,
    d_phone_alt boolean DEFAULT true NOT NULL,
    d_phone_fax boolean DEFAULT true NOT NULL,
    d_phone_mobile boolean DEFAULT true NOT NULL
);


--
-- Name: distinction_instances_distinction_instance_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE distinction_instances_distinction_instance_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: distinction_instances; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE distinction_instances (
    distinction_instance_id integer DEFAULT nextval('distinction_instances_distinction_instance_id_seq'::regclass) NOT NULL,
    distinction_id integer NOT NULL,
    role_id integer,
    event_id integer,
    status_id integer NOT NULL,
    instance_info text,
    award_year integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    updated_by integer NOT NULL
);


--
-- Name: distinction_relationships_distinction_relationship_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE distinction_relationships_distinction_relationship_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: distinction_relationships; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE distinction_relationships (
    distinction_relationship_id integer DEFAULT nextval('distinction_relationships_distinction_relationship_id_seq'::regclass) NOT NULL,
    relationship_id integer NOT NULL,
    relationship_type_id integer NOT NULL,
    distinction_instance_id integer NOT NULL,
    is_dominant_entity boolean DEFAULT true NOT NULL
);


--
-- Name: distinctions_distinction_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE distinctions_distinction_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: distinctions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE distinctions (
    distinction_id integer DEFAULT nextval('distinctions_distinction_id_seq'::regclass) NOT NULL,
    contactinfo_id integer NOT NULL,
    status_id integer NOT NULL,
    award_name text NOT NULL,
    award_name_alt text,
    award_info text,
    awarded_since_year integer,
    frequency text,
    currently_awarded boolean DEFAULT false,
    general_note text,
    internal_note text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    updated_by integer NOT NULL,
    CONSTRAINT ckc_awarded_since_yea_distinct CHECK (((awarded_since_year IS NULL) OR ((awarded_since_year >= 0) AND (awarded_since_year <= 9999))))
);


--
-- Name: email_archive_archive_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE email_archive_archive_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: entity_relationship_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE entity_relationship_types (
    relationship_type_id integer NOT NULL,
    entity_type_id integer NOT NULL
);


--
-- Name: entity_types_entity_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE entity_types_entity_type_id_seq
    START WITH 12
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: entity_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE entity_types (
    entity_type_id integer DEFAULT nextval('entity_types_entity_type_id_seq'::regclass) NOT NULL,
    entity_type text NOT NULL
);


--
-- Name: events_event_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE events_event_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: events; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE events (
    event_id integer DEFAULT nextval('events_event_id_seq'::regclass) NOT NULL,
    event_type_id integer NOT NULL,
    contactinfo_id integer NOT NULL,
    related_event_id integer,
    status_id integer NOT NULL,
    event_title text NOT NULL,
    event_start timestamp without time zone,
    event_finish timestamp without time zone,
    supress_times boolean DEFAULT false NOT NULL,
    entry_deadline timestamp without time zone,
    entry_anonymous boolean DEFAULT false,
    entry_age_limit text,
    entry_fee_note text,
    prize_info_note text,
    tickets_note text,
    general_note text,
    internal_note text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    updated_by integer NOT NULL
);


--
-- Name: event_advanced_search; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW event_advanced_search AS
    SELECT e.event_id, e.status_id, e.event_type_id, c.contactinfo_id, c.region_id, c.locality, e.event_start, e.event_finish FROM (events e LEFT JOIN contactinfos c ON ((c.contactinfo_id = e.contactinfo_id))) ORDER BY e.event_id;


--
-- Name: event_attachments_event_attachment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE event_attachments_event_attachment_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: event_attachments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE event_attachments (
    event_attachment_id integer DEFAULT nextval('event_attachments_event_attachment_id_seq'::regclass) NOT NULL,
    attachment_type_id integer NOT NULL,
    event_id integer NOT NULL,
    media_item_id integer NOT NULL
);


--
-- Name: event_relationships_event_relationship_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE event_relationships_event_relationship_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: event_relationships; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE event_relationships (
    event_relationship_id integer DEFAULT nextval('event_relationships_event_relationship_id_seq'::regclass) NOT NULL,
    relationship_id integer NOT NULL,
    relationship_type_id integer,
    event_id integer NOT NULL,
    is_dominant_entity boolean DEFAULT true NOT NULL
);


--
-- Name: event_types_event_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE event_types_event_type_id_seq
    START WITH 19
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: event_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE event_types (
    event_type_id integer DEFAULT nextval('event_types_event_type_id_seq'::regclass) NOT NULL,
    event_type_desc text NOT NULL
);


--
-- Name: exam_set_works_exam_set_work_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE exam_set_works_exam_set_work_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: exam_set_works; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE exam_set_works (
    exam_set_work_id integer DEFAULT nextval('exam_set_works_exam_set_work_id_seq'::regclass) NOT NULL,
    manifestation_id integer NOT NULL,
    examboard_id integer NOT NULL,
    grade_notes text
);


--
-- Name: examboards_examboard_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE examboards_examboard_id_seq
    START WITH 8
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: examboards; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE examboards (
    examboard_id integer DEFAULT nextval('examboards_examboard_id_seq'::regclass) NOT NULL,
    examboard_name text NOT NULL
);


--
-- Name: expression_access_rights_expression_access_right_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE expression_access_rights_expression_access_right_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: expression_access_rights; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE expression_access_rights (
    expression_access_right_id integer DEFAULT nextval('expression_access_rights_expression_access_right_id_seq'::regclass) NOT NULL,
    expression_id integer NOT NULL,
    access_right_id integer NOT NULL,
    access_right_source text NOT NULL,
    CONSTRAINT ckc_access_right_sour_expressi CHECK (((access_right_source = 'composer'::text) OR (access_right_source = 'publisher'::text)))
);


--
-- Name: expression_languages_expression_language_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE expression_languages_expression_language_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: expression_languages; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE expression_languages (
    expression_language_id integer DEFAULT nextval('expression_languages_expression_language_id_seq'::regclass) NOT NULL,
    expression_id integer NOT NULL,
    language_id integer NOT NULL
);


--
-- Name: expression_manifestations_expression_manifestation_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE expression_manifestations_expression_manifestation_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: expression_manifestations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE expression_manifestations (
    expression_manifestation_id integer DEFAULT nextval('expression_manifestations_expression_manifestation_id_seq'::regclass) NOT NULL,
    manifestation_id integer NOT NULL,
    expression_id integer NOT NULL,
    expression_order integer
);


--
-- Name: expression_relationships_expression_relationship_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE expression_relationships_expression_relationship_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: expression_relationships; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE expression_relationships (
    expression_relationship_id integer DEFAULT nextval('expression_relationships_expression_relationship_id_seq'::regclass) NOT NULL,
    relationship_type_id integer NOT NULL,
    relationship_id integer NOT NULL,
    expression_id integer NOT NULL,
    is_dominant_entity boolean DEFAULT true NOT NULL
);


--
-- Name: expressions_expression_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE expressions_expression_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: expressions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE expressions (
    expression_id integer DEFAULT nextval('expressions_expression_id_seq'::regclass) NOT NULL,
    work_id integer NOT NULL,
    mode_id integer NOT NULL,
    expression_title text,
    status_id integer NOT NULL,
    expression_start timestamp without time zone,
    expression_finish timestamp without time zone,
    supress_times boolean DEFAULT false NOT NULL,
    partial_expression boolean DEFAULT false,
    partial_expression_note text,
    premiere character(3),
    edition character(3) DEFAULT ''::bpchar,
    players_count integer,
    use_restriction_note text DEFAULT 'available'::text NOT NULL,
    general_note text,
    internal_note text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    updated_by integer NOT NULL,
    CONSTRAINT ckc_edition_expressi CHECK (((edition IS NULL) OR ((((edition = ''::bpchar) OR (edition = 'ORG'::bpchar)) OR (edition = 'RFP'::bpchar)) OR (edition = 'GEN'::bpchar)))),
    CONSTRAINT ckc_premiere_expressi CHECK (((premiere IS NULL) OR (((premiere = 'NA'::bpchar) OR (premiere = 'NZ'::bpchar)) OR (premiere = 'W'::bpchar)))),
    CONSTRAINT ckc_use_restriction_n_expressi CHECK (((use_restriction_note = 'available'::text) OR (use_restriction_note = 'unavailable'::text)))
);


--
-- Name: ezpages_pages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ezpages_pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: featured_featured_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE featured_featured_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: files_uploaded_files_uploaded_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE files_uploaded_files_uploaded_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: formats_format_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE formats_format_id_seq
    START WITH 32
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: formats; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE formats (
    format_id integer DEFAULT nextval('formats_format_id_seq'::regclass) NOT NULL,
    format_desc text NOT NULL,
    manifestation_format boolean DEFAULT false NOT NULL,
    resource_format boolean DEFAULT false NOT NULL
);


--
-- Name: geo_zones_geo_zone_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE geo_zones_geo_zone_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: group_pricing_group_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE group_pricing_group_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: item_types_item_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE item_types_item_type_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: item_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE item_types (
    item_type_id integer DEFAULT nextval('item_types_item_type_id_seq'::regclass) NOT NULL,
    item_type_desc text NOT NULL,
    display_order integer DEFAULT 0 NOT NULL
);


--
-- Name: items_item_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE items_item_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: items; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE items (
    item_id integer DEFAULT nextval('items_item_id_seq'::regclass) NOT NULL,
    resource_id integer,
    item_type_id integer NOT NULL,
    manifestation_id integer,
    status_id integer NOT NULL,
    item_category character(1) DEFAULT 'M'::bpchar NOT NULL,
    item_location text,
    physical_description text,
    internal_note text,
    out_on_loan_or_hire boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    updated_by integer NOT NULL,
    borrowed_date timestamp without time zone,
    return_date timestamp without time zone,
    login_id integer,
    CONSTRAINT ckc_item_category_items CHECK (((item_category = 'R'::bpchar) OR (item_category = 'M'::bpchar)))
);


--
-- Name: languages_language_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE languages_language_id_seq
    START WITH 33
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: languages; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE languages (
    language_id integer DEFAULT nextval('languages_language_id_seq'::regclass) NOT NULL,
    language_name text NOT NULL,
    char_encoding text,
    is_default boolean DEFAULT false NOT NULL,
    display_order integer DEFAULT 0 NOT NULL
);


--
-- Name: languages_languages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE languages_languages_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: layout_boxes_layout_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE layout_boxes_layout_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: logins_login_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE logins_login_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: logins; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE logins (
    login_id integer DEFAULT nextval('logins_login_id_seq'::regclass) NOT NULL,
    organisation_id integer,
    person_id integer,
    login_agent_class character(1) DEFAULT 'P'::bpchar NOT NULL,
    username text NOT NULL,
    "password" text NOT NULL,
    salt text NOT NULL,
    password_valid_until timestamp without time zone,
    password_forever boolean DEFAULT false NOT NULL,
    locked boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    login_fail_count integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    updated_by integer,
    moneyworks_name text,
    CONSTRAINT ckc_login_agent_class_logins CHECK ((((login_agent_class = 'P'::bpchar) OR (login_agent_class = 'O'::bpchar)) OR (login_agent_class = 'G'::bpchar)))
);


--
-- Name: mailout_attachments_mailout_attachment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mailout_attachments_mailout_attachment_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: mailout_attachments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE mailout_attachments (
    mailout_attachment_id integer DEFAULT nextval('mailout_attachments_mailout_attachment_id_seq'::regclass) NOT NULL,
    attachment_type_id integer NOT NULL,
    campaign_mailout_id integer NOT NULL,
    media_item_id integer NOT NULL
);


--
-- Name: mailout_contacts_mailout_contact_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mailout_contacts_mailout_contact_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: mailout_contacts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE mailout_contacts (
    mailout_contact_id integer DEFAULT nextval('mailout_contacts_mailout_contact_id_seq'::regclass) NOT NULL,
    role_contactinfo_id integer,
    campaign_mailout_id integer NOT NULL,
    salutation text,
    name text,
    address_line1 text,
    address_line2 text,
    address_line3 text,
    address_line4 text,
    address_line5 text,
    address_line6 text,
    address_line7 text,
    email text,
    phone text,
    fax text,
    mobile_sms text,
    delivery_failed boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    updated_by integer NOT NULL,
    delivery_timestamp timestamp without time zone,
    nomen text,
    building text,
    street text,
    po_box text,
    suburb text,
    locality text,
    postcode text,
    region text,
    country text,
    role_title text,
    organisation_name text
);


--
-- Name: manifestation_access_rights_manifestation_access_right_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE manifestation_access_rights_manifestation_access_right_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: manifestation_access_rights; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE manifestation_access_rights (
    manifestation_access_right_id integer DEFAULT nextval('manifestation_access_rights_manifestation_access_right_id_seq'::regclass) NOT NULL,
    access_right_id integer NOT NULL,
    manifestation_id integer NOT NULL,
    access_right_source text NOT NULL,
    CONSTRAINT ckc_access_right_sour_manifest CHECK (((access_right_source = 'composer'::text) OR (access_right_source = 'publisher'::text)))
);


--
-- Name: manifestation_type_formats_manifestation_type_format_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE manifestation_type_formats_manifestation_type_format_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: manifestation_type_formats; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE manifestation_type_formats (
    manifestation_type_format_id integer DEFAULT nextval('manifestation_type_formats_manifestation_type_format_id_seq'::regclass) NOT NULL,
    manifestation_type_id integer NOT NULL,
    format_id integer NOT NULL
);


--
-- Name: manifestation_types_manifestation_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE manifestation_types_manifestation_type_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: manifestation_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE manifestation_types (
    manifestation_type_id integer DEFAULT nextval('manifestation_types_manifestation_type_id_seq'::regclass) NOT NULL,
    manifestation_type_desc text NOT NULL,
    manifestation_type_category integer,
    CONSTRAINT ckc_manifestation_typ_manifest CHECK (((manifestation_type_category IS NULL) OR (((manifestation_type_category = 1) OR (manifestation_type_category = 2)) OR (manifestation_type_category = 3))))
);


--
-- Name: manifestations_manifestation_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE manifestations_manifestation_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: sounz_product_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sounz_product_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: manifestations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE manifestations (
    manifestation_id integer DEFAULT nextval('manifestations_manifestation_id_seq'::regclass) NOT NULL,
    manifestation_type_id integer NOT NULL,
    format_id integer NOT NULL,
    status_id integer NOT NULL,
    manifestation_title text NOT NULL,
    manifestation_title_alt text,
    series_title text,
    publication_year integer,
    isbn text,
    ismn text,
    isrc text,
    issn text,
    imprint text,
    copyright text,
    collation text,
    duration interval,
    dedication_note text,
    publisher_note text,
    content_note text,
    general_note text,
    internal_note text,
    manifestation_code integer NOT NULL,
    mw_code text,
    clonable boolean DEFAULT false NOT NULL,
    available_for_loan boolean DEFAULT false NOT NULL,
    available_for_hire boolean DEFAULT false NOT NULL,
    available_for_sale boolean DEFAULT false NOT NULL,
    item_cost numeric DEFAULT 0.00,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    updated_by integer NOT NULL,
    downloadable boolean DEFAULT false NOT NULL,
    freight_code integer,
    download_file_name text,
    sale_product_id integer DEFAULT nextval('sounz_product_id_seq'::regclass) NOT NULL,
    loan_product_id integer DEFAULT nextval('sounz_product_id_seq'::regclass) NOT NULL,
    download_file_name_2 text,
    CONSTRAINT ckc_publication_year_manifest CHECK (((publication_year IS NULL) OR ((publication_year >= 0) AND (publication_year <= 9999))))
);


--
-- Name: manifestation_advanced_search; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW manifestation_advanced_search AS
    SELECT m.manifestation_id, m.status_id, rt.manifestation_type_id, f.format_id, m.clonable, m.available_for_loan, m.available_for_hire, m.available_for_sale FROM (((manifestations m LEFT JOIN manifestation_types rt ON ((rt.manifestation_type_id = m.manifestation_type_id))) LEFT JOIN manifestation_type_formats rtf ON ((rtf.manifestation_type_format_id = m.format_id))) LEFT JOIN formats f ON ((f.format_id = m.format_id))) ORDER BY m.manifestation_id;


--
-- Name: manifestation_attachments_manifestation_attachment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE manifestation_attachments_manifestation_attachment_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: manifestation_attachments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE manifestation_attachments (
    manifestation_attachment_id integer DEFAULT nextval('manifestation_attachments_manifestation_attachment_id_seq'::regclass) NOT NULL,
    attachment_type_id integer NOT NULL,
    manifestation_id integer NOT NULL,
    media_item_id integer NOT NULL
);


--
-- Name: manifestation_relationships_manifestation_relationship_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE manifestation_relationships_manifestation_relationship_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: manifestation_relationships; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE manifestation_relationships (
    manifestation_relationship_id integer DEFAULT nextval('manifestation_relationships_manifestation_relationship_id_seq'::regclass) NOT NULL,
    relationship_id integer NOT NULL,
    relationship_type_id integer NOT NULL,
    manifestation_id integer NOT NULL,
    is_dominant_entity boolean DEFAULT true NOT NULL
);


--
-- Name: manufacturers_manufacturers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE manufacturers_manufacturers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: marketing_campaigns_marketing_campaign_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE marketing_campaigns_marketing_campaign_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: marketing_campaigns; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE marketing_campaigns (
    marketing_campaign_id integer DEFAULT nextval('marketing_campaigns_marketing_campaign_id_seq'::regclass) NOT NULL,
    project_id integer NOT NULL,
    campaign_manager integer,
    campaign_name text NOT NULL,
    campaign_description text,
    campaign_status character(1) DEFAULT 'i'::bpchar NOT NULL,
    finished_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    updated_by integer NOT NULL,
    CONSTRAINT ckc_campaign_status_marketin CHECK (((campaign_status = 'i'::bpchar) OR (campaign_status = 'f'::bpchar)))
);


--
-- Name: marketing_categories_marketing_category_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE marketing_categories_marketing_category_id_seq
    START WITH 26
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: marketing_categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE marketing_categories (
    marketing_category_id integer DEFAULT nextval('marketing_categories_marketing_category_id_seq'::regclass) NOT NULL,
    description text NOT NULL,
    abbreviation text NOT NULL,
    display_order integer DEFAULT 0 NOT NULL
);


--
-- Name: marketing_subcategories_marketing_subcategory_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE marketing_subcategories_marketing_subcategory_id_seq
    START WITH 130
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: marketing_subcategories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE marketing_subcategories (
    marketing_subcategory_id integer DEFAULT nextval('marketing_subcategories_marketing_subcategory_id_seq'::regclass) NOT NULL,
    marketing_category_id integer NOT NULL,
    description text NOT NULL,
    abbreviation text NOT NULL,
    display_order integer DEFAULT 0 NOT NULL
);


--
-- Name: media_clips_clip_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE media_clips_clip_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: media_items_media_item_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE media_items_media_item_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: media_items; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE media_items (
    media_item_id integer DEFAULT nextval('media_items_media_item_id_seq'::regclass) NOT NULL,
    parent_id integer,
    mime_type_id integer,
    media_item_path text,
    media_item_desc text,
    caption text,
    width integer,
    height integer,
    size integer,
    filename text,
    thumbnail text,
    content_type text,
    copyright text,
    internal_note text,
    available_for_use boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    updated_by integer
);


--
-- Name: media_manager_media_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE media_manager_media_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: media_types_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE media_types_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: member_type_privileges_member_type_privilege_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE member_type_privileges_member_type_privilege_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: member_type_privileges; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE member_type_privileges (
    member_type_privilege_id integer DEFAULT nextval('member_type_privileges_member_type_privilege_id_seq'::regclass) NOT NULL,
    member_type_id integer NOT NULL,
    privilege_id integer NOT NULL
);


--
-- Name: member_types_member_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE member_types_member_type_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: member_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE member_types (
    member_type_id integer DEFAULT nextval('member_types_member_type_id_seq'::regclass) NOT NULL,
    member_type_desc text NOT NULL
);


--
-- Name: memberships_membership_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE memberships_membership_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: memberships; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE memberships (
    membership_id integer DEFAULT nextval('memberships_membership_id_seq'::regclass) NOT NULL,
    login_id integer NOT NULL,
    member_type_id integer NOT NULL,
    expiry_date timestamp without time zone,
    pending_payment boolean DEFAULT true,
    purchased_date timestamp without time zone,
    renewed_date timestamp without time zone,
    zencart_order_id integer,
    loan_count integer
);


--
-- Name: mime_categories_mime_category_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mime_categories_mime_category_id_seq
    START WITH 3
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: mime_categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE mime_categories (
    mime_category_id integer DEFAULT nextval('mime_categories_mime_category_id_seq'::regclass) NOT NULL,
    mime_category_desc text NOT NULL
);


--
-- Name: mime_types_mime_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mime_types_mime_type_id_seq
    START WITH 4
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: mime_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE mime_types (
    mime_type_id integer DEFAULT nextval('mime_types_mime_type_id_seq'::regclass) NOT NULL,
    mime_category_id integer NOT NULL,
    mime_type_desc text NOT NULL,
    display_order integer DEFAULT 0 NOT NULL
);


--
-- Name: modes_mode_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE modes_mode_id_seq
    START WITH 6
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: modes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE modes (
    mode_id integer DEFAULT nextval('modes_mode_id_seq'::regclass) NOT NULL,
    mode_desc text NOT NULL
);


--
-- Name: music_genre_music_genre_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE music_genre_music_genre_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: news_article_attachments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE news_article_attachments (
    news_article_attachment_id integer NOT NULL,
    media_item_id integer NOT NULL,
    news_article_id integer NOT NULL,
    attachment_type_id integer NOT NULL
);


--
-- Name: news_article_attachments_news_article_attachment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE news_article_attachments_news_article_attachment_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: news_article_attachments_news_article_attachment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE news_article_attachments_news_article_attachment_id_seq OWNED BY news_article_attachments.news_article_attachment_id;


--
-- Name: news_articles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE news_articles (
    news_article_id integer NOT NULL,
    headline text NOT NULL,
    content text,
    precis text,
    article_timestamp timestamp without time zone,
    article_type text DEFAULT 'n'::text NOT NULL,
    feature boolean DEFAULT false NOT NULL,
    archived boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    updated_by integer NOT NULL,
    status_id integer NOT NULL,
    CONSTRAINT ckc_article_type_news_art CHECK (((article_type = 'n'::text) OR (article_type = 'p'::text)))
);


--
-- Name: news_articles_news_article_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE news_articles_news_article_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: news_articles_news_article_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE news_articles_news_article_id_seq OWNED BY news_articles.news_article_id;


--
-- Name: newsletters_newsletters_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE newsletters_newsletters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: nomens_nomen_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE nomens_nomen_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: nomens; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE nomens (
    nomen_id integer DEFAULT nextval('nomens_nomen_id_seq'::regclass) NOT NULL,
    nomen text,
    display_order integer DEFAULT 0 NOT NULL
);


--
-- Name: orders_orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE orders_orders_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: orders_products_attributes_orders_products_attributes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE orders_products_attributes_orders_products_attributes_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: orders_products_download_orders_products_download_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE orders_products_download_orders_products_download_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: orders_products_orders_products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE orders_products_orders_products_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: orders_status_history_orders_status_history_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE orders_status_history_orders_status_history_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: orders_total_orders_total_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE orders_total_orders_total_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: organisation_attachments_organisation_attachment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE organisation_attachments_organisation_attachment_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: organisation_attachments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE organisation_attachments (
    organisation_attachment_id integer DEFAULT nextval('organisation_attachments_organisation_attachment_id_seq'::regclass) NOT NULL,
    attachment_type_id integer NOT NULL,
    organisation_id integer NOT NULL,
    media_item_id integer NOT NULL
);


--
-- Name: paypal_payment_status_history_payment_status_history_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE paypal_payment_status_history_payment_status_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: paypal_payment_status_payment_status_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE paypal_payment_status_payment_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: paypal_paypal_ipn_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE paypal_paypal_ipn_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: paypal_session_unique_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE paypal_session_unique_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: paypal_testing_paypal_ipn_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE paypal_testing_paypal_ipn_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: person_attachments_person_attachment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE person_attachments_person_attachment_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: person_attachments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE person_attachments (
    person_attachment_id integer DEFAULT nextval('person_attachments_person_attachment_id_seq'::regclass) NOT NULL,
    attachment_type_id integer NOT NULL,
    person_id integer NOT NULL,
    media_item_id integer NOT NULL
);


--
-- Name: privileges_privilege_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE privileges_privilege_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: privileges; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE "privileges" (
    privilege_id integer DEFAULT nextval('privileges_privilege_id_seq'::regclass) NOT NULL,
    privilege_name text NOT NULL,
    privilege_desc text
);


--
-- Name: product_type_layout_configuration_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE product_type_layout_configuration_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: product_types_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE product_types_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: products_attributes_products_attributes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE products_attributes_products_attributes_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: products_description_products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE products_description_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: products_products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE products_products_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: project_team_members_project_team_member_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE project_team_members_project_team_member_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: project_team_members; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE project_team_members (
    project_team_member_id integer DEFAULT nextval('project_team_members_project_team_member_id_seq'::regclass) NOT NULL,
    project_id integer NOT NULL,
    person_id integer NOT NULL,
    manager boolean DEFAULT false NOT NULL
);


--
-- Name: project_version_history_project_version_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE project_version_history_project_version_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: project_version_project_version_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE project_version_project_version_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: projects_project_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE projects_project_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE projects (
    project_id integer DEFAULT nextval('projects_project_id_seq'::regclass) NOT NULL,
    project_status integer DEFAULT 0 NOT NULL,
    project_title text NOT NULL,
    project_description text,
    start_date timestamp without time zone,
    proposed_finish_date timestamp without time zone,
    actual_finish_date timestamp without time zone,
    internal_note text,
    general_note text,
    for_public_display boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    updated_by integer NOT NULL,
    CONSTRAINT ckc_project_status_projects CHECK ((((project_status = 0) OR (project_status = 1)) OR (project_status = 2)))
);


--
-- Name: prov_composer_bios; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE prov_composer_bios (
    prov_composer_bio_id integer NOT NULL,
    status_id integer NOT NULL,
    name text,
    email text,
    date_of_birth text,
    replacing_bio boolean DEFAULT false NOT NULL,
    amending_bio boolean DEFAULT false NOT NULL,
    bio text,
    author_or_source text,
    pull_quote text,
    attaching_photo boolean DEFAULT false NOT NULL,
    photo_credit text,
    website text,
    awards text,
    publisher_info text,
    use_my_current_works boolean DEFAULT false NOT NULL,
    selected_works_to_delete text,
    selected_works_to_add text,
    genres_and_influences text,
    influence_maori boolean DEFAULT false NOT NULL,
    influence_landscape boolean DEFAULT false NOT NULL,
    influence_culture_nz boolean DEFAULT false NOT NULL,
    influence_culture_pacific boolean DEFAULT false NOT NULL,
    influence_culture_other boolean DEFAULT false NOT NULL,
    influence_religion_spirit boolean DEFAULT false NOT NULL,
    influence_lang_lit boolean DEFAULT false NOT NULL,
    influence_perf_or_visual boolean DEFAULT false NOT NULL,
    influence_politics boolean DEFAULT false NOT NULL,
    influence_history boolean DEFAULT false NOT NULL,
    influence_maths_science boolean DEFAULT false NOT NULL,
    influence_none_abstract boolean DEFAULT false NOT NULL,
    pub_licence_already boolean DEFAULT false NOT NULL,
    pub_licence_forms_send boolean DEFAULT false NOT NULL,
    member_canz boolean DEFAULT false NOT NULL,
    member_apra boolean DEFAULT false NOT NULL,
    other_contact text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    submitted_by integer NOT NULL
);


--
-- Name: prov_composer_bios_prov_composer_bio_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE prov_composer_bios_prov_composer_bio_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: prov_composer_bios_prov_composer_bio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE prov_composer_bios_prov_composer_bio_id_seq OWNED BY prov_composer_bios.prov_composer_bio_id;


--
-- Name: prov_contact_updates; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE prov_contact_updates (
    prov_contact_update_id integer NOT NULL,
    status_id integer NOT NULL,
    name text,
    email text,
    new_contact boolean DEFAULT false NOT NULL,
    existing_contact boolean DEFAULT false NOT NULL,
    nomen_none boolean DEFAULT false NOT NULL,
    nomen_mr boolean DEFAULT false NOT NULL,
    nomen_ms boolean DEFAULT false NOT NULL,
    nomen_mrs boolean DEFAULT false NOT NULL,
    nomen_mme boolean DEFAULT false NOT NULL,
    nomen_dr boolean DEFAULT false NOT NULL,
    nomen_prof boolean DEFAULT false NOT NULL,
    nomen_lady boolean DEFAULT false NOT NULL,
    nomen_sir boolean DEFAULT false NOT NULL,
    nomen_dame boolean DEFAULT false NOT NULL,
    nomen_miss boolean DEFAULT false NOT NULL,
    job_title text,
    organisation text,
    postal_address text,
    postcode text,
    physical_address text,
    phone_home text,
    phone_work text,
    phone_fax text,
    phone_mobile text,
    website text,
    pref_comm_method_email boolean DEFAULT false NOT NULL,
    pref_comm_method_phone boolean DEFAULT false NOT NULL,
    pref_comm_method_fax boolean DEFAULT false NOT NULL,
    pref_comm_method_post boolean DEFAULT false NOT NULL,
    other_info text,
    send_sounz_news_email boolean DEFAULT false NOT NULL,
    send_sounz_events_post boolean DEFAULT false NOT NULL,
    send_sounz_events_email boolean DEFAULT false NOT NULL,
    send_sounz_updates boolean DEFAULT false NOT NULL,
    send_donor_info boolean DEFAULT false NOT NULL,
    send_bequest_info boolean DEFAULT false NOT NULL,
    send_sounz_news_post boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    submitted_by integer NOT NULL
);


--
-- Name: prov_contact_updates_prov_contact_update_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE prov_contact_updates_prov_contact_update_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: prov_contact_updates_prov_contact_update_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE prov_contact_updates_prov_contact_update_id_seq OWNED BY prov_contact_updates.prov_contact_update_id;


--
-- Name: prov_contributor_profiles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE prov_contributor_profiles (
    prov_contributor_profile_id integer NOT NULL,
    status_id integer NOT NULL,
    name text,
    email text,
    date_of_est_birth text,
    new_profile boolean DEFAULT false NOT NULL,
    updated_profile boolean DEFAULT false NOT NULL,
    profile text,
    author_or_source text,
    attaching_photo boolean DEFAULT false,
    photo_credit text,
    attaching_logo boolean DEFAULT false NOT NULL,
    website text,
    awards text,
    other_contact text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    submitted_by integer NOT NULL
);


--
-- Name: prov_contributor_profiles_prov_contributor_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE prov_contributor_profiles_prov_contributor_profile_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: prov_contributor_profiles_prov_contributor_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE prov_contributor_profiles_prov_contributor_profile_id_seq OWNED BY prov_contributor_profiles.prov_contributor_profile_id;


--
-- Name: prov_events; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE prov_events (
    prov_event_id integer NOT NULL,
    status_id integer NOT NULL,
    name text,
    email text,
    event_name text,
    type_concert boolean DEFAULT false NOT NULL,
    type_seminar boolean DEFAULT false NOT NULL,
    type_film boolean DEFAULT false NOT NULL,
    type_workshop_reading boolean DEFAULT false NOT NULL,
    type_dance_performance boolean DEFAULT false NOT NULL,
    type_exhibition_installation boolean DEFAULT false NOT NULL,
    type_theatre boolean DEFAULT false NOT NULL,
    type_broadcast boolean DEFAULT false NOT NULL,
    type_launch boolean DEFAULT false NOT NULL,
    type_rehearsal boolean DEFAULT false NOT NULL,
    type_pre_concert_talk boolean DEFAULT false NOT NULL,
    type_opera_musical boolean DEFAULT false NOT NULL,
    type_ceremony boolean DEFAULT false NOT NULL,
    type_opportunity boolean DEFAULT false NOT NULL,
    part_of_conference boolean DEFAULT false NOT NULL,
    part_of_festival boolean DEFAULT false NOT NULL,
    part_of_tour boolean DEFAULT false NOT NULL,
    part_of_season boolean DEFAULT false NOT NULL,
    umbrella_event text,
    venue text,
    venue_address text,
    event_start_date text,
    event_start_time text,
    event_finish_date text,
    event_finish_time text,
    presenter text,
    event_notes text,
    composers text,
    performers text,
    booking_email text,
    booking_phone text,
    booking_mobile text,
    booking_fax text,
    booking_note text,
    other_info text,
    attachment_info text,
    booking_website text,
    "work" text,
    send_sounz_news_post boolean DEFAULT false NOT NULL,
    send_sounz_news_email boolean DEFAULT false NOT NULL,
    send_sounz_events_post boolean DEFAULT false NOT NULL,
    send_sounz_events_email boolean DEFAULT false NOT NULL,
    send_sounz_updates boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    submitted_by integer NOT NULL
);


--
-- Name: prov_events_prov_event_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE prov_events_prov_event_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: prov_events_prov_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE prov_events_prov_event_id_seq OWNED BY prov_events.prov_event_id;


--
-- Name: prov_feedbacks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE prov_feedbacks (
    prov_feedback_id integer NOT NULL,
    status_id integer NOT NULL,
    visit_daily boolean DEFAULT false NOT NULL,
    visit_weekly boolean DEFAULT false NOT NULL,
    visit_monthly boolean DEFAULT false NOT NULL,
    visit_as_needed boolean DEFAULT false NOT NULL,
    use_educator boolean DEFAULT false NOT NULL,
    use_student boolean DEFAULT false NOT NULL,
    use_performer boolean DEFAULT false NOT NULL,
    use_composer boolean DEFAULT false NOT NULL,
    use_conductor boolean DEFAULT false NOT NULL,
    use_arts_mgr boolean DEFAULT false NOT NULL,
    use_customer boolean DEFAULT false NOT NULL,
    use_member boolean DEFAULT false NOT NULL,
    use_retailer boolean DEFAULT false NOT NULL,
    use_other boolean DEFAULT false NOT NULL,
    find_what boolean DEFAULT false NOT NULL,
    how_improve_website text,
    how_improve_services text,
    how_improve_resources text,
    comments text,
    respond_contact text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    submitted_by integer
);


--
-- Name: prov_feedbacks_prov_feedback_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE prov_feedbacks_prov_feedback_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: prov_feedbacks_prov_feedback_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE prov_feedbacks_prov_feedback_id_seq OWNED BY prov_feedbacks.prov_feedback_id;


--
-- Name: prov_work_updates; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE prov_work_updates (
    prov_work_update_id integer NOT NULL,
    status_id integer NOT NULL,
    name text,
    email text,
    work_title text,
    composed_by text,
    description text,
    instrumentation text,
    work_duration text,
    difficulty_beginner boolean DEFAULT false NOT NULL,
    difficulty_intermediate boolean DEFAULT false NOT NULL,
    difficulty_advanced boolean DEFAULT false NOT NULL,
    suitable_for_youth boolean DEFAULT false NOT NULL,
    sacred boolean DEFAULT false,
    year_creation text,
    year_revised text,
    revision_note text,
    contents text,
    commissioning_info text,
    text_info text,
    languages text,
    dedication text,
    programme_note text,
    first_perf_day text,
    first_perf_month text,
    first_perf_year text,
    venue text,
    city text,
    performers text,
    other_performances text,
    will_lodge_score boolean DEFAULT false NOT NULL,
    will_lodge_parts boolean DEFAULT false NOT NULL,
    format_pdf boolean DEFAULT false NOT NULL,
    format_hardcopy boolean DEFAULT false NOT NULL,
    score_sample text,
    for_sale_hardcopy boolean DEFAULT false NOT NULL,
    for_sale_download boolean DEFAULT false NOT NULL,
    for_hire_parts_only boolean DEFAULT false NOT NULL,
    commercial_publish_details text,
    will_lodge_recording boolean DEFAULT false NOT NULL,
    recording_performers text,
    recording_date text,
    recording_duration text,
    recording_permission boolean DEFAULT false NOT NULL,
    pref_sample_in_minutes text,
    for_sale_download_licence boolean DEFAULT false NOT NULL,
    commercial_release_details text,
    other_materials text,
    genres_and_influences text,
    influence_maori boolean DEFAULT false,
    influence_landscape boolean DEFAULT false,
    influence_culture_nz boolean DEFAULT false,
    influence_culture_pacific boolean DEFAULT false,
    influence_culture_other boolean DEFAULT false,
    influence_religion_spirit boolean DEFAULT false,
    influence_perf_or_visual boolean DEFAULT false,
    influence_politics boolean DEFAULT false,
    influence_history boolean DEFAULT false,
    influence_maths_science boolean DEFAULT false,
    influence_none_abstract boolean DEFAULT false,
    restriction_info text,
    copyright_owner text,
    other_info text,
    influence_lang_lit boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    submitted_by integer NOT NULL
);


--
-- Name: prov_work_updates_prov_work_update_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE prov_work_updates_prov_work_update_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: prov_work_updates_prov_work_update_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE prov_work_updates_prov_work_update_id_seq OWNED BY prov_work_updates.prov_work_update_id;


--
-- Name: publishing_statuses_status_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE publishing_statuses_status_id_seq
    START WITH 6
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: publishing_statuses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE publishing_statuses (
    status_id integer DEFAULT nextval('publishing_statuses_status_id_seq'::regclass) NOT NULL,
    status_desc text NOT NULL
);


--
-- Name: query_builder_query_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE query_builder_query_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: record_artists_artists_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE record_artists_artists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: record_company_record_company_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE record_company_record_company_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: regions_region_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE regions_region_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: regions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE regions (
    region_id integer DEFAULT nextval('regions_region_id_seq'::regclass) NOT NULL,
    country_id integer NOT NULL,
    region_name text NOT NULL
);


--
-- Name: related_communications; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE related_communications (
    communication_id integer NOT NULL,
    com_communication_id integer NOT NULL
);


--
-- Name: related_organisations_related_organisation_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE related_organisations_related_organisation_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: related_organisations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE related_organisations (
    organisation_id integer NOT NULL,
    org_organisation_id integer NOT NULL,
    related_organisation_id integer DEFAULT nextval('related_organisations_related_organisation_id_seq'::regclass) NOT NULL,
    relationship text
);


--
-- Name: relationship_types_relationship_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE relationship_types_relationship_type_id_seq
    START WITH 1002
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: relationship_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE relationship_types (
    relationship_type_id integer DEFAULT nextval('relationship_types_relationship_type_id_seq'::regclass) NOT NULL,
    relationship_type_desc text NOT NULL,
    inverse integer DEFAULT 0 NOT NULL
);


--
-- Name: relationships_relationship_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE relationships_relationship_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: relationships; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE relationships (
    relationship_id integer DEFAULT nextval('relationships_relationship_id_seq'::regclass) NOT NULL,
    entity_type_id integer NOT NULL,
    ent_entity_type_id integer NOT NULL,
    relationship_notes text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    updated_by integer NOT NULL
);


--
-- Name: reserved_items_reserved_item_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE reserved_items_reserved_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: reserved_items; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE reserved_items (
    reserved_item_id integer DEFAULT nextval('reserved_items_reserved_item_id_seq'::regclass) NOT NULL,
    item_id integer NOT NULL,
    login_id integer NOT NULL,
    date_reserved date NOT NULL,
    cancelled boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: resource_access_rights_resource_access_right_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE resource_access_rights_resource_access_right_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: resource_access_rights; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE resource_access_rights (
    resource_access_right_id integer DEFAULT nextval('resource_access_rights_resource_access_right_id_seq'::regclass) NOT NULL,
    access_right_id integer NOT NULL,
    resource_id integer NOT NULL,
    access_right_source text NOT NULL,
    CONSTRAINT ckc_access_right_sour_resource CHECK (((access_right_source = 'composer'::text) OR (access_right_source = 'publisher'::text)))
);


--
-- Name: resource_type_formats_resource_type_format_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE resource_type_formats_resource_type_format_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: resource_type_formats; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE resource_type_formats (
    resource_type_format_id integer DEFAULT nextval('resource_type_formats_resource_type_format_id_seq'::regclass) NOT NULL,
    resource_type_id integer NOT NULL,
    format_id integer NOT NULL
);


--
-- Name: resource_types_resource_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE resource_types_resource_type_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: resource_types; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE resource_types (
    resource_type_id integer DEFAULT nextval('resource_types_resource_type_id_seq'::regclass) NOT NULL,
    resource_type_desc text NOT NULL
);


--
-- Name: resources_resource_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE resources_resource_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: resources; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE resources (
    resource_id integer DEFAULT nextval('resources_resource_id_seq'::regclass) NOT NULL,
    resource_type_id integer NOT NULL,
    format_id integer NOT NULL,
    status_id integer NOT NULL,
    author_note text,
    resource_title text NOT NULL,
    resource_title_alt text,
    series_title text,
    publication_year integer,
    isbn text,
    ismn text,
    isrc text,
    issn text,
    imprint text,
    copyright text,
    collation text,
    duration interval,
    dedication_note text,
    publisher_note text,
    content_note text,
    general_note text,
    internal_note text,
    resource_code integer NOT NULL,
    mw_code text,
    clonable boolean DEFAULT false NOT NULL,
    available_for_loan boolean DEFAULT false NOT NULL,
    available_for_hire boolean DEFAULT false NOT NULL,
    available_for_sale boolean DEFAULT false NOT NULL,
    item_cost numeric DEFAULT 0.00,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    updated_by integer NOT NULL,
    downloadable boolean DEFAULT false NOT NULL,
    freight_code integer,
    sale_product_id integer DEFAULT nextval('sounz_product_id_seq'::regclass) NOT NULL,
    loan_product_id integer DEFAULT nextval('sounz_product_id_seq'::regclass) NOT NULL,
    download_file_name text,
    download_file_name_2 text,
    CONSTRAINT ckc_publication_year_resource CHECK (((publication_year IS NULL) OR ((publication_year >= 0) AND (publication_year <= 9999))))
);


--
-- Name: resource_advanced_search; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW resource_advanced_search AS
    SELECT r.resource_id, r.status_id, rt.resource_type_id, f.format_id, r.clonable, r.available_for_loan, r.available_for_hire, r.available_for_sale, r.downloadable FROM (((resources r LEFT JOIN resource_types rt ON ((rt.resource_type_id = r.resource_type_id))) LEFT JOIN resource_type_formats rtf ON ((rtf.resource_type_format_id = r.format_id))) LEFT JOIN formats f ON ((f.format_id = r.format_id)));


--
-- Name: resource_attachments_resource_attachment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE resource_attachments_resource_attachment_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: resource_attachments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE resource_attachments (
    resource_attachment_id integer DEFAULT nextval('resource_attachments_resource_attachment_id_seq'::regclass) NOT NULL,
    attachment_type_id integer NOT NULL,
    resource_id integer NOT NULL,
    media_item_id integer NOT NULL
);


--
-- Name: resource_relationships_resource_relationship_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE resource_relationships_resource_relationship_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: resource_relationships; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE resource_relationships (
    resource_relationship_id integer DEFAULT nextval('resource_relationships_resource_relationship_id_seq'::regclass) NOT NULL,
    relationship_id integer NOT NULL,
    relationship_type_id integer NOT NULL,
    resource_id integer NOT NULL,
    is_dominant_entity boolean DEFAULT true NOT NULL
);


--
-- Name: reviews_reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE reviews_reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: role_categorizations_role_categorization_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE role_categorizations_role_categorization_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: role_categorizations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE role_categorizations (
    role_categorization_id integer DEFAULT nextval('role_categorizations_role_categorization_id_seq'::regclass) NOT NULL,
    role_id integer NOT NULL,
    marketing_subcategory_id integer NOT NULL
);


--
-- Name: role_relationships_role_relationship_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE role_relationships_role_relationship_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: role_relationships; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE role_relationships (
    role_relationship_id integer DEFAULT nextval('role_relationships_role_relationship_id_seq'::regclass) NOT NULL,
    relationship_id integer NOT NULL,
    role_id integer NOT NULL,
    relationship_type_id integer NOT NULL,
    is_dominant_entity boolean DEFAULT true NOT NULL
);


--
-- Name: salemaker_sales_sale_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE salemaker_sales_sale_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: sample_attachments_sample_attachment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sample_attachments_sample_attachment_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: sample_attachments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sample_attachments (
    sample_attachment_id integer DEFAULT nextval('sample_attachments_sample_attachment_id_seq'::regclass) NOT NULL,
    attachment_type_id integer NOT NULL,
    media_item_id integer NOT NULL,
    sample_id integer NOT NULL
);


--
-- Name: samples_sample_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE samples_sample_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: samples; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE samples (
    sample_id integer DEFAULT nextval('samples_sample_id_seq'::regclass) NOT NULL,
    manifestation_id integer NOT NULL,
    status_id integer NOT NULL,
    sample_description text,
    sample_copyright text,
    "location" text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    updated_by integer NOT NULL,
    expression_id integer
);


--
-- Name: saved_contact_lists_saved_contact_list_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE saved_contact_lists_saved_contact_list_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: saved_contact_lists; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE saved_contact_lists (
    saved_contact_list_id integer DEFAULT nextval('saved_contact_lists_saved_contact_list_id_seq'::regclass) NOT NULL,
    list_name text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    updated_by integer NOT NULL
);


--
-- Name: saved_role_contactinfos_saved_role_contactinfo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE saved_role_contactinfos_saved_role_contactinfo_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: saved_role_contactinfos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE saved_role_contactinfos (
    saved_role_contactinfo_id integer DEFAULT nextval('saved_role_contactinfos_saved_role_contactinfo_id_seq'::regclass) NOT NULL,
    role_contactinfo_id integer NOT NULL,
    saved_contact_list_id integer NOT NULL
);


--
-- Name: saved_searches_search_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE saved_searches_search_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: saved_searches; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE saved_searches (
    search_id integer DEFAULT nextval('saved_searches_search_id_seq'::regclass) NOT NULL,
    saved_by_login_id integer NOT NULL,
    search_name text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    updated_by integer NOT NULL,
    search_data text,
    search_type text
);


--
-- Name: seq_manifestation_code; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE seq_manifestation_code
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: seq_resource_code; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE seq_resource_code
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: settings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE settings (
    setting_id integer NOT NULL,
    setting_name text NOT NULL,
    setting_value text NOT NULL
);


--
-- Name: settings_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE settings_setting_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: settings_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE settings_setting_id_seq OWNED BY settings.setting_id;


--
-- Name: sounz_donations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sounz_donations (
    sounz_donation_id integer DEFAULT nextval('sounz_product_id_seq'::regclass) NOT NULL,
    sounz_donation_price numeric DEFAULT 0.00 NOT NULL,
    sounz_donation_description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    updated_by integer NOT NULL,
    mw_code text
);



--
-- Name: sounz_services; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sounz_services (
    sounz_service_id integer NOT NULL,
    sounz_service_name text NOT NULL,
    sounz_service_description text,
    sounz_service_price numeric DEFAULT 0.00 NOT NULL,
    subscription_duration interval,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    updated_by integer NOT NULL,
    member_type_id integer,
    zencart_tag character varying(64),
    mw_code text,
    subscription_item_count integer
);


--
-- Name: sounz_services_sounz_service_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sounz_services_sounz_service_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: sounz_services_sounz_service_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sounz_services_sounz_service_id_seq OWNED BY sounz_services.sounz_service_id;


--
-- Name: superwork_relationships_superwork_relationship_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE superwork_relationships_superwork_relationship_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: superwork_relationships; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE superwork_relationships (
    superwork_relationship_id integer DEFAULT nextval('superwork_relationships_superwork_relationship_id_seq'::regclass) NOT NULL,
    relationship_id integer NOT NULL,
    relationship_type_id integer NOT NULL,
    superwork_id integer NOT NULL,
    is_dominant_entity boolean DEFAULT true NOT NULL
);


--
-- Name: superworks_superwork_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE superworks_superwork_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: superworks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE superworks (
    superwork_id integer DEFAULT nextval('superworks_superwork_id_seq'::regclass) NOT NULL,
    status_id integer NOT NULL,
    superwork_title text NOT NULL,
    superwork_title_alt text,
    source_material_note text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    updated_by integer NOT NULL
);


--
-- Name: valid_entity_entity_relationships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE valid_entity_entity_relationships_id_seq
    START WITH 417
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: valid_entity_entity_relationships; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE valid_entity_entity_relationships (
    id integer DEFAULT nextval('valid_entity_entity_relationships_id_seq'::regclass) NOT NULL,
    entity_type_from_id integer NOT NULL,
    entity_type_to_id integer NOT NULL,
    relationship_type_id integer NOT NULL,
    ruby_method_name text NOT NULL,
    page_title text NOT NULL,
    user_maintainable boolean DEFAULT true NOT NULL
);


--
-- Name: work_access_rights_work_access_right_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE work_access_rights_work_access_right_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: work_access_rights; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE work_access_rights (
    work_access_right_id integer DEFAULT nextval('work_access_rights_work_access_right_id_seq'::regclass) NOT NULL,
    access_right_id integer NOT NULL,
    work_id integer NOT NULL,
    access_right_source text NOT NULL,
    CONSTRAINT ckc_access_right_sour_work_acc CHECK (((access_right_source = 'composer'::text) OR (access_right_source = 'publisher'::text)))
);


--
-- Name: work_attachments_work_attachment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE work_attachments_work_attachment_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: work_attachments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE work_attachments (
    work_attachment_id integer DEFAULT nextval('work_attachments_work_attachment_id_seq'::regclass) NOT NULL,
    attachment_type_id integer NOT NULL,
    work_id integer NOT NULL,
    media_item_id integer NOT NULL
);


--
-- Name: work_categories_work_category_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE work_categories_work_category_id_seq
    START WITH 18
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: work_categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE work_categories (
    work_category_id integer DEFAULT nextval('work_categories_work_category_id_seq'::regclass) NOT NULL,
    work_category_desc text NOT NULL,
    work_category_abbrev text NOT NULL,
    additional boolean DEFAULT false NOT NULL,
    display_order integer DEFAULT 0 NOT NULL
);


--
-- Name: work_categorizations_work_categorization_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE work_categorizations_work_categorization_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: work_categorizations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE work_categorizations (
    work_categorization_id integer DEFAULT nextval('work_categorizations_work_categorization_id_seq'::regclass) NOT NULL,
    work_subcategory_id integer NOT NULL,
    work_id integer NOT NULL
);


--
-- Name: work_relationships_work_relationship_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE work_relationships_work_relationship_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: work_relationships; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE work_relationships (
    work_relationship_id integer DEFAULT nextval('work_relationships_work_relationship_id_seq'::regclass) NOT NULL,
    relationship_id integer NOT NULL,
    relationship_type_id integer NOT NULL,
    work_id integer NOT NULL,
    is_dominant_entity boolean DEFAULT true NOT NULL
);


--
-- Name: work_subcategories_work_subcategory_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE work_subcategories_work_subcategory_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: work_subcategories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE work_subcategories (
    work_subcategory_id integer DEFAULT nextval('work_subcategories_work_subcategory_id_seq'::regclass) NOT NULL,
    work_category_id integer NOT NULL,
    work_subcategory_desc text NOT NULL,
    legacy_4d_identity_code text NOT NULL,
    additional boolean DEFAULT false NOT NULL,
    display_order integer DEFAULT 0 NOT NULL
);


--
-- Name: works_work_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE works_work_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: works; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE works (
    work_id integer DEFAULT nextval('works_work_id_seq'::regclass) NOT NULL,
    work_subcategory_id integer NOT NULL,
    superwork_id integer NOT NULL,
    status_id integer NOT NULL,
    work_title text NOT NULL,
    work_description text,
    intended_duration interval,
    duration_varies boolean DEFAULT false NOT NULL,
    no_duration boolean DEFAULT false NOT NULL,
    difficulty integer DEFAULT 0,
    difficulty_note text,
    applicable_for_youth boolean DEFAULT false NOT NULL,
    year_of_creation integer,
    year_of_revision integer,
    instrumentation text,
    programme_note text,
    text_note text,
    internal_note text,
    dedication_note text,
    commissioned_note text,
    contents_note text,
    iswc_code text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    updated_by integer NOT NULL,
    legacy_4d_identity_code text,
    CONSTRAINT ckc_difficulty_works CHECK (((difficulty IS NULL) OR ((((difficulty = 0) OR (difficulty = 1)) OR (difficulty = 2)) OR (difficulty = 3)))),
    CONSTRAINT ckc_year_of_creation_works CHECK (((year_of_creation IS NULL) OR ((year_of_creation >= 0) AND (year_of_creation <= 9999)))),
    CONSTRAINT ckc_year_of_revision_works CHECK (((year_of_revision IS NULL) OR ((year_of_revision >= 0) AND (year_of_revision <= 9999))))
);


--
-- Name: work_composers; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW work_composers AS
    SELECT works.superwork_id, works.work_id, works.work_title, people.person_id AS composer_person_id, contributors.contributor_id AS composer_contributor_id, roles.role_title, work_categories.work_category_desc, work_subcategories.work_subcategory_desc FROM ((((((((((work_subcategories work_subcategories JOIN works works ON ((work_subcategories.work_subcategory_id = works.work_subcategory_id))) JOIN work_relationships work_relationships ON ((works.work_id = work_relationships.work_id))) JOIN relationships relationships ON ((work_relationships.relationship_id = relationships.relationship_id))) JOIN relationship_types relationship_types ON ((work_relationships.relationship_type_id = relationship_types.relationship_type_id))) JOIN role_relationships role_relationships ON ((relationships.relationship_id = role_relationships.relationship_id))) JOIN roles roles ON ((role_relationships.role_id = roles.role_id))) JOIN contributors contributors ON ((contributors.role_id = roles.role_id))) JOIN role_types role_types ON ((roles.role_type_id = role_types.role_type_id))) JOIN people people ON ((roles.person_id = people.person_id))) JOIN work_categories work_categories ON ((work_subcategories.work_category_id = work_categories.work_category_id))) WHERE (relationship_types.relationship_type_desc = 'Is composed by'::text);


--
-- Name: work_manifestation_advanced_search; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW work_manifestation_advanced_search AS
    SELECT w.work_id, e.expression_id, em.expression_manifestation_id, m.manifestation_id, m.available_for_hire, m.available_for_sale, m.downloadable FROM (((works w LEFT JOIN expressions e ON ((e.work_id = w.work_id))) LEFT JOIN expression_manifestations em ON ((e.expression_id = em.expression_id))) LEFT JOIN manifestations m ON ((em.manifestation_id = m.manifestation_id)));


--
-- Name: works_advanced_search; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW works_advanced_search AS
    SELECT w.work_id, w.programme_note, w.status_id, e.expression_id, em.expression_manifestation_id, m.manifestation_id, mt.manifestation_type_category, s.sample_id FROM (((((works w LEFT JOIN expressions e ON ((e.work_id = w.work_id))) LEFT JOIN expression_manifestations em ON ((e.expression_id = em.expression_id))) LEFT JOIN manifestations m ON ((em.manifestation_id = m.manifestation_id))) LEFT JOIN manifestation_types mt ON ((m.manifestation_type_id = mt.manifestation_type_id))) LEFT JOIN samples s ON ((s.manifestation_id = m.manifestation_id)));


--
-- Name: cm_content_attachment_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE cm_content_attachments ALTER COLUMN cm_content_attachment_id SET DEFAULT nextval('cm_content_attachments_cm_content_attachment_id_seq'::regclass);


--
-- Name: cm_content_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE cm_contents ALTER COLUMN cm_content_id SET DEFAULT nextval('cm_contents_cm_content_id_seq'::regclass);


--
-- Name: controller_restriction_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE controller_restrictions ALTER COLUMN controller_restriction_id SET DEFAULT nextval('controller_restrictions_controller_restriction_id_seq'::regclass);


--
-- Name: news_article_attachment_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE news_article_attachments ALTER COLUMN news_article_attachment_id SET DEFAULT nextval('news_article_attachments_news_article_attachment_id_seq'::regclass);


--
-- Name: news_article_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE news_articles ALTER COLUMN news_article_id SET DEFAULT nextval('news_articles_news_article_id_seq'::regclass);


--
-- Name: prov_composer_bio_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE prov_composer_bios ALTER COLUMN prov_composer_bio_id SET DEFAULT nextval('prov_composer_bios_prov_composer_bio_id_seq'::regclass);


--
-- Name: prov_contact_update_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE prov_contact_updates ALTER COLUMN prov_contact_update_id SET DEFAULT nextval('prov_contact_updates_prov_contact_update_id_seq'::regclass);


--
-- Name: prov_contributor_profile_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE prov_contributor_profiles ALTER COLUMN prov_contributor_profile_id SET DEFAULT nextval('prov_contributor_profiles_prov_contributor_profile_id_seq'::regclass);


--
-- Name: prov_event_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE prov_events ALTER COLUMN prov_event_id SET DEFAULT nextval('prov_events_prov_event_id_seq'::regclass);


--
-- Name: prov_feedback_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE prov_feedbacks ALTER COLUMN prov_feedback_id SET DEFAULT nextval('prov_feedbacks_prov_feedback_id_seq'::regclass);


--
-- Name: prov_work_update_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE prov_work_updates ALTER COLUMN prov_work_update_id SET DEFAULT nextval('prov_work_updates_prov_work_update_id_seq'::regclass);


--
-- Name: setting_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE settings ALTER COLUMN setting_id SET DEFAULT nextval('settings_setting_id_seq'::regclass);


--
-- Name: sounz_service_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE sounz_services ALTER COLUMN sounz_service_id SET DEFAULT nextval('sounz_services_sounz_service_id_seq'::regclass);


--
-- Name: pk_access_rights; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY access_rights
    ADD CONSTRAINT pk_access_rights PRIMARY KEY (access_right_id);


--
-- Name: pk_allowed_ips; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY allowed_ips
    ADD CONSTRAINT pk_allowed_ips PRIMARY KEY (allowed_ip_id);


--
-- Name: pk_attachment_types; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY attachment_types
    ADD CONSTRAINT pk_attachment_types PRIMARY KEY (attachment_type_id);


--
-- Name: pk_borrowed_items; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY borrowed_items
    ADD CONSTRAINT pk_borrowed_items PRIMARY KEY (borrowed_item_id);


--
-- Name: pk_campaign_mailouts; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY campaign_mailouts
    ADD CONSTRAINT pk_campaign_mailouts PRIMARY KEY (campaign_mailout_id);


--
-- Name: pk_cm_content_attachments; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cm_content_attachments
    ADD CONSTRAINT pk_cm_content_attachments PRIMARY KEY (cm_content_attachment_id);


--
-- Name: pk_cm_contents; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cm_contents
    ADD CONSTRAINT pk_cm_contents PRIMARY KEY (cm_content_id);


--
-- Name: pk_communication_methods; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY communication_methods
    ADD CONSTRAINT pk_communication_methods PRIMARY KEY (communication_method_id);


--
-- Name: pk_communication_types; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY communication_types
    ADD CONSTRAINT pk_communication_types PRIMARY KEY (communication_type_id);


--
-- Name: pk_communications; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY communications
    ADD CONSTRAINT pk_communications PRIMARY KEY (communication_id);


--
-- Name: pk_concept_relationships; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY concept_relationships
    ADD CONSTRAINT pk_concept_relationships PRIMARY KEY (concept_relationship_id);


--
-- Name: pk_concept_types; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY concept_types
    ADD CONSTRAINT pk_concept_types PRIMARY KEY (concept_type_id);


--
-- Name: pk_concepts; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY concepts
    ADD CONSTRAINT pk_concepts PRIMARY KEY (concept_id);


--
-- Name: pk_contactinfos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY contactinfos
    ADD CONSTRAINT pk_contactinfos PRIMARY KEY (contactinfo_id);


--
-- Name: pk_contributor_attachments; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY contributor_attachments
    ADD CONSTRAINT pk_contributor_attachments PRIMARY KEY (contributor_attachment_id);


--
-- Name: pk_contributors; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY contributors
    ADD CONSTRAINT pk_contributors PRIMARY KEY (contributor_id);


--
-- Name: pk_controller_restrictions; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY controller_restrictions
    ADD CONSTRAINT pk_controller_restrictions PRIMARY KEY (controller_restriction_id);


--
-- Name: pk_countries; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY countries
    ADD CONSTRAINT pk_countries PRIMARY KEY (country_id);


--
-- Name: pk_default_contactinfos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY default_contactinfos
    ADD CONSTRAINT pk_default_contactinfos PRIMARY KEY (default_contactinfo_id);


--
-- Name: pk_distinction_instances; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY distinction_instances
    ADD CONSTRAINT pk_distinction_instances PRIMARY KEY (distinction_instance_id);


--
-- Name: pk_distinction_relationships; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY distinction_relationships
    ADD CONSTRAINT pk_distinction_relationships PRIMARY KEY (distinction_relationship_id);


--
-- Name: pk_distinctions; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY distinctions
    ADD CONSTRAINT pk_distinctions PRIMARY KEY (distinction_id);


--
-- Name: pk_entity_relationship_types; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY entity_relationship_types
    ADD CONSTRAINT pk_entity_relationship_types PRIMARY KEY (relationship_type_id, entity_type_id);


--
-- Name: pk_entity_types; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY entity_types
    ADD CONSTRAINT pk_entity_types PRIMARY KEY (entity_type_id);


--
-- Name: pk_event_attachments; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY event_attachments
    ADD CONSTRAINT pk_event_attachments PRIMARY KEY (event_attachment_id);


--
-- Name: pk_event_relationships; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY event_relationships
    ADD CONSTRAINT pk_event_relationships PRIMARY KEY (event_relationship_id);


--
-- Name: pk_event_types; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY event_types
    ADD CONSTRAINT pk_event_types PRIMARY KEY (event_type_id);


--
-- Name: pk_events; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT pk_events PRIMARY KEY (event_id);


--
-- Name: pk_exam_set_works; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY exam_set_works
    ADD CONSTRAINT pk_exam_set_works PRIMARY KEY (exam_set_work_id);


--
-- Name: pk_examboards; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY examboards
    ADD CONSTRAINT pk_examboards PRIMARY KEY (examboard_id);


--
-- Name: pk_expression_access_rights; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY expression_access_rights
    ADD CONSTRAINT pk_expression_access_rights PRIMARY KEY (expression_access_right_id);


--
-- Name: pk_expression_languages; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY expression_languages
    ADD CONSTRAINT pk_expression_languages PRIMARY KEY (expression_language_id);


--
-- Name: pk_expression_manifestations; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY expression_manifestations
    ADD CONSTRAINT pk_expression_manifestations PRIMARY KEY (expression_manifestation_id);


--
-- Name: pk_expression_relationships; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY expression_relationships
    ADD CONSTRAINT pk_expression_relationships PRIMARY KEY (expression_relationship_id);


--
-- Name: pk_expressions; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY expressions
    ADD CONSTRAINT pk_expressions PRIMARY KEY (expression_id);


--
-- Name: pk_formats; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY formats
    ADD CONSTRAINT pk_formats PRIMARY KEY (format_id);


--
-- Name: pk_item_types; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY item_types
    ADD CONSTRAINT pk_item_types PRIMARY KEY (item_type_id);


--
-- Name: pk_items; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY items
    ADD CONSTRAINT pk_items PRIMARY KEY (item_id);


--
-- Name: pk_languages; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY languages
    ADD CONSTRAINT pk_languages PRIMARY KEY (language_id);


--
-- Name: pk_logins; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY logins
    ADD CONSTRAINT pk_logins PRIMARY KEY (login_id);


--
-- Name: pk_mailout_attachments; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mailout_attachments
    ADD CONSTRAINT pk_mailout_attachments PRIMARY KEY (mailout_attachment_id);


--
-- Name: pk_mailout_contacts; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mailout_contacts
    ADD CONSTRAINT pk_mailout_contacts PRIMARY KEY (mailout_contact_id);


--
-- Name: pk_manifestation_access_rights; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY manifestation_access_rights
    ADD CONSTRAINT pk_manifestation_access_rights PRIMARY KEY (manifestation_access_right_id);


--
-- Name: pk_manifestation_attachments; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY manifestation_attachments
    ADD CONSTRAINT pk_manifestation_attachments PRIMARY KEY (manifestation_attachment_id);


--
-- Name: pk_manifestation_relationships; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY manifestation_relationships
    ADD CONSTRAINT pk_manifestation_relationships PRIMARY KEY (manifestation_relationship_id);


--
-- Name: pk_manifestation_type_formats; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY manifestation_type_formats
    ADD CONSTRAINT pk_manifestation_type_formats PRIMARY KEY (manifestation_type_format_id);


--
-- Name: pk_manifestation_types; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY manifestation_types
    ADD CONSTRAINT pk_manifestation_types PRIMARY KEY (manifestation_type_id);


--
-- Name: pk_manifestations; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY manifestations
    ADD CONSTRAINT pk_manifestations PRIMARY KEY (manifestation_id);


--
-- Name: pk_marketing_campaigns; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY marketing_campaigns
    ADD CONSTRAINT pk_marketing_campaigns PRIMARY KEY (marketing_campaign_id);


--
-- Name: pk_marketing_categories; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY marketing_categories
    ADD CONSTRAINT pk_marketing_categories PRIMARY KEY (marketing_category_id);


--
-- Name: pk_marketing_subcategories; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY marketing_subcategories
    ADD CONSTRAINT pk_marketing_subcategories PRIMARY KEY (marketing_subcategory_id);


--
-- Name: pk_media_items; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY media_items
    ADD CONSTRAINT pk_media_items PRIMARY KEY (media_item_id);


--
-- Name: pk_member_type_privileges; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY member_type_privileges
    ADD CONSTRAINT pk_member_type_privileges PRIMARY KEY (member_type_privilege_id);


--
-- Name: pk_member_types; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY member_types
    ADD CONSTRAINT pk_member_types PRIMARY KEY (member_type_id);


--
-- Name: pk_memberships; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY memberships
    ADD CONSTRAINT pk_memberships PRIMARY KEY (membership_id);


--
-- Name: pk_mime_categories; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mime_categories
    ADD CONSTRAINT pk_mime_categories PRIMARY KEY (mime_category_id);


--
-- Name: pk_mime_types; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mime_types
    ADD CONSTRAINT pk_mime_types PRIMARY KEY (mime_type_id);


--
-- Name: pk_modes; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY modes
    ADD CONSTRAINT pk_modes PRIMARY KEY (mode_id);


--
-- Name: pk_news_article_attachments; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY news_article_attachments
    ADD CONSTRAINT pk_news_article_attachments PRIMARY KEY (news_article_attachment_id);


--
-- Name: pk_news_articles; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY news_articles
    ADD CONSTRAINT pk_news_articles PRIMARY KEY (news_article_id);


--
-- Name: pk_nomens; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY nomens
    ADD CONSTRAINT pk_nomens PRIMARY KEY (nomen_id);


--
-- Name: pk_organisation_attachments; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY organisation_attachments
    ADD CONSTRAINT pk_organisation_attachments PRIMARY KEY (organisation_attachment_id);


--
-- Name: pk_organisations; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY organisations
    ADD CONSTRAINT pk_organisations PRIMARY KEY (organisation_id);


--
-- Name: pk_people; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY people
    ADD CONSTRAINT pk_people PRIMARY KEY (person_id);


--
-- Name: pk_person_attachments; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY person_attachments
    ADD CONSTRAINT pk_person_attachments PRIMARY KEY (person_attachment_id);


--
-- Name: pk_privileges; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY "privileges"
    ADD CONSTRAINT pk_privileges PRIMARY KEY (privilege_id);


--
-- Name: pk_project_team_members; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY project_team_members
    ADD CONSTRAINT pk_project_team_members PRIMARY KEY (project_team_member_id);


--
-- Name: pk_projects; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT pk_projects PRIMARY KEY (project_id);


--
-- Name: pk_prov_composer_bios; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY prov_composer_bios
    ADD CONSTRAINT pk_prov_composer_bios PRIMARY KEY (prov_composer_bio_id);


--
-- Name: pk_prov_contact_updates; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY prov_contact_updates
    ADD CONSTRAINT pk_prov_contact_updates PRIMARY KEY (prov_contact_update_id);


--
-- Name: pk_prov_contributor_profiles; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY prov_contributor_profiles
    ADD CONSTRAINT pk_prov_contributor_profiles PRIMARY KEY (prov_contributor_profile_id);


--
-- Name: pk_prov_events; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY prov_events
    ADD CONSTRAINT pk_prov_events PRIMARY KEY (prov_event_id);


--
-- Name: pk_prov_feedbacks; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY prov_feedbacks
    ADD CONSTRAINT pk_prov_feedbacks PRIMARY KEY (prov_feedback_id);


--
-- Name: pk_prov_work_updates; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY prov_work_updates
    ADD CONSTRAINT pk_prov_work_updates PRIMARY KEY (prov_work_update_id);


--
-- Name: pk_publishing_statuses; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY publishing_statuses
    ADD CONSTRAINT pk_publishing_statuses PRIMARY KEY (status_id);


--
-- Name: pk_regions; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY regions
    ADD CONSTRAINT pk_regions PRIMARY KEY (region_id);


--
-- Name: pk_related_communications; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY related_communications
    ADD CONSTRAINT pk_related_communications PRIMARY KEY (communication_id, com_communication_id);


--
-- Name: pk_related_organisations; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY related_organisations
    ADD CONSTRAINT pk_related_organisations PRIMARY KEY (related_organisation_id);


--
-- Name: pk_relationship_types; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY relationship_types
    ADD CONSTRAINT pk_relationship_types PRIMARY KEY (relationship_type_id);


--
-- Name: pk_relationships; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY relationships
    ADD CONSTRAINT pk_relationships PRIMARY KEY (relationship_id);


--
-- Name: pk_reserved_items; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY reserved_items
    ADD CONSTRAINT pk_reserved_items PRIMARY KEY (reserved_item_id);


--
-- Name: pk_resource_access_rights; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY resource_access_rights
    ADD CONSTRAINT pk_resource_access_rights PRIMARY KEY (resource_access_right_id);


--
-- Name: pk_resource_attachments; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY resource_attachments
    ADD CONSTRAINT pk_resource_attachments PRIMARY KEY (resource_attachment_id);


--
-- Name: pk_resource_relationships; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY resource_relationships
    ADD CONSTRAINT pk_resource_relationships PRIMARY KEY (resource_relationship_id);


--
-- Name: pk_resource_type_formats; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY resource_type_formats
    ADD CONSTRAINT pk_resource_type_formats PRIMARY KEY (resource_type_format_id);


--
-- Name: pk_resource_types; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY resource_types
    ADD CONSTRAINT pk_resource_types PRIMARY KEY (resource_type_id);


--
-- Name: pk_resources; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY resources
    ADD CONSTRAINT pk_resources PRIMARY KEY (resource_id);


--
-- Name: pk_role_categorizations; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY role_categorizations
    ADD CONSTRAINT pk_role_categorizations PRIMARY KEY (role_categorization_id);


--
-- Name: pk_role_contactinfos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY role_contactinfos
    ADD CONSTRAINT pk_role_contactinfos PRIMARY KEY (role_contactinfo_id);


--
-- Name: pk_role_relationships; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY role_relationships
    ADD CONSTRAINT pk_role_relationships PRIMARY KEY (role_relationship_id);


--
-- Name: pk_role_types; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY role_types
    ADD CONSTRAINT pk_role_types PRIMARY KEY (role_type_id);


--
-- Name: pk_roles; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT pk_roles PRIMARY KEY (role_id);


--
-- Name: pk_sample_attachments; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sample_attachments
    ADD CONSTRAINT pk_sample_attachments PRIMARY KEY (sample_attachment_id);


--
-- Name: pk_samples; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY samples
    ADD CONSTRAINT pk_samples PRIMARY KEY (sample_id);


--
-- Name: pk_saved_contact_lists; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY saved_contact_lists
    ADD CONSTRAINT pk_saved_contact_lists PRIMARY KEY (saved_contact_list_id);


--
-- Name: pk_saved_role_contactinfos; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY saved_role_contactinfos
    ADD CONSTRAINT pk_saved_role_contactinfos PRIMARY KEY (saved_role_contactinfo_id);


--
-- Name: pk_saved_searches; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY saved_searches
    ADD CONSTRAINT pk_saved_searches PRIMARY KEY (search_id);


--
-- Name: pk_settings; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY settings
    ADD CONSTRAINT pk_settings PRIMARY KEY (setting_id);


--
-- Name: pk_sounz_donations; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sounz_donations
    ADD CONSTRAINT pk_sounz_donations PRIMARY KEY (sounz_donation_id);


--
-- Name: pk_sounz_services; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sounz_services
    ADD CONSTRAINT pk_sounz_services PRIMARY KEY (sounz_service_id);


--
-- Name: pk_superwork_relationships; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY superwork_relationships
    ADD CONSTRAINT pk_superwork_relationships PRIMARY KEY (superwork_relationship_id);


--
-- Name: pk_superworks; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY superworks
    ADD CONSTRAINT pk_superworks PRIMARY KEY (superwork_id);


--
-- Name: pk_valid_entity_entity_relatio; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY valid_entity_entity_relationships
    ADD CONSTRAINT pk_valid_entity_entity_relatio PRIMARY KEY (id);


--
-- Name: pk_work_access_rights; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY work_access_rights
    ADD CONSTRAINT pk_work_access_rights PRIMARY KEY (work_access_right_id);


--
-- Name: pk_work_attachments; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY work_attachments
    ADD CONSTRAINT pk_work_attachments PRIMARY KEY (work_attachment_id);


--
-- Name: pk_work_categories; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY work_categories
    ADD CONSTRAINT pk_work_categories PRIMARY KEY (work_category_id);


--
-- Name: pk_work_categorizations; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY work_categorizations
    ADD CONSTRAINT pk_work_categorizations PRIMARY KEY (work_categorization_id);


--
-- Name: pk_work_relationships; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY work_relationships
    ADD CONSTRAINT pk_work_relationships PRIMARY KEY (work_relationship_id);


--
-- Name: pk_work_subcategories; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY work_subcategories
    ADD CONSTRAINT pk_work_subcategories PRIMARY KEY (work_subcategory_id);


--
-- Name: pk_works; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY works
    ADD CONSTRAINT pk_works PRIMARY KEY (work_id);



CREATE INDEX borrowed_item_item_fk ON borrowed_items USING btree (item_id);


--
-- Name: borrowed_item_login_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX borrowed_item_login_fk ON borrowed_items USING btree (login_id);


--
-- Name: campaign_mailout_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX campaign_mailout_fk ON campaign_mailouts USING btree (marketing_campaign_id);


--
-- Name: campaign_manager_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX campaign_manager_fk ON marketing_campaigns USING btree (campaign_manager);


-- Name: cm_content_att_media_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX cm_content_att_media_fk ON cm_content_attachments USING btree (media_item_id);


--
-- Name: cm_content_att_type_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX cm_content_att_type_fk ON cm_content_attachments USING btree (attachment_type_id);


--
-- Name: cm_content_attachment_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX cm_content_attachment_fk ON cm_content_attachments USING btree (cm_content_id);


--
-- Name: cm_contents_name_uix; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX cm_contents_name_uix ON cm_contents USING btree (cm_content_name);


--
-- Name: cm_contents_updated_by_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX cm_contents_updated_by_fk ON cm_contents USING btree (status_id);


--
-- Name: cm_contents_updated_by_fk2; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX cm_contents_updated_by_fk2 ON cm_contents USING btree (updated_by);


--
-- Name: communication_method_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX communication_method_fk ON communications USING btree (communication_method_id);


--
-- Name: communication_role_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX communication_role_fk ON communications USING btree (role_id);


--
-- Name: communication_type_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX communication_type_fk ON communications USING btree (communication_type_id);


--
-- Name: concept_entity_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX concept_entity_fk ON concept_relationships USING btree (concept_id);


--
-- Name: concept_relationship_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX concept_relationship_fk ON concept_relationships USING btree (relationship_id);


--
-- Name: concept_relationship_uix; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX concept_relationship_uix ON concept_relationships USING btree (relationship_id, relationship_type_id, concept_id);


--
-- Name: concept_reltype_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX concept_reltype_fk ON concept_relationships USING btree (relationship_type_id);


--
-- Name: concept_type_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX concept_type_fk ON concepts USING btree (concept_type_id);


--
-- Name: contactinfo_country_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX contactinfo_country_fk ON contactinfos USING btree (country_id);


--
-- Name: contactinfo_region_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX contactinfo_region_fk ON contactinfos USING btree (region_id);


--
-- Name: contrib_att_type_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX contrib_att_type_fk ON contributor_attachments USING btree (attachment_type_id);


--
-- Name: contributor_att_media_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX contributor_att_media_fk ON contributor_attachments USING btree (media_item_id);


--
-- Name: contributor_attachment_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX contributor_attachment_fk ON contributor_attachments USING btree (contributor_id);


--
-- Name: contributor_attachment_uix; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX contributor_attachment_uix ON contributor_attachments USING btree (contributor_id, media_item_id);


--
-- Name: contributor_role_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX contributor_role_fk ON contributors USING btree (role_id);


--
-- Name: contributors_pubstatus_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX contributors_pubstatus_fk ON contributors USING btree (status_id);


--
-- Name: controller_restrict_pivilege_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX controller_restrict_pivilege_fk ON controller_restrictions USING btree (privilege_id);


--
-- Name: controller_restrict_status_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX controller_restrict_status_fk ON controller_restrictions USING btree (status_id);


--
-- Name: def_cinfo_default_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX def_cinfo_default_fk ON default_contactinfos USING btree (d_contactinfo_id);


--
-- Name: def_cinfo_master_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX def_cinfo_master_fk ON default_contactinfos USING btree (contactinfo_id);


--
-- Name: def_cinfo_uix; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX def_cinfo_uix ON default_contactinfos USING btree (contactinfo_id, d_contactinfo_id);


--
-- Name: distincinst_pubstatus_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX distincinst_pubstatus_fk ON distinction_instances USING btree (status_id);


--
-- Name: distinction_contactinfo_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX distinction_contactinfo_fk ON distinctions USING btree (contactinfo_id);


--
-- Name: distinction_entity_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX distinction_entity_fk ON distinction_relationships USING btree (distinction_instance_id);


--
-- Name: distinction_event_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX distinction_event_fk ON distinction_instances USING btree (event_id);


--
-- Name: distinction_instance_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX distinction_instance_fk ON distinction_instances USING btree (distinction_id);


--
-- Name: distinction_pubstatus_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX distinction_pubstatus_fk ON distinctions USING btree (status_id);


--
-- Name: distinction_relationship_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX distinction_relationship_fk ON distinction_relationships USING btree (relationship_id);


--
-- Name: distinction_relationship_uix; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX distinction_relationship_uix ON distinction_relationships USING btree (relationship_id, relationship_type_id, distinction_instance_id);


--
-- Name: distinction_reltype_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX distinction_reltype_fk ON distinction_relationships USING btree (relationship_type_id);


--
-- Name: donation_updated_by_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX donation_updated_by_fk ON sounz_donations USING btree (updated_by);


-- Name: entity_relationship_types2_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX entity_relationship_types2_fk ON entity_relationship_types USING btree (entity_type_id);


--
-- Name: entity_relationship_types_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX entity_relationship_types_fk ON entity_relationship_types USING btree (relationship_type_id);


--
-- Name: entity_type_a_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX entity_type_a_fk ON relationships USING btree (ent_entity_type_id);


--
-- Name: entity_type_b_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX entity_type_b_fk ON relationships USING btree (entity_type_id);


--
-- Name: event_att_media_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX event_att_media_fk ON event_attachments USING btree (media_item_id);


--
-- Name: event_att_type_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX event_att_type_fk ON event_attachments USING btree (attachment_type_id);


--
-- Name: event_attachment_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX event_attachment_fk ON event_attachments USING btree (event_id);


--
-- Name: event_attachment_uix; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX event_attachment_uix ON event_attachments USING btree (event_id, media_item_id);


--
-- Name: event_contactinfo_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX event_contactinfo_fk ON events USING btree (contactinfo_id);


--
-- Name: event_entity_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX event_entity_fk ON event_relationships USING btree (event_id);


--
-- Name: event_relationship_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX event_relationship_fk ON event_relationships USING btree (relationship_id);


--
-- Name: event_relationship_uix; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX event_relationship_uix ON event_relationships USING btree (relationship_id, relationship_type_id, event_id);


--
-- Name: event_reltype_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX event_reltype_fk ON event_relationships USING btree (relationship_type_id);


--
-- Name: event_type_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX event_type_fk ON events USING btree (event_type_id);


--
-- Name: events_pubstatus_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX events_pubstatus_fk ON events USING btree (status_id);


--
-- Name: exam_set_work_manif_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX exam_set_work_manif_fk ON exam_set_works USING btree (manifestation_id);


--
-- Name: expr_ar_expression_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX expr_ar_expression_fk ON expression_access_rights USING btree (expression_id);


--
-- Name: expr_ar_rights_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX expr_ar_rights_fk ON expression_access_rights USING btree (access_right_id);


--
-- Name: expr_ar_uix; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX expr_ar_uix ON expression_access_rights USING btree (expression_id, access_right_id, access_right_source);


--
-- Name: expr_lang_expression_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX expr_lang_expression_fk ON expression_languages USING btree (expression_id);


--
-- Name: expr_lang_language_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX expr_lang_language_fk ON expression_languages USING btree (language_id);


--
-- Name: expression_entity_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX expression_entity_fk ON expression_relationships USING btree (expression_id);


--
-- Name: expression_manifestation_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX expression_manifestation_fk ON expression_manifestations USING btree (expression_id);


--
-- Name: expression_relationship_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX expression_relationship_fk ON expression_relationships USING btree (relationship_id);


--
-- Name: expression_relationship_uix; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX expression_relationship_uix ON expression_relationships USING btree (relationship_id, relationship_type_id, expression_id);


--
-- Name: expression_reltype_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX expression_reltype_fk ON expression_relationships USING btree (relationship_type_id);


--
-- Name: expressions_pubstatus_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX expressions_pubstatus_fk ON expressions USING btree (status_id);


--
-- Name: item_type_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX item_type_fk ON items USING btree (item_type_id);


--
-- Name: items_pubstatus_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX items_pubstatus_fk ON items USING btree (status_id);


--
-- Name: login_allowed_ip_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX login_allowed_ip_fk ON allowed_ips USING btree (login_id);


--
-- Name: login_saved_search_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX login_saved_search_fk ON saved_searches USING btree (updated_by);


--
-- Name: mailout_att_media_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX mailout_att_media_fk ON mailout_attachments USING btree (media_item_id);


--
-- Name: mailout_att_type_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX mailout_att_type_fk ON mailout_attachments USING btree (attachment_type_id);


--
-- Name: mailout_attachment_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX mailout_attachment_fk ON mailout_attachments USING btree (campaign_mailout_id);


--
-- Name: mailout_contact_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX mailout_contact_fk ON mailout_contacts USING btree (campaign_mailout_id);


--
-- Name: mailout_role_contactinfo_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX mailout_role_contactinfo_fk ON mailout_contacts USING btree (role_contactinfo_id);


--
-- Name: main_work_subcategory_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX main_work_subcategory_fk ON works USING btree (work_subcategory_id);


--
-- Name: manif_ar_manifestation_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX manif_ar_manifestation_fk ON manifestation_access_rights USING btree (manifestation_id);


--
-- Name: manif_ar_rights_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX manif_ar_rights_fk ON manifestation_access_rights USING btree (access_right_id);


--
-- Name: manif_ar_uix; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX manif_ar_uix ON manifestation_access_rights USING btree (access_right_id, manifestation_id, access_right_source);


--
-- Name: manif_typeform_format_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX manif_typeform_format_fk ON manifestation_type_formats USING btree (format_id);


--
-- Name: manif_typeform_type_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX manif_typeform_type_fk ON manifestation_type_formats USING btree (manifestation_type_id);


--
-- Name: manifestation_att_media_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX manifestation_att_media_fk ON manifestation_attachments USING btree (media_item_id);


--
-- Name: manifestation_att_type_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX manifestation_att_type_fk ON manifestation_attachments USING btree (attachment_type_id);


--
-- Name: manifestation_attachment_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX manifestation_attachment_fk ON manifestation_attachments USING btree (manifestation_id);


--
-- Name: manifestation_attachment_uix; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX manifestation_attachment_uix ON manifestation_attachments USING btree (manifestation_id, media_item_id);


--
-- Name: manifestation_entity_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX manifestation_entity_fk ON manifestation_relationships USING btree (manifestation_id);


--
-- Name: manifestation_expression_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX manifestation_expression_fk ON expression_manifestations USING btree (manifestation_id);


--
-- Name: manifestation_format_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX manifestation_format_fk ON manifestations USING btree (format_id);


--
-- Name: manifestation_item_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX manifestation_item_fk ON items USING btree (manifestation_id);


--
-- Name: manifestation_relationship_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX manifestation_relationship_fk ON manifestation_relationships USING btree (relationship_id);


--
-- Name: manifestation_relationship_uix; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX manifestation_relationship_uix ON manifestation_relationships USING btree (relationship_id, relationship_type_id, manifestation_id);


--
-- Name: manifestation_reltype_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX manifestation_reltype_fk ON manifestation_relationships USING btree (relationship_type_id);


--
-- Name: manifestation_sample_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX manifestation_sample_fk ON samples USING btree (manifestation_id);


--
-- Name: manifestation_type_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX manifestation_type_fk ON manifestations USING btree (manifestation_type_id);


--
-- Name: manifestations_pubstatus_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX manifestations_pubstatus_fk ON manifestations USING btree (status_id);


-- Name: marketing_cat_subcat_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX marketing_cat_subcat_fk ON marketing_subcategories USING btree (marketing_category_id);


--
-- Name: media_item_mimetype_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX media_item_mimetype_fk ON media_items USING btree (mime_type_id);


--
-- Name: membership_login_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX membership_login_fk ON memberships USING btree (login_id);


--
-- Name: membership_member_type_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX membership_member_type_fk ON memberships USING btree (member_type_id);


--
-- Name: memtype_priv_privilege_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX memtype_priv_privilege_fk ON member_type_privileges USING btree (privilege_id);


--
-- Name: memtype_priv_type_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX memtype_priv_type_fk ON member_type_privileges USING btree (member_type_id);


--
-- Name: mimetype_category_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX mimetype_category_fk ON mime_types USING btree (mime_category_id);


--
-- Name: mode_of_expression_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX mode_of_expression_fk ON expressions USING btree (mode_id);


--
-- Name: news_article_att_media_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX news_article_att_media_fk ON news_article_attachments USING btree (media_item_id);


--
-- Name: news_article_att_type_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX news_article_att_type_fk ON news_article_attachments USING btree (attachment_type_id);


--
-- Name: news_article_attachment_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX news_article_attachment_fk ON news_article_attachments USING btree (news_article_id);


--
-- Name: news_articles_pubstatus_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX news_articles_pubstatus_fk ON news_articles USING btree (status_id);


--
-- Name: org_att_type_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX org_att_type_fk ON organisation_attachments USING btree (attachment_type_id);


--
-- Name: org_login_organisation_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX org_login_organisation_fk ON logins USING btree (organisation_id);


--
-- Name: organisation_att_media_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX organisation_att_media_fk ON organisation_attachments USING btree (media_item_id);


--
-- Name: organisation_attachment_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX organisation_attachment_fk ON organisation_attachments USING btree (organisation_id);


--
-- Name: organisation_attachment_uix; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX organisation_attachment_uix ON organisation_attachments USING btree (organisation_id, media_item_id);


--
-- Name: organisations_pubstatus_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX organisations_pubstatus_fk ON organisations USING btree (status_id);


--
-- Name: parent_concept_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX parent_concept_fk ON concepts USING btree (parent_concept_id);


--
-- Name: parent_event_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX parent_event_fk ON events USING btree (related_event_id);


--
-- Name: parent_media_item_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX parent_media_item_fk ON media_items USING btree (parent_id);


--
-- Name: people_pubstatus_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX people_pubstatus_fk ON people USING btree (status_id);


--
-- Name: person_att_media_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX person_att_media_fk ON person_attachments USING btree (media_item_id);


--
-- Name: person_att_type_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX person_att_type_fk ON person_attachments USING btree (attachment_type_id);


--
-- Name: person_attachment_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX person_attachment_fk ON person_attachments USING btree (person_id);


--
-- Name: person_attachment_uix; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX person_attachment_uix ON person_attachments USING btree (person_id, media_item_id);


--
-- Name: person_login_person_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX person_login_person_fk ON logins USING btree (person_id);


--
-- Name: person_nomen_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX person_nomen_fk ON people USING btree (nomen_id);


--
-- Name: person_role_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX person_role_fk ON roles USING btree (person_id);


--
-- Name: preferred_comm_method_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX preferred_comm_method_fk ON contactinfos USING btree (preferred_comm_method);


--
-- Name: project_campaign_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX project_campaign_fk ON marketing_campaigns USING btree (project_id);


--
-- Name: project_tmbr_person_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX project_tmbr_person_fk ON project_team_members USING btree (person_id);


--
-- Name: project_tmbr_proj_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX project_tmbr_proj_fk ON project_team_members USING btree (project_id);


--
-- Name: prov_composer_bios_pubstatus_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX prov_composer_bios_pubstatus_fk ON prov_composer_bios USING btree (status_id);


--
-- Name: prov_composer_bios_submitted_by_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX prov_composer_bios_submitted_by_fk ON prov_composer_bios USING btree (submitted_by);


--
-- Name: prov_contact_updates_pubstatus_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX prov_contact_updates_pubstatus_fk ON prov_contact_updates USING btree (status_id);


--
-- Name: prov_contact_updates_submitted_by_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX prov_contact_updates_submitted_by_fk ON prov_contact_updates USING btree (submitted_by);


--
-- Name: prov_contributor_profiles_pubstatus_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX prov_contributor_profiles_pubstatus_fk ON prov_contributor_profiles USING btree (status_id);


--
-- Name: prov_contributor_profiles_submitted_by_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX prov_contributor_profiles_submitted_by_fk ON prov_contributor_profiles USING btree (submitted_by);


--
-- Name: prov_events_pubstatus_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX prov_events_pubstatus_fk ON prov_events USING btree (status_id);


--
-- Name: prov_events_submitted_by_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX prov_events_submitted_by_fk ON prov_events USING btree (submitted_by);


--
-- Name: prov_feedbacks_pubstatus_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX prov_feedbacks_pubstatus_fk ON prov_feedbacks USING btree (status_id);


--
-- Name: prov_feedbacks_submitted_by_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX prov_feedbacks_submitted_by_fk ON prov_feedbacks USING btree (submitted_by);


--
-- Name: prov_work_updates_pubstatus_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX prov_work_updates_pubstatus_fk ON prov_work_updates USING btree (status_id);


--
-- Name: prov_work_updates_submitted_by_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX prov_work_updates_submitted_by_fk ON prov_work_updates USING btree (submitted_by);


--
-- Name: region_country_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX region_country_fk ON regions USING btree (country_id);


--
-- Name: related_communications2_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX related_communications2_fk ON related_communications USING btree (com_communication_id);


--
-- Name: related_communications_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX related_communications_fk ON related_communications USING btree (communication_id);


--
-- Name: related_from_org_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX related_from_org_fk ON related_organisations USING btree (organisation_id);


--
-- Name: related_org_org_uix; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX related_org_org_uix ON related_organisations USING btree (organisation_id, org_organisation_id);


--
-- Name: related_to_org_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX related_to_org_fk ON related_organisations USING btree (org_organisation_id);


--
-- Name: res_ar_resource_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX res_ar_resource_fk ON resource_access_rights USING btree (resource_id);


--
-- Name: res_ar_rights_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX res_ar_rights_fk ON resource_access_rights USING btree (access_right_id);


--
-- Name: res_ar_uix; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX res_ar_uix ON resource_access_rights USING btree (access_right_id, resource_id, access_right_source);


--
-- Name: res_typeform_forrmat_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX res_typeform_forrmat_fk ON resource_type_formats USING btree (format_id);


--
-- Name: res_typeform_resource_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX res_typeform_resource_fk ON resource_type_formats USING btree (resource_type_id);


--
-- Name: reserved_item_item_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX reserved_item_item_fk ON reserved_items USING btree (item_id);


--
-- Name: reserved_item_login_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX reserved_item_login_fk ON reserved_items USING btree (login_id);


--
-- Name: resource_att_media_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX resource_att_media_fk ON resource_attachments USING btree (media_item_id);


--
-- Name: resource_att_type_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX resource_att_type_fk ON resource_attachments USING btree (attachment_type_id);


--
-- Name: resource_attachment_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX resource_attachment_fk ON resource_attachments USING btree (resource_id);


--
-- Name: resource_attachment_uix; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX resource_attachment_uix ON resource_attachments USING btree (resource_id, media_item_id);


--
-- Name: resource_entity_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX resource_entity_fk ON resource_relationships USING btree (resource_id);


--
-- Name: resource_format_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX resource_format_fk ON resources USING btree (format_id);


--
-- Name: resource_item_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX resource_item_fk ON items USING btree (resource_id);


--
-- Name: resource_relationship_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX resource_relationship_fk ON resource_relationships USING btree (relationship_id);


--
-- Name: resource_relationship_uix; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX resource_relationship_uix ON resource_relationships USING btree (relationship_id, relationship_type_id, resource_id);


--
-- Name: resource_reltype_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX resource_reltype_fk ON resource_relationships USING btree (relationship_type_id);


--
-- Name: resource_type_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX resource_type_fk ON resources USING btree (resource_type_id);


--
-- Name: resources_pubstatus_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX resources_pubstatus_fk ON resources USING btree (status_id);


-- Name: role_categ_role_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX role_categ_role_fk ON role_categorizations USING btree (role_id);


--
-- Name: role_categ_subcat_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX role_categ_subcat_fk ON role_categorizations USING btree (marketing_subcategory_id);


--
-- Name: role_cinfo_cinfo_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX role_cinfo_cinfo_fk ON role_contactinfos USING btree (contactinfo_id);


--
-- Name: role_cinfo_role_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX role_cinfo_role_fk ON role_contactinfos USING btree (role_id);


--
-- Name: role_cinfo_uix; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX role_cinfo_uix ON role_contactinfos USING btree (contactinfo_id);


--
-- Name: role_distinction_instance_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX role_distinction_instance_fk ON distinction_instances USING btree (role_id);


--
-- Name: role_entity_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX role_entity_fk ON role_relationships USING btree (role_id);


--
-- Name: role_organisation_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX role_organisation_fk ON roles USING btree (organisation_id);


--
-- Name: role_relationship_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX role_relationship_fk ON role_relationships USING btree (relationship_id);


--
-- Name: role_relationship_uix; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX role_relationship_uix ON role_relationships USING btree (relationship_id, relationship_type_id, role_id);


--
-- Name: role_reltype_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX role_reltype_fk ON role_relationships USING btree (relationship_type_id);


--
-- Name: role_type_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX role_type_fk ON roles USING btree (role_type_id);


--
-- Name: sample_att_media_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX sample_att_media_fk ON sample_attachments USING btree (media_item_id);


--
-- Name: sample_att_type_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX sample_att_type_fk ON sample_attachments USING btree (attachment_type_id);


--
-- Name: sample_attachment_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX sample_attachment_fk ON sample_attachments USING btree (sample_id);


--
-- Name: sample_expression_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX sample_expression_fk ON samples USING btree (expression_id);


--
-- Name: samples_pubstatus_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX samples_pubstatus_fk ON samples USING btree (status_id);


--
-- Name: saved_rolecinfo_cinfo_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX saved_rolecinfo_cinfo_fk ON saved_role_contactinfos USING btree (role_contactinfo_id);


--
-- Name: saved_rolecinfo_list_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX saved_rolecinfo_list_fk ON saved_role_contactinfos USING btree (saved_contact_list_id);


--
-- Name: setwork_examboard_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX setwork_examboard_fk ON exam_set_works USING btree (examboard_id);


--
-- Name: superwork_entity_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX superwork_entity_fk ON superwork_relationships USING btree (superwork_id);


--
-- Name: superwork_relationship_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX superwork_relationship_fk ON superwork_relationships USING btree (relationship_id);


--
-- Name: superwork_relationship_uix; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX superwork_relationship_uix ON superwork_relationships USING btree (relationship_id, relationship_type_id, superwork_id);


--
-- Name: superwork_reltype_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX superwork_reltype_fk ON superwork_relationships USING btree (relationship_type_id);


--
-- Name: superworks_pubstatus_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX superworks_pubstatus_fk ON superworks USING btree (status_id);


--
-- Name: updated_by_10_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX updated_by_10_fk ON expressions USING btree (updated_by);


--
-- Name: updated_by_11_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX updated_by_11_fk ON relationships USING btree (updated_by);


--
-- Name: updated_by_12_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX updated_by_12_fk ON manifestations USING btree (updated_by);


--
-- Name: updated_by_13_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX updated_by_13_fk ON concepts USING btree (updated_by);


--
-- Name: updated_by_14_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX updated_by_14_fk ON samples USING btree (updated_by);


--
-- Name: updated_by_16_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX updated_by_16_fk ON events USING btree (updated_by);


--
-- Name: updated_by_17_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX updated_by_17_fk ON resources USING btree (updated_by);


--
-- Name: updated_by_18_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX updated_by_18_fk ON distinction_instances USING btree (updated_by);


--
-- Name: updated_by_19_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX updated_by_19_fk ON distinctions USING btree (updated_by);


--
-- Name: updated_by_1_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX updated_by_1_fk ON mailout_contacts USING btree (updated_by);


--
-- Name: updated_by_20_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX updated_by_20_fk ON contactinfos USING btree (updated_by);


--
-- Name: updated_by_21_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX updated_by_21_fk ON saved_searches USING btree (saved_by_login_id);


--
-- Name: updated_by_22_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX updated_by_22_fk ON communications USING btree (updated_by);


--
-- Name: updated_by_23_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX updated_by_23_fk ON projects USING btree (updated_by);


--
-- Name: updated_by_24_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX updated_by_24_fk ON marketing_campaigns USING btree (updated_by);


--
-- Name: updated_by_25_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX updated_by_25_fk ON people USING btree (updated_by);


--
-- Name: updated_by_27_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX updated_by_27_fk ON logins USING btree (updated_by);


--
-- Name: updated_by_28_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX updated_by_28_fk ON items USING btree (updated_by);


--
-- Name: updated_by_29_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX updated_by_29_fk ON roles USING btree (updated_by);


--
-- Name: updated_by_2_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX updated_by_2_fk ON campaign_mailouts USING btree (updated_by);


--
-- Name: updated_by_30_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX updated_by_30_fk ON news_articles USING btree (updated_by);


--
-- Name: updated_by_31_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX updated_by_31_fk ON sounz_services USING btree (updated_by);


--
-- Name: updated_by_3_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX updated_by_3_fk ON saved_contact_lists USING btree (updated_by);


--
-- Name: updated_by_5_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX updated_by_5_fk ON organisations USING btree (updated_by);


--
-- Name: updated_by_6_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX updated_by_6_fk ON media_items USING btree (updated_by);


--
-- Name: updated_by_7_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX updated_by_7_fk ON contributors USING btree (updated_by);


--
-- Name: updated_by_8_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX updated_by_8_fk ON superworks USING btree (updated_by);


--
-- Name: updated_by_9_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX updated_by_9_fk ON works USING btree (updated_by);


--
-- Name: veer_entity_from_index; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX veer_entity_from_index ON valid_entity_entity_relationships USING btree (entity_type_from_id);


--
-- Name: veer_entity_rel_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX veer_entity_rel_type ON valid_entity_entity_relationships USING btree (relationship_type_id);


--
-- Name: veer_entity_to_index; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX veer_entity_to_index ON valid_entity_entity_relationships USING btree (entity_type_to_id);


--
-- Name: work_ar_rights_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX work_ar_rights_fk ON work_access_rights USING btree (access_right_id);


--
-- Name: work_ar_uix; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX work_ar_uix ON work_access_rights USING btree (access_right_id, work_id, access_right_source);


--
-- Name: work_ar_work_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX work_ar_work_fk ON work_access_rights USING btree (work_id);


--
-- Name: work_att_media_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX work_att_media_fk ON work_attachments USING btree (media_item_id);


--
-- Name: work_att_type_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX work_att_type_fk ON work_attachments USING btree (attachment_type_id);


--
-- Name: work_attachment_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX work_attachment_fk ON work_attachments USING btree (work_id);


--
-- Name: work_attachment_uix; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX work_attachment_uix ON work_attachments USING btree (work_id, media_item_id);


--
-- Name: work_cat_subcat_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX work_cat_subcat_fk ON work_subcategories USING btree (work_category_id);


--
-- Name: work_categ_subcat_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX work_categ_subcat_fk ON work_categorizations USING btree (work_subcategory_id);


--
-- Name: work_categ_work_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX work_categ_work_fk ON work_categorizations USING btree (work_id);


--
-- Name: work_entity_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX work_entity_fk ON work_relationships USING btree (work_id);


--
-- Name: work_expression_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX work_expression_fk ON expressions USING btree (work_id);


--
-- Name: work_relationship_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX work_relationship_fk ON work_relationships USING btree (relationship_id);


--
-- Name: work_relationship_uix; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX work_relationship_uix ON work_relationships USING btree (relationship_id, relationship_type_id, work_id);


--
-- Name: work_reltype_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX work_reltype_fk ON work_relationships USING btree (relationship_type_id);


--
-- Name: work_superwork_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX work_superwork_fk ON works USING btree (superwork_id);


--
-- Name: works_pubstatus_fk; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX works_pubstatus_fk ON works USING btree (status_id);


--
-- Name: fk_allowed__login_all_logins; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY allowed_ips
    ADD CONSTRAINT fk_allowed__login_all_logins FOREIGN KEY (login_id) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_borrowed_borrowed__items; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY borrowed_items
    ADD CONSTRAINT fk_borrowed_borrowed__items FOREIGN KEY (item_id) REFERENCES items(item_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_borrowed_borrowed__logins; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY borrowed_items
    ADD CONSTRAINT fk_borrowed_borrowed__logins FOREIGN KEY (login_id) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_campaign_campaign__marketin; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY campaign_mailouts
    ADD CONSTRAINT fk_campaign_campaign__marketin FOREIGN KEY (marketing_campaign_id) REFERENCES marketing_campaigns(marketing_campaign_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_cm_conte_cm_conten_attachme; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cm_content_attachments
    ADD CONSTRAINT fk_cm_conte_cm_conten_attachme FOREIGN KEY (attachment_type_id) REFERENCES attachment_types(attachment_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_cm_conte_cm_conten_cm_conte; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cm_content_attachments
    ADD CONSTRAINT fk_cm_conte_cm_conten_cm_conte FOREIGN KEY (cm_content_id) REFERENCES cm_contents(cm_content_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_cm_conte_cm_conten_media_it; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cm_content_attachments
    ADD CONSTRAINT fk_cm_conte_cm_conten_media_it FOREIGN KEY (media_item_id) REFERENCES media_items(media_item_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_communic_communica_roles; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY communications
    ADD CONSTRAINT fk_communic_communica_roles FOREIGN KEY (role_id) REFERENCES roles(role_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_concept__concept_e_concepts; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY concept_relationships
    ADD CONSTRAINT fk_concept__concept_e_concepts FOREIGN KEY (concept_id) REFERENCES concepts(concept_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_concept_relationship2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY concept_relationships
    ADD CONSTRAINT fk_concept_relationship2 FOREIGN KEY (relationship_id) REFERENCES relationships(relationship_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_concept_relationship3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY concept_relationships
    ADD CONSTRAINT fk_concept_relationship3 FOREIGN KEY (relationship_type_id) REFERENCES relationship_types(relationship_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_concepts_concept_t_concept_; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY concepts
    ADD CONSTRAINT fk_concepts_concept_t_concept_ FOREIGN KEY (concept_type_id) REFERENCES concept_types(concept_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_concepts_parent_co_concepts; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY concepts
    ADD CONSTRAINT fk_concepts_parent_co_concepts FOREIGN KEY (parent_concept_id) REFERENCES concepts(concept_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_contact_method; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY communications
    ADD CONSTRAINT fk_contact_method FOREIGN KEY (communication_method_id) REFERENCES communication_methods(communication_method_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_contact_type; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY communications
    ADD CONSTRAINT fk_contact_type FOREIGN KEY (communication_type_id) REFERENCES communication_types(communication_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_contacti_contactin_countrie; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY contactinfos
    ADD CONSTRAINT fk_contacti_contactin_countrie FOREIGN KEY (country_id) REFERENCES countries(country_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_contacti_contactin_regions; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY contactinfos
    ADD CONSTRAINT fk_contacti_contactin_regions FOREIGN KEY (region_id) REFERENCES regions(region_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_contacti_preferred_communic; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY contactinfos
    ADD CONSTRAINT fk_contacti_preferred_communic FOREIGN KEY (preferred_comm_method) REFERENCES communication_methods(communication_method_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_contribu_contrib_a_attachme; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY contributor_attachments
    ADD CONSTRAINT fk_contribu_contrib_a_attachme FOREIGN KEY (attachment_type_id) REFERENCES attachment_types(attachment_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_contribu_contribut_contribu; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY contributor_attachments
    ADD CONSTRAINT fk_contribu_contribut_contribu FOREIGN KEY (contributor_id) REFERENCES contributors(contributor_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_contribu_contribut_media_it; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY contributor_attachments
    ADD CONSTRAINT fk_contribu_contribut_media_it FOREIGN KEY (media_item_id) REFERENCES media_items(media_item_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_contribu_contribut_publishi; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY contributors
    ADD CONSTRAINT fk_contribu_contribut_publishi FOREIGN KEY (status_id) REFERENCES publishing_statuses(status_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_contributor_relationship; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY role_relationships
    ADD CONSTRAINT fk_contributor_relationship FOREIGN KEY (relationship_id) REFERENCES relationships(relationship_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_contributor_relationship2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY role_relationships
    ADD CONSTRAINT fk_contributor_relationship2 FOREIGN KEY (role_id) REFERENCES roles(role_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_contributor_relationship3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY role_relationships
    ADD CONSTRAINT fk_contributor_relationship3 FOREIGN KEY (relationship_type_id) REFERENCES relationship_types(relationship_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_contributor_role; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY contributors
    ADD CONSTRAINT fk_contributor_role FOREIGN KEY (role_id) REFERENCES roles(role_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_controll_controlle_privileg; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY controller_restrictions
    ADD CONSTRAINT fk_controll_controlle_privileg FOREIGN KEY (privilege_id) REFERENCES "privileges"(privilege_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_controll_controlle_publishi; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY controller_restrictions
    ADD CONSTRAINT fk_controll_controlle_publishi FOREIGN KEY (status_id) REFERENCES publishing_statuses(status_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_def_cinfo_default; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY default_contactinfos
    ADD CONSTRAINT fk_def_cinfo_default FOREIGN KEY (d_contactinfo_id) REFERENCES contactinfos(contactinfo_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_def_cinfo_master; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY default_contactinfos
    ADD CONSTRAINT fk_def_cinfo_master FOREIGN KEY (contactinfo_id) REFERENCES contactinfos(contactinfo_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_distinct_distincin_publishi; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY distinction_instances
    ADD CONSTRAINT fk_distinct_distincin_publishi FOREIGN KEY (status_id) REFERENCES publishing_statuses(status_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_distinct_distincti_contacti; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY distinctions
    ADD CONSTRAINT fk_distinct_distincti_contacti FOREIGN KEY (contactinfo_id) REFERENCES contactinfos(contactinfo_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_distinct_distincti_publishi; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY distinctions
    ADD CONSTRAINT fk_distinct_distincti_publishi FOREIGN KEY (status_id) REFERENCES publishing_statuses(status_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_distinction_inst_event; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY distinction_instances
    ADD CONSTRAINT fk_distinction_inst_event FOREIGN KEY (event_id) REFERENCES events(event_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_distinction_inst_role; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY distinction_instances
    ADD CONSTRAINT fk_distinction_inst_role FOREIGN KEY (role_id) REFERENCES roles(role_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_distinction_instance; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY distinction_instances
    ADD CONSTRAINT fk_distinction_instance FOREIGN KEY (distinction_id) REFERENCES distinctions(distinction_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_distinction_relationship; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY distinction_relationships
    ADD CONSTRAINT fk_distinction_relationship FOREIGN KEY (relationship_id) REFERENCES relationships(relationship_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_distinction_relationship2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY distinction_relationships
    ADD CONSTRAINT fk_distinction_relationship2 FOREIGN KEY (relationship_type_id) REFERENCES relationship_types(relationship_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_distinction_relationship3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY distinction_relationships
    ADD CONSTRAINT fk_distinction_relationship3 FOREIGN KEY (distinction_instance_id) REFERENCES distinction_instances(distinction_instance_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_entity_r_entity_re_entity_t; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY entity_relationship_types
    ADD CONSTRAINT fk_entity_r_entity_re_entity_t FOREIGN KEY (entity_type_id) REFERENCES entity_types(entity_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_entity_r_entity_re_relation; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY entity_relationship_types
    ADD CONSTRAINT fk_entity_r_entity_re_relation FOREIGN KEY (relationship_type_id) REFERENCES relationship_types(relationship_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_entity_type_a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY relationships
    ADD CONSTRAINT fk_entity_type_a FOREIGN KEY (ent_entity_type_id) REFERENCES entity_types(entity_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_entity_type_b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY relationships
    ADD CONSTRAINT fk_entity_type_b FOREIGN KEY (entity_type_id) REFERENCES entity_types(entity_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_event_at_event_att_attachme; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY event_attachments
    ADD CONSTRAINT fk_event_at_event_att_attachme FOREIGN KEY (attachment_type_id) REFERENCES attachment_types(attachment_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_event_at_event_att_events; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY event_attachments
    ADD CONSTRAINT fk_event_at_event_att_events FOREIGN KEY (event_id) REFERENCES events(event_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_event_at_event_att_media_it; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY event_attachments
    ADD CONSTRAINT fk_event_at_event_att_media_it FOREIGN KEY (media_item_id) REFERENCES media_items(media_item_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_event_re_event_ent_events; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY event_relationships
    ADD CONSTRAINT fk_event_re_event_ent_events FOREIGN KEY (event_id) REFERENCES events(event_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_event_relationship; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY event_relationships
    ADD CONSTRAINT fk_event_relationship FOREIGN KEY (relationship_id) REFERENCES relationships(relationship_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_event_relationship2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY event_relationships
    ADD CONSTRAINT fk_event_relationship2 FOREIGN KEY (relationship_type_id) REFERENCES relationship_types(relationship_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_events_event_con_contacti; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY events
    ADD CONSTRAINT fk_events_event_con_contacti FOREIGN KEY (contactinfo_id) REFERENCES contactinfos(contactinfo_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_events_event_typ_event_ty; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY events
    ADD CONSTRAINT fk_events_event_typ_event_ty FOREIGN KEY (event_type_id) REFERENCES event_types(event_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_events_events_pu_publishi; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY events
    ADD CONSTRAINT fk_events_events_pu_publishi FOREIGN KEY (status_id) REFERENCES publishing_statuses(status_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_events_parent_ev_events; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY events
    ADD CONSTRAINT fk_events_parent_ev_events FOREIGN KEY (related_event_id) REFERENCES events(event_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_exam_set_exam_set__manifest; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY exam_set_works
    ADD CONSTRAINT fk_exam_set_exam_set__manifest FOREIGN KEY (manifestation_id) REFERENCES manifestations(manifestation_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_exam_set_setwork_e_examboar; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY exam_set_works
    ADD CONSTRAINT fk_exam_set_setwork_e_examboar FOREIGN KEY (examboard_id) REFERENCES examboards(examboard_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_expressi_expr_ar_e_expressi; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY expression_access_rights
    ADD CONSTRAINT fk_expressi_expr_ar_e_expressi FOREIGN KEY (expression_id) REFERENCES expressions(expression_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_expressi_expr_ar_r_access_r; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY expression_access_rights
    ADD CONSTRAINT fk_expressi_expr_ar_r_access_r FOREIGN KEY (access_right_id) REFERENCES access_rights(access_right_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_expressi_expressio_publishi; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY expressions
    ADD CONSTRAINT fk_expressi_expressio_publishi FOREIGN KEY (status_id) REFERENCES publishing_statuses(status_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_expressi_manifesta_manifest; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY expression_manifestations
    ADD CONSTRAINT fk_expressi_manifesta_manifest FOREIGN KEY (manifestation_id) REFERENCES manifestations(manifestation_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_expressi_mode_of_e_modes; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY expressions
    ADD CONSTRAINT fk_expressi_mode_of_e_modes FOREIGN KEY (mode_id) REFERENCES modes(mode_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_expressi_work_expr_works; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY expressions
    ADD CONSTRAINT fk_expressi_work_expr_works FOREIGN KEY (work_id) REFERENCES works(work_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_expression_entity; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY expression_relationships
    ADD CONSTRAINT fk_expression_entity FOREIGN KEY (expression_id) REFERENCES expressions(expression_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_expression_lang_expression; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY expression_languages
    ADD CONSTRAINT fk_expression_lang_expression FOREIGN KEY (expression_id) REFERENCES expressions(expression_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_expression_lang_lang; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY expression_languages
    ADD CONSTRAINT fk_expression_lang_lang FOREIGN KEY (language_id) REFERENCES languages(language_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_expression_manifestation; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY expression_manifestations
    ADD CONSTRAINT fk_expression_manifestation FOREIGN KEY (expression_id) REFERENCES expressions(expression_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_expression_relationship; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY expression_relationships
    ADD CONSTRAINT fk_expression_relationship FOREIGN KEY (relationship_id) REFERENCES relationships(relationship_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_expression_relationship2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY expression_relationships
    ADD CONSTRAINT fk_expression_relationship2 FOREIGN KEY (relationship_type_id) REFERENCES relationship_types(relationship_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_items_item_type_item_typ; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY items
    ADD CONSTRAINT fk_items_item_type_item_typ FOREIGN KEY (item_type_id) REFERENCES item_types(item_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_items_items_pub_publishi; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY items
    ADD CONSTRAINT fk_items_items_pub_publishi FOREIGN KEY (status_id) REFERENCES publishing_statuses(status_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_items_manifesta_manifest; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY items
    ADD CONSTRAINT fk_items_manifesta_manifest FOREIGN KEY (manifestation_id) REFERENCES manifestations(manifestation_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_items_resource__resource; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY items
    ADD CONSTRAINT fk_items_resource__resource FOREIGN KEY (resource_id) REFERENCES resources(resource_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_logins_org_login_organisa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY logins
    ADD CONSTRAINT fk_logins_org_login_organisa FOREIGN KEY (organisation_id) REFERENCES organisations(organisation_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_logins_person_lo_people; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY logins
    ADD CONSTRAINT fk_logins_person_lo_people FOREIGN KEY (person_id) REFERENCES people(person_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_mailout__mailout_a_attachme; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mailout_attachments
    ADD CONSTRAINT fk_mailout__mailout_a_attachme FOREIGN KEY (attachment_type_id) REFERENCES attachment_types(attachment_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_mailout__mailout_a_campaign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mailout_attachments
    ADD CONSTRAINT fk_mailout__mailout_a_campaign FOREIGN KEY (campaign_mailout_id) REFERENCES campaign_mailouts(campaign_mailout_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_mailout__mailout_a_media_it; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mailout_attachments
    ADD CONSTRAINT fk_mailout__mailout_a_media_it FOREIGN KEY (media_item_id) REFERENCES media_items(media_item_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_mailout__mailout_c_campaign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mailout_contacts
    ADD CONSTRAINT fk_mailout__mailout_c_campaign FOREIGN KEY (campaign_mailout_id) REFERENCES campaign_mailouts(campaign_mailout_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_mailout__mailout_r_role_con; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mailout_contacts
    ADD CONSTRAINT fk_mailout__mailout_r_role_con FOREIGN KEY (role_contactinfo_id) REFERENCES role_contactinfos(role_contactinfo_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_manifest_manif_ar__access_r; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY manifestation_access_rights
    ADD CONSTRAINT fk_manifest_manif_ar__access_r FOREIGN KEY (access_right_id) REFERENCES access_rights(access_right_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_manifest_manif_ar__manifest; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY manifestation_access_rights
    ADD CONSTRAINT fk_manifest_manif_ar__manifest FOREIGN KEY (manifestation_id) REFERENCES manifestations(manifestation_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_manifest_manif_typ_formats; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY manifestation_type_formats
    ADD CONSTRAINT fk_manifest_manif_typ_formats FOREIGN KEY (format_id) REFERENCES formats(format_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_manifest_manif_typ_manifest; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY manifestation_type_formats
    ADD CONSTRAINT fk_manifest_manif_typ_manifest FOREIGN KEY (manifestation_type_id) REFERENCES manifestation_types(manifestation_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_manifest_manifesta_attachme; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY manifestation_attachments
    ADD CONSTRAINT fk_manifest_manifesta_attachme FOREIGN KEY (attachment_type_id) REFERENCES attachment_types(attachment_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_manifest_manifesta_formats; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY manifestations
    ADD CONSTRAINT fk_manifest_manifesta_formats FOREIGN KEY (format_id) REFERENCES formats(format_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_manifest_manifesta_manifest; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY manifestations
    ADD CONSTRAINT fk_manifest_manifesta_manifest FOREIGN KEY (manifestation_type_id) REFERENCES manifestation_types(manifestation_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_manifest_manifesta_media_it; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY manifestation_attachments
    ADD CONSTRAINT fk_manifest_manifesta_media_it FOREIGN KEY (media_item_id) REFERENCES media_items(media_item_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_manifest_manifesta_publishi; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY manifestations
    ADD CONSTRAINT fk_manifest_manifesta_publishi FOREIGN KEY (status_id) REFERENCES publishing_statuses(status_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_manifestation_attachment; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY manifestation_attachments
    ADD CONSTRAINT fk_manifestation_attachment FOREIGN KEY (manifestation_id) REFERENCES manifestations(manifestation_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_manifestation_relationship; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY manifestation_relationships
    ADD CONSTRAINT fk_manifestation_relationship FOREIGN KEY (relationship_id) REFERENCES relationships(relationship_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_manifestation_relationship2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY manifestation_relationships
    ADD CONSTRAINT fk_manifestation_relationship2 FOREIGN KEY (relationship_type_id) REFERENCES relationship_types(relationship_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_manifestation_relationship3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY manifestation_relationships
    ADD CONSTRAINT fk_manifestation_relationship3 FOREIGN KEY (manifestation_id) REFERENCES manifestations(manifestation_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_marketin_campaign__mgr; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY marketing_campaigns
    ADD CONSTRAINT fk_marketin_campaign__mgr FOREIGN KEY (campaign_manager) REFERENCES project_team_members(project_team_member_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_marketin_marketing_marketin; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY marketing_subcategories
    ADD CONSTRAINT fk_marketin_marketing_marketin FOREIGN KEY (marketing_category_id) REFERENCES marketing_categories(marketing_category_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_marketin_project_c_projects; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY marketing_campaigns
    ADD CONSTRAINT fk_marketin_project_c_projects FOREIGN KEY (project_id) REFERENCES projects(project_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_media_it_media_ite_mime_typ; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY media_items
    ADD CONSTRAINT fk_media_it_media_ite_mime_typ FOREIGN KEY (mime_type_id) REFERENCES mime_types(mime_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_media_it_parent_me_media_it; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY media_items
    ADD CONSTRAINT fk_media_it_parent_me_media_it FOREIGN KEY (parent_id) REFERENCES media_items(media_item_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_member_t_memtype_p_member_t; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY member_type_privileges
    ADD CONSTRAINT fk_member_t_memtype_p_member_t FOREIGN KEY (member_type_id) REFERENCES member_types(member_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_member_t_memtype_p_privileg; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY member_type_privileges
    ADD CONSTRAINT fk_member_t_memtype_p_privileg FOREIGN KEY (privilege_id) REFERENCES "privileges"(privilege_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_membersh_membershi_logins; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY memberships
    ADD CONSTRAINT fk_membersh_membershi_logins FOREIGN KEY (login_id) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_membersh_membershi_member_t; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY memberships
    ADD CONSTRAINT fk_membersh_membershi_member_t FOREIGN KEY (member_type_id) REFERENCES member_types(member_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_mime_typ_mimetype__mime_cat; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mime_types
    ADD CONSTRAINT fk_mime_typ_mimetype__mime_cat FOREIGN KEY (mime_category_id) REFERENCES mime_categories(mime_category_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_news_art_news_arti_attachme; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY news_article_attachments
    ADD CONSTRAINT fk_news_art_news_arti_attachme FOREIGN KEY (attachment_type_id) REFERENCES attachment_types(attachment_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_news_art_news_arti_media_it; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY news_article_attachments
    ADD CONSTRAINT fk_news_art_news_arti_media_it FOREIGN KEY (media_item_id) REFERENCES media_items(media_item_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_news_art_news_arti_news_art; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY news_article_attachments
    ADD CONSTRAINT fk_news_art_news_arti_news_art FOREIGN KEY (news_article_id) REFERENCES news_articles(news_article_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_news_art_updated_b_logins; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY news_articles
    ADD CONSTRAINT fk_news_art_updated_b_logins FOREIGN KEY (updated_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_news_article_news_article_publishi; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY news_articles
    ADD CONSTRAINT fk_news_article_news_article_publishi FOREIGN KEY (status_id) REFERENCES publishing_statuses(status_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_organisa_org_att_t_attachme; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY organisation_attachments
    ADD CONSTRAINT fk_organisa_org_att_t_attachme FOREIGN KEY (attachment_type_id) REFERENCES attachment_types(attachment_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_organisa_organisat_media_it; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY organisation_attachments
    ADD CONSTRAINT fk_organisa_organisat_media_it FOREIGN KEY (media_item_id) REFERENCES media_items(media_item_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_organisa_organisat_organisa; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY organisation_attachments
    ADD CONSTRAINT fk_organisa_organisat_organisa FOREIGN KEY (organisation_id) REFERENCES organisations(organisation_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_organisa_organisat_publishi; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY organisations
    ADD CONSTRAINT fk_organisa_organisat_publishi FOREIGN KEY (status_id) REFERENCES publishing_statuses(status_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_people_people_pu_publishi; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY people
    ADD CONSTRAINT fk_people_people_pu_publishi FOREIGN KEY (status_id) REFERENCES publishing_statuses(status_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_people_person_no_nomens; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY people
    ADD CONSTRAINT fk_people_person_no_nomens FOREIGN KEY (nomen_id) REFERENCES nomens(nomen_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_person_a_person_at_attachme; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY person_attachments
    ADD CONSTRAINT fk_person_a_person_at_attachme FOREIGN KEY (attachment_type_id) REFERENCES attachment_types(attachment_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_person_a_person_at_media_it; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY person_attachments
    ADD CONSTRAINT fk_person_a_person_at_media_it FOREIGN KEY (media_item_id) REFERENCES media_items(media_item_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_person_a_person_at_people; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY person_attachments
    ADD CONSTRAINT fk_person_a_person_at_people FOREIGN KEY (person_id) REFERENCES people(person_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_project__project_t_people; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_team_members
    ADD CONSTRAINT fk_project__project_t_people FOREIGN KEY (person_id) REFERENCES people(person_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_project__project_t_projects; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY project_team_members
    ADD CONSTRAINT fk_project__project_t_projects FOREIGN KEY (project_id) REFERENCES projects(project_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_prov_composer_bios_pubstatus; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY prov_composer_bios
    ADD CONSTRAINT fk_prov_composer_bios_pubstatus FOREIGN KEY (status_id) REFERENCES publishing_statuses(status_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_prov_composer_bios_submitted_by; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY prov_composer_bios
    ADD CONSTRAINT fk_prov_composer_bios_submitted_by FOREIGN KEY (submitted_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_prov_contact_updates_pubstatus; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY prov_contact_updates
    ADD CONSTRAINT fk_prov_contact_updates_pubstatus FOREIGN KEY (status_id) REFERENCES publishing_statuses(status_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_prov_contact_updates_submitted_by; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY prov_contact_updates
    ADD CONSTRAINT fk_prov_contact_updates_submitted_by FOREIGN KEY (submitted_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_prov_contributor_profiles_pubstatus; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY prov_contributor_profiles
    ADD CONSTRAINT fk_prov_contributor_profiles_pubstatus FOREIGN KEY (status_id) REFERENCES publishing_statuses(status_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_prov_contributor_profiles_submitted_by; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY prov_contributor_profiles
    ADD CONSTRAINT fk_prov_contributor_profiles_submitted_by FOREIGN KEY (submitted_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_prov_events_pubstatus; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY prov_events
    ADD CONSTRAINT fk_prov_events_pubstatus FOREIGN KEY (status_id) REFERENCES publishing_statuses(status_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_prov_events_submitted_by; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY prov_events
    ADD CONSTRAINT fk_prov_events_submitted_by FOREIGN KEY (submitted_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_prov_feedbacks_pubstatus; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY prov_feedbacks
    ADD CONSTRAINT fk_prov_feedbacks_pubstatus FOREIGN KEY (status_id) REFERENCES publishing_statuses(status_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_prov_feedbacks_submitted_by; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY prov_feedbacks
    ADD CONSTRAINT fk_prov_feedbacks_submitted_by FOREIGN KEY (submitted_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_prov_wor_fk_prov_w_logins; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY prov_work_updates
    ADD CONSTRAINT fk_prov_wor_fk_prov_w_logins FOREIGN KEY (submitted_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_prov_work_updates_pubstatus; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY prov_work_updates
    ADD CONSTRAINT fk_prov_work_updates_pubstatus FOREIGN KEY (status_id) REFERENCES publishing_statuses(status_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_regions_region_co_countrie; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY regions
    ADD CONSTRAINT fk_regions_region_co_countrie FOREIGN KEY (country_id) REFERENCES countries(country_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_related_communication; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY related_communications
    ADD CONSTRAINT fk_related_communication FOREIGN KEY (communication_id) REFERENCES communications(communication_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_related_communication2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY related_communications
    ADD CONSTRAINT fk_related_communication2 FOREIGN KEY (com_communication_id) REFERENCES communications(communication_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_related_org; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY related_organisations
    ADD CONSTRAINT fk_related_org FOREIGN KEY (org_organisation_id) REFERENCES organisations(organisation_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_related_org2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY related_organisations
    ADD CONSTRAINT fk_related_org2 FOREIGN KEY (organisation_id) REFERENCES organisations(organisation_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_reserved_reserved__items; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY reserved_items
    ADD CONSTRAINT fk_reserved_reserved__items FOREIGN KEY (item_id) REFERENCES items(item_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_reserved_reserved__logins; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY reserved_items
    ADD CONSTRAINT fk_reserved_reserved__logins FOREIGN KEY (login_id) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_resource_relationship; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_relationships
    ADD CONSTRAINT fk_resource_relationship FOREIGN KEY (relationship_id) REFERENCES relationships(relationship_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_resource_relationship2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_relationships
    ADD CONSTRAINT fk_resource_relationship2 FOREIGN KEY (relationship_type_id) REFERENCES relationship_types(relationship_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_resource_relationship3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_relationships
    ADD CONSTRAINT fk_resource_relationship3 FOREIGN KEY (resource_id) REFERENCES resources(resource_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_resource_res_ar_re_resource; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_access_rights
    ADD CONSTRAINT fk_resource_res_ar_re_resource FOREIGN KEY (resource_id) REFERENCES resources(resource_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_resource_res_ar_ri_access_r; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_access_rights
    ADD CONSTRAINT fk_resource_res_ar_ri_access_r FOREIGN KEY (access_right_id) REFERENCES access_rights(access_right_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_resource_res_typef_formats; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_type_formats
    ADD CONSTRAINT fk_resource_res_typef_formats FOREIGN KEY (format_id) REFERENCES formats(format_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_resource_res_typef_resource; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_type_formats
    ADD CONSTRAINT fk_resource_res_typef_resource FOREIGN KEY (resource_type_id) REFERENCES resource_types(resource_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_resource_resource__attachme; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_attachments
    ADD CONSTRAINT fk_resource_resource__attachme FOREIGN KEY (attachment_type_id) REFERENCES attachment_types(attachment_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_resource_resource__formats; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resources
    ADD CONSTRAINT fk_resource_resource__formats FOREIGN KEY (format_id) REFERENCES formats(format_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_resource_resource__media_it; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_attachments
    ADD CONSTRAINT fk_resource_resource__media_it FOREIGN KEY (media_item_id) REFERENCES media_items(media_item_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_resource_resource__resource; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resource_attachments
    ADD CONSTRAINT fk_resource_resource__resource FOREIGN KEY (resource_id) REFERENCES resources(resource_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_resource_resources_publishi; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resources
    ADD CONSTRAINT fk_resource_resources_publishi FOREIGN KEY (status_id) REFERENCES publishing_statuses(status_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_resource_type; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resources
    ADD CONSTRAINT fk_resource_type FOREIGN KEY (resource_type_id) REFERENCES resource_types(resource_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_role_cat_role_cate_marketin; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY role_categorizations
    ADD CONSTRAINT fk_role_cat_role_cate_marketin FOREIGN KEY (marketing_subcategory_id) REFERENCES marketing_subcategories(marketing_subcategory_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_role_cat_role_cate_roles; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY role_categorizations
    ADD CONSTRAINT fk_role_cat_role_cate_roles FOREIGN KEY (role_id) REFERENCES roles(role_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_role_cinfo_cinfo; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY role_contactinfos
    ADD CONSTRAINT fk_role_cinfo_cinfo FOREIGN KEY (contactinfo_id) REFERENCES contactinfos(contactinfo_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_role_cinfo_role; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY role_contactinfos
    ADD CONSTRAINT fk_role_cinfo_role FOREIGN KEY (role_id) REFERENCES roles(role_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_role_org; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT fk_role_org FOREIGN KEY (organisation_id) REFERENCES organisations(organisation_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_role_person; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT fk_role_person FOREIGN KEY (person_id) REFERENCES people(person_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_roles_role_type_role_typ; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT fk_roles_role_type_role_typ FOREIGN KEY (role_type_id) REFERENCES role_types(role_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_roles_updated_b_logins; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT fk_roles_updated_b_logins FOREIGN KEY (updated_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_sample_a_sample_at_attachme; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_attachments
    ADD CONSTRAINT fk_sample_a_sample_at_attachme FOREIGN KEY (attachment_type_id) REFERENCES attachment_types(attachment_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_sample_a_sample_at_media_it; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_attachments
    ADD CONSTRAINT fk_sample_a_sample_at_media_it FOREIGN KEY (media_item_id) REFERENCES media_items(media_item_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_sample_a_sample_at_samples; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sample_attachments
    ADD CONSTRAINT fk_sample_a_sample_at_samples FOREIGN KEY (sample_id) REFERENCES samples(sample_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_sample_expression; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY samples
    ADD CONSTRAINT fk_sample_expression FOREIGN KEY (expression_id) REFERENCES expressions(expression_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_samples_manifesta_manifest; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY samples
    ADD CONSTRAINT fk_samples_manifesta_manifest FOREIGN KEY (manifestation_id) REFERENCES manifestations(manifestation_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_samples_samples_p_publishi; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY samples
    ADD CONSTRAINT fk_samples_samples_p_publishi FOREIGN KEY (status_id) REFERENCES publishing_statuses(status_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_saved_by_login_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY saved_searches
    ADD CONSTRAINT fk_saved_by_login_id FOREIGN KEY (saved_by_login_id) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_saved_rolecinfo_cinfo; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY saved_role_contactinfos
    ADD CONSTRAINT fk_saved_rolecinfo_cinfo FOREIGN KEY (role_contactinfo_id) REFERENCES role_contactinfos(role_contactinfo_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_saved_rolecinfo_list; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY saved_role_contactinfos
    ADD CONSTRAINT fk_saved_rolecinfo_list FOREIGN KEY (saved_contact_list_id) REFERENCES saved_contact_lists(saved_contact_list_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_sounz_donations_updated_by; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sounz_donations
    ADD CONSTRAINT fk_sounz_donations_updated_by FOREIGN KEY (updated_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_sounz_services_updated_by; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sounz_services
    ADD CONSTRAINT fk_sounz_services_updated_by FOREIGN KEY (updated_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_superwor_superwork_publishi; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY superworks
    ADD CONSTRAINT fk_superwor_superwork_publishi FOREIGN KEY (status_id) REFERENCES publishing_statuses(status_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_superwor_superwork_superwor; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY superwork_relationships
    ADD CONSTRAINT fk_superwor_superwork_superwor FOREIGN KEY (superwork_id) REFERENCES superworks(superwork_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_superwork_relationship; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY superwork_relationships
    ADD CONSTRAINT fk_superwork_relationship FOREIGN KEY (relationship_id) REFERENCES relationships(relationship_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_superwork_relationship2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY superwork_relationships
    ADD CONSTRAINT fk_superwork_relationship2 FOREIGN KEY (relationship_type_id) REFERENCES relationship_types(relationship_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_updated_by_10; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY expressions
    ADD CONSTRAINT fk_updated_by_10 FOREIGN KEY (updated_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_updated_by_11; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY relationships
    ADD CONSTRAINT fk_updated_by_11 FOREIGN KEY (updated_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_updated_by_12; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY manifestations
    ADD CONSTRAINT fk_updated_by_12 FOREIGN KEY (updated_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_updated_by_13; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY concepts
    ADD CONSTRAINT fk_updated_by_13 FOREIGN KEY (updated_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_updated_by_14; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY samples
    ADD CONSTRAINT fk_updated_by_14 FOREIGN KEY (updated_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_updated_by_16; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY events
    ADD CONSTRAINT fk_updated_by_16 FOREIGN KEY (updated_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_updated_by_17; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY resources
    ADD CONSTRAINT fk_updated_by_17 FOREIGN KEY (updated_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_updated_by_19; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY distinctions
    ADD CONSTRAINT fk_updated_by_19 FOREIGN KEY (updated_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_updated_by_2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY campaign_mailouts
    ADD CONSTRAINT fk_updated_by_2 FOREIGN KEY (updated_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_updated_by_20; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY contactinfos
    ADD CONSTRAINT fk_updated_by_20 FOREIGN KEY (updated_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_updated_by_21; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY saved_searches
    ADD CONSTRAINT fk_updated_by_21 FOREIGN KEY (updated_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_updated_by_22; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY communications
    ADD CONSTRAINT fk_updated_by_22 FOREIGN KEY (updated_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_updated_by_23; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT fk_updated_by_23 FOREIGN KEY (updated_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_updated_by_24; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY marketing_campaigns
    ADD CONSTRAINT fk_updated_by_24 FOREIGN KEY (updated_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_updated_by_25; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY people
    ADD CONSTRAINT fk_updated_by_25 FOREIGN KEY (updated_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_updated_by_27; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY logins
    ADD CONSTRAINT fk_updated_by_27 FOREIGN KEY (updated_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_updated_by_28; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY items
    ADD CONSTRAINT fk_updated_by_28 FOREIGN KEY (updated_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_updated_by_3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY saved_contact_lists
    ADD CONSTRAINT fk_updated_by_3 FOREIGN KEY (updated_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_updated_by_5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY organisations
    ADD CONSTRAINT fk_updated_by_5 FOREIGN KEY (updated_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_updated_by_6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY media_items
    ADD CONSTRAINT fk_updated_by_6 FOREIGN KEY (updated_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_updated_by_7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY contributors
    ADD CONSTRAINT fk_updated_by_7 FOREIGN KEY (updated_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_updated_by_8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY superworks
    ADD CONSTRAINT fk_updated_by_8 FOREIGN KEY (updated_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_updated_by_9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY works
    ADD CONSTRAINT fk_updated_by_9 FOREIGN KEY (updated_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_veer_entitytype_from; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY valid_entity_entity_relationships
    ADD CONSTRAINT fk_veer_entitytype_from FOREIGN KEY (entity_type_from_id) REFERENCES entity_types(entity_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_veer_entitytype_to; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY valid_entity_entity_relationships
    ADD CONSTRAINT fk_veer_entitytype_to FOREIGN KEY (entity_type_to_id) REFERENCES entity_types(entity_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_veer_relationshiptype; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY valid_entity_entity_relationships
    ADD CONSTRAINT fk_veer_relationshiptype FOREIGN KEY (relationship_type_id) REFERENCES relationship_types(relationship_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_work_acc_work_ar_r_access_r; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY work_access_rights
    ADD CONSTRAINT fk_work_acc_work_ar_r_access_r FOREIGN KEY (access_right_id) REFERENCES access_rights(access_right_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_work_acc_work_ar_w_works; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY work_access_rights
    ADD CONSTRAINT fk_work_acc_work_ar_w_works FOREIGN KEY (work_id) REFERENCES works(work_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_work_att_work_att__attachme; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY work_attachments
    ADD CONSTRAINT fk_work_att_work_att__attachme FOREIGN KEY (attachment_type_id) REFERENCES attachment_types(attachment_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_work_att_work_att__media_it; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY work_attachments
    ADD CONSTRAINT fk_work_att_work_att__media_it FOREIGN KEY (media_item_id) REFERENCES media_items(media_item_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_work_att_work_atta_works; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY work_attachments
    ADD CONSTRAINT fk_work_att_work_atta_works FOREIGN KEY (work_id) REFERENCES works(work_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_work_cat_work_cate_work_sub; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY work_categorizations
    ADD CONSTRAINT fk_work_cat_work_cate_work_sub FOREIGN KEY (work_subcategory_id) REFERENCES work_subcategories(work_subcategory_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_work_cat_work_cate_works; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY work_categorizations
    ADD CONSTRAINT fk_work_cat_work_cate_works FOREIGN KEY (work_id) REFERENCES works(work_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_work_rel_work_enti_works; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY work_relationships
    ADD CONSTRAINT fk_work_rel_work_enti_works FOREIGN KEY (work_id) REFERENCES works(work_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_work_relationship; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY work_relationships
    ADD CONSTRAINT fk_work_relationship FOREIGN KEY (relationship_id) REFERENCES relationships(relationship_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_work_relationship2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY work_relationships
    ADD CONSTRAINT fk_work_relationship2 FOREIGN KEY (relationship_type_id) REFERENCES relationship_types(relationship_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_work_sub_work_cat__work_cat; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY work_subcategories
    ADD CONSTRAINT fk_work_sub_work_cat__work_cat FOREIGN KEY (work_category_id) REFERENCES work_categories(work_category_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: fk_works_main_work_work_sub; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY works
    ADD CONSTRAINT fk_works_main_work_work_sub FOREIGN KEY (work_subcategory_id) REFERENCES work_subcategories(work_subcategory_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_works_work_supe_superwor; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY works
    ADD CONSTRAINT fk_works_work_supe_superwor FOREIGN KEY (superwork_id) REFERENCES superworks(superwork_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fk_works_works_pub_publishi; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY works
    ADD CONSTRAINT fk_works_works_pub_publishi FOREIGN KEY (status_id) REFERENCES publishing_statuses(status_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: updated_by_1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mailout_contacts
    ADD CONSTRAINT updated_by_1 FOREIGN KEY (updated_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- Name: updated_by_18; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY distinction_instances
    ADD CONSTRAINT updated_by_18 FOREIGN KEY (updated_by) REFERENCES logins(login_id) ON UPDATE RESTRICT ON DELETE RESTRICT DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

