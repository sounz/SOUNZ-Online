-- Views for sonline music search
BEGIN;

CREATE VIEW work_manifestation_advanced_search AS
SELECT w.work_id, e.expression_id, em.expression_manifestation_id, m.manifestation_id, m.available_for_hire,
m.available_for_sale, m.downloadable 
FROM works w 
LEFT JOIN expressions e ON e.work_id=w.work_id 
LEFT JOIN expression_manifestations em ON e.expression_id=em.expression_id 
LEFT JOIN manifestations m ON em.manifestation_id=m.manifestation_id;

COMMIT;

--add 'downloadable' field to resource_advanced_search view
begin;

--first drop resource_advanced_search view

drop view resource_advanced_search;

--then recreate it with 'downloadable' field
create view resource_advanced_search as
select r.resource_id, r.status_id, rt.resource_type_id, f.format_id, r.clonable, r.available_for_loan, r.available_for_hire,
r.available_for_sale, r.downloadable
from resources r
left join resource_types rt on rt.resource_type_id = r.resource_type_id
left join resource_type_formats rtf on rtf.resource_type_format_id = r.format_id
left join formats f on f.format_id = r.format_id
;
commit;