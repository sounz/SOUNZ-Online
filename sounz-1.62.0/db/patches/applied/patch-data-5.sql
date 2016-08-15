
-- create a view to more easily access tables of work info for advanced search

BEGIN;

CREATE VIEW works_advanced_search AS
SELECT w.work_id, w.programme_note, w.status_id, e.expression_id,em.expression_manifestation_id,m.manifestation_id,mt.manifestation_type_category,s.sample_id 
FROM works w 
LEFT JOIN expressions e ON e.work_id=w.work_id 
LEFT JOIN expression_manifestations em ON e.expression_id=em.expression_id 
LEFT JOIN manifestations m ON em.manifestation_id=m.manifestation_id 
LEFT JOIN manifestation_types mt ON m.manifestation_type_id=mt.manifestation_type_id 
LEFT JOIN samples s ON s.manifestation_id=m.manifestation_id;


GRANT SELECT ON works_advanced_search TO SOUNZ_REPORTS;

COMMIT;
