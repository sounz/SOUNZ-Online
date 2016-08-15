-- Patch for SOUNZ database upgrade
-- 1.57.8 to 1.57.9
--
BEGIN;

-- WR98831 updating shipping costs

UPDATE zencartconfiguration SET configuration_value = '0,0,20,4.00,200,3.50,750,6.50,1500,7.00,1750,10.00,2000,10.00' where configuration_id = 593;

UPDATE zencartconfiguration SET configuration_value = '0,0,20,6.00,750,8.00,1500,13.00,1750,17.00,2000,17.00' where configuration_id = 601;

UPDATE zencartconfiguration SET configuration_value = '0,0,20,8.00,200,8.50,300,10.00,400,11.00,500,12.00,750,14.50,1000,15.50,1250,18.00,1500,20.50,1750,23.00,2000,25.50' where configuration_id = 615;

UPDATE zencartconfiguration SET configuration_value = '0,0,200,12.50,300,14.50,400,16.50,500,18.50,750,23.00,1000,24.50,1250,28.00,1500,32.50,1750,36.50,2000,41.00' where configuration_id = 618;

UPDATE zencartconfiguration SET configuration_value = '0,0,200,14.50,300,17.00,400,19.50,500,22.00,750,28.00,1000,30.00,1250,35.50,1500,41.50,1750,47.00,2000,52.50' where configuration_id = 621;

UPDATE zencartconfiguration SET configuration_value = '0,0,200,16.50,300,19.50,400,22.50,500,25.50,750,32.00,1000,36.50,1250,44.00,1500,50.00,1750,57.00,2000,64.00' where configuration_id = 624;

UPDATE zencartconfiguration SET configuration_value = '0,0,200,16.50,300,19.50,400,22.50,500,25.50,750,32.00,1000,36.50,1250,44.00,1500,50.00,1750,57.00,2000,64.00' where configuration_id = 627;

-- Set SHIPPING_MAX_WEIGHT only for freight codes > 2000 
UPDATE zencartconfiguration SET configuration_value = 2001 where configuration_id = 204;

COMMIT;
