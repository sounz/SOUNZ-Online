/*This fixes a bug in data migration where the NZ national region is incorrectly assigned ot other countries
- this results a contactinfo  object belong to 2 countries, less than ideal for faceting
*/
begin;
update contactinfos set region_id = null  where contactinfo_id in (select contactinfo_id from contactinfos where
	 region_id = 19 and country_id != 158 order  by contactinfo_id);
commit;