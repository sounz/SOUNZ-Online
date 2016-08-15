----------------------------------------------------------------------------
-- VIEWS
-- 
-- Definitions of all views defined for the SOUNZ database.
--
----------------------------------------------------------------------------

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

BEGIN;

CREATE VIEW work_composers AS
SELECT works.superwork_id, works.work_id, works.work_title,
       people.person_id,
       contributors.contributor_id,
       roles.role_title,
       work_categories.work_category_desc,
       work_subcategories.work_subcategory_desc
FROM
     work_subcategories work_subcategories
     INNER JOIN works works
       ON work_subcategories.work_subcategory_id = works.work_subcategory_id
     INNER JOIN work_relationships work_relationships
       ON works.work_id = work_relationships.work_id
     INNER JOIN relationships relationships
       ON work_relationships.relationship_id = relationships.relationship_id
     INNER JOIN relationship_types relationship_types
       ON work_relationships.relationship_type_id = relationship_types.relationship_type_id
     INNER JOIN role_relationships role_relationships
       ON relationships.relationship_id = role_relationships.relationship_id
     INNER JOIN roles roles
       ON role_relationships.role_id = roles.role_id
     INNER JOIN contributors contributors
       ON contributors.role_id = roles.role_id
     INNER JOIN role_types role_types
       ON roles.role_type_id = role_types.role_type_id
     INNER JOIN people people
       ON roles.person_id = people.person_id
     INNER JOIN work_categories work_categories
       ON work_subcategories.work_category_id = work_categories.work_category_id
WHERE
     relationship_types.relationship_type_desc = 'Is composed by';

GRANT SELECT ON work_composers TO SOUNZ_REPORTS;


COMMIT;




-- view for contributor search

BEGIN;

CREATE VIEW contributor_advanced_search AS
SELECT c.contributor_id, c.status_id, c.composer_status, c.canz_member as canz,
 	   c.apra_member as apra, r.role_id, rt.role_type_id, 
	   p.person_id, p.year_of_birth, p.gender,p.deceased, o.organisation_id,
	   cis.contactinfo_id, cis.region_id
		/* for info*/
		,rt.role_type_desc,p.first_names, p.last_name,o.organisation_name
from
	contributors c
left join roles r on c.role_id = r.role_id
left join role_types rt ON rt.role_type_id=r.role_type_id
left join people p on r.person_id = p.person_id
left join organisations o on r.organisation_id = o.organisation_id
left join role_contactinfos rcis on rcis.role_id = r.role_id
left join contactinfos cis on rcis.contactinfo_id = cis.contactinfo_id
where r.organisation_id is null

UNION
SELECT c.contributor_id, c.status_id, c.composer_status, c.canz_member as canz,
 	   c.apra_member as apra, r.role_id, rt.role_type_id, 
	   p.person_id, o.year_of_establishment as year_of_birth, p.gender,p.deceased, o.organisation_id,
	   cis.contactinfo_id, cis.region_id
		/* for info*/
		,rt.role_type_desc,p.first_names, p.last_name,o.organisation_name
from
	contributors c
left join roles r on c.role_id = r.role_id
left join role_types rt ON rt.role_type_id=r.role_type_id
left join people p on r.person_id = p.person_id
left join organisations o on r.organisation_id = o.organisation_id
left join role_contactinfos rcis on rcis.role_id = r.role_id
left join contactinfos cis on rcis.contactinfo_id = cis.contactinfo_id
where r.person_id is null

;
COMMIT;





/* View for manifestation and resource searching */

/* firstly, resources */
begin;
create view resource_advanced_search as
select r.resource_id, r.status_id, rt.resource_type_id, f.format_id, r.clonable, r.available_for_loan, r.available_for_hire,
r.available_for_sale
from resources r
left join resource_types rt on rt.resource_type_id = r.resource_type_id
left join resource_type_formats rtf on rtf.resource_type_format_id = r.format_id
left join formats f on f.format_id = r.format_id
;
commit;


/* now, manifestations */
begin;
create view manifestation_advanced_search as
select m.manifestation_id, m.status_id, rt.manifestation_type_id, f.format_id, m.clonable, m.available_for_loan, m.available_for_hire,
m.available_for_sale
from manifestations m
left join manifestation_types rt on rt.manifestation_type_id = m.manifestation_type_id
left join manifestation_type_formats rtf on rtf.manifestation_type_format_id = m.format_id
left join formats f on f.format_id = m.format_id
order by manifestation_id
;
commit;



/* for events */
begin;
create view event_advanced_search as
select e.event_id, e.status_id,e.event_type_id, c.contactinfo_id, c.locality, e.event_start, e.event_finish
from events e
left join contactinfos c on c.contactinfo_id = e.contactinfo_id
order by event_id;

commit;
