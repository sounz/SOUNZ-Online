-- Patch for SOUNZ database upgrade
-- 1.0.0 to 1.0.1
--

-- FIX WORK DURATION
-- Batch convert all works with a zero duration to have nil duration, and
-- set no duration flag to true
begin;
update works set intended_duration = null, no_duration = true where
intended_duration = '00:00:00';
commit;

-- REMOVING A CATEGORY FROM VOCAL SOLO
-- Vocal Solo fix for spoken word with accompanying instruments
begin;
 delete from work_subcategories where work_category_id = (select
work_category_id from work_categories where work_category_desc = 'Vocal
Solo') and work_subcategory_desc = 'Spoken Word with accompanying
instruments';
commit;

-- COUNTRIES
-- Update regions, as per 42579
begin;
-- Insertion for Australia / :New South Wales
insert into regions(region_name, country_id) values ('New South Wales',
(select country_id from countries where country_name = 'Australia')
);
-- Insertion for Australia / :Victoria
insert into regions(region_name, country_id) values ('Victoria',
(select country_id from countries where country_name = 'Australia')
);
-- Insertion for Australia / :Queensland
insert into regions(region_name, country_id) values ('Queensland',
(select country_id from countries where country_name = 'Australia')
);
-- Insertion for Australia / :South Australia
insert into regions(region_name, country_id) values ('South Australia',
(select country_id from countries where country_name = 'Australia')
);
-- Insertion for Australia / :Western Australia
insert into regions(region_name, country_id) values ('Western Australia',
(select country_id from countries where country_name = 'Australia')
);
-- Insertion for Australia / :Tasmania
insert into regions(region_name, country_id) values ('Tasmania',
(select country_id from countries where country_name = 'Australia')
);
-- Insertion for Australia / :Northern Territory
insert into regions(region_name, country_id) values ('Northern Territory',
(select country_id from countries where country_name = 'Australia')
);
-- Insertion for United States / :Alabama
insert into regions(region_name, country_id) values ('Alabama',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Alaska
insert into regions(region_name, country_id) values ('Alaska',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Arizona
insert into regions(region_name, country_id) values ('Arizona',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Arkansas
insert into regions(region_name, country_id) values ('Arkansas',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :California
insert into regions(region_name, country_id) values ('California',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Colorado
insert into regions(region_name, country_id) values ('Colorado',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Connecticut
insert into regions(region_name, country_id) values ('Connecticut',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Delaware
insert into regions(region_name, country_id) values ('Delaware',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Florida
insert into regions(region_name, country_id) values ('Florida',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Georgia
insert into regions(region_name, country_id) values ('Georgia',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Hawaii
insert into regions(region_name, country_id) values ('Hawaii',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Idaho
insert into regions(region_name, country_id) values ('Idaho',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Illinois
insert into regions(region_name, country_id) values ('Illinois',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Indiana
insert into regions(region_name, country_id) values ('Indiana',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Iowa
insert into regions(region_name, country_id) values ('Iowa',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Kansas
insert into regions(region_name, country_id) values ('Kansas',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Kentucky
insert into regions(region_name, country_id) values ('Kentucky',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Louisiana
insert into regions(region_name, country_id) values ('Louisiana',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Maine
insert into regions(region_name, country_id) values ('Maine',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Maryland
insert into regions(region_name, country_id) values ('Maryland',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Massachusetts
insert into regions(region_name, country_id) values ('Massachusetts',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Michigan
insert into regions(region_name, country_id) values ('Michigan',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Minnesota
insert into regions(region_name, country_id) values ('Minnesota',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Mississippi
insert into regions(region_name, country_id) values ('Mississippi',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Missouri
insert into regions(region_name, country_id) values ('Missouri',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Montana
insert into regions(region_name, country_id) values ('Montana',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Nebraska
insert into regions(region_name, country_id) values ('Nebraska',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Nevada
insert into regions(region_name, country_id) values ('Nevada',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :New Hampshire
insert into regions(region_name, country_id) values ('New Hampshire',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :New Jersey
insert into regions(region_name, country_id) values ('New Jersey',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :New Mexico
insert into regions(region_name, country_id) values ('New Mexico',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :New York
insert into regions(region_name, country_id) values ('New York',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :North Carolina
insert into regions(region_name, country_id) values ('North Carolina',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :North Dakota
insert into regions(region_name, country_id) values ('North Dakota',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Ohio
insert into regions(region_name, country_id) values ('Ohio',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Oklahoma
insert into regions(region_name, country_id) values ('Oklahoma',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Oregon
insert into regions(region_name, country_id) values ('Oregon',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Pennsylvania
insert into regions(region_name, country_id) values ('Pennsylvania',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Rhode Island
insert into regions(region_name, country_id) values ('Rhode Island',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :South Carolina
insert into regions(region_name, country_id) values ('South Carolina',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :South Dakota
insert into regions(region_name, country_id) values ('South Dakota',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Tennessee
insert into regions(region_name, country_id) values ('Tennessee',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Texas
insert into regions(region_name, country_id) values ('Texas',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Utah
insert into regions(region_name, country_id) values ('Utah',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Vermont
insert into regions(region_name, country_id) values ('Vermont',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Virginia
insert into regions(region_name, country_id) values ('Virginia',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Washington
insert into regions(region_name, country_id) values ('Washington',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :West Virginia
insert into regions(region_name, country_id) values ('West Virginia',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Wisconsin
insert into regions(region_name, country_id) values ('Wisconsin',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for United States / :Wyoming
insert into regions(region_name, country_id) values ('Wyoming',
(select country_id from countries where country_name = 'United States')
);
-- Insertion for Canada / :Alberta
insert into regions(region_name, country_id) values ('Alberta',
(select country_id from countries where country_name = 'Canada')
);
-- Insertion for Canada / :British Columbia
insert into regions(region_name, country_id) values ('British Columbia',
(select country_id from countries where country_name = 'Canada')
);
-- Insertion for Canada / :Manitoba
insert into regions(region_name, country_id) values ('Manitoba',
(select country_id from countries where country_name = 'Canada')
);
-- Insertion for Canada / :Newfoundland
insert into regions(region_name, country_id) values ('Newfoundland',
(select country_id from countries where country_name = 'Canada')
);
-- Insertion for Canada / :New Brunswick
insert into regions(region_name, country_id) values ('New Brunswick',
(select country_id from countries where country_name = 'Canada')
);
-- Insertion for Canada / :Nova Scotia
insert into regions(region_name, country_id) values ('Nova Scotia',
(select country_id from countries where country_name = 'Canada')
);
-- Insertion for Canada / :Quebec
insert into regions(region_name, country_id) values ('Quebec',
(select country_id from countries where country_name = 'Canada')
);
-- Insertion for Canada / :Saskatchewan
insert into regions(region_name, country_id) values ('Saskatchewan',
(select country_id from countries where country_name = 'Canada')
);
-- Insertion for Canada / :Yukon
insert into regions(region_name, country_id) values ('Yukon',
(select country_id from countries where country_name = 'Canada')
);
-- Insertion for United Kingdom / :England
insert into regions(region_name, country_id) values ('England',
(select country_id from countries where country_name = 'United Kingdom')
);
-- Insertion for United Kingdom / :Wales
insert into regions(region_name, country_id) values ('Wales',
(select country_id from countries where country_name = 'United Kingdom')
);
-- Insertion for United Kingdom / :Northern Ireland
insert into regions(region_name, country_id) values ('Northern Ireland',
(select country_id from countries where country_name = 'United Kingdom')
);
-- Insertion for United Kingdom / :Scotland
insert into regions(region_name, country_id) values ('Scotland',
(select country_id from countries where country_name = 'United Kingdom')
);

commit;


-- Not Applicable manifestation type
-- Changed part recorded to a score and non applicable to a recording
begin;
update manifestation_types set manifestation_type_category = 1 where
 manifestation_type_desc = 'part - recorded';

update manifestation_types set manifestation_type_category = 2 where
 manifestation_type_desc = 'Not-applicable';

commit;


