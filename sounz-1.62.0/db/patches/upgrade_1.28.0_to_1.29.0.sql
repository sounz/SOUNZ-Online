-- Patch for SOUNZ database upgrade
-- 1.28.0 to 1.29.0
--

-- Delete 'UNKNOWN' categories and appropriate subcategories
-- as deprecated - WR#59124
begin;

delete from work_subcategories where work_category_id in (select work_category_id from work_categories where work_category_desc ilike 'unknown%');

delete from work_categories where work_category_desc ilike 'unknown%';

commit;
