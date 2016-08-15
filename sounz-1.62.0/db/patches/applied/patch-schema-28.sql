-- Allow status_id of controller_restrictions to be NULL
begin;

alter table controller_restrictions alter column status_id drop NOT NULL;

commit;