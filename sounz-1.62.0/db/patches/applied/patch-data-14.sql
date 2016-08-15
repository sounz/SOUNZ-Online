-- add a super user
begin;
insert into member_types (member_type_desc) values ('Superuser');
commit;
