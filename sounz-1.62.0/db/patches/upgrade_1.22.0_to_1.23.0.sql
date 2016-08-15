-- Patch for SOUNZ database upgrade
-- 1.22.0 to 1.23.0
--

BEGIN;

-- WR#54985 - Do not use stock check processing
UPDATE zencartconfiguration SET configuration_value = 'false' WHERE configuration_key='STOCK_CHECK';


-- WR#54904 - adding support for DPS Payment Express Fail Proof Result Notification
-- psql version of the db changes required for a zencart module:
-- http://www.zen-cart.com/index.php?main_page=product_contrib_info&cPath=40_48&products_id=937
CREATE SEQUENCE zencartdps_pxpay_id_seq;
CREATE TABLE zencartdps_pxpay (
  dps_pxpay_id integer DEFAULT nextval('zencartdps_pxpay_id_seq'::regclass) NOT NULL,

  txn_id varchar(16) NOT NULL,
  txn_type varchar(16) NOT NULL,
  merchant_ref varchar(64) NOT NULL default '',
  total_amount numeric(14,2) NOT NULL default 0,
  order_id integer, -- NOT NULL default '0',
  success smallint DEFAULT (0)::smallint NOT NULL,
  response_text varchar(32) NOT NULL default '',
  auth_code varchar(22) NOT NULL default '',
  txn_ref varchar(16) NOT NULL default ''
);

ALTER TABLE public.zencartdps_pxpay OWNER TO sounz;

ALTER TABLE ONLY zencartdps_pxpay
    ADD CONSTRAINT zencartdps_pxpay_pkey PRIMARY KEY (dps_pxpay_id);

ALTER TABLE ONLY zencartdps_pxpay
    ADD CONSTRAINT fk_zencartdps_pxpay FOREIGN KEY (order_id) REFERENCES zencartorders (orders_id) ON DELETE CASCADE;

INSERT INTO settings (setting_name, setting_value) VALUES ('FailedOrdersNotificationRecipient', 'admin@sounz.org.nz');

-- replace ExpiringMembershipFailureRecipient by ErrorRecipient which is more appropriate name as it is used in several places now
DELETE FROM settings WHERE setting_name = 'ExpiringMembershipFailureRecipient';

INSERT INTO settings (setting_name, setting_value) VALUES ('ErrorRecipient', 'liuba@catalyst.net.nz,gordon@catalyst.net.nz,paul@catalyst.net.nz');

-- Restriction for /failed_orders_controller/ALL, for a privilege CAN_EDIT_SALES_HISTORY
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('failed_orders_controller', 'ALL', 'get',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_SALES_HISTORY')
);

-- Restriction for /failed_orders_controller/ALL, for a privilege CAN_EDIT_SALES_HISTORY
insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values
('failed_orders_controller', 'ALL', 'post',
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_SALES_HISTORY')
);

COMMIT;
