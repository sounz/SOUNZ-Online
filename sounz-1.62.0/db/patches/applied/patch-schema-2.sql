----------------------------------------------------------------------------
-- dbdiff.php 2.1.0 PostgreSQL v8.1
-- connecting as user paul at 22/08/2007 17:44:38
--
-- Instructions:
-- apply this script to target database sounz, This will then
-- make it identical to the reference database, sounz-new.
--
----------------------------------------------------------------------------

-- CREATING NEW INDEX res_ar_uix

CREATE unique INDEX RES_AR_UIX ON resource_access_rights (
  access_right_id,
  resource_id,
  access_right_source
);

