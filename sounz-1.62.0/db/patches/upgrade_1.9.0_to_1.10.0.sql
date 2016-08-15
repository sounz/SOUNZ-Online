begin;

-- Name fix
update work_subcategories set work_subcategory_desc = 'Requires Found or Invented Instruments' 
where work_subcategory_desc = 'Requires Found Instruments';

-- Addition of site specific
insert into work_subcategories (work_subcategory_desc, work_category_id, legacy_4d_identity_code) values
	('Site specific', 
	(select work_category_id from work_categories where work_category_desc = 'Additional'),
	9999
	);
commit;
