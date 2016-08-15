--

begin;
	insert into member_types (member_type_desc) values ('Editor');
		
	insert into member_type_privileges 	(member_type_id , privilege_id ) values (
		(select member_type_id from member_types where member_type_desc  = 'Editor'),
		(select  privilege_id from privileges where  privilege_name  = 'CAN_EDIT_CONTENT_PAGES')
		);
		

commit;