-- Patch for SOUNZ database upgrade
-- 1.40.0 to 1.41.0
--
begin;

-- Restriction for /people/login_from_checkout, for a privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('people', 'login_from_checkout', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- WR67105 introducing order parameter for regions
ALTER TABLE regions ADD COLUMN region_order integer;

-- WR67110 correct some country names
update countries set country_name = 'Cocos (Keeling) Islands' where country_name = 'Cocos (keeling) Islands';
update countries set country_name = 'Cote D''Ivoire' where country_name = 'Cote D''ivoire';
update countries set country_name = 'Falkland Islands (Malvinas)' where country_name = 'Falkland Islands (malvinas)';
update countries set country_name = 'Guinea-Bissau' where country_name = 'Guinea-bissau';
update countries set country_name = 'Heard Island and McDonald Islands' where country_name = 'Heard Island and Mcdonald Islands';
update countries set country_name = 'Holy See (Vatican City State)' where country_name = 'Holy See (vatican City State)';
update countries set country_name = 'Timor-Leste' where country_name = 'Timor-leste';
update countries set country_name = 'Virgin Islands, US' where country_name = 'Virgin Islands, U.s.';

-- WR67105 - add territories of US to regions
insert into regions (country_id, region_name) values (231, 'American Samoa');
insert into regions (country_id, region_name) values (231, 'District of Columbia');
insert into regions (country_id, region_name) values (231, 'Federated States of Micronesia');
insert into regions (country_id, region_name) values (231, 'Guam');
insert into regions (country_id, region_name) values (231, 'North Marianas');
insert into regions (country_id, region_name) values (231, 'Puerto Rico');
insert into regions (country_id, region_name) values (231, 'Virgin Islands');

-- WR67105 introducing order parameter for regions

UPDATE regions set region_order = 1 where region_id = 94;
UPDATE regions set region_order = 2 where region_id = 20;
UPDATE regions set region_order = 3 where region_id = 26;
UPDATE regions set region_order = 4 where region_id = 22;
UPDATE regions set region_order = 5 where region_id = 23;
UPDATE regions set region_order = 6 where region_id = 25;
UPDATE regions set region_order = 7 where region_id = 21;
UPDATE regions set region_order = 8 where region_id = 24;
UPDATE regions set region_order = 1 where region_id = 77;
UPDATE regions set region_order = 2 where region_id = 78;
UPDATE regions set region_order = 3 where region_id = 79;
UPDATE regions set region_order = 4 where region_id = 81;
UPDATE regions set region_order = 5 where region_id = 80;
UPDATE regions set region_order = 6 where region_id = 91;
UPDATE regions set region_order = 7 where region_id = 82;
UPDATE regions set region_order = 8 where region_id = 92;
UPDATE regions set region_order = 9 where region_id = 90;
UPDATE regions set region_order = 10 where region_id = 93;
UPDATE regions set region_order = 11 where region_id = 83;
UPDATE regions set region_order = 12 where region_id = 84;
UPDATE regions set region_order = 13 where region_id = 85;
UPDATE regions set region_order = 1 where region_id = 2;
UPDATE regions set region_order = 2 where region_id = 4;
UPDATE regions set region_order = 3 where region_id = 14;
UPDATE regions set region_order = 4 where region_id = 5;
UPDATE regions set region_order = 5 where region_id = 9;
UPDATE regions set region_order = 6 where region_id = 12;
UPDATE regions set region_order = 7 where region_id = 1;
UPDATE regions set region_order = 8 where region_id = 15;
UPDATE regions set region_order = 9 where region_id = 6;
UPDATE regions set region_order = 10 where region_id = 16;
UPDATE regions set region_order = 11 where region_id = 7;
UPDATE regions set region_order = 12 where region_id = 3;
UPDATE regions set region_order = 13 where region_id = 10;
UPDATE regions set region_order = 14 where region_id = 8;
UPDATE regions set region_order = 15 where region_id = 11;
UPDATE regions set region_order = 16 where region_id = 13;
UPDATE regions set region_order = 17 where region_id = 17;
UPDATE regions set region_order = 18 where region_id = 18;
UPDATE regions set region_order = 19 where region_id = 19;
UPDATE regions set region_order = 1 where region_id = 86;
UPDATE regions set region_order = 2 where region_id = 88;
UPDATE regions set region_order = 3 where region_id = 89;
UPDATE regions set region_order = 4 where region_id = 87;
UPDATE regions set region_order = 1 where region_id = 27;
UPDATE regions set region_order = 2 where region_id = 28;
UPDATE regions set region_order = 3 where region_id = 95;
UPDATE regions set region_order = 4 where region_id = 29;
UPDATE regions set region_order = 5 where region_id = 30;
UPDATE regions set region_order = 6 where region_id = 31;
UPDATE regions set region_order = 7 where region_id = 32;
UPDATE regions set region_order = 8 where region_id = 33;
UPDATE regions set region_order = 9 where region_id = 34;
UPDATE regions set region_order = 10 where region_id = 96;
UPDATE regions set region_order = 11 where region_id = 97;
UPDATE regions set region_order = 12 where region_id = 35;
UPDATE regions set region_order = 13 where region_id = 36;
UPDATE regions set region_order = 14 where region_id = 98;
UPDATE regions set region_order = 15 where region_id = 37;
UPDATE regions set region_order = 16 where region_id = 38;
UPDATE regions set region_order = 17 where region_id = 39;
UPDATE regions set region_order = 18 where region_id = 40;
UPDATE regions set region_order = 19 where region_id = 41;
UPDATE regions set region_order = 20 where region_id = 42;
UPDATE regions set region_order = 21 where region_id = 43;
UPDATE regions set region_order = 22 where region_id = 44;
UPDATE regions set region_order = 23 where region_id = 45;
UPDATE regions set region_order = 24 where region_id = 46;
UPDATE regions set region_order = 25 where region_id = 47;
UPDATE regions set region_order = 26 where region_id = 48;
UPDATE regions set region_order = 27 where region_id = 49;
UPDATE regions set region_order = 28 where region_id = 50;
UPDATE regions set region_order = 29 where region_id = 51;
UPDATE regions set region_order = 30 where region_id = 52;
UPDATE regions set region_order = 31 where region_id = 53;
UPDATE regions set region_order = 32 where region_id = 54;
UPDATE regions set region_order = 33 where region_id = 55;
UPDATE regions set region_order = 34 where region_id = 56;
UPDATE regions set region_order = 35 where region_id = 57;
UPDATE regions set region_order = 36 where region_id = 58;
UPDATE regions set region_order = 37 where region_id = 59;
UPDATE regions set region_order = 38 where region_id = 60;
UPDATE regions set region_order = 39 where region_id = 99;
UPDATE regions set region_order = 40 where region_id = 61;
UPDATE regions set region_order = 41 where region_id = 62;
UPDATE regions set region_order = 42 where region_id = 63;
UPDATE regions set region_order = 43 where region_id = 64;
UPDATE regions set region_order = 44 where region_id = 100;
UPDATE regions set region_order = 45 where region_id = 65;
UPDATE regions set region_order = 46 where region_id = 66;
UPDATE regions set region_order = 47 where region_id = 67;
UPDATE regions set region_order = 48 where region_id = 68;
UPDATE regions set region_order = 49 where region_id = 69;
UPDATE regions set region_order = 50 where region_id = 70;
UPDATE regions set region_order = 51 where region_id = 71;
UPDATE regions set region_order = 52 where region_id = 101;
UPDATE regions set region_order = 53 where region_id = 72;
UPDATE regions set region_order = 54 where region_id = 73;
UPDATE regions set region_order = 55 where region_id = 74;
UPDATE regions set region_order = 56 where region_id = 75;
UPDATE regions set region_order = 57 where region_id = 76;

commit;
