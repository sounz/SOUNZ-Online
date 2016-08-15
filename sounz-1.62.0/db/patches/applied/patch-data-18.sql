--Convert administrators to superusers
begin;
update memberships set member_type_id = 
	(select member_type_id from member_types where member_type_desc = 'Superuser') where 
	member_type_id = (select member_type_id from member_types where member_type_desc = 'Administrator');
commit;

