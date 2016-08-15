-- Fix 'critical' issue with naming...
begin;
update relationship_types set relationship_type_desc ='Is broadcast by' where relationship_type_desc = 'Is broadcasted by';
commit;