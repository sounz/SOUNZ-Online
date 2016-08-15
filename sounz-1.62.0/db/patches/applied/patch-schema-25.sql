----------------------------------------------------------------------------
-- dbdiff.php 2.1.0 PostgreSQL v8.1
-- connecting as user paul at 30/10/2007 11:27:36
--
-- Instructions:
-- apply this script to target database diffsounz, This will then
-- make it identical to the reference database, diffsounz-new.
--
----------------------------------------------------------------------------

-- RE-CREATING CHANGED CONSTRAINT ckc_login_agent_class_logins
alter table logins
 drop constraint ckc_login_agent_class_logins restrict;
alter table logins
  add constraint ckc_login_agent_class_logins check (((login_agent_class = 'P'::bpchar) OR (login_agent_class = 'O'::bpchar)) OR (login_agent_class = 'G'::bpchar));
