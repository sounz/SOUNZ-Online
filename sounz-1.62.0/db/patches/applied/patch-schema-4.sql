/*Column to support explicit ordering of role types is needed*/
alter table role_types add column display_order int not null default 0;