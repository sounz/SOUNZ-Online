

--add a unique product_id to manifestations and resources

begin;
create sequence sounz_product_id_seq;
alter table manifestations add column sale_product_id int not null default nextval('sounz_product_id_seq');
alter table manifestations add column loan_product_id int not null default nextval('sounz_product_id_seq');
alter table resources add column sale_product_id int not null default nextval('sounz_product_id_seq');
alter table resources add column loan_product_id int not null default nextval('sounz_product_id_seq');

commit;
