--
-- Generated from mysql2pgsql.perl
-- http://gborg.postgresql.org/project/mysql2psql/
-- (c) 2001 - 2007 Jose M. Duarte, Joseph Speigle
--

-- warnings are printed for  --DROP tables if they do not exist
-- please see http://archives.postgresql.org/pgsql-novice/2004-10/msg00158.php

-- ##############################################################




--
-- * Main Zen Cart SQL Load for MySQL databases
-- * @package Installer
-- * @access private
-- * @copyright Copyright 2003-2007 Zen Cart Development Team
-- * @copyright Portions Copyright 2003 osCommerce
-- * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
-- * @version $Id: mysql_zencart.sql 6538 2007-06-26 03:11:09Z drbyte $
--
--########### IMPORTANT INSTRUCTIONS ###############
--
-- * Zen Cart uses the zc_install/index.php program to do installations
-- * This SQL script is intended to be used by running zc_install 
-- * It is *not* recommended to simply run these statements manually via any other means
-- * ie: not via phpMyAdmin or other SQL front-end tools
-- * The zc_install program catches possible problems/exceptions
-- * and also handles table-prefixes automatically, based on selections made during installation
--
--####################################################
-- --------------------------------------------------------
--
-- Table structure for table upgrade_exceptions
-- (Placed at top so any exceptions during installation can be trapped as well)
--
-- --DROP TABLE IF EXISTS upgrade_exceptions CASCADE;
-- --DROP SEQUENCE IF EXISTS upgrade_exceptions_upgrade_exception_id_seq CASCADE ;

CREATE SEQUENCE upgrade_exceptions_upgrade_exception_id_seq ;

CREATE TABLE upgrade_exceptions (
  upgrade_exception_id integer DEFAULT nextval('upgrade_exceptions_upgrade_exception_id_seq') NOT NULL,
  sql_file  varchar(50) default NULL,
 
  reason  varchar(200) default NULL,
 
  errordate  timestamp without time zone default '0001-01-01 00:00:00',
 
  sqlstatement  text,
 
  primary key (upgrade_exception_id)
) ;



-- --------------------------------------------------------
--
-- Table structure for table address_book
--
 --DROP TABLE address_book CASCADE
 --DROP SEQUENCE address_book_address_book_id_seq CASCADE ;

CREATE SEQUENCE address_book_address_book_id_seq ;

CREATE TABLE address_book (
  address_book_id integer DEFAULT nextval('address_book_address_book_id_seq') NOT NULL,
  customers_id  int NOT NULL default '0',
 
  entry_gender  char(1) NOT NULL default '',
 
  entry_company  varchar(32) default NULL,
 
  entry_firstname  varchar(32) NOT NULL default '',
 
  entry_lastname  varchar(32) NOT NULL default '',
 
  entry_street_address  varchar(64) NOT NULL default '',
 
  entry_suburb  varchar(32) default NULL,
 
  entry_postcode  varchar(10) NOT NULL default '',
 
  entry_city  varchar(32) NOT NULL default '',
 
  entry_state  varchar(32) default NULL,
 
  entry_country_id  int NOT NULL default '0',
 
  entry_zone_id  int NOT NULL default '0',
 
  primary key (address_book_id)
) ;



CREATE INDEX address_book_customers_id_idx ON address_book USING btree (customers_id);
-- --------------------------------------------------------
--
-- Table structure for table 'address_format'
--
 --DROP TABLE address_format CASCADE
 --DROP SEQUENCE address_format_address_format_id_seq CASCADE ;

CREATE SEQUENCE address_format_address_format_id_seq ;

CREATE TABLE address_format (
  address_format_id integer DEFAULT nextval('address_format_address_format_id_seq') NOT NULL,
  address_format  varchar(128) NOT NULL default '',
 
  address_summary  varchar(48) NOT NULL default '',
 
  primary key (address_format_id)
) ;



-- --------------------------------------------------------
--
-- Table structure for table 'admin'
--
 --DROP TABLE admin CASCADE\g
 --DROP SEQUENCE admin_admin_id_seq CASCADE ;

CREATE SEQUENCE admin_admin_id_seq ;

CREATE TABLE admin (
  admin_id integer DEFAULT nextval('admin_admin_id_seq') NOT NULL,
  admin_name  varchar(32) NOT NULL default '',
 
  admin_email  varchar(96) NOT NULL default '',
 
  admin_pass  varchar(40) NOT NULL default '',
 
  admin_level  smallint NOT NULL default '1',
 
  primary key (admin_id)
) ;



CREATE INDEX admin_admin_name_idx ON admin USING btree (admin_name);
CREATE INDEX admin_admin_email_idx ON admin USING btree (admin_email);
-- --------------------------------------------------------
--
-- Table structure for table 'admin_activity_log'
--
 --DROP TABLE admin_activity_log CASCADE\g
 --DROP SEQUENCE admin_activity_log_log_id_seq CASCADE ;

CREATE SEQUENCE admin_activity_log_log_id_seq ;

CREATE TABLE admin_activity_log (
  log_id integer DEFAULT nextval('admin_activity_log_log_id_seq') NOT NULL,
  access_date  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  admin_id  int NOT NULL default '0',
 
  page_accessed  varchar(80) NOT NULL default '',
 
  page_parameters  text,
 
  ip_address  varchar(15) NOT NULL default '',
 
  primary key (log_id)
) ;



CREATE INDEX admin_activity_log_page_accessed_idx ON admin_activity_log USING btree (page_accessed);
CREATE INDEX admin_activity_log_access_date_idx ON admin_activity_log USING btree (access_date);
CREATE INDEX admin_activity_log_ip_address_idx ON admin_activity_log USING btree (ip_address);
-- --------------------------------------------------------
--
-- Table structure for table 'authorizenet'
--
 --DROP TABLE authorizenet CASCADE\g
 --DROP SEQUENCE authorizenet_id_seq CASCADE ;

CREATE SEQUENCE authorizenet_id_seq ;

CREATE TABLE authorizenet (
  id integer DEFAULT nextval('authorizenet_id_seq') NOT NULL,
  customer_id  int NOT NULL default '0',
 
  order_id  int NOT NULL default '0',
 
  response_code  int NOT NULL default '0',
 
  response_text  varchar(255) NOT NULL default '',
 
  authorization_type  text NOT NULL,
 
  transaction_id  int NOT NULL default '0',
 
  sent  text NOT NULL,
 
  received  text NOT NULL,
 
  time  varchar(50) NOT NULL default '',
 
  session_id  varchar(255) NOT NULL default '',
 
  primary key (id)
) ;



-- --------------------------------------------------------
--
-- Table structure for table 'banners'
--
 --DROP TABLE banners CASCADE\g
 --DROP SEQUENCE banners_banners_id_seq CASCADE ;

CREATE SEQUENCE banners_banners_id_seq ;

CREATE TABLE banners (
  banners_id integer DEFAULT nextval('banners_banners_id_seq') NOT NULL,
  banners_title  varchar(64) NOT NULL default '',
 
  banners_url  varchar(255) NOT NULL default '',
 
  banners_image  varchar(64) NOT NULL default '',
 
  banners_group  varchar(15) NOT NULL default '',
 
  banners_html_text  text,
 
  expires_impressions  int default '0',
 
  expires_date  timestamp without time zone default NULL,
 
  date_scheduled  timestamp without time zone default NULL,
 
  date_added  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  date_status_change  timestamp without time zone default NULL,
 
  status  int NOT NULL default '1',
 
  banners_open_new_windows  int NOT NULL default '1',
 
  banners_on_ssl  int NOT NULL default '1',
 
  banners_sort_order  int NOT NULL default '0',
 
  primary key (banners_id)
) ;




CREATE INDEX banners_1_idx ON banners USING btree (status, banners_group);
CREATE INDEX banners_expires_date_idx ON banners USING btree (expires_date);
CREATE INDEX banners_date_scheduled_idx ON banners USING btree (date_scheduled);
-- --------------------------------------------------------
--
-- Table structure for table 'banners_history'
--
 --DROP TABLE banners_history CASCADE\g
 --DROP SEQUENCE banners_history_banners_history_id_seq CASCADE ;

CREATE SEQUENCE banners_history_banners_history_id_seq ;

CREATE TABLE banners_history (
  banners_history_id integer DEFAULT nextval('banners_history_banners_history_id_seq') NOT NULL,
  banners_id  int NOT NULL default '0',
 
  banners_shown  int NOT NULL default '0',
 
  banners_clicked  int NOT NULL default '0',
 
  banners_history_date  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  primary key (banners_history_id)
) ;



CREATE INDEX banners_history_banners_id_idx ON banners_history USING btree (banners_id);
-- --------------------------------------------------------
--
-- Table structure for table 'categories'
--
 --DROP TABLE categories CASCADE\g
 --DROP SEQUENCE categories_categories_id_seq CASCADE ;

CREATE SEQUENCE categories_categories_id_seq ;

CREATE TABLE categories (
  categories_id integer DEFAULT nextval('categories_categories_id_seq') NOT NULL,
  categories_image  varchar(64) default NULL,
 
  parent_id  int NOT NULL default '0',
 
  sort_order  int default NULL,
 
  date_added  timestamp without time zone default NULL,
 
  last_modified  timestamp without time zone default NULL,
 
  categories_status  smallint NOT NULL default '1',
 
  primary key (categories_id)
) ;



CREATE INDEX categories_1_idx ON categories USING btree (parent_id, categories_id);
CREATE INDEX categories_categories_status_idx ON categories USING btree (categories_status);
CREATE INDEX categories_sort_order_idx ON categories USING btree (sort_order);
-- --------------------------------------------------------
--
-- Table structure for table 'categories_description'
--
 --DROP TABLE categories_description CASCADE\g
CREATE TABLE categories_description (
  categories_id  int NOT NULL default '0',
 
  language_id  int NOT NULL default '1',
 
  categories_name  varchar(32) NOT NULL default '',
 
  categories_description  text NOT NULL,
 
  primary key (categories_id, language_id)
) ;



CREATE INDEX categories_description_categories_name_idx ON categories_description USING btree (categories_name);
-- --------------------------------------------------------
--
-- Table structure for table 'configuration'
--
 --DROP TABLE configuration CASCADE\g
 --DROP SEQUENCE configuration_configuration_id_seq CASCADE ;

CREATE SEQUENCE configuration_configuration_id_seq ;

CREATE TABLE configuration (
  configuration_id integer DEFAULT nextval('configuration_configuration_id_seq') NOT NULL,
  configuration_title  text NOT NULL,
 
  configuration_key  varchar(255) NOT NULL default '',
 
  configuration_value  text NOT NULL,
 
  configuration_description  text NOT NULL,
 
  configuration_group_id  int NOT NULL default '0',
 
  sort_order  int default NULL,
 
  last_modified  timestamp without time zone default NULL,
 
  date_added  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  use_function  text default NULL,
 
  set_function  text default NULL,
 
  primary key (configuration_id),
 unique (configuration_key) 
) ;



CREATE INDEX configuration_1_idx ON configuration USING btree (configuration_key, configuration_value);
CREATE INDEX configuration_configuration_group_id_idx ON configuration USING btree (configuration_group_id);
-- --------------------------------------------------------
--
-- Table structure for table 'configuration_group'
--
 --DROP TABLE configuration_group CASCADE\g
 --DROP SEQUENCE configuration_group_configuration_group_id_seq CASCADE ;

CREATE SEQUENCE configuration_group_configuration_group_id_seq ;

CREATE TABLE configuration_group (
  configuration_group_id integer DEFAULT nextval('configuration_group_configuration_group_id_seq') NOT NULL,
  configuration_group_title  varchar(64) NOT NULL default '',
 
  configuration_group_description  varchar(255) NOT NULL default '',
 
  sort_order  int default NULL,
 
  visible  int default '1',
 
  primary key (configuration_group_id)
) ;



CREATE INDEX configuration_group_visible_idx ON configuration_group USING btree (visible);
-- --------------------------------------------------------
--
-- Table structure for table 'counter'
--
 --DROP TABLE counter CASCADE\g
CREATE TABLE counter (
  startdate  char(8) default NULL,
 
  counter  int default NULL
 
) ;



-- --------------------------------------------------------
--
-- Table structure for table 'counter_history'
--
 --DROP TABLE counter_history CASCADE\g
CREATE TABLE counter_history (
  startdate  char(8) default NULL,
 
  counter  int default NULL,
 
  session_counter  int default NULL
 
) ;



-- --------------------------------------------------------
--
-- Table structure for table 'countries'
--
 --DROP TABLE countries CASCADE\g
 --DROP SEQUENCE countries_countries_id_seq CASCADE ;

CREATE SEQUENCE countries_countries_id_seq ;

CREATE TABLE countries (
  countries_id integer DEFAULT nextval('countries_countries_id_seq') NOT NULL,
  countries_name  varchar(64) NOT NULL default '',
 
  countries_iso_code_2  char(2) NOT NULL default '',
 
  countries_iso_code_3  char(3) NOT NULL default '',
 
  address_format_id  int NOT NULL default '0',
 
  primary key (countries_id)
) ;



CREATE INDEX countries_countries_name_idx ON countries USING btree (countries_name);
CREATE INDEX countries_address_format_id_idx ON countries USING btree (address_format_id);
CREATE INDEX countries_countries_iso_code_2_idx ON countries USING btree (countries_iso_code_2);
CREATE INDEX countries_countries_iso_code_3_idx ON countries USING btree (countries_iso_code_3);
-- --------------------------------------------------------
--
-- Table structure for table 'coupon_email_track'
--
 --DROP TABLE coupon_email_track CASCADE\g
 --DROP SEQUENCE coupon_email_track_unique_id_seq CASCADE ;

CREATE SEQUENCE coupon_email_track_unique_id_seq ;

CREATE TABLE coupon_email_track (
  unique_id integer DEFAULT nextval('coupon_email_track_unique_id_seq') NOT NULL,
  coupon_id  int NOT NULL default '0',
 
  customer_id_sent  int NOT NULL default '0',
 
  sent_firstname  varchar(32) default NULL,
 
  sent_lastname  varchar(32) default NULL,
 
  emailed_to  varchar(32) default NULL,
 
  date_sent  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  primary key (unique_id)
) ;



CREATE INDEX coupon_email_track_coupon_id_idx ON coupon_email_track USING btree (coupon_id);
-- --------------------------------------------------------
--
-- Table structure for table 'coupon_gv_customer'
--
 --DROP TABLE coupon_gv_customer CASCADE\g
CREATE TABLE coupon_gv_customer (
  customer_id  int NOT NULL default '0',
 
  amount  decimal(15,4) NOT NULL default '0.0000',
 
  primary key (customer_id)
) ;



-- --------------------------------------------------------
--
-- Table structure for table 'coupon_gv_queue'
--
 --DROP TABLE coupon_gv_queue CASCADE\g
 --DROP SEQUENCE coupon_gv_queue_unique_id_seq CASCADE ;

CREATE SEQUENCE coupon_gv_queue_unique_id_seq ;

CREATE TABLE coupon_gv_queue (
  unique_id integer DEFAULT nextval('coupon_gv_queue_unique_id_seq') NOT NULL,
  customer_id  int NOT NULL default '0',
 
  order_id  int NOT NULL default '0',
 
  amount  decimal(15,4) NOT NULL default '0.0000',
 
  date_created  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  ipaddr  varchar(32) NOT NULL default '',
 
  release_flag  char(1) NOT NULL default 'N',
 
  primary key (unique_id)
) ;



CREATE INDEX coupon_gv_queue_1_idx ON coupon_gv_queue USING btree (customer_id, order_id);
CREATE INDEX coupon_gv_queue_release_flag_idx ON coupon_gv_queue USING btree (release_flag);
-- --------------------------------------------------------
--
-- Table structure for table 'coupon_redeem_track'
--
 --DROP TABLE coupon_redeem_track CASCADE\g
 --DROP SEQUENCE coupon_redeem_track_unique_id_seq CASCADE ;

CREATE SEQUENCE coupon_redeem_track_unique_id_seq ;

CREATE TABLE coupon_redeem_track (
  unique_id integer DEFAULT nextval('coupon_redeem_track_unique_id_seq') NOT NULL,
  coupon_id  int NOT NULL default '0',
 
  customer_id  int NOT NULL default '0',
 
  redeem_date  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  redeem_ip  varchar(32) NOT NULL default '',
 
  order_id  int NOT NULL default '0',
 
  primary key (unique_id)
) ;



CREATE INDEX coupon_redeem_track_coupon_id_idx ON coupon_redeem_track USING btree (coupon_id);
-- --------------------------------------------------------
--
-- Table structure for table 'coupon_restrict'
--
 --DROP TABLE coupon_restrict CASCADE\g
 --DROP SEQUENCE coupon_restrict_restrict_id_seq CASCADE ;

CREATE SEQUENCE coupon_restrict_restrict_id_seq ;

CREATE TABLE coupon_restrict (
  restrict_id integer DEFAULT nextval('coupon_restrict_restrict_id_seq') NOT NULL,
  coupon_id  int NOT NULL default '0',
 
  product_id  int NOT NULL default '0',
 
  category_id  int NOT NULL default '0',
 
  coupon_restrict  char(1) NOT NULL default 'N',
 
  primary key (restrict_id)
) ;



CREATE INDEX coupon_restrict_1_idx ON coupon_restrict USING btree (coupon_id, product_id);
-- --------------------------------------------------------
--
-- Table structure for table 'coupons'
--
 --DROP TABLE coupons CASCADE\g
 --DROP SEQUENCE coupons_coupon_id_seq CASCADE ;

CREATE SEQUENCE coupons_coupon_id_seq ;

CREATE TABLE coupons (
  coupon_id integer DEFAULT nextval('coupons_coupon_id_seq') NOT NULL,
  coupon_type  char(1) NOT NULL default 'F',
 
  coupon_code  varchar(32) NOT NULL default '',
 
  coupon_amount  decimal(15,4) NOT NULL default '0.0000',
 
  coupon_minimum_order  decimal(15,4) NOT NULL default '0.0000',
 
  coupon_start_date  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  coupon_expire_date  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  uses_per_coupon  int NOT NULL default '1',
 
  uses_per_user  int NOT NULL default '0',
 
  restrict_to_products  varchar(255) default NULL,
 
  restrict_to_categories  varchar(255) default NULL,
 
  restrict_to_customers  text,
 
  coupon_active  char(1) NOT NULL default 'Y',
 
  date_created  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  date_modified  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  coupon_zone_restriction  int NOT NULL default '0',
 
  primary key (coupon_id)
) ;



CREATE INDEX coupons_1_idx ON coupons USING btree (coupon_active, coupon_type);
CREATE INDEX coupons_coupon_code_idx ON coupons USING btree (coupon_code);
CREATE INDEX coupons_coupon_type_idx ON coupons USING btree (coupon_type);
-- --------------------------------------------------------
--
-- Table structure for table 'coupons_description'
--
 --DROP TABLE coupons_description CASCADE\g
CREATE TABLE coupons_description (
  coupon_id  int NOT NULL default '0',
 
  language_id  int NOT NULL default '0',
 
  coupon_name  varchar(32) NOT NULL default '',
 
  coupon_description  text,
 
  primary key (coupon_id, language_id)
) ;



-- --------------------------------------------------------
--
-- Table structure for table 'currencies'
--
 --DROP TABLE currencies CASCADE\g
 --DROP SEQUENCE currencies_currencies_id_seq CASCADE ;

CREATE SEQUENCE currencies_currencies_id_seq ;

CREATE TABLE currencies (
  currencies_id integer DEFAULT nextval('currencies_currencies_id_seq') NOT NULL,
  title  varchar(32) NOT NULL default '',
 
  code  char(3) NOT NULL default '',
 
  symbol_left  varchar(24) default NULL,
 
  symbol_right  varchar(24) default NULL,
 
  decimal_point  char(1) default NULL,
 
  thousands_point  char(1) default NULL,
 
  decimal_places  char(1) default NULL,
 
  value float default NULL,
 
  last_updated  timestamp without time zone default NULL,
 
  primary key (currencies_id)
) ;



-- --------------------------------------------------------
--
-- Table structure for table 'customers'
--
 --DROP TABLE customers CASCADE\g
 --DROP SEQUENCE customers_customers_id_seq CASCADE ;

CREATE SEQUENCE customers_customers_id_seq ;

CREATE TABLE customers (
  customers_id integer DEFAULT nextval('customers_customers_id_seq') NOT NULL,
  customers_gender  char(1) NOT NULL default '',
 
  customers_firstname  varchar(32) NOT NULL default '',
 
  customers_lastname  varchar(32) NOT NULL default '',
 
  customers_dob  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  customers_email_address  varchar(96) NOT NULL default '',
 
  customers_nick  varchar(96) NOT NULL default '',
 
  customers_default_address_id  int NOT NULL default '0',
 
  customers_telephone  varchar(32) NOT NULL default '',
 
  customers_fax  varchar(32) default NULL,
 
  customers_password  varchar(40) NOT NULL default '',
 
  customers_newsletter  char(1) default NULL,
 
  customers_group_pricing  int NOT NULL default '0',
 
  customers_email_format  varchar(4) NOT NULL default 'TEXT',
 
  customers_authorization  int NOT NULL default '0',
 
  customers_referral  varchar(32) NOT NULL default '',
 
  customers_paypal_payerid  VARCHAR(20) NOT NULL default '',
 
  customers_paypal_ec  smallint DEFAULT 0 NOT NULL,
 
  primary key (customers_id)
) ;



CREATE INDEX customers_customers_email_address_idx ON customers USING btree (customers_email_address);
CREATE INDEX customers_customers_referral_idx ON customers USING btree (customers_referral);
CREATE INDEX customers_customers_group_pricing_idx ON customers USING btree (customers_group_pricing);
CREATE INDEX customers_customers_nick_idx ON customers USING btree (customers_nick);
CREATE INDEX customers_customers_newsletter_idx ON customers USING btree (customers_newsletter);
-- --------------------------------------------------------
--
-- Table structure for table 'customers_basket'
--
 --DROP TABLE customers_basket CASCADE\g
 --DROP SEQUENCE customers_basket_customers_basket_id_seq CASCADE ;

CREATE SEQUENCE customers_basket_customers_basket_id_seq ;

CREATE TABLE customers_basket (
  customers_basket_id integer DEFAULT nextval('customers_basket_customers_basket_id_seq') NOT NULL,
  customers_id  int NOT NULL default '0',
 
  products_id  text NOT NULL,
 
  customers_basket_quantity  float NOT NULL default '0',
 
  final_price  decimal(15,4) NOT NULL default '0.0000',
 
  customers_basket_date_added  varchar(8) default NULL,
 
  primary key (customers_basket_id)
) ;



CREATE INDEX customers_basket_customers_id_idx ON customers_basket USING btree (customers_id);
-- --------------------------------------------------------
--
-- Table structure for table 'customers_basket_attributes'
--
 --DROP TABLE customers_basket_attributes CASCADE\g
 --DROP SEQUENCE customers_basket_attributes_customers_basket_attributes_id_seq CASCADE ;

CREATE SEQUENCE customers_basket_attributes_customers_basket_attributes_id_seq ;

CREATE TABLE customers_basket_attributes (
  customers_basket_attributes_id integer DEFAULT nextval('customers_basket_attributes_customers_basket_attributes_id_seq') NOT NULL,
  customers_id  int NOT NULL default '0',
 
  products_id  text NOT NULL,
 
  products_options_id  varchar(64) NOT NULL default '0',
 
  products_options_value_id  int NOT NULL default '0',
 
  products_options_value_text  bytea NULL,
 
  products_options_sort_order  text NOT NULL,
 
  primary key (customers_basket_attributes_id)
) ;



CREATE INDEX customers_basket_attributes_1_idx ON customers_basket_attributes USING btree (customers_id, products_id);
-- --------------------------------------------------------
--
-- Table structure for table 'customers_info'
--
 --DROP TABLE customers_info CASCADE\g
CREATE TABLE customers_info (
  customers_info_id  int NOT NULL default '0',
 
  customers_info_date_of_last_logon  timestamp without time zone default NULL,
 
  customers_info_number_of_logons  int default NULL,
 
  customers_info_date_account_created  timestamp without time zone default NULL,
 
  customers_info_date_account_last_modified  timestamp without time zone default NULL,
 
  global_product_notifications  int default '0',
 
  primary key (customers_info_id)
) ;


-- --------------------------------------------------------
--
-- Table structure for table db_cache
--
 --DROP TABLE db_cache CASCADE\g
CREATE TABLE db_cache (
  cache_entry_name  varchar(64) NOT NULL default '',
 
  cache_data  bytea,
 
  cache_entry_created  int default NULL,
 
  primary key (cache_entry_name)
) ;





-- --------------------------------------------------------
--
-- Table structure for table 'email_archive'
--
 --DROP TABLE email_archive CASCADE\g
 --DROP SEQUENCE email_archive_archive_id_seq CASCADE ;

CREATE SEQUENCE email_archive_archive_id_seq ;

CREATE TABLE email_archive (
  archive_id integer DEFAULT nextval('email_archive_archive_id_seq') NOT NULL,
  email_to_name  varchar(96) NOT NULL default '',
 
  email_to_address  varchar(96) NOT NULL default '',
 
  email_from_name  varchar(96) NOT NULL default '',
 
  email_from_address  varchar(96) NOT NULL default '',
 
  email_subject  varchar(255) NOT NULL default '',
 
  email_html  text NOT NULL,
 
  email_text  text NOT NULL,
 
  date_sent  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  module  varchar(64) NOT NULL default '',
 
  primary key (archive_id)
) ;




CREATE INDEX email_archive_email_to_address_idx ON email_archive USING btree (email_to_address);
CREATE INDEX email_archive_module_idx ON email_archive USING btree (module);
-- --------------------------------------------------------
--
-- Table structure for table 'ezpages'
--
 --DROP TABLE ezpages CASCADE\g
 --DROP SEQUENCE ezpages_pages_id_seq CASCADE ;

CREATE SEQUENCE ezpages_pages_id_seq ;

CREATE TABLE ezpages (
  pages_id integer DEFAULT nextval('ezpages_pages_id_seq') NOT NULL,
  languages_id  int NOT NULL default '1',
 
  pages_title  varchar(64) NOT NULL default '',
 
  alt_url  varchar(255) NOT NULL default '',
 
  alt_url_external  varchar(255) NOT NULL default '',
 
  pages_html_text  text,
 
  status_header  int NOT NULL default '1',
 
  status_sidebox  int NOT NULL default '1',
 
  status_footer  int NOT NULL default '1',
 
  status_toc  int NOT NULL default '1',
 
  header_sort_order  int NOT NULL default '0',
 
  sidebox_sort_order  int NOT NULL default '0',
 
  footer_sort_order  int NOT NULL default '0',
 
  toc_sort_order  int NOT NULL default '0',
 
  page_open_new_window  int NOT NULL default '0',
 
  page_is_ssl  int NOT NULL default '0',
 
  toc_chapter  int NOT NULL default '0',
 
  primary key (pages_id)
) ;



CREATE INDEX ezpages_languages_id_idx ON ezpages USING btree (languages_id);
CREATE INDEX ezpages_status_header_idx ON ezpages USING btree (status_header);
CREATE INDEX ezpages_status_sidebox_idx ON ezpages USING btree (status_sidebox);
CREATE INDEX ezpages_status_footer_idx ON ezpages USING btree (status_footer);
CREATE INDEX ezpages_status_toc_idx ON ezpages USING btree (status_toc);
-- --------------------------------------------------------
--
-- Table structure for table 'featured'
--
 --DROP TABLE featured CASCADE\g
 --DROP SEQUENCE featured_featured_id_seq CASCADE ;

CREATE SEQUENCE featured_featured_id_seq ;

CREATE TABLE featured (
  featured_id integer DEFAULT nextval('featured_featured_id_seq') NOT NULL,
  products_id  int NOT NULL default '0',
 
  featured_date_added  timestamp without time zone default NULL,
 
  featured_last_modified  timestamp without time zone default NULL,
 
  expires_date  date NOT NULL default '0001-01-01',
 
  date_status_change  timestamp without time zone default NULL,
 
  status  int NOT NULL default '1',
 
  featured_date_available  date NOT NULL default '0001-01-01',
 
  primary key (featured_id)
) ;



CREATE INDEX featured_status_idx ON featured USING btree (status);
CREATE INDEX featured_products_id_idx ON featured USING btree (products_id);
CREATE INDEX featured_featured_date_available_idx ON featured USING btree (featured_date_available);
CREATE INDEX featured_expires_date_idx ON featured USING btree (expires_date);
-- --------------------------------------------------------
--
-- Table structure for table 'files_uploaded'
--
 --DROP TABLE files_uploaded CASCADE\g
 --DROP SEQUENCE files_uploaded_files_uploaded_id_seq CASCADE ;

CREATE SEQUENCE files_uploaded_files_uploaded_id_seq ;

CREATE TABLE files_uploaded (
  files_uploaded_id integer DEFAULT nextval('files_uploaded_files_uploaded_id_seq') NOT NULL,
  sesskey  varchar(32) default NULL,
 
  customers_id  int default NULL,
 
  files_uploaded_name  varchar(64) NOT NULL default '',
 
  primary key (files_uploaded_id)
) ;



CREATE INDEX files_uploaded_customers_id_idx ON files_uploaded USING btree (customers_id);
--COMMENT ON TABLE files_uploaded IS 'Must always have either a sesskey or customers_id';
-- --------------------------------------------------------
--
-- Table structure for table 'geo_zones'
--
 --DROP TABLE geo_zones CASCADE\g
 --DROP SEQUENCE geo_zones_geo_zone_id_seq CASCADE ;

CREATE SEQUENCE geo_zones_geo_zone_id_seq ;

CREATE TABLE geo_zones (
  geo_zone_id integer DEFAULT nextval('geo_zones_geo_zone_id_seq') NOT NULL,
  geo_zone_name  varchar(32) NOT NULL default '',
 
  geo_zone_description  varchar(255) NOT NULL default '',
 
  last_modified  timestamp without time zone default NULL,
 
  date_added  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  primary key (geo_zone_id)
) ;


-- --------------------------------------------------------
--
-- Table structure for table 'get_terms_to_filter'
--
 --DROP TABLE get_terms_to_filter CASCADE\g
CREATE TABLE get_terms_to_filter (
  get_term_name  varchar(255) NOT NULL default '',
 
  get_term_table  varchar(64) NOT NULL,
 
  get_term_name_field  varchar(64) NOT NULL,
 
  primary key (get_term_name)
) ;



-- --------------------------------------------------------
--
-- Table structure for table 'group_pricing'
--
 --DROP TABLE group_pricing CASCADE\g
 --DROP SEQUENCE group_pricing_group_id_seq CASCADE ;

CREATE SEQUENCE group_pricing_group_id_seq ;

CREATE TABLE group_pricing (
  group_id integer DEFAULT nextval('group_pricing_group_id_seq') NOT NULL,
  group_name  varchar(32) NOT NULL default '',
 
  group_percentage  decimal(5,2) NOT NULL default '0.00',
 
  last_modified  timestamp without time zone default NULL,
 
  date_added  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  primary key (group_id)
) ;



-- --------------------------------------------------------
--
-- Table structure for table 'languages'
--
 --DROP TABLE languages CASCADE\g
 --DROP SEQUENCE languages_languages_id_seq CASCADE ;

CREATE SEQUENCE languages_languages_id_seq ;

CREATE TABLE languages (
  languages_id integer DEFAULT nextval('languages_languages_id_seq') NOT NULL,
  name  varchar(32) NOT NULL default '',
 
  code  char(2) NOT NULL default '',
 
  image  varchar(64) default NULL,
 
  directory  varchar(32) default NULL,
 
  sort_order  int default NULL,
 
  primary key (languages_id)
) ;



CREATE INDEX languages_name_idx ON languages USING btree (name);
-- --------------------------------------------------------
--
-- Table structure for table 'layout_boxes'
--
 --DROP TABLE layout_boxes CASCADE\g
 --DROP SEQUENCE layout_boxes_layout_id_seq CASCADE ;

CREATE SEQUENCE layout_boxes_layout_id_seq ;

CREATE TABLE layout_boxes (
  layout_id integer DEFAULT nextval('layout_boxes_layout_id_seq') NOT NULL,
  layout_template  varchar(64) NOT NULL default '',
 
  layout_box_name  varchar(64) NOT NULL default '',
 
  layout_box_status  smallint NOT NULL default '0',
 
  layout_box_location  smallint NOT NULL default '0',
 
  layout_box_sort_order  int NOT NULL default '0',
 
  layout_box_sort_order_single  int NOT NULL default '0',
 
  layout_box_status_single  smallint NOT NULL default '0',
 
  primary key (layout_id)
) ;



CREATE INDEX layout_boxes_1_idx ON layout_boxes USING btree (layout_template, layout_box_name);
CREATE INDEX layout_boxes_layout_box_status_idx ON layout_boxes USING btree (layout_box_status);
CREATE INDEX layout_boxes_layout_box_sort_order_idx ON layout_boxes USING btree (layout_box_sort_order);
-- --------------------------------------------------------
--
-- Table structure for table 'manufacturers'
--
 --DROP TABLE manufacturers CASCADE\g
 --DROP SEQUENCE manufacturers_manufacturers_id_seq CASCADE ;

CREATE SEQUENCE manufacturers_manufacturers_id_seq ;

CREATE TABLE manufacturers (
  manufacturers_id integer DEFAULT nextval('manufacturers_manufacturers_id_seq') NOT NULL,
  manufacturers_name  varchar(32) NOT NULL default '',
 
  manufacturers_image  varchar(64) default NULL,
 
  date_added  timestamp without time zone default NULL,
 
  last_modified  timestamp without time zone default NULL,
 
  primary key (manufacturers_id)
) ;



CREATE INDEX manufacturers_manufacturers_name_idx ON manufacturers USING btree (manufacturers_name);
-- --------------------------------------------------------
--
-- Table structure for table 'manufacturers_info'
--
 --DROP TABLE manufacturers_info CASCADE\g
CREATE TABLE manufacturers_info (
  manufacturers_id  int NOT NULL default '0',
 
  languages_id  int NOT NULL default '0',
 
  manufacturers_url  varchar(255) NOT NULL default '',
 
  url_clicked  int NOT NULL default '0',
 
  date_last_click  timestamp without time zone default NULL,
 
  primary key (manufacturers_id, languages_id)
) ;



-- --------------------------------------------------------
--
-- Table structure for table 'media_clips'
--
 --DROP TABLE media_clips CASCADE\g
 --DROP SEQUENCE media_clips_clip_id_seq CASCADE ;

CREATE SEQUENCE media_clips_clip_id_seq ;

CREATE TABLE media_clips (
  clip_id integer DEFAULT nextval('media_clips_clip_id_seq') NOT NULL,
  media_id  int NOT NULL default '0',
 
  clip_type  smallint NOT NULL default '0',
 
  clip_filename  text NOT NULL,
 
  date_added  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  last_modified  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  primary key (clip_id)
) ;



CREATE INDEX media_clips_media_id_idx ON media_clips USING btree (media_id);
CREATE INDEX media_clips_clip_type_idx ON media_clips USING btree (clip_type);
-- --------------------------------------------------------
--
-- Table structure for table 'media_manager'
--
 --DROP TABLE media_manager CASCADE\g
 --DROP SEQUENCE media_manager_media_id_seq CASCADE ;

CREATE SEQUENCE media_manager_media_id_seq ;

CREATE TABLE media_manager (
  media_id integer DEFAULT nextval('media_manager_media_id_seq') NOT NULL,
  media_name  varchar(255) NOT NULL default '',
 
  last_modified  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  date_added  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  primary key (media_id)
) ;



CREATE INDEX media_manager_media_name_idx ON media_manager USING btree (media_name);
-- --------------------------------------------------------
--
-- Table structure for table 'media_to_products'
--
 --DROP TABLE media_to_products CASCADE\g
CREATE TABLE media_to_products (
  media_id  int NOT NULL default '0',
 
  product_id  int NOT NULL default '0'
) ;



CREATE INDEX media_to_products_1_idx ON media_to_products USING btree (media_id, product_id);
-- --------------------------------------------------------
--
-- Table structure for table 'media_types'
--
 --DROP TABLE media_types CASCADE\g
 --DROP SEQUENCE media_types_type_id_seq CASCADE ;

CREATE SEQUENCE media_types_type_id_seq ;

CREATE TABLE media_types (
  type_id integer DEFAULT nextval('media_types_type_id_seq') NOT NULL,
  type_name  varchar(64) NOT NULL default '',
 
  type_ext  varchar(8) NOT NULL default '',
 
  primary key (type_id)
) ;

INSERT INTO media_types (type_name, type_ext) VALUES (E'MP3',E'.mp3');
 



CREATE INDEX media_types_type_name_idx ON media_types USING btree (type_name);
-- -------------------------------------------------------
--
-- Table structure for table 'meta_tags_categories_description'
--
 --DROP TABLE meta_tags_categories_description CASCADE\g
CREATE TABLE meta_tags_categories_description (
  categories_id  int NOT NULL,
 
  language_id  int NOT NULL default '1',
 
  metatags_title  varchar(255) NOT NULL default '',
 
  metatags_keywords  text,
 
  metatags_description  text,
 
  primary key (categories_id, language_id)
) ;



-- --------------------------------------------------------
--
-- Table structure for table 'meta_tags_products_description'
--
 --DROP TABLE meta_tags_products_description CASCADE\g
CREATE TABLE meta_tags_products_description (
  products_id  int NOT NULL,
 
  language_id  int NOT NULL default '1',
 
  metatags_title  varchar(255) NOT NULL default '',
 
  metatags_keywords  text,
 
  metatags_description  text,
 
  primary key (products_id, language_id)
) ;



-- --------------------------------------------------------
--
-- Table structure for table 'music_genre'
--
 --DROP TABLE music_genre CASCADE\g
 --DROP SEQUENCE music_genre_music_genre_id_seq CASCADE ;

CREATE SEQUENCE music_genre_music_genre_id_seq ;

CREATE TABLE music_genre (
  music_genre_id integer DEFAULT nextval('music_genre_music_genre_id_seq') NOT NULL,
  music_genre_name  varchar(32) NOT NULL default '',
 
  date_added  timestamp without time zone default NULL,
 
  last_modified  timestamp without time zone default NULL,
 
  primary key (music_genre_id)
) ;



CREATE INDEX music_genre_music_genre_name_idx ON music_genre USING btree (music_genre_name);
-- --------------------------------------------------------
--
-- Table structure for table 'newsletters'
--
 --DROP TABLE newsletters CASCADE\g
 --DROP SEQUENCE newsletters_newsletters_id_seq CASCADE ;

CREATE SEQUENCE newsletters_newsletters_id_seq ;

CREATE TABLE newsletters (
  newsletters_id integer DEFAULT nextval('newsletters_newsletters_id_seq') NOT NULL,
  title  varchar(255) NOT NULL default '',
 
  content  text NOT NULL,
 
  content_html  text NOT NULL,
 
  module  varchar(255) NOT NULL default '',
 
  date_added  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  date_sent  timestamp without time zone default NULL,
 
  status  int default NULL,
 
  locked  int default '0',
 
  primary key (newsletters_id)
) ;



-- --------------------------------------------------------
--
-- Table structure for table 'orders'
--
 --DROP TABLE orders CASCADE\g
 --DROP SEQUENCE orders_orders_id_seq CASCADE ;

CREATE SEQUENCE orders_orders_id_seq ;

CREATE TABLE orders (
  orders_id integer DEFAULT nextval('orders_orders_id_seq') NOT NULL,
  customers_id  int NOT NULL default '0',
 
  customers_name  varchar(64) NOT NULL default '',
 
  customers_company  varchar(32) default NULL,
 
  customers_street_address  varchar(64) NOT NULL default '',
 
  customers_suburb  varchar(32) default NULL,
 
  customers_city  varchar(32) NOT NULL default '',
 
  customers_postcode  varchar(10) NOT NULL default '',
 
  customers_state  varchar(32) default NULL,
 
  customers_country  varchar(32) NOT NULL default '',
 
  customers_telephone  varchar(32) NOT NULL default '',
 
  customers_email_address  varchar(96) NOT NULL default '',
 
  customers_address_format_id  int NOT NULL default '0',
 
  delivery_name  varchar(64) NOT NULL default '',
 
  delivery_company  varchar(32) default NULL,
 
  delivery_street_address  varchar(64) NOT NULL default '',
 
  delivery_suburb  varchar(32) default NULL,
 
  delivery_city  varchar(32) NOT NULL default '',
 
  delivery_postcode  varchar(10) NOT NULL default '',
 
  delivery_state  varchar(32) default NULL,
 
  delivery_country  varchar(32) NOT NULL default '',
 
  delivery_address_format_id  int NOT NULL default '0',
 
  billing_name  varchar(64) NOT NULL default '',
 
  billing_company  varchar(32) default NULL,
 
  billing_street_address  varchar(64) NOT NULL default '',
 
  billing_suburb  varchar(32) default NULL,
 
  billing_city  varchar(32) NOT NULL default '',
 
  billing_postcode  varchar(10) NOT NULL default '',
 
  billing_state  varchar(32) default NULL,
 
  billing_country  varchar(32) NOT NULL default '',
 
  billing_address_format_id  int NOT NULL default '0',
 
  payment_method  varchar(128) NOT NULL default '',
 
  payment_module_code  varchar(32) NOT NULL default '',
 
  shipping_method  varchar(128) NOT NULL default '',
 
  shipping_module_code  varchar(32) NOT NULL default '',
 
  coupon_code  varchar(32) NOT NULL default '',
 
  cc_type  varchar(20) default NULL,
 
  cc_owner  varchar(64) default NULL,
 
  cc_number  varchar(32) default NULL,
 
  cc_expires  varchar(4) default NULL,
 
  cc_cvv  bytea,
 
  last_modified  timestamp without time zone default NULL,
 
  date_purchased  timestamp without time zone default NULL,
 
  orders_status  int NOT NULL default '0',
 
  orders_date_finished  timestamp without time zone default NULL,
 
  currency  char(3) default NULL,
 
  currency_value  decimal(14,6) default NULL,
 
  order_total  decimal(14,2) default NULL,
 
  order_tax  decimal(14,2) default NULL,
 
  paypal_ipn_id  int NOT NULL default '0',
 
  ip_address  varchar(96) NOT NULL default '',
 
  primary key (orders_id)
) ;




CREATE INDEX orders_1_idx ON orders USING btree (orders_status, orders_id, customers_id);
CREATE INDEX orders_date_purchased_idx ON orders USING btree (date_purchased);
-- --------------------------------------------------------
--
-- Table structure for table 'orders_products'
--
 --DROP TABLE orders_products CASCADE\g
 --DROP SEQUENCE orders_products_orders_products_id_seq CASCADE ;

CREATE SEQUENCE orders_products_orders_products_id_seq ;

CREATE TABLE orders_products (
  orders_products_id integer DEFAULT nextval('orders_products_orders_products_id_seq') NOT NULL,
  orders_id  int NOT NULL default '0',
 
  products_id  int NOT NULL default '0',
 
  products_model  varchar(32) default NULL,
 
  products_name  varchar(64) NOT NULL default '',
 
  products_price  decimal(15,4) NOT NULL default '0.0000',
 
  final_price  decimal(15,4) NOT NULL default '0.0000',
 
  products_tax  decimal(7,4) NOT NULL default '0.0000',
 
  products_quantity  float NOT NULL default '0',
 
  onetime_charges  decimal(15,4) NOT NULL default '0.0000',
 
  products_priced_by_attribute  smallint NOT NULL default '0',
 
  product_is_free  smallint NOT NULL default '0',
 
  products_discount_type  smallint NOT NULL default '0',
 
  products_discount_type_from  smallint NOT NULL default '0',
 
  products_prid  text NOT NULL,
 
  primary key (orders_products_id)
) ;




CREATE INDEX orders_products_1_idx ON orders_products USING btree (orders_id, products_id);
-- --------------------------------------------------------
--
-- Table structure for table 'orders_products_attributes'
--
 --DROP TABLE orders_products_attributes CASCADE\g
 --DROP SEQUENCE orders_products_attributes_orders_products_attributes_id_seq CASCADE ;

CREATE SEQUENCE orders_products_attributes_orders_products_attributes_id_seq ;

CREATE TABLE orders_products_attributes (
  orders_products_attributes_id integer DEFAULT nextval('orders_products_attributes_orders_products_attributes_id_seq') NOT NULL,
  orders_id  int NOT NULL default '0',
 
  orders_products_id  int NOT NULL default '0',
 
  products_options  varchar(32) NOT NULL default '',
 
  products_options_values  bytea NOT NULL,
 
  options_values_price  decimal(15,4) NOT NULL default '0.0000',
 
  price_prefix  char(1) NOT NULL default '',
 
  product_attribute_is_free  smallint NOT NULL default '0',
 
  products_attributes_weight  float NOT NULL default '0',
 
  products_attributes_weight_prefix  char(1) NOT NULL default '',
 
  attributes_discounted  smallint NOT NULL default '1',
 
  attributes_price_base_included  smallint NOT NULL default '1',
 
  attributes_price_onetime  decimal(15,4) NOT NULL default '0.0000',
 
  attributes_price_factor  decimal(15,4) NOT NULL default '0.0000',
 
  attributes_price_factor_offset  decimal(15,4) NOT NULL default '0.0000',
 
  attributes_price_factor_onetime  decimal(15,4) NOT NULL default '0.0000',
 
  attributes_price_factor_onetime_offset  decimal(15,4) NOT NULL default '0.0000',
 
  attributes_qty_prices  text,
 
  attributes_qty_prices_onetime  text,
 
  attributes_price_words  decimal(15,4) NOT NULL default '0.0000',
 
  attributes_price_words_free  int NOT NULL default '0',
 
  attributes_price_letters  decimal(15,4) NOT NULL default '0.0000',
 
  attributes_price_letters_free  int NOT NULL default '0',
 
  products_options_id  int NOT NULL default '0',
 
  products_options_values_id  int NOT NULL default '0',
 
  products_prid  text NOT NULL,
 
  primary key (orders_products_attributes_id)
) ;



CREATE INDEX orders_products_attributes_1_idx ON orders_products_attributes USING btree (orders_id, orders_products_id);
-- --------------------------------------------------------
--
-- Table structure for table 'orders_products_download'
--
 --DROP TABLE orders_products_download CASCADE\g
 --DROP SEQUENCE orders_products_download_orders_products_download_id_seq CASCADE ;

CREATE SEQUENCE orders_products_download_orders_products_download_id_seq ;

CREATE TABLE orders_products_download (
  orders_products_download_id integer DEFAULT nextval('orders_products_download_orders_products_download_id_seq') NOT NULL,
  orders_id  int NOT NULL default '0',
 
  orders_products_id  int NOT NULL default '0',
 
  orders_products_filename  varchar(255) NOT NULL default '',
 
  download_maxdays  int NOT NULL default '0',
 
  download_count  int NOT NULL default '0',
 
  products_prid  text NOT NULL,
 
  primary key (orders_products_download_id)
) ;



CREATE INDEX orders_products_download_orders_id_idx ON orders_products_download USING btree (orders_id);
CREATE INDEX orders_products_download_orders_products_id_idx ON orders_products_download USING btree (orders_products_id);
-- --------------------------------------------------------
--
-- Table structure for table 'orders_status'
--
 --DROP TABLE orders_status CASCADE\g
CREATE TABLE orders_status (
  orders_status_id  int NOT NULL default '0',
 
  language_id  int NOT NULL default '1',
 
  orders_status_name  varchar(32) NOT NULL default '',
 
  primary key (orders_status_id, language_id)
) ;



CREATE INDEX orders_status_orders_status_name_idx ON orders_status USING btree (orders_status_name);
-- --------------------------------------------------------
--
-- Table structure for table 'orders_status_history'
--
 --DROP TABLE orders_status_history CASCADE\g
 --DROP SEQUENCE orders_status_history_orders_status_history_id_seq CASCADE ;

CREATE SEQUENCE orders_status_history_orders_status_history_id_seq ;

CREATE TABLE orders_status_history (
  orders_status_history_id integer DEFAULT nextval('orders_status_history_orders_status_history_id_seq') NOT NULL,
  orders_id  int NOT NULL default '0',
 
  orders_status_id  int NOT NULL default '0',
 
  date_added  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  customer_notified  int default '0',
 
  comments  text,
 
  primary key (orders_status_history_id)
) ;



CREATE INDEX orders_status_history_1_idx ON orders_status_history USING btree (orders_id, orders_status_id);
-- --------------------------------------------------------
--
-- Table structure for table 'orders_total'
--
 --DROP TABLE orders_total CASCADE\g
 --DROP SEQUENCE orders_total_orders_total_id_seq CASCADE ;

CREATE SEQUENCE orders_total_orders_total_id_seq ;

CREATE TABLE orders_total (
  orders_total_id integer DEFAULT nextval('orders_total_orders_total_id_seq') NOT NULL,
  orders_id  int NOT NULL default '0',
 
  title  varchar(255) NOT NULL default '',
 
  text  varchar(255) NOT NULL default '',
 
  value  decimal(15,4) NOT NULL default '0.0000',
 
  class  varchar(32) NOT NULL default '',
 
  sort_order  int NOT NULL default '0',
 
  primary key (orders_total_id)
) ;



CREATE INDEX orders_total_orders_id_idx ON orders_total USING btree (orders_id);
CREATE INDEX orders_total_class_idx ON orders_total USING btree (class);
-- --------------------------------------------------------
--
-- Table structure for table 'paypal'
--
 --DROP TABLE paypal CASCADE\g
 --DROP SEQUENCE paypal_paypal_ipn_id_seq CASCADE ;

CREATE SEQUENCE paypal_paypal_ipn_id_seq ;

CREATE TABLE paypal (
  paypal_ipn_id integer DEFAULT nextval('paypal_paypal_ipn_id_seq') NOT NULL,
  zen_order_id int CHECK (zen_order_id >= 0) NOT NULL default '0',
  txn_type  varchar(40) NOT NULL default '',
 
  reason_code  varchar(40) default NULL,
 
  payment_type  varchar(40) NOT NULL default '',
 
  payment_status  varchar(32) NOT NULL default '',
 
  pending_reason  varchar(32) default NULL,
 
  invoice  varchar(128) default NULL,
 
  mc_currency  char(3) NOT NULL default '',
 
  first_name  varchar(32) NOT NULL default '',
 
  last_name  varchar(32) NOT NULL default '',
 
  payer_business_name  varchar(128) default NULL,
 
  address_name  varchar(64) default NULL,
 
  address_street  varchar(254) default NULL,
 
  address_city  varchar(120) default NULL,
 
  address_state  varchar(120) default NULL,
 
  address_zip  varchar(10) default NULL,
 
  address_country  varchar(64) default NULL,
 
  address_status  varchar(11) default NULL,
 
  payer_email  varchar(128) NOT NULL default '',
 
  payer_id  varchar(32) NOT NULL default '',
 
  payer_status  varchar(10) NOT NULL default '',
 
  payment_date  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  business  varchar(128) NOT NULL default '',
 
  receiver_email  varchar(128) NOT NULL default '',
 
  receiver_id  varchar(32) NOT NULL default '',
 
  txn_id  varchar(20) NOT NULL default '',
 
  parent_txn_id  varchar(20) default NULL,
 
  num_cart_items smallint CHECK (num_cart_items >= 0) NOT NULL default '1',
  mc_gross  decimal(7,2) NOT NULL default '0.00',
 
  mc_fee  decimal(7,2) NOT NULL default '0.00',
 
  payment_gross  decimal(7,2) default NULL,
 
  payment_fee  decimal(7,2) default NULL,
 
  settle_amount  decimal(7,2) default NULL,
 
  settle_currency  char(3) default NULL,
 
  exchange_rate  decimal(4,2) default NULL,
 
  notify_version  decimal(2,1) NOT NULL default '0.0',
 
  verify_sign  varchar(128) NOT NULL default '',
 
  last_modified  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  date_added  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  memo  text,
 
  primary key (paypal_ipn_id, txn_id)
) ;



CREATE INDEX paypal_zen_order_id_idx ON paypal USING btree (zen_order_id);
-- --------------------------------------------------------
--
-- Table structure for table 'paypal_payment_status'
--
 --DROP TABLE paypal_payment_status CASCADE\g
 --DROP SEQUENCE paypal_payment_status_payment_status_id_seq CASCADE ;

CREATE SEQUENCE paypal_payment_status_payment_status_id_seq ;

CREATE TABLE paypal_payment_status (
  payment_status_id integer DEFAULT nextval('paypal_payment_status_payment_status_id_seq') NOT NULL,
  payment_status_name  varchar(64) NOT NULL default '',
 
  primary key (payment_status_id)
) ;


--
-- Dumping data for table 'paypal_payment_status'
--
INSERT INTO paypal_payment_status VALUES (1, E'Completed');
 
INSERT INTO paypal_payment_status VALUES (2, E'Pending');
 
INSERT INTO paypal_payment_status VALUES (3, E'Failed');
 
INSERT INTO paypal_payment_status VALUES (4, E'Denied');
 
INSERT INTO paypal_payment_status VALUES (5, E'Refunded');
 
INSERT INTO paypal_payment_status VALUES (6, E'Canceled_Reversal');
 
INSERT INTO paypal_payment_status VALUES (7, E'Reversed');
 



-- --------------------------------------------------------
--
-- Table structure for table 'paypal_payment_status_history'
--
 --DROP TABLE paypal_payment_status_history CASCADE\g
 --DROP SEQUENCE paypal_payment_status_history_payment_status_history_id_seq CASCADE ;

CREATE SEQUENCE paypal_payment_status_history_payment_status_history_id_seq ;

CREATE TABLE paypal_payment_status_history (
  payment_status_history_id integer DEFAULT nextval('paypal_payment_status_history_payment_status_history_id_seq') NOT NULL,
  paypal_ipn_id  int NOT NULL default '0',
 
  txn_id  varchar(64) NOT NULL default '',
 
  parent_txn_id  varchar(64) NOT NULL default '',
 
  payment_status  varchar(17) NOT NULL default '',
 
  pending_reason  varchar(14) default NULL,
 
  date_added  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  primary key (payment_status_history_id)
) ;



CREATE INDEX paypal_payment_status_history_paypal_ipn_id_idx ON paypal_payment_status_history USING btree (paypal_ipn_id);
-- --------------------------------------------------------
--
-- Table structure for table 'paypal_session'
--
 --DROP TABLE paypal_session CASCADE\g
 --DROP SEQUENCE paypal_session_unique_id_seq CASCADE ;

CREATE SEQUENCE paypal_session_unique_id_seq ;

CREATE TABLE paypal_session (
  unique_id integer DEFAULT nextval('paypal_session_unique_id_seq') NOT NULL,
  session_id  text NOT NULL,
 
  saved_session  bytea NOT NULL,
 
  expiry  int NOT NULL default '0',
 
  primary key (unique_id)
) ;



CREATE INDEX paypal_session_session_id_idx ON paypal_session USING btree (session_id);
-- --------------------------------------------------------
--
-- Table structure for table 'paypal_testing'
--
 --DROP TABLE paypal_testing CASCADE\g
 --DROP SEQUENCE paypal_testing_paypal_ipn_id_seq CASCADE ;

CREATE SEQUENCE paypal_testing_paypal_ipn_id_seq ;

CREATE TABLE paypal_testing (
  paypal_ipn_id integer DEFAULT nextval('paypal_testing_paypal_ipn_id_seq') NOT NULL,
  zen_order_id int CHECK (zen_order_id >= 0) NOT NULL default '0',
  custom  varchar(255) NOT NULL default '',
 
  txn_type  varchar(40) NOT NULL default '',
 
  reason_code  varchar(40) default NULL,
 
  payment_type  varchar(40) NOT NULL default '',
 
  payment_status  varchar(32) NOT NULL default '',
 
  pending_reason  varchar(32) default NULL,
 
  invoice  varchar(128) default NULL,
 
  mc_currency  char(3) NOT NULL default '',
 
  first_name  varchar(32) NOT NULL default '',
 
  last_name  varchar(32) NOT NULL default '',
 
  payer_business_name  varchar(128) default NULL,
 
  address_name  varchar(64) default NULL,
 
  address_street  varchar(254) default NULL,
 
  address_city  varchar(120) default NULL,
 
  address_state  varchar(120) default NULL,
 
  address_zip  varchar(10) default NULL,
 
  address_country  varchar(64) default NULL,
 
  address_status  varchar(11) default NULL,
 
  payer_email  varchar(128) NOT NULL default '',
 
  payer_id  varchar(32) NOT NULL default '',
 
  payer_status  varchar(10) NOT NULL default '',
 
  payment_date  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  business  varchar(128) NOT NULL default '',
 
  receiver_email  varchar(128) NOT NULL default '',
 
  receiver_id  varchar(32) NOT NULL default '',
 
  txn_id  varchar(20) NOT NULL default '',
 
  parent_txn_id  varchar(20) default NULL,
 
  num_cart_items smallint CHECK (num_cart_items >= 0) NOT NULL default '1',
  mc_gross  decimal(7,2) NOT NULL default '0.00',
 
  mc_fee  decimal(7,2) NOT NULL default '0.00',
 
  payment_gross  decimal(7,2) default NULL,
 
  payment_fee  decimal(7,2) default NULL,
 
  settle_amount  decimal(7,2) default NULL,
 
  settle_currency  char(3) default NULL,
 
  exchange_rate  decimal(4,2) default NULL,
 
  notify_version  decimal(2,1) NOT NULL default '0.0',
 
  verify_sign  varchar(128) NOT NULL default '',
 
  last_modified  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  date_added  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  memo  text,
 
  primary key (paypal_ipn_id, txn_id)
) ;



CREATE INDEX paypal_testing_zen_order_id_idx ON paypal_testing USING btree (zen_order_id);
-- --------------------------------------------------------
--
-- Table structure for table 'product_music_extra'
--
 --DROP TABLE product_music_extra CASCADE\g
CREATE TABLE product_music_extra (
  products_id  int NOT NULL default '0',
 
  artists_id  int NOT NULL default '0',
 
  record_company_id  int NOT NULL default '0',
 
  music_genre_id  int NOT NULL default '0',
 
  primary key (products_id)
) ;



CREATE INDEX product_music_extra_music_genre_id_idx ON product_music_extra USING btree (music_genre_id);
CREATE INDEX product_music_extra_artists_id_idx ON product_music_extra USING btree (artists_id);
CREATE INDEX product_music_extra_record_company_id_idx ON product_music_extra USING btree (record_company_id);
-- --------------------------------------------------------
--
-- Table structure for table 'product_type_layout'
--
 --DROP TABLE product_type_layout CASCADE\g
 --DROP SEQUENCE product_type_layout_configuration_id_seq CASCADE ;

CREATE SEQUENCE product_type_layout_configuration_id_seq ;

CREATE TABLE product_type_layout (
  configuration_id integer DEFAULT nextval('product_type_layout_configuration_id_seq') NOT NULL,
  configuration_title  text NOT NULL,
 
  configuration_key  varchar(255) NOT NULL default '',
 
  configuration_value  text NOT NULL,
 
  configuration_description  text NOT NULL,
 
  product_type_id  int NOT NULL default '0',
 
  sort_order  int default NULL,
 
  last_modified  timestamp without time zone default NULL,
 
  date_added  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  use_function  text default NULL,
 
  set_function  text default NULL,
 
  primary key (configuration_id),
 unique (configuration_key) 
) ;



CREATE INDEX product_type_layout_1_idx ON product_type_layout USING btree (configuration_key, configuration_value);
-- --------------------------------------------------------
--
-- Table structure for table 'product_types'
--
 --DROP TABLE product_types CASCADE\g
 --DROP SEQUENCE product_types_type_id_seq CASCADE ;

CREATE SEQUENCE product_types_type_id_seq ;

CREATE TABLE product_types (
  type_id integer DEFAULT nextval('product_types_type_id_seq') NOT NULL,
  type_name  varchar(255) NOT NULL default '',
 
  type_handler  varchar(255) NOT NULL default '',
 
  type_master_type  int NOT NULL default '1',
 
  allow_add_to_cart  char(1) NOT NULL default 'Y',
 
  default_image  varchar(255) NOT NULL default '',
 
  date_added  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  last_modified  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  primary key (type_id)
) ;



CREATE INDEX product_types_type_master_type_idx ON product_types USING btree (type_master_type);
-- --------------------------------------------------------
--
-- Table structure for table 'product_types_to_category'
--
 --DROP TABLE product_types_to_category CASCADE\g
CREATE TABLE product_types_to_category (
  product_type_id  int NOT NULL default '0',
 
  category_id  int NOT NULL default '0'
) ;




CREATE INDEX product_types_to_category_category_id_idx ON product_types_to_category USING btree (category_id);
CREATE INDEX product_types_to_category_product_type_id_idx ON product_types_to_category USING btree (product_type_id);
-- --------------------------------------------------------
--
-- Table structure for table 'products'
--
 --DROP TABLE products CASCADE\g
 --DROP SEQUENCE products_products_id_seq CASCADE ;

CREATE SEQUENCE products_products_id_seq ;

CREATE TABLE products (
  products_id integer DEFAULT nextval('products_products_id_seq') NOT NULL,
  products_type  int NOT NULL default '1',
 
  products_quantity  float NOT NULL default '0',
 
  products_model  varchar(32) default NULL,
 
  products_image  varchar(64) default NULL,
 
  products_price  decimal(15,4) NOT NULL default '0.0000',
 
  products_virtual  smallint NOT NULL default '0',
 
  products_date_added  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  products_last_modified  timestamp without time zone default NULL,
 
  products_date_available  timestamp without time zone default NULL,
 
  products_weight  float NOT NULL default '0',
 
  products_status  smallint NOT NULL default '0',
 
  products_tax_class_id  int NOT NULL default '0',
 
  manufacturers_id  int default NULL,
 
  products_ordered  float NOT NULL default '0',
 
  products_quantity_order_min  float NOT NULL default '1',
 
  products_quantity_order_units  float NOT NULL default '1',
 
  products_priced_by_attribute  smallint NOT NULL default '0',
 
  product_is_free  smallint NOT NULL default '0',
 
  product_is_call  smallint NOT NULL default '0',
 
  products_quantity_mixed  smallint NOT NULL default '0',
 
  product_is_always_free_shipping  smallint NOT NULL default '0',
 
  products_qty_box_status  smallint NOT NULL default '1',
 
  products_quantity_order_max  float NOT NULL default '0',
 
  products_sort_order  int NOT NULL default '0',
 
  products_discount_type  smallint NOT NULL default '0',
 
  products_discount_type_from  smallint NOT NULL default '0',
 
  products_price_sorter  decimal(15,4) NOT NULL default '0.0000',
 
  master_categories_id  int NOT NULL default '0',
 
  products_mixed_discount_quantity  smallint NOT NULL default '1',
 
  metatags_title_status  smallint NOT NULL default '0',
 
  metatags_products_name_status  smallint NOT NULL default '0',
 
  metatags_model_status  smallint NOT NULL default '0',
 
  metatags_price_status  smallint NOT NULL default '0',
 
  metatags_title_tagline_status  smallint NOT NULL default '0',
 
  primary key (products_id)
) ;


CREATE INDEX products_products_date_added_idx ON products USING btree (products_date_added);
CREATE INDEX products_products_status_idx ON products USING btree (products_status);
CREATE INDEX products_products_date_available_idx ON products USING btree (products_date_available);
CREATE INDEX products_products_ordered_idx ON products USING btree (products_ordered);
CREATE INDEX products_products_model_idx ON products USING btree (products_model);
CREATE INDEX products_products_price_sorter_idx ON products USING btree (products_price_sorter);
CREATE INDEX products_master_categories_id_idx ON products USING btree (master_categories_id);
CREATE INDEX products_products_sort_order_idx ON products USING btree (products_sort_order);
CREATE INDEX products_manufacturers_id_idx ON products USING btree (manufacturers_id);
-- --------------------------------------------------------
--
-- Table structure for table 'products_attributes'
--
 --DROP TABLE products_attributes CASCADE\g
 --DROP SEQUENCE products_attributes_products_attributes_id_seq CASCADE ;

CREATE SEQUENCE products_attributes_products_attributes_id_seq ;

CREATE TABLE products_attributes (
  products_attributes_id integer DEFAULT nextval('products_attributes_products_attributes_id_seq') NOT NULL,
  products_id  int NOT NULL default '0',
 
  options_id  int NOT NULL default '0',
 
  options_values_id  int NOT NULL default '0',
 
  options_values_price  decimal(15,4) NOT NULL default '0.0000',
 
  price_prefix  char(1) NOT NULL default '',
 
  products_options_sort_order  int NOT NULL default '0',
 
  product_attribute_is_free  smallint NOT NULL default '0',
 
  products_attributes_weight  float NOT NULL default '0',
 
  products_attributes_weight_prefix  char(1) NOT NULL default '',
 
  attributes_display_only  smallint NOT NULL default '0',
 
  attributes_default  smallint NOT NULL default '0',
 
  attributes_discounted  smallint NOT NULL default '1',
 
  attributes_image  varchar(64) default NULL,
 
  attributes_price_base_included  smallint NOT NULL default '1',
 
  attributes_price_onetime  decimal(15,4) NOT NULL default '0.0000',
 
  attributes_price_factor  decimal(15,4) NOT NULL default '0.0000',
 
  attributes_price_factor_offset  decimal(15,4) NOT NULL default '0.0000',
 
  attributes_price_factor_onetime  decimal(15,4) NOT NULL default '0.0000',
 
  attributes_price_factor_onetime_offset  decimal(15,4) NOT NULL default '0.0000',
 
  attributes_qty_prices  text,
 
  attributes_qty_prices_onetime  text,
 
  attributes_price_words  decimal(15,4) NOT NULL default '0.0000',
 
  attributes_price_words_free  int NOT NULL default '0',
 
  attributes_price_letters  decimal(15,4) NOT NULL default '0.0000',
 
  attributes_price_letters_free  int NOT NULL default '0',
 
  attributes_required  smallint NOT NULL default '0',
 
  primary key (products_attributes_id)
) ;



CREATE INDEX products_attributes_1_idx ON products_attributes USING btree (products_id, options_id, options_values_id);
CREATE INDEX products_attributes_products_options_sort_order_idx ON products_attributes USING btree (products_options_sort_order);
-- --------------------------------------------------------
--
-- Table structure for table 'products_attributes_download'
--
 --DROP TABLE products_attributes_download CASCADE\g
CREATE TABLE products_attributes_download (
  products_attributes_id  int NOT NULL default '0',
 
  products_attributes_filename  varchar(255) NOT NULL default '',
 
  products_attributes_maxdays  int default '0',
 
  products_attributes_maxcount  int default '0',
 
  primary key (products_attributes_id)
) ;



-- --------------------------------------------------------
--
-- Table structure for table 'products_description'
--
 --DROP TABLE products_description CASCADE\g
 --DROP SEQUENCE products_description_products_id_seq CASCADE ;

CREATE SEQUENCE products_description_products_id_seq ;

CREATE TABLE products_description (
  products_id integer DEFAULT nextval('products_description_products_id_seq') NOT NULL,
  language_id  int NOT NULL default '1',
 
  products_name  varchar(64) NOT NULL default '',
 
  products_description  text,
 
  products_url  varchar(255) default NULL,
 
  products_viewed  int default '0',
 
  primary key (products_id, language_id)
) ;


CREATE INDEX products_description_products_name_idx ON products_description USING btree (products_name);
-- --------------------------------------------------------
--
-- Table structure for table 'products_discount_quantity'
--
 --DROP TABLE products_discount_quantity CASCADE\g
CREATE TABLE products_discount_quantity (
  discount_id  int NOT NULL default '0',
 
  products_id  int NOT NULL default '0',
 
  discount_qty  float NOT NULL default '0',
 
  discount_price  decimal(15,4) NOT NULL default '0.0000'
) ;



CREATE INDEX products_discount_quantity_1_idx ON products_discount_quantity USING btree (products_id, discount_qty);
-- --------------------------------------------------------
--
-- Table structure for table 'products_notifications'
--
 --DROP TABLE products_notifications CASCADE\g
CREATE TABLE products_notifications (
  products_id  int NOT NULL default '0',
 
  customers_id  int NOT NULL default '0',
 
  date_added  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  primary key (products_id, customers_id)
) ;



-- --------------------------------------------------------
--
-- Table structure for table 'products_options'
--
 --DROP TABLE products_options CASCADE\g
CREATE TABLE products_options (
  products_options_id  int NOT NULL default '0',
 
  language_id  int NOT NULL default '1',
 
  products_options_name  varchar(32) NOT NULL default '',
 
  products_options_sort_order  int NOT NULL default '0',
 
  products_options_type  int NOT NULL default '0',
 
  products_options_length  smallint NOT NULL default '32',
 
  products_options_comment  varchar(64) default NULL,
 
  products_options_size  smallint NOT NULL default '32',
 
  products_options_images_per_row  int default '5',
 
  products_options_images_style  int default '0',
 
  products_options_rows  smallint NOT NULL default '1',
 
  primary key (products_options_id, language_id)
) ;



CREATE INDEX products_options_language_id_idx ON products_options USING btree (language_id);
CREATE INDEX products_options_products_options_sort_order_idx ON products_options USING btree (products_options_sort_order);
CREATE INDEX products_options_products_options_name_idx ON products_options USING btree (products_options_name);
-- --------------------------------------------------------
--
-- Table structure for table 'products_options_types'
--
 --DROP TABLE products_options_types CASCADE\g
CREATE TABLE products_options_types (
  products_options_types_id  int NOT NULL default '0',
 
  products_options_types_name  varchar(32) default NULL,
 
  primary key (products_options_types_id)
) ;



--COMMENT ON TABLE products_options_types IS 'Track products_options_types';
-- --------------------------------------------------------
--
-- Table structure for table 'products_options_values'
--
 --DROP TABLE products_options_values CASCADE\g
CREATE TABLE products_options_values (
  products_options_values_id  int NOT NULL default '0',
 
  language_id  int NOT NULL default '1',
 
  products_options_values_name  varchar(64) NOT NULL default '',
 
  products_options_values_sort_order  int NOT NULL default '0',
 
  primary key (products_options_values_id, language_id)
) ;



CREATE INDEX products_options_values_products_options_values_name_idx ON products_options_values USING btree (products_options_values_name);
CREATE INDEX products_options_values_products_options_values_sort_order_idx ON products_options_values USING btree (products_options_values_sort_order);
-- --------------------------------------------------------
--
-- Table structure for table 'products_options_values_to_products_options'
--
 --DROP TABLE products_options_values_to_products_options CASCADE\g
 --DROP SEQUENCE ucts_options_products_options_values_to_products_options_id_seq CASCADE ;

CREATE SEQUENCE ucts_options_products_options_values_to_products_options_id_seq ;

CREATE TABLE products_options_values_to_products_options (
  products_options_values_to_products_options_id integer DEFAULT nextval('ucts_options_products_options_values_to_products_options_id_seq') NOT NULL,
  products_options_id  int NOT NULL default '0',
 
  products_options_values_id  int NOT NULL default '0',
 
  primary key (products_options_values_to_products_options_id)
) ;



CREATE INDEX ucts_options_values_to_products_options_products_options_id_idx ON products_options_values_to_products_options USING btree (products_options_id);
CREATE INDEX tions_values_to_products_options_products_options_values_id_idx ON products_options_values_to_products_options USING btree (products_options_values_id);
-- --------------------------------------------------------
--
-- Table structure for table 'products_to_categories'
--
 --DROP TABLE products_to_categories CASCADE\g
CREATE TABLE products_to_categories (
  products_id  int NOT NULL default '0',
 
  categories_id  int NOT NULL default '0',
 
  primary key (products_id, categories_id)
) ;



CREATE INDEX products_to_categories_1_idx ON products_to_categories USING btree (categories_id, products_id);
-- --------------------------------------------------------
--
-- Table structure for table 'project_version'
--
 --DROP TABLE project_version CASCADE\g
 --DROP SEQUENCE project_version_project_version_id_seq CASCADE ;

CREATE SEQUENCE project_version_project_version_id_seq ;

CREATE TABLE project_version (
  project_version_id integer DEFAULT nextval('project_version_project_version_id_seq') NOT NULL,
  project_version_key  varchar(40) NOT NULL default '',
 
  project_version_major  varchar(20) NOT NULL default '',
 
  project_version_minor  varchar(20) NOT NULL default '',
 
  project_version_patch1  varchar(20) NOT NULL default '',
 
  project_version_patch2  varchar(20) NOT NULL default '',
 
  project_version_patch1_source  varchar(20) NOT NULL default '',
 
  project_version_patch2_source  varchar(20) NOT NULL default '',
 
  project_version_comment  varchar(250) NOT NULL default '',
 
  project_version_date_applied  timestamp without time zone NOT NULL default '0001-01-01 01:01:01',
 
  primary key (project_version_id),
 unique (project_version_key) 
) ;



--COMMENT ON TABLE project_version IS 'Database Version Tracking';
-- --------------------------------------------------------
--
-- Table structure for table 'project_version_history'
--
 --DROP TABLE project_version_history CASCADE\g
 --DROP SEQUENCE project_version_history_project_version_id_seq CASCADE ;

CREATE SEQUENCE project_version_history_project_version_id_seq ;

CREATE TABLE project_version_history (
  project_version_id integer DEFAULT nextval('project_version_history_project_version_id_seq') NOT NULL,
  project_version_key  varchar(40) NOT NULL default '',
 
  project_version_major  varchar(20) NOT NULL default '',
 
  project_version_minor  varchar(20) NOT NULL default '',
 
  project_version_patch  varchar(20) NOT NULL default '',
 
  project_version_comment  varchar(250) NOT NULL default '',
 
  project_version_date_applied  timestamp without time zone NOT NULL default '0001-01-01 01:01:01',
 
  primary key (project_version_id)
) ;


--COMMENT ON TABLE project_version_history IS 'Database Version Tracking History';
-- --------------------------------------------------------
--
-- Table structure for table 'query_builder'
-- This table is used by audiences.php for building data-extraction queries
--
 --DROP TABLE query_builder CASCADE\g
 --DROP SEQUENCE query_builder_query_id_seq CASCADE ;

CREATE SEQUENCE query_builder_query_id_seq ;

CREATE TABLE query_builder (
  query_id integer DEFAULT nextval('query_builder_query_id_seq') NOT NULL,
  query_category  varchar(40) NOT NULL default '',
 
  query_name  varchar(80) NOT NULL default '',
 
  query_description  TEXT NOT NULL,
 
  query_string  TEXT NOT NULL,
 
  query_keys_list  TEXT NOT NULL,
 
  primary key (query_id),
 unique (query_name) 
) ;



--COMMENT ON TABLE query_builder IS 'Stores queries for re-use in Admin email and report modules';
-- --------------------------------------------------------
--
-- Table structure for table 'record_artists'
--
 --DROP TABLE record_artists CASCADE\g
 --DROP SEQUENCE record_artists_artists_id_seq CASCADE ;

CREATE SEQUENCE record_artists_artists_id_seq ;

CREATE TABLE record_artists (
  artists_id integer DEFAULT nextval('record_artists_artists_id_seq') NOT NULL,
  artists_name  varchar(32) NOT NULL default '',
 
  artists_image  varchar(64) default NULL,
 
  date_added  timestamp without time zone default NULL,
 
  last_modified  timestamp without time zone default NULL,
 
  primary key (artists_id)
) ;



CREATE INDEX record_artists_artists_name_idx ON record_artists USING btree (artists_name);
-- --------------------------------------------------------
--
-- Table structure for table 'record_artists_info'
--
 --DROP TABLE record_artists_info CASCADE\g
CREATE TABLE record_artists_info (
  artists_id  int NOT NULL default '0',
 
  languages_id  int NOT NULL default '0',
 
  artists_url  varchar(255) NOT NULL default '',
 
  url_clicked  int NOT NULL default '0',
 
  date_last_click  timestamp without time zone default NULL,
 
  primary key (artists_id, languages_id)
) ;



-- --------------------------------------------------------
--
-- Table structure for table 'record_company'
--
 --DROP TABLE record_company CASCADE\g
 --DROP SEQUENCE record_company_record_company_id_seq CASCADE ;

CREATE SEQUENCE record_company_record_company_id_seq ;

CREATE TABLE record_company (
  record_company_id integer DEFAULT nextval('record_company_record_company_id_seq') NOT NULL,
  record_company_name  varchar(32) NOT NULL default '',
 
  record_company_image  varchar(64) default NULL,
 
  date_added  timestamp without time zone default NULL,
 
  last_modified  timestamp without time zone default NULL,
 
  primary key (record_company_id)
) ;



CREATE INDEX record_company_record_company_name_idx ON record_company USING btree (record_company_name);
-- --------------------------------------------------------
--
-- Table structure for table 'record_company_info'
--
 --DROP TABLE record_company_info CASCADE\g
CREATE TABLE record_company_info (
  record_company_id  int NOT NULL default '0',
 
  languages_id  int NOT NULL default '0',
 
  record_company_url  varchar(255) NOT NULL default '',
 
  url_clicked  int NOT NULL default '0',
 
  date_last_click  timestamp without time zone default NULL,
 
  primary key (record_company_id, languages_id)
) ;



-- --------------------------------------------------------
--
-- Table structure for table 'reviews'
--
 --DROP TABLE reviews CASCADE\g
 --DROP SEQUENCE reviews_reviews_id_seq CASCADE ;

CREATE SEQUENCE reviews_reviews_id_seq ;

CREATE TABLE reviews (
  reviews_id integer DEFAULT nextval('reviews_reviews_id_seq') NOT NULL,
  products_id  int NOT NULL default '0',
 
  customers_id  int default NULL,
 
  customers_name  varchar(64) NOT NULL default '',
 
  reviews_rating  int default NULL,
 
  date_added  timestamp without time zone default NULL,
 
  last_modified  timestamp without time zone default NULL,
 
  reviews_read  int NOT NULL default '0',
 
  status  int NOT NULL default '1',
 
  primary key (reviews_id)
) ;



CREATE INDEX reviews_products_id_idx ON reviews USING btree (products_id);
CREATE INDEX reviews_customers_id_idx ON reviews USING btree (customers_id);
CREATE INDEX reviews_status_idx ON reviews USING btree (status);
CREATE INDEX reviews_date_added_idx ON reviews USING btree (date_added);
-- --------------------------------------------------------
--
-- Table structure for table 'reviews_description'
--
 --DROP TABLE reviews_description CASCADE\g
CREATE TABLE reviews_description (
  reviews_id  int NOT NULL default '0',
 
  languages_id  int NOT NULL default '0',
 
  reviews_text  text NOT NULL,
 
  primary key (reviews_id, languages_id)
) ;



-- --------------------------------------------------------
--
-- Table structure for table 'salemaker_sales'
--
 --DROP TABLE salemaker_sales CASCADE\g
 --DROP SEQUENCE salemaker_sales_sale_id_seq CASCADE ;

CREATE SEQUENCE salemaker_sales_sale_id_seq ;

CREATE TABLE salemaker_sales (
  sale_id integer DEFAULT nextval('salemaker_sales_sale_id_seq') NOT NULL,
  sale_status  smallint NOT NULL default '0',
 
  sale_name  varchar(30) NOT NULL default '',
 
  sale_deduction_value  decimal(15,4) NOT NULL default '0.0000',
 
  sale_deduction_type  smallint NOT NULL default '0',
 
  sale_pricerange_from  decimal(15,4) NOT NULL default '0.0000',
 
  sale_pricerange_to  decimal(15,4) NOT NULL default '0.0000',
 
  sale_specials_condition  smallint NOT NULL default '0',
 
  sale_categories_selected  text,
 
  sale_categories_all  text,
 
  sale_date_start  date NOT NULL default '0001-01-01',
 
  sale_date_end  date NOT NULL default '0001-01-01',
 
  sale_date_added  date NOT NULL default '0001-01-01',
 
  sale_date_last_modified  date NOT NULL default '0001-01-01',
 
  sale_date_status_change  date NOT NULL default '0001-01-01',
 
  primary key (sale_id)
) ;



CREATE INDEX salemaker_sales_sale_status_idx ON salemaker_sales USING btree (sale_status);
CREATE INDEX salemaker_sales_sale_date_start_idx ON salemaker_sales USING btree (sale_date_start);
CREATE INDEX salemaker_sales_sale_date_end_idx ON salemaker_sales USING btree (sale_date_end);
-- --------------------------------------------------------
--
-- Table structure for table 'sessions'
--
 --DROP TABLE sessions CASCADE\g
CREATE TABLE sessions (
  sesskey  varchar(32) NOT NULL default '',
 
  expiry int CHECK (expiry >= 0) NOT NULL default '0',
  value  text NOT NULL,
 
  primary key (sesskey)
) ;



-- --------------------------------------------------------
--
-- Table structure for table 'specials'
--
 --DROP TABLE specials CASCADE\g
 --DROP SEQUENCE specials_specials_id_seq CASCADE ;

CREATE SEQUENCE specials_specials_id_seq ;

CREATE TABLE specials (
  specials_id integer DEFAULT nextval('specials_specials_id_seq') NOT NULL,
  products_id  int NOT NULL default '0',
 
  specials_new_products_price  decimal(15,4) NOT NULL default '0.0000',
 
  specials_date_added  timestamp without time zone default NULL,
 
  specials_last_modified  timestamp without time zone default NULL,
 
  expires_date  date NOT NULL default '0001-01-01',
 
  date_status_change  timestamp without time zone default NULL,
 
  status  int NOT NULL default '1',
 
  specials_date_available  date NOT NULL default '0001-01-01',
 
  primary key (specials_id)
) ;



CREATE INDEX specials_status_idx ON specials USING btree (status);
CREATE INDEX specials_products_id_idx ON specials USING btree (products_id);
CREATE INDEX specials_specials_date_available_idx ON specials USING btree (specials_date_available);
CREATE INDEX specials_expires_date_idx ON specials USING btree (expires_date);
-- --------------------------------------------------------
--
-- Table structure for table 'tax_class'
--
 --DROP TABLE tax_class CASCADE\g
 --DROP SEQUENCE tax_class_tax_class_id_seq CASCADE ;

CREATE SEQUENCE tax_class_tax_class_id_seq ;

CREATE TABLE tax_class (
  tax_class_id integer DEFAULT nextval('tax_class_tax_class_id_seq') NOT NULL,
  tax_class_title  varchar(32) NOT NULL default '',
 
  tax_class_description  varchar(255) NOT NULL default '',
 
  last_modified  timestamp without time zone default NULL,
 
  date_added  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  primary key (tax_class_id)
) ;



-- --------------------------------------------------------
--
-- Table structure for table 'tax_rates'
--
 --DROP TABLE tax_rates CASCADE\g
 --DROP SEQUENCE tax_rates_tax_rates_id_seq CASCADE ;

CREATE SEQUENCE tax_rates_tax_rates_id_seq ;

CREATE TABLE tax_rates (
  tax_rates_id integer DEFAULT nextval('tax_rates_tax_rates_id_seq') NOT NULL,
  tax_zone_id  int NOT NULL default '0',
 
  tax_class_id  int NOT NULL default '0',
 
  tax_priority  int default '1',
 
  tax_rate  decimal(7,4) NOT NULL default '0.0000',
 
  tax_description  varchar(255) NOT NULL default '',
 
  last_modified  timestamp without time zone default NULL,
 
  date_added  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  primary key (tax_rates_id)
) ;



CREATE INDEX tax_rates_tax_zone_id_idx ON tax_rates USING btree (tax_zone_id);
CREATE INDEX tax_rates_tax_class_id_idx ON tax_rates USING btree (tax_class_id);
-- --------------------------------------------------------
--
-- Table structure for table 'template_select'
--
 --DROP TABLE template_select CASCADE\g
 --DROP SEQUENCE template_select_template_id_seq CASCADE ;

CREATE SEQUENCE template_select_template_id_seq ;

CREATE TABLE template_select (
  template_id integer DEFAULT nextval('template_select_template_id_seq') NOT NULL,
  template_dir  varchar(64) NOT NULL default '',
 
  template_language  varchar(64) NOT NULL default '0',
 
  primary key (template_id)
) ;




CREATE INDEX template_select_template_language_idx ON template_select USING btree (template_language);
-- --------------------------------------------------------
--
-- Table structure for table 'whos_online'
--
 --DROP TABLE whos_online CASCADE\g
CREATE TABLE whos_online (
  customer_id  int default NULL,
 
  full_name  varchar(64) NOT NULL default '',
 
  session_id  varchar(128) NOT NULL default '',
 
  ip_address  varchar(15) NOT NULL default '',
 
  time_entry  varchar(14) NOT NULL default '',
 
  time_last_click  varchar(14) NOT NULL default '',
 
  last_page_url  varchar(255) NOT NULL default '',
 
  host_address  text NOT NULL,
 
  user_agent  varchar(255) NOT NULL default ''
) ;



CREATE INDEX whos_online_ip_address_idx ON whos_online USING btree (ip_address);
CREATE INDEX whos_online_session_id_idx ON whos_online USING btree (session_id);
CREATE INDEX whos_online_customer_id_idx ON whos_online USING btree (customer_id);
CREATE INDEX whos_online_time_entry_idx ON whos_online USING btree (time_entry);
CREATE INDEX whos_online_time_last_click_idx ON whos_online USING btree (time_last_click);
CREATE INDEX whos_online_last_page_url_idx ON whos_online USING btree (last_page_url);
-- --------------------------------------------------------
--
-- Table structure for table 'zones'
--
 --DROP TABLE zones CASCADE\g
 --DROP SEQUENCE zones_zone_id_seq CASCADE ;

CREATE SEQUENCE zones_zone_id_seq ;

CREATE TABLE zones (
  zone_id integer DEFAULT nextval('zones_zone_id_seq') NOT NULL,
  zone_country_id  int NOT NULL default '0',
 
  zone_code  varchar(32) NOT NULL default '',
 
  zone_name  varchar(32) NOT NULL default '',
 
  primary key (zone_id)
) ;



CREATE INDEX zones_zone_country_id_idx ON zones USING btree (zone_country_id);
CREATE INDEX zones_zone_code_idx ON zones USING btree (zone_code);
-- --------------------------------------------------------
--
-- Table structure for table 'zones_to_geo_zones'
--
 --DROP TABLE zones_to_geo_zones CASCADE\g
 --DROP SEQUENCE zones_to_geo_zones_association_id_seq CASCADE ;

CREATE SEQUENCE zones_to_geo_zones_association_id_seq ;

CREATE TABLE zones_to_geo_zones (
  association_id integer DEFAULT nextval('zones_to_geo_zones_association_id_seq') NOT NULL,
  zone_country_id  int NOT NULL default '0',
 
  zone_id  int default NULL,
 
  geo_zone_id  int default NULL,
 
  last_modified  timestamp without time zone default NULL,
 
  date_added  timestamp without time zone NOT NULL default '0001-01-01 00:00:00',
 
  primary key (association_id)
) ;



CREATE INDEX zones_to_geo_zones_1_idx ON zones_to_geo_zones USING btree (geo_zone_id, zone_country_id, zone_id);
--
-- Database table for customers_wishlist
--
 --DROP TABLE customers_wishlist CASCADE\g
CREATE TABLE customers_wishlist (
  products_id  int NOT NULL default '0',
 
  customers_id  int NOT NULL default '0',
 
  products_model  varchar(13) default NULL,
 
  products_name  varchar(64) NOT NULL default '',
 
  products_price  decimal(8,2) NOT NULL default '0.00',
 
  final_price  decimal(8,2) NOT NULL default '0.00',
 
  products_quantity  int NOT NULL default '0',
 
  wishlist_name  varchar(64) default NULL
 
) ;


















-- data
INSERT INTO template_select VALUES (1, E'classic', E'0');
 

-- 1 - Default, 2 - USA, 3 - Spain, 4 - Singapore, 5 - Germany, 6 - UK/GB
INSERT INTO address_format VALUES (1, E'$firstname $lastname$cr$streets$cr$city, $postcode$cr$statecomma$country',E'$city / $country');
 
INSERT INTO address_format VALUES (2, E'$firstname $lastname$cr$streets$cr$city, $state  $postcode$cr$country',E'$city, $state / $country');
 
INSERT INTO address_format VALUES (3, E'$firstname $lastname$cr$streets$cr$city$cr$postcode - $statecomma$country',E'$state / $country');
 
INSERT INTO address_format VALUES (4, E'$firstname $lastname$cr$streets$cr$city ($postcode)$cr$country', E'$postcode / $country');
 
INSERT INTO address_format VALUES (5, E'$firstname $lastname$cr$streets$cr$postcode $city$cr$country',E'$city / $country');
 
INSERT INTO address_format VALUES (6, E'$firstname $lastname$cr$streets$cr$city$cr$state$cr$postcode$cr$country',E'$postcode / $country');
 

INSERT INTO admin VALUES (1, E'Admin', E'admin@localhost', E'351683ea4e19efe34874b501fdbf9792:9b', 1);
 

INSERT INTO banners (banners_title, banners_url, banners_image, banners_group, banners_html_text, expires_impressions, expires_date, date_scheduled, date_added, date_status_change, status, banners_open_new_windows, banners_on_ssl, banners_sort_order) VALUES (E'Zen Cart', E'http://www.zen-cart.com', E'banners/zencart_468_60_02.gif', E'Wide-Banners', E'', 0, NULL, NULL, E'2004-01-11 20:59:12', NULL, 1, 1, 1, 0);
 
INSERT INTO banners (banners_title, banners_url, banners_image, banners_group, banners_html_text, expires_impressions, expires_date, date_scheduled, date_added, date_status_change, status, banners_open_new_windows, banners_on_ssl, banners_sort_order) VALUES (E'Zen Cart the art of e-commerce', E'http://www.zen-cart.com', E'banners/125zen_logo.gif', E'SideBox-Banners', E'', 0, NULL, NULL, E'2004-01-11 20:59:12', NULL, 1, 1, 1, 0);
 
INSERT INTO banners (banners_title, banners_url, banners_image, banners_group, banners_html_text, expires_impressions, expires_date, date_scheduled, date_added, date_status_change, status, banners_open_new_windows, banners_on_ssl, banners_sort_order) VALUES (E'Zen Cart the art of e-commerce', E'http://www.zen-cart.com', E'banners/125x125_zen_logo.gif', E'SideBox-Banners', E'', 0, NULL, NULL, E'2004-01-11 20:59:12', NULL, 1, 1, 1, 0);
 
INSERT INTO banners (banners_title, banners_url, banners_image, banners_group, banners_html_text, expires_impressions, expires_date, date_scheduled, date_added, date_status_change, status, banners_open_new_windows, banners_on_ssl, banners_sort_order) VALUES (E'if you have to think ... you haven''t been Zenned!', E'http://www.zen-cart.com', E'banners/think_anim.gif', E'Wide-Banners', E'', 0, NULL, NULL, E'2004-01-12 20:53:18', NULL, 1, 1, 1, 0);
 
INSERT INTO banners (banners_title, banners_url, banners_image, banners_group, banners_html_text, expires_impressions, expires_date, date_scheduled, date_added, date_status_change, status, banners_open_new_windows, banners_on_ssl, banners_sort_order) VALUES (E'Sashbox.net - the ultimate e-commerce hosting solution', E'http://www.sashbox.net/zencart/', E'banners/sashbox_125x50.jpg', E'BannersAll', E'', 0, NULL, NULL, E'2005-05-13 10:53:50', NULL, 1, 1, 1, 20);
 
INSERT INTO banners (banners_title, banners_url, banners_image, banners_group, banners_html_text, expires_impressions, expires_date, date_scheduled, date_added, date_status_change, status, banners_open_new_windows, banners_on_ssl, banners_sort_order) VALUES (E'Zen Cart the art of e-commerce', E'http://www.zen-cart.com', E'banners/bw_zen_88wide.gif', E'BannersAll', E'', 0, NULL, NULL, E'2005-05-13 10:54:38', NULL, 1, 1, 1, 10);
 
INSERT INTO banners (banners_title, banners_url, banners_image, banners_group, banners_html_text, expires_impressions, expires_date, date_scheduled, date_added, date_status_change, status, banners_open_new_windows, banners_on_ssl, banners_sort_order) VALUES (E'Sashbox.net - the ultimate e-commerce hosting solution', E'http://www.sashbox.net/zencart/', E'banners/sashbox_468x60.jpg', E'Wide-Banners', E'', 0, NULL, NULL, E'2005-05-13 10:55:11', NULL, 1, 1, 1, 0);
 
INSERT INTO banners (banners_title, banners_url, banners_image, banners_group, banners_html_text, expires_impressions, expires_date, date_scheduled, date_added, date_status_change, status, banners_open_new_windows, banners_on_ssl, banners_sort_order) VALUES (E'Start Accepting Credit Cards For Your Business Today!', E'http://www.zen-cart.com/index.php?main_page=infopages&pages_id=30', E'banners/cardsvcs_468x60.gif', E'Wide-Banners', E'', 0, NULL, NULL, E'2006-03-13 11:02:43', NULL, 1, 1, 1, 0);
 
INSERT INTO banners (banners_title, banners_url, banners_image, banners_group, banners_html_text, expires_impressions, expires_date, date_scheduled, date_added, date_status_change, status, banners_open_new_windows, banners_on_ssl, banners_sort_order) VALUES (E'eStart Your Web Store with Zen Cart(tm)', E'http://www.lulu.com/content/466605', E'banners/big-book-ad.gif', E'Wide-Banners', E'', E'0', NULL, NULL, E'2007-02-10 00:00:00',NULL,E'1',E'1',E'1',E'1');
 
INSERT INTO banners (banners_title, banners_url, banners_image, banners_group, banners_html_text, expires_impressions, expires_date, date_scheduled, date_added, date_status_change, status, banners_open_new_windows, banners_on_ssl, banners_sort_order) VALUES (E'eStart Your Web Store with Zen Cart(tm)', E'http://www.lulu.com/content/466605', E'banners/tall-book.gif', E'SideBox-Banners', E'', E'0', NULL, NULL, E'2007-02-10 00:00:00',NULL,E'1',E'1',E'1',E'1');
 
INSERT INTO banners (banners_title, banners_url, banners_image, banners_group, banners_html_text, expires_impressions, expires_date, date_scheduled, date_added, date_status_change, status, banners_open_new_windows, banners_on_ssl, banners_sort_order) VALUES (E'eStart Your Web Store with Zen Cart(tm)', E'http://www.lulu.com/content/466605', E'banners/tall-book.gif', E'BannersAll', E'', E'0', NULL, NULL, E'2007-02-10 00:00:00',NULL,E'1',E'1',E'1',E'15');
 


INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Store Name', E'STORE_NAME', E'Zen Cart', E'The name of my store', E'1', E'1', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Store Owner', E'STORE_OWNER', E'Team Zen Cart', E'The name of my store owner', E'1', E'2', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (E'Country', E'STORE_COUNTRY', E'223', E'The country my store is located in <br /><br /><strong>Note: Please remember to update the store zone.</strong>', E'1', E'6', E'zen_get_country_name', E'zen_cfg_pull_down_country_list(', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (E'Zone', E'STORE_ZONE', E'18', E'The zone my store is located in', E'1', E'7', E'zen_cfg_get_zone_name', E'zen_cfg_pull_down_zone_list(', now());

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Expected Sort Order', E'EXPECTED_PRODUCTS_SORT', E'desc', E'This is the sort order used in the expected products box.', E'1', E'8', E'zen_cfg_select_option(array(\'asc\',\'desc\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Expected Sort Field', E'EXPECTED_PRODUCTS_FIELD', E'date_expected', E'The column to sort by in the expected products box.', E'1', E'9', E'zen_cfg_select_option(array(\'products_name\', \'date_expected\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Switch To Default Language Currency', E'USE_DEFAULT_LANGUAGE_CURRENCY', E'false', E'Automatically switch to the language\'s currency when it is changed', E'1', E'10', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Language Selector', E'LANGUAGE_DEFAULT_SELECTOR', E'Default', E'Should the default language be based on the Store preferences, or the customer\'s browser settings?<br /><br />Default: Store\'s default settings', E'1', E'11', E'zen_cfg_select_option(array(\'Default\', \'Browser\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Use Search-Engine Safe URLs (still in development)', E'SEARCH_ENGINE_FRIENDLY_URLS', E'false', E'Use search-engine safe urls for all site links', E'6', E'12', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Display Cart After Adding Product', E'DISPLAY_CART', E'true', E'Display the shopping cart after adding a product (or return back to their origin)', E'1', E'14', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Default Search Operator', E'ADVANCED_SEARCH_DEFAULT_OPERATOR', E'and', E'Default search operators', E'1', E'17', E'zen_cfg_select_option(array(\'and\', \'or\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Store Address and Phone', E'STORE_NAME_ADDRESS', E'Store Name\nAddress\nCountry\nPhone', E'This is the Store Name, Address and Phone used on printable documents and displayed online', E'1', E'18', E'zen_cfg_textarea(', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Show Category Counts', E'SHOW_COUNTS', E'true', E'Count recursively how many products are in each category', E'1', E'19', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Tax Decimal Places', E'TAX_DECIMAL_PLACES', E'0', E'Pad the tax value this amount of decimal places', E'1', E'20', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Display Prices with Tax', E'DISPLAY_PRICE_WITH_TAX', E'false', E'Display prices with tax included (true) or add the tax at the end (false)', E'1', E'21', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Display Prices with Tax in Admin', E'DISPLAY_PRICE_WITH_TAX_ADMIN', E'false', E'Display prices with tax included (true) or add the tax at the end (false) in Admin(Invoices)', E'1', E'21', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Basis of Product Tax', E'STORE_PRODUCT_TAX_BASIS', E'Shipping', E'On what basis is Product Tax calculated. Options are<br />Shipping - Based on customers Shipping Address<br />Billing Based on customers Billing address<br />Store - Based on Store address if Billing/Shipping Zone equals Store zone', E'1', E'21', E'zen_cfg_select_option(array(\'Shipping\', \'Billing\', \'Store\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Basis of Shipping Tax', E'STORE_SHIPPING_TAX_BASIS', E'Shipping', E'On what basis is Shipping Tax calculated. Options are<br />Shipping - Based on customers Shipping Address<br />Billing Based on customers Billing address<br />Store - Based on Store address if Billing/Shipping Zone equals Store zone - Can be overriden by correctly written Shipping Module', E'1', E'21', E'zen_cfg_select_option(array(\'Shipping\', \'Billing\', \'Store\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Sales Tax Display Status', E'STORE_TAX_DISPLAY_STATUS', E'0', E'Always show Sales Tax even when amount is $0.00?<br />0= Off<br />1= On', E'1', E'21', E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Admin Session Time Out in Seconds', E'SESSION_TIMEOUT_ADMIN', E'3600', E'Enter the time in seconds. Default=3600<br />Example: 3600= 1 hour<br /><br />Note: Too few seconds can result in timeout issues when adding/editing products', 1, 40, NULL, now(), NULL, NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Admin Set max_execution_time for processes', E'GLOBAL_SET_TIME_LIMIT', E'60', E'Enter the time in seconds for how long the max_execution_time of processes should be. Default=60<br />Example: 60= 1 minute<br /><br />Note: Changing the time limit is only needed if you are having problems with the execution time of a process', 1, 42, NULL, now(), NULL, NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Show if version update available', E'SHOW_VERSION_UPDATE_IN_HEADER', E'true', E'Automatically check to see if a new version of Zen Cart is available. Enabling this can sometimes slow down the loading of Admin pages. (Displayed on main Index page after login, and Server Info page.)', 1, 44, E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Store Status', E'STORE_STATUS', E'0', E'What is your Store Status<br />0= Normal Store<br />1= Showcase no prices<br />2= Showcase with prices', E'1', E'25', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Server Uptime', E'DISPLAY_SERVER_UPTIME', E'true', E'Displaying Server uptime can cause entries in error logs on some servers. (true = Display, false = don\'t display)', 1, 46, E'2003-11-08 20:24:47', E'0001-01-01 00:00:00', E'', E'zen_cfg_select_option(array(\'true\', \'false\'),');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Missing Page Check', E'MISSING_PAGE_CHECK', E'Page Not Found', E'Zen Cart can check for missing pages in the URL and redirect to Index page. For debugging you may want to turn this off. <br /><br /><strong>Default=On</strong><br />On = Send missing pages to \'index\'<br />Off = Don\'t check for missing pages<br />Page Not Found = display the Page-Not-Found page', 1, 48, E'2003-11-08 20:24:47', E'0001-01-01 00:00:00', E'', E'zen_cfg_select_option(array(\'On\', \'Off\', \'Page Not Found\'),');
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'cURL Proxy Status', E'CURL_PROXY_REQUIRED', E'False', E'Does your host require that you use a proxy for cURL communication?', E'1', E'50', E'zen_cfg_select_option(array(\'True\', \'False\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'cURL Proxy Address', E'CURL_PROXY_SERVER_DETAILS', E'', E'If you have GoDaddy hosting or other hosting services that require use of a proxy to talk to external sites via cURL, enter their proxy address here.<br />format: address:port<br />ie: for GoDaddy, enter: <strong>proxy.shr.secureserver.net:3128</strong> or possibly 64.202.165.130:3128', 1, 51, NULL, now(), NULL, NULL);
 


INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'HTML Editor', E'HTML_EDITOR_PREFERENCE', E'NONE', E'Please select the HTML/Rich-Text editor you wish to use for composing Admin-related emails, newsletters, and product descriptions', E'1', E'110', E'zen_cfg_pull_down_htmleditors(', now());
 
--phpbb
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Enable phpBB linkage?', E'PHPBB_LINKS_ENABLED', E'false', E'Should Zen Cart synchronize new account information to your (already-installed) phpBB forum?', E'1', E'120', E'zen_cfg_select_option(array(\'true\', \'false\'),', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Show Category Counts - Admin', E'SHOW_COUNTS_ADMIN', E'true', E'Show Category Counts in Admin?', E'1', E'19', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Currency Conversion Ratio', E'CURRENCY_UPLIFT_RATIO', E'1.05', E'When auto-updating currencies, what uplift ratio should be used to calculate the exchange rate used by your store?<br />ie: the bank rate is obtained from the currency-exchange servers; how much extra do you want to charge in order to make up the difference between the bank rate and the consumer rate?<br /><br /><strong>Default: 1.05 </strong><br />This will cause the published bank rate to be multiplied by 1.05 to set the currency rates in your store.', 1, 55, NULL, now(), NULL, NULL);
 


INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'First Name', E'ENTRY_FIRST_NAME_MIN_LENGTH', E'2', E'Minimum length of first name', E'2', E'1', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Last Name', E'ENTRY_LAST_NAME_MIN_LENGTH', E'2', E'Minimum length of last name', E'2', E'2', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Date of Birth', E'ENTRY_DOB_MIN_LENGTH', E'10', E'Minimum length of date of birth', E'2', E'3', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'E-Mail Address', E'ENTRY_EMAIL_ADDRESS_MIN_LENGTH', E'6', E'Minimum length of e-mail address', E'2', E'4', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Street Address', E'ENTRY_STREET_ADDRESS_MIN_LENGTH', E'5', E'Minimum length of street address', E'2', E'5', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Company', E'ENTRY_COMPANY_MIN_LENGTH', E'0', E'Minimum length of company name', E'2', E'6', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Post Code', E'ENTRY_POSTCODE_MIN_LENGTH', E'4', E'Minimum length of post code', E'2', E'7', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'City', E'ENTRY_CITY_MIN_LENGTH', E'3', E'Minimum length of city', E'2', E'8', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'State', E'ENTRY_STATE_MIN_LENGTH', E'2', E'Minimum length of state', E'2', E'9', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Telephone Number', E'ENTRY_TELEPHONE_MIN_LENGTH', E'3', E'Minimum length of telephone number', E'2', E'10', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Password', E'ENTRY_PASSWORD_MIN_LENGTH', E'5', E'Minimum length of password', E'2', E'11', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Credit Card Owner Name', E'CC_OWNER_MIN_LENGTH', E'3', E'Minimum length of credit card owner name', E'2', E'12', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Credit Card Number', E'CC_NUMBER_MIN_LENGTH', E'10', E'Minimum length of credit card number', E'2', E'13', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Credit Card CVV Number', E'CC_CVV_MIN_LENGTH', E'3', E'Minimum length of credit card CVV number', E'2', E'13', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Product Review Text', E'REVIEW_TEXT_MIN_LENGTH', E'50', E'Minimum length of product review text', E'2', E'14', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Best Sellers', E'MIN_DISPLAY_BESTSELLERS', E'1', E'Minimum number of best sellers to display', E'2', E'15', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Also Purchased Products', E'MIN_DISPLAY_ALSO_PURCHASED', E'1', E'Minimum number of products to display in the \'This Customer Also Purchased\' box', E'2', E'16', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Nick Name', E'ENTRY_NICK_MIN_LENGTH', E'3', E'Minimum length of Nick Name', E'2', E'1', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Address Book Entries', E'MAX_ADDRESS_BOOK_ENTRIES', E'5', E'Maximum address book entries a customer is allowed to have', E'3', E'1', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Search Results Per Page', E'MAX_DISPLAY_SEARCH_RESULTS', E'20', E'Number of products to list on a search result page', E'3', E'2', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Prev/Next Navigation Page Links', E'MAX_DISPLAY_PAGE_LINKS', E'5', E'Number of \'number\' links use for page-sets', E'3', E'3', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Products on Special ', E'MAX_DISPLAY_SPECIAL_PRODUCTS', E'9', E'Number of products on special to display', E'3', E'4', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'New Products Module', E'MAX_DISPLAY_NEW_PRODUCTS', E'9', E'Number of new products to display in a category', E'3', E'5', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Upcoming Products ', E'MAX_DISPLAY_UPCOMING_PRODUCTS', E'10', E'Number of \'upcoming\' products to display', E'3', E'6', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Manufacturers List - Scroll Box Size/Style', E'MAX_MANUFACTURERS_LIST', E'3', E'Number of manufacturers names to be displayed in the scroll box window. Setting this to 1 or 0 will display a  --DROPdown list.', E'3', E'7', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Manufacturers List - Verify Product Exist', E'PRODUCTS_MANUFACTURERS_STATUS', E'1', E'Verify that at least 1 product exists and is active for the manufacturer name to show<br /><br />Note: When this feature is ON it can produce slower results on sites with a large number of products and/or manufacturers<br />0= off 1= on', 3, 7, E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Music Genre List - Scroll Box Size/Style', E'MAX_MUSIC_GENRES_LIST', E'3', E'Number of music genre names to be displayed in the scroll box window. Setting this to 1 or 0 will display a  --DROPdown list.', E'3', E'7', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Record Company List - Scroll Box Size/Style', E'MAX_RECORD_COMPANY_LIST', E'3', E'Number of record company names to be displayed in the scroll box window. Setting this to 1 or 0 will display a  --DROPdown list.', E'3', E'7', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Length of Record Company Name', E'MAX_DISPLAY_RECORD_COMPANY_NAME_LEN', E'15', E'Used in record companies box; maximum length of record company name to display. Longer names will be truncated.', E'3', E'8', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Length of Music Genre Name', E'MAX_DISPLAY_MUSIC_GENRES_NAME_LEN', E'15', E'Used in music genres box; maximum length of music genre name to display. Longer names will be truncated.', E'3', E'8', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Length of Manufacturers Name', E'MAX_DISPLAY_MANUFACTURER_NAME_LEN', E'15', E'Used in manufacturers box; maximum length of manufacturers name to display. Longer names will be truncated.', E'3', E'8', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'New Product Reviews Per Page', E'MAX_DISPLAY_NEW_REVIEWS', E'6', E'Number of new reviews to display on each page', E'3', E'9', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Random Product Reviews For Box', E'MAX_RANDOM_SELECT_REVIEWS', E'10', E'Number of random product reviews to rotate in the box', E'3', E'10', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Random New Products For Box', E'MAX_RANDOM_SELECT_NEW', E'10', E'Number of random new product to display in box', E'3', E'11', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Random Products On Special For Box', E'MAX_RANDOM_SELECT_SPECIALS', E'10', E'Number of random products on special to display in box', E'3', E'12', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Categories To List Per Row', E'MAX_DISPLAY_CATEGORIES_PER_ROW', E'3', E'How many categories to list per row', E'3', E'13', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'New Products Listing- Number Per Page', E'MAX_DISPLAY_PRODUCTS_NEW', E'10', E'Number of new products listed per page', E'3', E'14', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Best Sellers For Box', E'MAX_DISPLAY_BESTSELLERS', E'10', E'Number of best sellers to display in box', E'3', E'15', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Also Purchased Products', E'MAX_DISPLAY_ALSO_PURCHASED', E'6', E'Number of products to display in the \'This Customer Also Purchased\' box', E'3', E'16', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Recent Purchases Box- NOTE: box is disabled ', E'MAX_DISPLAY_PRODUCTS_IN_ORDER_HISTORY_BOX', E'6', E'Number of products to display in the recent purchases box', E'3', E'17', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Customer Order History List Per Page', E'MAX_DISPLAY_ORDER_HISTORY', E'10', E'Number of orders to display in the order history list in \'My Account\'', E'3', E'18', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Maximum Display of Customers on Customers Page', E'MAX_DISPLAY_SEARCH_RESULTS_CUSTOMER', E'20', E'', 3, 19, now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Maximum Display of Orders on Orders Page', E'MAX_DISPLAY_SEARCH_RESULTS_ORDERS', E'20', E'', 3, 20, now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Maximum Display of Products on Reports', E'MAX_DISPLAY_SEARCH_RESULTS_REPORTS', E'20', E'', 3, 21, now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Maximum Categories Products Display List', E'MAX_DISPLAY_RESULTS_CATEGORIES', E'10', E'Number of products to list per screen', 3, 22, now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Products Listing- Number Per Page', E'MAX_DISPLAY_PRODUCTS_LISTING', E'10', E'Maximum Number of Products to list per page on main page', E'3', E'30', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Products Attributes - Option Names and Values Display', E'MAX_ROW_LISTS_OPTIONS', E'10', E'Maximum number of option names and values to display in the products attributes page', E'3', E'24', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Products Attributes - Attributes Controller Display', E'MAX_ROW_LISTS_ATTRIBUTES_CONTROLLER', E'30', E'Maximum number of attributes to display in the Attributes Controller page', E'3', E'25', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Products Attributes - Downloads Manager Display', E'MAX_DISPLAY_SEARCH_RESULTS_DOWNLOADS_MANAGER', E'30', E'Maximum number of attributes downloads to display in the Downloads Manager page', E'3', E'26', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Featured Products - Number to Display Admin', E'MAX_DISPLAY_SEARCH_RESULTS_FEATURED_ADMIN', E'10', E'Number of featured products to list per screen - Admin', 3, 27, now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Maximum Display of Featured Products - Main Page', E'MAX_DISPLAY_SEARCH_RESULTS_FEATURED', E'9', E'Number of featured products to list on main page', 3, 28, now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Maximum Display of Featured Products Page', E'MAX_DISPLAY_PRODUCTS_FEATURED_PRODUCTS', E'10', E'Number of featured products to list per screen', 3, 29, now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Random Featured Products For Box', E'MAX_RANDOM_SELECT_FEATURED_PRODUCTS', E'10', E'Number of random featured products to display in box', E'3', E'30', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Maximum Display of Specials Products - Main Page', E'MAX_DISPLAY_SPECIAL_PRODUCTS_INDEX', E'9', E'Number of special products to list on main page', 3, 31, now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'New Product Listing - Limited to ...', E'SHOW_NEW_PRODUCTS_LIMIT', E'0', E'Limit the New Product Listing to<br />0= All Products<br />1= Current Month<br />7= 7 Days<br />14= 14 Days<br />30= 30 Days<br />60= 60 Days<br />90= 90 Days<br />120= 120 Days', E'3', E'40', E'zen_cfg_select_option(array(\'0\', \'1\', \'7\', \'14\', \'30\', \'60\', \'90\', \'120\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Maximum Display of Products All Page', E'MAX_DISPLAY_PRODUCTS_ALL', E'10', E'Number of products to list per screen', 3, 45, now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Maximum Display of Language Flags in Language Side Box', E'MAX_LANGUAGE_FLAGS_COLUMNS', E'3', E'Number of Language Flags per Row', 3, 50, now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Maximum File Upload Size', E'MAX_FILE_UPLOAD_SIZE', E'2048000', E'What is the Maximum file size for uploads?<br />Default= 2048000', 3, 60, now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Allowed Filename Extensions for uploading', E'UPLOAD_FILENAME_EXTENSIONS', E'jpg,jpeg,gif,png,eps,cdr,ai,pdf,tif,tiff,bmp,zip', E'List the permissible filetypes (filename extensions) to be allowed when files are uploaded to your site by customers. Separate multiple values with commas(,). Do not include the dot(.).<br /><br />Suggested setting: jpg,jpeg,gif,png,eps,cdr,ai,pdf,tif,tiff,bmp,zip', E'3', E'61', E'zen_cfg_textarea(', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Maximum Orders Detail Display on Admin Orders Listing', E'MAX_DISPLAY_RESULTS_ORDERS_DETAILS_LISTING', E'0', E'Maximum number of Order Details<br />0 = Unlimited', 3, 65, now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Maximum PayPal IPN Display on Admin Listing', E'MAX_DISPLAY_SEARCH_RESULTS_PAYPAL_IPN', E'20', E'Maximum number of PayPal IPN Lisings in Admin<br />Default is 20', 3, 66, now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Maximum Display Columns Products to Multiple Categories Manager', E'MAX_DISPLAY_PRODUCTS_TO_CATEGORIES_COLUMNS', E'3', E'Maximum Display Columns Products to Multiple Categories Manager<br />3 = Default', 3, 70, now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Maximum Display EZ-Pages', E'MAX_DISPLAY_SEARCH_RESULTS_EZPAGE', E'20', E'Maximum Display EZ-Pages<br />20 = Default', 3, 71, now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Small Image Width', E'SMALL_IMAGE_WIDTH', E'100', E'The pixel width of small images', E'4', E'1', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Small Image Height', E'SMALL_IMAGE_HEIGHT', E'80', E'The pixel height of small images', E'4', E'2', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Heading Image Width - Admin', E'HEADING_IMAGE_WIDTH', E'57', E'The pixel width of heading images in the Admin<br />NOTE: Presently, this adjusts the spacing on the pages in the Admin Pages or could be used to add images to the heading in the Admin', E'4', E'3', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Heading Image Height - Admin', E'HEADING_IMAGE_HEIGHT', E'40', E'The pixel height of heading images in the Admin<br />NOTE: Presently, this adjusts the spacing on the pages in the Admin Pages or could be used to add images to the heading in the Admin', E'4', E'4', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Subcategory Image Width', E'SUBCATEGORY_IMAGE_WIDTH', E'100', E'The pixel width of subcategory images', E'4', E'5', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Subcategory Image Height', E'SUBCATEGORY_IMAGE_HEIGHT', E'57', E'The pixel height of subcategory images', E'4', E'6', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Calculate Image Size', E'CONFIG_CALCULATE_IMAGE_SIZE', E'true', E'Calculate the size of images?', E'4', E'7', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Image Required', E'IMAGE_REQUIRED', E'true', E'Enable to display broken images. Good for development.', E'4', E'8', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Image - Shopping Cart Status', E'IMAGE_SHOPPING_CART_STATUS', E'1', E'Show product image in the shopping cart?<br />0= off 1= on', 4, 9, E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Image - Shopping Cart Width', E'IMAGE_SHOPPING_CART_WIDTH', E'50', E'Default = 50', 4, 10, now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Image - Shopping Cart Height', E'IMAGE_SHOPPING_CART_HEIGHT', E'40', E'Default = 40', 4, 11, now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Category Icon Image Width - Product Info Pages', E'CATEGORY_ICON_IMAGE_WIDTH', E'57', E'The pixel width of Category Icon heading images for Product Info Pages', E'4', E'13', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Category Icon Image Height - Product Info Pages', E'CATEGORY_ICON_IMAGE_HEIGHT', E'40', E'The pixel height of Category Icon heading images for Product Info Pages', E'4', E'14', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Top Subcategory Image Width', E'SUBCATEGORY_IMAGE_TOP_WIDTH', E'150', E'The pixel width of Top subcategory images<br />Top subcategory is when the Category contains subcategories', E'4', E'15', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Top Subcategory Image Height', E'SUBCATEGORY_IMAGE_TOP_HEIGHT', E'85', E'The pixel height of Top subcategory images<br />Top subcategory is when the Category contains subcategories', E'4', E'16', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Product Info - Image Width', E'MEDIUM_IMAGE_WIDTH', E'150', E'The pixel width of Product Info images', E'4', E'20', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Product Info - Image Height', E'MEDIUM_IMAGE_HEIGHT', E'120', E'The pixel height of Product Info images', E'4', E'21', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Product Info - Image Medium Suffix', E'IMAGE_SUFFIX_MEDIUM', E'_MED', E'Product Info Medium Image Suffix<br />Default = _MED', E'4', E'22', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Product Info - Image Large Suffix', E'IMAGE_SUFFIX_LARGE', E'_LRG', E'Product Info Large Image Suffix<br />Default = _LRG', E'4', E'23', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Product Info - Number of Additional Images per Row', E'IMAGES_AUTO_ADDED', E'3', E'Product Info - Enter the number of additional images to display per row<br />Default = 3', E'4', E'30', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Image - Product Listing Width', E'IMAGE_PRODUCT_LISTING_WIDTH', E'100', E'Default = 100', 4, 40, now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Image - Product Listing Height', E'IMAGE_PRODUCT_LISTING_HEIGHT', E'80', E'Default = 80', 4, 41, now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Image - Product New Listing Width', E'IMAGE_PRODUCT_NEW_LISTING_WIDTH', E'100', E'Default = 100', 4, 42, now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Image - Product New Listing Height', E'IMAGE_PRODUCT_NEW_LISTING_HEIGHT', E'80', E'Default = 80', 4, 43, now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Image - New Products Width', E'IMAGE_PRODUCT_NEW_WIDTH', E'100', E'Default = 100', 4, 44, now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Image - New Products Height', E'IMAGE_PRODUCT_NEW_HEIGHT', E'80', E'Default = 80', 4, 45, now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Image - Featured Products Width', E'IMAGE_FEATURED_PRODUCTS_LISTING_WIDTH', E'100', E'Default = 100', 4, 46, now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Image - Featured Products Height', E'IMAGE_FEATURED_PRODUCTS_LISTING_HEIGHT', E'80', E'Default = 80', 4, 47, now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Image - Product All Listing Width', E'IMAGE_PRODUCT_ALL_LISTING_WIDTH', E'100', E'Default = 100', 4, 48, now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Image - Product All Listing Height', E'IMAGE_PRODUCT_ALL_LISTING_HEIGHT', E'80', E'Default = 80', 4, 49, now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Product Image - No Image Status', E'PRODUCTS_IMAGE_NO_IMAGE_STATUS', E'1', E'Use automatic No Image when none is added to product<br />0= off<br />1= On', E'4', E'60', E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Product Image - No Image picture', E'PRODUCTS_IMAGE_NO_IMAGE', E'no_picture.gif', E'Use automatic No Image when none is added to product<br />Default = no_picture.gif', E'4', E'61', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Image - Use Proportional Images on Products and Categories', E'PROPORTIONAL_IMAGES_STATUS', E'1', E'Use Proportional Images on Products and Categories?<br /><br />NOTE: Do not use 0 height or width settings for Proportion Images<br />0= off 1= on', 4, 75, E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Email Salutation', E'ACCOUNT_GENDER', E'true', E'Display salutation choice during account creation and with account information', E'5', E'1', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Date of Birth', E'ACCOUNT_DOB', E'true', E'Display date of birth field during account creation and with account information<br />NOTE: Set Minimum Value Date of Birth to blank for not required<br />Set Minimum Value Date of Birth > 0 to require', E'5', E'2', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Company', E'ACCOUNT_COMPANY', E'true', E'Display company field during account creation and with account information', E'5', E'3', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Address Line 2', E'ACCOUNT_SUBURB', E'true', E'Display address line 2 field during account creation and with account information', E'5', E'4', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'State', E'ACCOUNT_STATE', E'true', E'Display state field during account creation and with account information', E'5', E'5', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'State - Always display as pulldown?', E'ACCOUNT_STATE_DRAW_INITIAL_ --DROPDOWN', E'false', E'When state field is displayed, should it always be a pulldown menu?', 5, E'5', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (E'Create Account Default Country ID', E'SHOW_CREATE_ACCOUNT_DEFAULT_COUNTRY', E'223', E'Set Create Account Default Country ID to:<br />Default is 223', E'5', E'6', E'zen_get_country_name', E'zen_cfg_pull_down_country_list_none(', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Fax Number', E'ACCOUNT_FAX_NUMBER', E'true', E'Display fax number field during account creation and with account information', E'5', E'10', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Show Newsletter Checkbox', E'ACCOUNT_NEWSLETTER_STATUS', E'1', E'Show Newsletter Checkbox<br />0= off<br />1= Display Unchecked<br />2= Display Checked<br /><strong>Note: Defaulting this to accepted may be in violation of certain regulations for your state or country</strong>', 5, 45, E'zen_cfg_select_option(array(\'0\', \'1\', \'2\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Customer Default Email Preference', E'ACCOUNT_EMAIL_PREFERENCE', E'0', E'Set the Default Customer Default Email Preference<br />0= Text<br />1= HTML<br />', 5, 46, E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Customer Product Notification Status', E'CUSTOMERS_PRODUCTS_NOTIFICATION_STATUS', E'1', E'Customer should be asked about product notifications after checkout success and in account preferences<br />0= Never ask<br />1= Ask (ignored on checkout if has already selected global notifications)<br /><br />Note: Sidebox must be turned off separately', E'5', E'50', E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Customer Shop Status - View Shop and Prices', E'CUSTOMERS_APPROVAL', E'0', E'Customer must be approved to shop<br />0= Not required<br />1= Must login to browse<br />2= May browse but no prices unless logged in<br />3= Showroom Only<br /><br />It is recommended that Option 2 be used for the purposes of Spiders if you wish customers to login to see prices.', E'5', E'55', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\', \'3\'), ', now());
 

--customer approval to shop
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Customer Approval Status - Authorization Pending', E'CUSTOMERS_APPROVAL_AUTHORIZATION', E'0', E'Customer must be Authorized to shop<br />0= Not required<br />1= Must be Authorized to Browse<br />2= May browse but no prices unless Authorized<br />3= Customer May Browse and May see Prices but Must be Authorized to Buy<br /><br />It is recommended that Option 2 or 3 be used for the purposes of Spiders', E'5', E'65', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\', \'3\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, use_function) VALUES (E'Customer Authorization: filename', E'CUSTOMERS_AUTHORIZATION_FILENAME', E'customers_authorization', E'Customer Authorization filename<br />Note: Do not include the extension<br />Default=customers_authorization', E'5', E'66', E'', now(), NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, use_function) VALUES (E'Customer Authorization: Hide Header', E'CUSTOMERS_AUTHORIZATION_HEADER_OFF', E'false', E'Customer Authorization: Hide Header <br />(true=hide false=show)', E'5', E'67', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now(), NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, use_function) VALUES (E'Customer Authorization: Hide Column Left', E'CUSTOMERS_AUTHORIZATION_COLUMN_LEFT_OFF', E'false', E'Customer Authorization: Hide Column Left <br />(true=hide false=show)', E'5', E'68', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now(), NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, use_function) VALUES (E'Customer Authorization: Hide Column Right', E'CUSTOMERS_AUTHORIZATION_COLUMN_RIGHT_OFF', E'false', E'Customer Authorization: Hide Column Right <br />(true=hide false=show)', E'5', E'69', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now(), NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, use_function) VALUES (E'Customer Authorization: Hide Footer', E'CUSTOMERS_AUTHORIZATION_FOOTER_OFF', E'false', E'Customer Authorization: Hide Footer <br />(true=hide false=show)', E'5', E'70', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now(), NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, use_function) VALUES (E'Customer Authorization: Hide Prices', E'CUSTOMERS_AUTHORIZATION_PRICES_OFF', E'false', E'Customer Authorization: Hide Prices <br />(true=hide false=show)', E'5', E'71', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now(), NULL);
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Customers Referral Status', E'CUSTOMERS_REFERRAL_STATUS', E'0', E'Customers Referral Code is created from<br />0= Off<br />1= 1st Discount Coupon Code used<br />2= Customer can add during create account or edit if blank<br /><br />NOTE: Once the Customers Referral Code has been set it can only be changed in the Admin Customer', E'5', E'80', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Installed Modules', E'MODULE_PAYMENT_INSTALLED', E'cc.php;freecharger.php;moneyorder.php', E'List of payment module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: cc.php;cod.php;paypal.php)', E'6', E'0', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Installed Modules', E'MODULE_ORDER_TOTAL_INSTALLED', E'ot_subtotal.php;ot_shipping.php;ot_coupon.php;ot_group_pricing.php;ot_tax.php;ot_loworderfee.php;ot_gv.php;ot_total.php', E'List of order_total module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: ot_subtotal.php;ot_tax.php;ot_shipping.php;ot_total.php)', E'6', E'0', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Installed Modules', E'MODULE_SHIPPING_INSTALLED', E'flat.php;freeshipper.php;item.php;storepickup.php', E'List of shipping module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: ups.php;flat.php;item.php)', E'6', E'0', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Enable Credit Card Module', E'MODULE_PAYMENT_CC_STATUS', E'True', E'Do you want to accept credit card payments?', E'6', E'0', E'zen_cfg_select_option(array(\'True\', \'False\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Split Credit Card E-Mail Address', E'MODULE_PAYMENT_CC_EMAIL', E'', E'If an e-mail address is entered, the middle digits of the credit card number will be sent to the e-mail address (the outside digits are stored in the database with the middle digits censored)', E'6', E'0', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Collect & store the CVV number', E'MODULE_PAYMENT_CC_COLLECT_CVV', E'False', E'Do you want to collect the CVV number. Note: If you do the CVV number will be stored in the database in an encoded format.', 6, 0, NULL, E'2004-01-11 22:55:51', NULL, E'zen_cfg_select_option(array(\'True\', \'False\'),');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Store the Credit Card Number', E'MODULE_PAYMENT_CC_STORE_NUMBER', E'False', E'Do you want to store the Credit Card Number. Note: The Credit Card Number will be stored unenecrypted, and as such may represent a security problem', 6, 0, NULL, now(), NULL, 'zen_cfg_select_option(array(\'True\', \'False\'),');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Sort order of display.', E'MODULE_PAYMENT_CC_SORT_ORDER', E'0', E'Sort order of display. Lowest is displayed first.', E'6', '0' , now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (E'Payment Zone', E'MODULE_PAYMENT_CC_ZONE', E'0', E'If a zone is selected, only enable this payment method for that zone.', E'6', E'2', E'zen_get_zone_class_title', E'zen_cfg_pull_down_zone_classes(', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, use_function, date_added) VALUES (E'Set Order Status', E'MODULE_PAYMENT_CC_ORDER_STATUS_ID', E'0', E'Set the status of orders made with this payment module to this value', E'6', E'0', E'zen_cfg_pull_down_order_statuses(', E'zen_get_order_status_name', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Enable Free Shipping', E'MODULE_SHIPPING_FREESHIPPER_STATUS', E'True', E'Do you want to offer Free shipping?', 6, 0, now(), NULL, 'zen_cfg_select_option(array(\'True\', \'False\'), ');
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Free Shipping Cost', E'MODULE_SHIPPING_FREESHIPPER_COST', E'0.00', E'What is the Shipping cost?', 6, 6, now(), NULL, NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Handling Fee', E'MODULE_SHIPPING_FREESHIPPER_HANDLING', E'0', E'Handling fee for this shipping method.', 6, 0, now(), NULL, NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Tax Class', E'MODULE_SHIPPING_FREESHIPPER_TAX_CLASS', E'0', E'Use the following tax class on the shipping fee.', 6, 0, now(), 'zen_get_tax_class_title', 'zen_cfg_pull_down_tax_classes(');


INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Shipping Zone', E'MODULE_SHIPPING_FREESHIPPER_ZONE', E'0', E'If a zone is selected, only enable this shipping method for that zone.', 6, 0, now(), 'zen_get_zone_class_title', 'zen_cfg_pull_down_zone_classes(');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Sort Order', E'MODULE_SHIPPING_FREESHIPPER_SORT_ORDER', E'0', E'Sort order of display.', 6, 0, now(), NULL, NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Enable Store Pickup Shipping', E'MODULE_SHIPPING_STOREPICKUP_STATUS', E'True', E'Do you want to offer In Store rate shipping?', 6, 0, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (array(\'True\', \'False\'), ');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Shipping Cost', E'MODULE_SHIPPING_STOREPICKUP_COST', E'0.00', E'The shipping cost for all orders using this shipping method.', 6, 0, now(), NULL, NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Tax Class', E'MODULE_SHIPPING_STOREPICKUP_TAX_CLASS', E'0', E'Use the following tax class on the shipping fee.', 6, 0, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Tax Basis', E'MODULE_SHIPPING_STOREPICKUP_TAX_BASIS', E'Shipping', E'On what basis is Shipping Tax calculated. Options are<br />Shipping - Based on customers Shipping Address<br />Billing Based on customers Billing address<br />Store - Based on Store address if Billing/Shipping Zone equals Store zone', 6, 0, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (array(\'Shipping\', \'Billing\'), ');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Shipping Zone', E'MODULE_SHIPPING_STOREPICKUP_ZONE', E'0', E'If a zone is selected, only enable this shipping method for that zone.', 6, 0, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Sort Order', E'MODULE_SHIPPING_STOREPICKUP_SORT_ORDER', E'0', E'Sort order of display.', 6, 0, now(), NULL, NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Enable Item Shipping', E'MODULE_SHIPPING_ITEM_STATUS', E'True', E'Do you want to offer per item rate shipping?', 6, 0, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (array(\'True\', \'False\'), ');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Shipping Cost', E'MODULE_SHIPPING_ITEM_COST', E'2.50', E'The shipping cost will be multiplied by the number of items in an order that uses this shipping method.', 6, 0, now(), NULL, NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Handling Fee', E'MODULE_SHIPPING_ITEM_HANDLING', E'0', E'Handling fee for this shipping method.', 6, 0, now(), NULL, NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Tax Class', E'MODULE_SHIPPING_ITEM_TAX_CLASS', E'0', E'Use the following tax class on the shipping fee.', 6, 0, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Tax Basis', E'MODULE_SHIPPING_ITEM_TAX_BASIS', E'Shipping', E'On what basis is Shipping Tax calculated. Options are<br />Shipping - Based on customers Shipping Address<br />Billing Based on customers Billing address<br />Store - Based on Store address if Billing/Shipping Zone equals Store zone', 6, 0, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (array(\'Shipping\', \'Billing\', \'Store\'), ');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Shipping Zone', E'MODULE_SHIPPING_ITEM_ZONE', E'0', E'If a zone is selected, only enable this shipping method for that zone.', 6, 0, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Sort Order', E'MODULE_SHIPPING_ITEM_SORT_ORDER', E'0', E'Sort order of display.', 6, 0, now(), NULL, NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Enable Free Charge Module', E'MODULE_PAYMENT_FREECHARGER_STATUS', E'True', E'Do you want to accept Free Charge payments?', 6, 1, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (array(\'True\', \'False\'), ');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Sort order of display.', E'MODULE_PAYMENT_FREECHARGER_SORT_ORDER', E'0', E'Sort order of display. Lowest is displayed first.', 6, 0, now(), NULL, NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Payment Zone', E'MODULE_PAYMENT_FREECHARGER_ZONE', E'0', E'If a zone is selected, only enable this payment method for that zone.', 6, 2, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Set Order Status', E'MODULE_PAYMENT_FREECHARGER_ORDER_STATUS_ID', E'0', E'Set the status of orders made with this payment module to this value', 6, 0, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Enable Check/Money Order Module', E'MODULE_PAYMENT_MONEYORDER_STATUS', E'True', E'Do you want to accept Check/Money Order payments?', 6, 1, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (array(\'True\', \'False\'), ');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Make Payable to:', E'MODULE_PAYMENT_MONEYORDER_PAYTO', E'the Store Owner/Website Name', E'Who should payments be made payable to?', 6, 1, now(), NULL, NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Sort order of display.', E'MODULE_PAYMENT_MONEYORDER_SORT_ORDER', E'0', E'Sort order of display. Lowest is displayed first.', 6, 0, now(), NULL, NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Payment Zone', E'MODULE_PAYMENT_MONEYORDER_ZONE', E'0', E'If a zone is selected, only enable this payment method for that zone.', 6, 2, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Set Order Status', E'MODULE_PAYMENT_MONEYORDER_ORDER_STATUS_ID', E'0', E'Set the status of orders made with this payment module to this value', 6, 0, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Include Tax', E'MODULE_ORDER_TOTAL_GROUP_PRICING_INC_TAX', E'false', E'Include Tax value in amount before discount calculation?', 6, 6, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (array(\'true\', \'false\'), ');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'This module is installed', E'MODULE_ORDER_TOTAL_GROUP_PRICING_STATUS', E'true', E'', 6, 1, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (array(\'true\'), ');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Sort Order', E'MODULE_ORDER_TOTAL_GROUP_PRICING_SORT_ORDER', E'290', E'Sort order of display.', 6, 2, now(), NULL, NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Include Shipping', E'MODULE_ORDER_TOTAL_GROUP_PRICING_INC_SHIPPING', E'false', E'Include Shipping value in amount before discount calculation?', 6, 5, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (array(\'true\', \'false\'), ');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Re-calculate Tax', E'MODULE_ORDER_TOTAL_GROUP_PRICING_CALC_TAX', E'Standard', E'Re-Calculate Tax', 6, 7, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (array(\'None\', \'Standard\', \'Credit Note\'), ');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (E'Tax Class', E'MODULE_ORDER_TOTAL_GROUP_PRICING_TAX_CLASS', E'0', E'Use the following tax class when treating Group Discount as Credit Note.', 6, 0, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function, set_function) VALUES (');


INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Enable Flat Shipping', E'MODULE_SHIPPING_FLAT_STATUS', E'True', E'Do you want to offer flat rate shipping?', E'6', E'0', E'zen_cfg_select_option(array(\'True\', \'False\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Shipping Cost', E'MODULE_SHIPPING_FLAT_COST', E'5.00', E'The shipping cost for all orders using this shipping method.', E'6', E'0', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (E'Tax Class', E'MODULE_SHIPPING_FLAT_TAX_CLASS', E'0', E'Use the following tax class on the shipping fee.', E'6', E'0', E'zen_get_tax_class_title', E'zen_cfg_pull_down_tax_classes(', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Tax Basis', E'MODULE_SHIPPING_FLAT_TAX_BASIS', E'Shipping', E'On what basis is Shipping Tax calculated. Options are<br />Shipping - Based on customers Shipping Address<br />Billing Based on customers Billing address<br />Store - Based on Store address if Billing/Shipping Zone equals Store zone', E'6', E'0', E'zen_cfg_select_option(array(\'Shipping\', \'Billing\', \'Store\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (E'Shipping Zone', E'MODULE_SHIPPING_FLAT_ZONE', E'0', E'If a zone is selected, only enable this shipping method for that zone.', E'6', E'0', E'zen_get_zone_class_title', E'zen_cfg_pull_down_zone_classes(', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Sort Order', E'MODULE_SHIPPING_FLAT_SORT_ORDER', E'0', E'Sort order of display.', E'6', E'0', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Default Currency', E'DEFAULT_CURRENCY', E'USD', E'Default Currency', E'6', E'0', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Default Language', E'DEFAULT_LANGUAGE', E'en', E'Default Language', E'6', E'0', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Default Order Status For New Orders', E'DEFAULT_ORDERS_STATUS_ID', E'1', E'When a new order is created, this order status will be assigned to it.', E'6', E'0', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Admin configuration_key shows', E'ADMIN_CONFIGURATION_KEY_ON', E'0', E'Manually switch to value of 1 to see the configuration_key name in configuration displays', E'6', E'0', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (E'Country of Origin', E'SHIPPING_ORIGIN_COUNTRY', E'223', E'Select the country of origin to be used in shipping quotes.', E'7', E'1', E'zen_get_country_name', E'zen_cfg_pull_down_country_list(', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Postal Code', E'SHIPPING_ORIGIN_ZIP', E'NONE', E'Enter the Postal Code (ZIP) of the Store to be used in shipping quotes. NOTE: For USA zip codes, only use your 5 digit zip code.', E'7', E'2', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Enter the Maximum Package Weight you will ship', E'SHIPPING_MAX_WEIGHT', E'50', E'Carriers have a max weight limit for a single package. This is a common one for all.', E'7', E'3', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Package Tare Small to Medium - added percentage:weight', E'SHIPPING_BOX_WEIGHT', E'0:3', E'What is the weight of typical packaging of small to medium packages?<br />Example: 10% + 1lb 10:1<br />10% + 0lbs 10:0<br />0% + 5lbs 0:5<br />0% + 0lbs 0:0', E'7', E'4', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Larger packages - added packaging percentage:weight', E'SHIPPING_BOX_PADDING', E'10:0', E'What is the weight of typical packaging for Large packages?<br />Example: 10% + 1lb 10:1<br />10% + 0lbs 10:0<br />0% + 5lbs 0:5<br />0% + 0lbs 0:0', E'7', E'5', now());
 


-- moved to product_types
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Product Virtual Default Status - Skip Shipping Address', 'PRODUCTS_VIRTUAL_DEFAULT', '0', 'What should the Default Virtual Product status be when adding new products?<br /><br />0= Virtual Product Defaults to OFF<br />1= Virtual Product Defaults to ON<br />NOTE: Virtual Products do not require a Shipping Address', '7', '10', 'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Product Free Shipping Default Status - Normal Shipping Rules', 'PRODUCTS_IS_ALWAYS_FREE_SHIPPING_DEFAULT', '0', 'What should the Default Free Shipping status be when adding new products?<br /><br />0= Free Shipping Defaults to OFF<br />1= Free Shipping Defaults to ON<br />NOTE: Free Shipping Products require a Shipping Address', '7', '11', 'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Display Number of Boxes and Weight Status', E'SHIPPING_BOX_WEIGHT_DISPLAY', E'3', E'Display Shipping Weight and Number of Boxes?<br /><br />0= off<br />1= Boxes Only<br />2= Weight Only<br />3= Both Boxes and Weight', E'7', E'15', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\', \'3\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Shipping Estimator Display Settings for Shopping Cart', E'SHOW_SHIPPING_ESTIMATOR_BUTTON', E'1', E'<br />0= Off<br />1= Display as Button on Shopping Cart<br />2= Display as Listing on Shopping Cart Page', E'7', E'20', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\'), ', now());
 


INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Order Free Shipping 0 Weight Status', E'ORDER_WEIGHT_ZERO_STATUS', E'0', E'If there is no weight to the order, does the order have Free Shipping?<br />0= no<br />1= yes<br /><br />Note: When using Free Shipping, Enable the Free Shipping Module this will only show when shipping is free.', E'7', E'15', E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Image', E'PRODUCT_LIST_IMAGE', E'1', E'Do you want to display the Product Image?', E'8', E'1', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Manufacturer Name',E'PRODUCT_LIST_MANUFACTURER', E'0', E'Do you want to display the Product Manufacturer Name?', E'8', E'2', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Model', E'PRODUCT_LIST_MODEL', E'0', E'Do you want to display the Product Model?', E'8', E'3', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Name', E'PRODUCT_LIST_NAME', E'2', E'Do you want to display the Product Name?', E'8', E'4', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Price/Add to Cart', E'PRODUCT_LIST_PRICE', E'3', E'Do you want to display the Product Price/Add to Cart', E'8', E'5', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Quantity', E'PRODUCT_LIST_QUANTITY', E'0', E'Do you want to display the Product Quantity?', E'8', E'6', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Weight', E'PRODUCT_LIST_WEIGHT', E'0', E'Do you want to display the Product Weight?', E'8', E'7', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Price/Add to Cart Column Width', E'PRODUCTS_LIST_PRICE_WIDTH', E'125', E'Define the width of the Price/Add to Cart column<br />Default= 125', E'8', E'8', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Display Category/Manufacturer Filter (0=off; 1=on)', E'PRODUCT_LIST_FILTER', E'1', E'Do you want to display the Category/Manufacturer Filter?', E'8', E'9', E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Prev/Next Split Page Navigation (1-top, 2-bottom, 3-both)', E'PREV_NEXT_BAR_LOCATION', E'3', E'Sets the location of the Prev/Next Split Page Navigation', E'8', E'10', E'zen_cfg_select_option(array(\'1\', \'2\', \'3\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Listing Default Sort Order', E'PRODUCT_LISTING_DEFAULT_SORT_ORDER', E'', E'Product Listing Default sort order?<br />NOTE: Leave Blank for Product Sort Order. Sort the Product Listing in the order you wish for the default display to start in to get the sort order setting. Example: 2a', E'8', E'15', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Display Product Add to Cart Button (0=off; 1=on; 2=on with Qty Box per Product)', E'PRODUCT_LIST_PRICE_BUY_NOW', E'1', E'Do you want to display the Add to Cart Button?<br /><br /><strong>NOTE:</strong> Turn OFF Display Multiple Products Qty Box Status to use Option 2 on with Qty Box per Product', E'8', E'20', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Display Multiple Products Qty Box Status and Set Button Location', E'PRODUCT_LISTING_MULTIPLE_ADD_TO_CART', E'3', E'Do you want to display Add Multiple Products Qty Box and Set Button Location?<br />0= off<br />1= Top<br />2= Bottom<br />3= Both', E'8', E'25', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\', \'3\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Description', E'PRODUCT_LIST_DESCRIPTION', E'150', E'Do you want to display the Product Description?<br /><br />0= OFF<br />150= Suggested Length, or enter the maximum number of characters to display', E'8', E'30', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Product Listing Ascending Sort Order', E'PRODUCT_LIST_SORT_ORDER_ASCENDING', E'+', E'What do you want to use to indicate Sort Order Ascending?<br />Default = +', 8, 40, NULL, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Product Listing Descending Sort Order', E'PRODUCT_LIST_SORT_ORDER_DESCENDING', E'-', E'What do you want to use to indicate Sort Order Descending?<br />Default = -', 8, 41, NULL, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (');


INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Include Product Listing Alpha Sorter  --DROPdown', E'PRODUCT_LIST_ALPHA_SORTER', E'true', E'Do you want to include an Alpha Filter  --DROPdown on the Product Listing?', E'8', E'50', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Include Product Listing Sub Categories Image', E'PRODUCT_LIST_CATEGORIES_IMAGE_STATUS', E'true', E'Do you want to include the Sub Categories Image on the Product Listing?', E'8', E'52', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Include Product Listing Top Categories Image', E'PRODUCT_LIST_CATEGORIES_IMAGE_STATUS_TOP', E'true', E'Do you want to include the Top Categories Image on the Product Listing?', E'8', E'53', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Show SubCategories on Main Page while navigating', E'PRODUCT_LIST_CATEGORY_ROW_STATUS', E'1', E'Show Sub-Categories on Main Page while navigating through Categories<br /><br />0= off<br />1= on', E'8', E'60', E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Check stock level', E'STOCK_CHECK', E'true', E'Check to see if sufficent stock is available', E'9', E'1', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Subtract stock', E'STOCK_LIMITED', E'true', E'Subtract product in stock by product orders', E'9', E'2', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Allow Checkout', E'STOCK_ALLOW_CHECKOUT', E'true', E'Allow customer to checkout even if there is insufficient stock', E'9', E'3', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Mark product out of stock', E'STOCK_MARK_PRODUCT_OUT_OF_STOCK', E'***', E'Display something on screen so customer can see which product has insufficient stock', E'9', E'4', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Stock Re-order level', E'STOCK_REORDER_LEVEL', E'5', E'Define when stock needs to be re-ordered', E'9', E'5', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Products status in Catalog when out of stock should be set to', E'SHOW_PRODUCTS_SOLD_OUT', E'0', E'Show Products when out of stock<br /><br />0= set product status to OFF<br />1= leave product status ON', E'9', E'10', E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Show Sold Out Image in place of Add to Cart', E'SHOW_PRODUCTS_SOLD_OUT_IMAGE', E'1', E'Show Sold Out Image instead of Add to Cart Button<br /><br />0= off<br />1= on', E'9', E'11', E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Product Quantity Decimals', E'QUANTITY_DECIMALS', E'0', E'Allow how many decimals on Quantity<br /><br />0= off', E'9', E'15', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\', \'3\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Show Shopping Cart - Delete Checkboxes or Delete Button', E'SHOW_SHOPPING_CART_DELETE', E'3', E'Show on Shopping Cart Delete Button and/or Checkboxes<br /><br />1= Delete Button Only<br />2= Checkbox Only<br />3= Both Delete Button and Checkbox', E'9', E'20', E'zen_cfg_select_option(array(\'1\', \'2\', \'3\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Show Shopping Cart - Update Cart Button Location', E'SHOW_SHOPPING_CART_UPDATE', E'3', E'Show on Shopping Cart Update Cart Button Location as:<br /><br />1= Next to each Qty Box<br />2= Below all Products<br />3= Both Next to each Qty Box and Below all Products', E'9', E'22', E'zen_cfg_select_option(array(\'1\', \'2\', \'3\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Show New Products on empty Shopping Cart Page', E'SHOW_SHOPPING_CART_EMPTY_NEW_PRODUCTS', E'1', E'Show New Products on empty Shopping Cart Page<br />0= off or set the sort order', E'9', E'30', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\', \'3\', \'4\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Show Featured Products on empty Shopping Cart Page', E'SHOW_SHOPPING_CART_EMPTY_FEATURED_PRODUCTS', E'2', E'Show Featured Products on empty Shopping Cart Page<br />0= off or set the sort order', E'9', E'31', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\', \'3\', \'4\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Show Special Products on empty Shopping Cart Page', E'SHOW_SHOPPING_CART_EMPTY_SPECIALS_PRODUCTS', E'3', E'Show Special Products on empty Shopping Cart Page<br />0= off or set the sort order', E'9', E'32', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\', \'3\', \'4\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Show Upcoming Products on empty Shopping Cart Page', E'SHOW_SHOPPING_CART_EMPTY_UPCOMING', E'4', E'Show Upcoming Products on empty Shopping Cart Page<br />0= off or set the sort order', E'9', E'33', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\', \'3\', \'4\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Store Page Parse Time', E'STORE_PAGE_PARSE_TIME', E'false', E'Store the time it takes to parse a page', E'10', E'1', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Log Destination', E'STORE_PAGE_PARSE_TIME_LOG', E'/var/log/www/zen/page_parse_time.log', E'Directory and filename of the page parse time log', E'10', E'2', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Log Date Format', E'STORE_PARSE_DATE_TIME_FORMAT', E'%d/%m/%Y %H:%M:%S', E'The date format', E'10', E'3', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Display The Page Parse Time', E'DISPLAY_PAGE_PARSE_TIME', E'false', E'Display the page parse time on the bottom of each page<br />You do not need to store the times to display them in the Catalog', E'10', E'4', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Store Database Queries', E'STORE_DB_TRANSACTIONS', E'false', E'Store the database queries in the page parse time log (PHP4 only)', E'10', E'5', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'E-Mail Transport Method', E'EMAIL_TRANSPORT', E'PHP', E'Defines the method for sending mail.<br /><strong>PHP</strong> is the default, and uses built-in PHP wrappers for processing.<br />Servers running on Windows and MacOS should change this setting to <strong>SMTP</strong>.<br /><br /><strong>SMTPAUTH</strong> should only be used if your server requires SMTP authorization to send messages. You must also configure your SMTPAUTH settings in the appropriate fields in this admin section.<br /><br /><strong>sendmail</strong> is for linux/unix hosts using the sendmail program on the server<br /><strong>sendmail-f</strong> is only for servers which require the use of the -f parameter to send mail. This is a security setting often used to prevent spoofing. Will cause errors if your host mailserver is not configured to use it.<br /><br /><strong>Qmail</strong> is used for linux/unix hosts running Qmail as sendmail wrapper at /var/qmail/bin/sendmail.', E'12', E'1', E'zen_cfg_select_option(array(\'PHP\', \'sendmail\', \'sendmail-f\', \'smtp\', \'smtpauth\', \'Qmail\'),', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'SMTP Email Account Mailbox', E'EMAIL_SMTPAUTH_MAILBOX', E'YourEmailAccountNameHere', E'Enter the mailbox account name (me@mydomain.com) supplied by your host. This is the account name that your host requires for SMTP authentication.<br />Only required if using SMTP Authentication for email.', E'12', E'101', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'SMTP Email Account Password', E'EMAIL_SMTPAUTH_PASSWORD', E'YourPasswordHere', E'Enter the password for your SMTP mailbox. <br />Only required if using SMTP Authentication for email.', E'12', E'101', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'SMTP Email Mail Host', E'EMAIL_SMTPAUTH_MAIL_SERVER', E'mail.EnterYourDomain.com', E'Enter the DNS name of your SMTP mail server.<br />ie: mail.mydomain.com<br />or 55.66.77.88<br />Only required if using SMTP Authentication for email.', E'12', E'101', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'SMTP Email Mail Server Port', E'EMAIL_SMTPAUTH_MAIL_SERVER_PORT', E'25', E'Enter the IP port number that your SMTP mailserver operates on.<br />Only required if using SMTP Authentication for email.', E'12', E'101', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Convert currencies for Text emails', E'CURRENCIES_TRANSLATIONS', E'&pound;,\xA3:&euro;,\x80', E'What currency conversions do you need for Text emails?<br />Default = &amp;pound;,\xA3:&amp;euro;,\x80', 12, 120, NULL, E'2003-11-21 00:00:00', NULL, E'zen_cfg_textarea_small(');
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'E-Mail Linefeeds', E'EMAIL_LINEFEED', E'LF', E'Defines the character sequence used to separate mail headers.', E'12', E'2', E'zen_cfg_select_option(array(\'LF\', \'CRLF\'),', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Use MIME HTML When Sending Emails', E'EMAIL_USE_HTML', E'false', E'Send e-mails in HTML format', E'12', E'3', E'zen_cfg_select_option(array(\'true\', \'false\'),', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Verify E-Mail Addresses Through DNS', E'ENTRY_EMAIL_ADDRESS_CHECK', E'false', E'Verify e-mail address through a DNS server', E'12', E'6', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Send E-Mails', E'SEND_EMAILS', E'true', E'Send out e-mails', E'12', E'5', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Email Archiving Active?', E'EMAIL_ARCHIVE', E'false', E'If you wish to have email messages archived/stored when sent, set this to true.', E'12', E'6', E'zen_cfg_select_option(array(\'true\', \'false\'),', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'E-Mail Friendly-Errors', E'EMAIL_FRIENDLY_ERRORS', E'false', E'Do you want to display friendly errors if emails fail? Setting this to false will display PHP errors and likely cause the script to fail. Only set to false while troubleshooting, and true for a live shop.', E'12', E'7', E'zen_cfg_select_option(array(\'true\', \'false\'),', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Email Address (Displayed to Contact you)', E'STORE_OWNER_EMAIL_ADDRESS', E'root@localhost', E'Email address of Store Owner. Used as display only when informing customers of how to contact you.', E'12', E'10', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Email Address (sent FROM)', E'EMAIL_FROM', E'Zen Cart <root@localhost>', E'Address from which email messages will be sent by default. Can be over-ridden at compose-time in admin modules.', E'12', E'11', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function) VALUES (E'Emails must send from known domain?', E'EMAIL_SEND_MUST_BE_STORE', E'No', E'Does your mailserver require that all outgoing emails have their from address match a known domain that exists on your webserver?<br /><br />This is often set in order to prevent spoofing and spam broadcasts. If set to Yes, this will cause the email address (sent FROM) to be used as the from address on all outgoing mail.', 12, 11, NULL, E'zen_cfg_select_option(array(\'No\', \'Yes\'), ');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function) VALUES (E'Email Admin Format?', E'ADMIN_EXTRA_EMAIL_FORMAT', E'TEXT', E'Please select the Admin extra email format', 12, 12, NULL, E'zen_cfg_select_option(array(\'TEXT\', \'HTML\'), ');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Send Copy of Order Confirmation Emails To', E'SEND_EXTRA_ORDER_EMAILS_TO', E'', E'Send COPIES of order confirmation emails to the following email addresses, in this format: Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;', E'12', E'12', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Send Copy of Create Account Emails To - Status', E'SEND_EXTRA_CREATE_ACCOUNT_EMAILS_TO_STATUS', E'0', E'Send copy of Create Account Status<br />0= off 1= on', E'12', E'13', E'zen_cfg_select_option(array(\'0\', \'1\'),', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Send Copy of Create Account Emails To', E'SEND_EXTRA_CREATE_ACCOUNT_EMAILS_TO', E'', E'Send copy of Create Account emails to the following email addresses, in this format: Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;', E'12', E'14', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Send Copy of Tell a Friend Emails To - Status', E'SEND_EXTRA_TELL_A_FRIEND_EMAILS_TO_STATUS', E'0', E'Send copy of Tell a Friend Status<br />0= off 1= on', E'12', E'15', E'zen_cfg_select_option(array(\'0\', \'1\'),', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Send Copy of Tell a Friend Emails To', E'SEND_EXTRA_TELL_A_FRIEND_EMAILS_TO', E'', E'Send copy of Tell a Friend emails to the following email addresses, in this format: Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;', E'12', E'16', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Send Copy of Customer GV Send Emails To - Status', E'SEND_EXTRA_GV_CUSTOMER_EMAILS_TO_STATUS', E'0', E'Send copy of Customer GV Send Status<br />0= off 1= on', E'12', E'17', E'zen_cfg_select_option(array(\'0\', \'1\'),', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Send Copy of Customer GV Send Emails To', E'SEND_EXTRA_GV_CUSTOMER_EMAILS_TO', E'', E'Send copy of Customer GV Send emails to the following email addresses, in this format: Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;', E'12', E'18', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Send Copy of Admin GV Mail Emails To - Status', E'SEND_EXTRA_GV_ADMIN_EMAILS_TO_STATUS', E'0', E'Send copy of Admin GV Mail Status<br />0= off 1= on', E'12', E'19', E'zen_cfg_select_option(array(\'0\', \'1\'),', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Send Copy of Customer Admin GV Mail Emails To', E'SEND_EXTRA_GV_ADMIN_EMAILS_TO', E'', E'Send copy of Admin GV Mail emails to the following email addresses, in this format: Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;', E'12', E'20', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Send Copy of Admin Discount Coupon Mail Emails To - Status', E'SEND_EXTRA_DISCOUNT_COUPON_ADMIN_EMAILS_TO_STATUS', E'0', E'Send copy of Admin Discount Coupon Mail Status<br />0= off 1= on', E'12', E'21', E'zen_cfg_select_option(array(\'0\', \'1\'),', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Send Copy of Customer Admin Discount Coupon Mail Emails To', E'SEND_EXTRA_DISCOUNT_COUPON_ADMIN_EMAILS_TO', E'', E'Send copy of Admin Discount Coupon Mail emails to the following email addresses, in this format: Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;', E'12', E'22', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Send Copy of Admin Orders Status Emails To - Status', E'SEND_EXTRA_ORDERS_STATUS_ADMIN_EMAILS_TO_STATUS', E'0', E'Send copy of Admin Orders Status Status<br />0= off 1= on', E'12', E'23', E'zen_cfg_select_option(array(\'0\', \'1\'),', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Send Copy of Admin Orders Status Emails To', E'SEND_EXTRA_ORDERS_STATUS_ADMIN_EMAILS_TO', E'', E'Send copy of Admin Orders Status emails to the following email addresses, in this format: Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;', E'12', E'24', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Send Notice of Pending Reviews Emails To - Status', E'SEND_EXTRA_REVIEW_NOTIFICATION_EMAILS_TO_STATUS', E'0', E'Send copy of Pending Reviews Status<br />0= off 1= on', E'12', E'25', E'zen_cfg_select_option(array(\'0\', \'1\'),', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Send Notice of Pending Reviews Emails To', E'SEND_EXTRA_REVIEW_NOTIFICATION_EMAILS_TO', E'', E'Send copy of Pending Reviews emails to the following email addresses, in this format: Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;', E'12', E'26', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Set Contact Us Email  --DROPdown List', E'CONTACT_US_LIST', E'', E'On the Contact Us Page, set the list of email addresses , in this format: Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;', E'12', E'40', E'zen_cfg_textarea(', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Allow Guest To Tell A Friend', E'ALLOW_GUEST_TO_TELL_A_FRIEND', E'false', E'Allow guests to tell a friend about a product. <br />If set to [false], then tell-a-friend will prompt for login if user is not already logged in.', E'12', E'50', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Contact Us - Show Store Name and Address', E'CONTACT_US_STORE_NAME_ADDRESS', E'1', E'Include Store Name and Address<br />0= off 1= on', E'12', E'50', E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Send Low Stock Emails', E'SEND_LOWSTOCK_EMAIL', E'0', E'When stock level is at or below low stock level send an email<br />0= off<br />1= on', E'12', E'60', now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (array(\'0\', \'1\'),');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Send Low Stock Emails To', E'SEND_EXTRA_LOW_STOCK_EMAILS_TO', E'', E'When stock level is at or below low stock level send an email to this address, in this format: Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;', E'12', E'61', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Display Newsletter Unsubscribe Link?', E'SHOW_NEWSLETTER_UNSUBSCRIBE_LINK', E'true', E'Show Newsletter Unsubscribe link in the Information side-box?', E'12', E'70', E'zen_cfg_select_option(array(\'true\', \'false\'),', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Audience-Select Count Display', E'AUDIENCE_SELECT_DISPLAY_COUNTS', E'true', E'When displaying lists of available audiences/recipients, should the recipients-count be included? <br /><em>(This may make things slower if you have a lot of customers or complex audience queries)</em>', E'12', E'90', E'zen_cfg_select_option(array(\'true\', \'false\'),', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Enable Downloads', E'DOWNLOAD_ENABLED', E'true', E'Enable the products download functions.', E'13', E'1', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Download by Redirect', E'DOWNLOAD_BY_REDIRECT', E'true', E'Use browser redirection for download. Disable on non-Unix systems.<br /><br />Note: Set /pub to 777 when redirect is true', E'13', E'2', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Download by streaming', E'DOWNLOAD_IN_CHUNKS', E'false', E'If download-by-redirect is disabled, and your PHP memory_limit setting is under 8 MB, you might need to enable this setting so that files are streamed in smaller segments to the browser.<br /><br />Has no effect if Download By Redirect is enabled.', E'13', E'2', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Download Expiration (Number of Days)' ,'DOWNLOAD_MAX_DAYS', E'7', E'Set number of days before the download link expires. 0 means no limit.', E'13', E'3', E'', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Number of Downloads Allowed - Per Product' ,'DOWNLOAD_MAX_COUNT', E'5', E'Set the maximum number of downloads. 0 means no download authorized.', E'13', E'4', E'', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Downloads Controller Update Status Value', E'DOWNLOADS_ORDERS_STATUS_UPDATED_VALUE', E'4', E'What orders_status resets the Download days and Max Downloads - Default is 4', E'13', E'10', now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Downloads Controller Order Status Value >= lower value', E'DOWNLOADS_CONTROLLER_ORDERS_STATUS', E'2', E'Downloads Controller Order Status Value - Default >= 2<br /><br />Downloads are available for checkout based on the orders status. Orders with orders status greater than this value will be available for download. The orders status is set for an order by the Payment Modules. Set the lower range for this range.', E'13', E'12', now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Downloads Controller Order Status Value <= upper value', E'DOWNLOADS_CONTROLLER_ORDERS_STATUS_END', E'4', E'Downloads Controller Order Status Value - Default <= 4<br /><br />Downloads are available for checkout based on the orders status. Orders with orders status less than this value will be available for download. The orders status is set for an order by the Payment Modules. Set the upper range for this range.', E'13', E'13', now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();


INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Enable Price Factor', E'ATTRIBUTES_ENABLED_PRICE_FACTOR', E'true', E'Enable the Attributes Price Factor.', E'13', E'25', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Enable Qty Price Discount', E'ATTRIBUTES_ENABLED_QTY_PRICES', E'true', E'Enable the Attributes Quantity Price Discounts.', E'13', E'26', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Enable Attribute Images', E'ATTRIBUTES_ENABLED_IMAGES', E'true', E'Enable the Attributes Images.', E'13', E'28', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Enable Text Pricing by word or letter', E'ATTRIBUTES_ENABLED_TEXT_PRICES', E'true', E'Enable the Attributes Text Pricing by word or letter.', E'13', E'35', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Text Pricing - Spaces are Free', E'TEXT_SPACES_FREE', E'1', E'On Text pricing Spaces are Free<br /><br />0= off 1= on', E'13', E'36', E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Read Only option type - Ignore for Add to Cart', E'PRODUCTS_OPTIONS_TYPE_READONLY_IGNORED', E'1', E'When a Product only uses READONLY attributes, should the Add to Cart button be On or Off?<br />0= OFF<br />1= ON', E'13', E'37', E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 



INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Enable GZip Compression', E'GZIP_LEVEL', E'0', E'0= off 1= on', E'14', E'1', E'zen_cfg_select_option(array(\'0\', \'1\'),', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Session Directory', E'SESSION_WRITE_DIRECTORY', E'/tmp', E'If sessions are file based, store them in this directory.', E'15', E'1', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Cookie Domain', E'SESSION_USE_FQDN', E'True', E'If True the full domain name will be used to store the cookie, e.g. www.mydomain.com. If False only a partial domain name will be used, e.g. mydomain.com. If you are unsure about this, always leave set to true.', E'15', E'2', E'zen_cfg_select_option(array(\'True\', \'False\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Force Cookie Use', E'SESSION_FORCE_COOKIE_USE', E'False', E'Force the use of sessions when cookies are only enabled.', E'15', E'2', E'zen_cfg_select_option(array(\'True\', \'False\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Check SSL Session ID', E'SESSION_CHECK_SSL_SESSION_ID', E'False', E'Validate the SSL_SESSION_ID on every secure HTTPS page request.', E'15', E'3', E'zen_cfg_select_option(array(\'True\', \'False\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Check User Agent', E'SESSION_CHECK_USER_AGENT', E'False', E'Validate the clients browser user agent on every page request.', E'15', E'4', E'zen_cfg_select_option(array(\'True\', \'False\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Check IP Address', E'SESSION_CHECK_IP_ADDRESS', E'False', E'Validate the clients IP address on every page request.', E'15', E'5', E'zen_cfg_select_option(array(\'True\', \'False\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Prevent Spider Sessions', E'SESSION_BLOCK_SPIDERS', E'True', E'Prevent known spiders from starting a session.', E'15', E'6', E'zen_cfg_select_option(array(\'True\', \'False\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Recreate Session', E'SESSION_RECREATE', E'True', E'Recreate the session to generate a new session ID when the customer logs on or creates an account (PHP >=4.1 needed).', E'15', E'7', E'zen_cfg_select_option(array(\'True\', \'False\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'IP to Host Conversion Status', E'SESSION_IP_TO_HOST_ADDRESS', E'true', E'Convert IP Address to Host Address<br /><br />Note: on some servers this can slow down the initial start of a session or execution of Emails', E'15', E'10', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Length of the redeem code', E'SECURITY_CODE_LENGTH', E'10', E'Enter the length of the redeem code<br />The longer the more secure', 16, 1, NULL, now(), NULL, NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, use_function, date_added) VALUES (E'Default Order Status For Zero Balance Orders', E'DEFAULT_ZERO_BALANCE_ORDERS_STATUS_ID', E'2', E'When an order\'s balance is zero, this order status will be assigned to it.', E'16', E'0', E'zen_cfg_pull_down_order_statuses(', E'zen_get_order_status_name', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'New Signup Discount Coupon ID#', E'NEW_SIGNUP_DISCOUNT_COUPON', E'', E'Select the coupon<br />', 16, 75, NULL, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'New Signup Gift Voucher Amount', E'NEW_SIGNUP_GIFT_VOUCHER_AMOUNT', E'', E'Leave blank for none<br />Or enter an amount ie. 10 for $10.00', 16, 76, NULL, now(), NULL, NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Maximum Discount Coupons Per Page', E'MAX_DISPLAY_SEARCH_RESULTS_DISCOUNT_COUPONS', E'20', E'Number of Discount Coupons to list per Page', E'16', E'81', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Maximum Discount Coupon Report Results Per Page', E'MAX_DISPLAY_SEARCH_RESULTS_DISCOUNT_COUPONS_REPORTS', E'20', E'Number of Discount Coupons to list on Reports Page', E'16', E'81', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Credit Card Enable Status - VISA', E'CC_ENABLED_VISA', E'1', E'Accept VISA 0= off 1= on', E'17', E'1', E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Credit Card Enable Status - MasterCard', E'CC_ENABLED_MC', E'1', E'Accept MasterCard 0= off 1= on', E'17', E'2', E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Credit Card Enable Status - AmericanExpress', E'CC_ENABLED_AMEX', E'0', E'Accept AmericanExpress 0= off 1= on', E'17', E'3', E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Credit Card Enable Status - Diners Club', E'CC_ENABLED_DINERS_CLUB', E'0', E'Accept Diners Club 0= off 1= on', E'17', E'4', E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Credit Card Enable Status - Discover Card', E'CC_ENABLED_DISCOVER', E'0', E'Accept Discover Card 0= off 1= on', E'17', E'5', E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Credit Card Enable Status - JCB', E'CC_ENABLED_JCB', E'0', E'Accept JCB 0= off 1= on', E'17', E'6', E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Credit Card Enable Status - AUSTRALIAN BANKCARD', E'CC_ENABLED_AUSTRALIAN_BANKCARD', E'0', E'Accept AUSTRALIAN BANKCARD 0= off 1= on', E'17', E'7', E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Credit Card Enable Status - SOLO', E'CC_ENABLED_SOLO', E'0', E'Accept SOLO Card 0= off 1= on', E'17', E'8', E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Credit Card Enable Status - Switch', E'CC_ENABLED_SWITCH', E'0', E'Accept SWITCH Card 0= off 1= on', E'17', E'9', E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Credit Card Enable Status - Maestro', E'CC_ENABLED_MAESTRO', E'0', E'Accept MAESTRO Card 0= off 1= on', E'17', E'10', E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 


INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Credit Card Enabled - Show on Payment', E'SHOW_ACCEPTED_CREDIT_CARDS', E'0', E'Show accepted credit cards on Payment page?<br />0= off<br />1= As Text<br />2= As Images<br /><br />Note: images and text must be defined in both the database and language file for specific credit card types.', E'17', E'50', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'This module is installed', E'MODULE_ORDER_TOTAL_GV_STATUS', E'true', E'', 6, 1, NULL, E'2003-10-30 22:16:40', NULL, E'zen_cfg_select_option(array(\'true\'),');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Sort Order', E'MODULE_ORDER_TOTAL_GV_SORT_ORDER', E'840', E'Sort order of display.', 6, 2, NULL, E'2003-10-30 22:16:40', NULL, NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Queue Purchases', E'MODULE_ORDER_TOTAL_GV_QUEUE', E'true', E'Do you want to queue purchases of the Gift Voucher?', 6, 3, NULL, E'2003-10-30 22:16:40', NULL, E'zen_cfg_select_option(array(\'true\', \'false\'),');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Include Shipping', E'MODULE_ORDER_TOTAL_GV_INC_SHIPPING', E'true', E'Include Shipping in calculation', 6, 5, NULL, E'2003-10-30 22:16:40', NULL, E'zen_cfg_select_option(array(\'true\', \'false\'),');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Include Tax', E'MODULE_ORDER_TOTAL_GV_INC_TAX', E'true', E'Include Tax in calculation.', 6, 6, NULL, E'2003-10-30 22:16:40', NULL, E'zen_cfg_select_option(array(\'true\', \'false\'),');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Re-calculate Tax', E'MODULE_ORDER_TOTAL_GV_CALC_TAX', E'None', E'Re-Calculate Tax', 6, 7, NULL, E'2003-10-30 22:16:40', NULL, E'zen_cfg_select_option(array(\'None\', \'Standard\', \'Credit Note\'),');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Tax Class', E'MODULE_ORDER_TOTAL_GV_TAX_CLASS', E'0', E'Use the following tax class when treating Gift Voucher as Credit Note.', 6, 0, NULL, E'2003-10-30 22:16:40', E'zen_get_tax_class_title', E'zen_cfg_pull_down_tax_classes(');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Credit including Tax', E'MODULE_ORDER_TOTAL_GV_CREDIT_TAX', E'false', E'Add tax to purchased Gift Voucher when crediting to Account', 6, 8, NULL, E'2003-10-30 22:16:40', NULL, E'zen_cfg_select_option(array(\'true\', \'false\'),');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Set Order Status', E'MODULE_ORDER_TOTAL_GV_ORDER_STATUS_ID', E'0', E'Set the status of orders made where GV covers full payment', 6, 0, NULL, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (');


INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'This module is installed', E'MODULE_ORDER_TOTAL_LOWORDERFEE_STATUS', E'true', E'', 6, 1, NULL, E'2003-10-30 22:16:43', NULL, E'zen_cfg_select_option(array(\'true\'),');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Sort Order', E'MODULE_ORDER_TOTAL_LOWORDERFEE_SORT_ORDER', E'400', E'Sort order of display.', 6, 2, NULL, E'2003-10-30 22:16:43', NULL, NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Allow Low Order Fee', E'MODULE_ORDER_TOTAL_LOWORDERFEE_LOW_ORDER_FEE', E'false', E'Do you want to allow low order fees?', 6, 3, NULL, E'2003-10-30 22:16:43', NULL, E'zen_cfg_select_option(array(\'true\', \'false\'),');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Order Fee For Orders Under', E'MODULE_ORDER_TOTAL_LOWORDERFEE_ORDER_UNDER', E'50', E'Add the low order fee to orders under this amount.', 6, 4, NULL, E'2003-10-30 22:16:43', E'currencies->format', NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Order Fee', E'MODULE_ORDER_TOTAL_LOWORDERFEE_FEE', E'5', E'For Percentage Calculation - include a % Example: 10%<br />For a flat amount just enter the amount - Example: 5 for $5.00', 6, 5, NULL, E'2003-10-30 22:16:43', E'', NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Attach Low Order Fee On Orders Made', E'MODULE_ORDER_TOTAL_LOWORDERFEE_DESTINATION', E'both', E'Attach low order fee for orders sent to the set destination.', 6, 6, NULL, E'2003-10-30 22:16:43', NULL, E'zen_cfg_select_option(array(\'national\', \'international\', \'both\'),');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Tax Class', E'MODULE_ORDER_TOTAL_LOWORDERFEE_TAX_CLASS', E'0', E'Use the following tax class on the low order fee.', 6, 7, NULL, E'2003-10-30 22:16:43', E'zen_get_tax_class_title', E'zen_cfg_pull_down_tax_classes(');
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'No Low Order Fee on Virtual Products', E'MODULE_ORDER_TOTAL_LOWORDERFEE_VIRTUAL', E'false', E'Do not charge Low Order Fee when cart is Virtual Products Only', 6, 8, NULL, E'2004-04-20 22:16:43', NULL, E'zen_cfg_select_option(array(\'true\', \'false\'),');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'No Low Order Fee on Gift Vouchers', E'MODULE_ORDER_TOTAL_LOWORDERFEE_GV', E'false', E'Do not charge Low Order Fee when cart is Gift Vouchers Only', 6, 9, NULL, E'2004-04-20 22:16:43', NULL, E'zen_cfg_select_option(array(\'true\', \'false\'),');
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'This module is installed', E'MODULE_ORDER_TOTAL_SHIPPING_STATUS', E'true', E'', 6, 1, NULL, E'2003-10-30 22:16:46', NULL, E'zen_cfg_select_option(array(\'true\'),');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Sort Order', E'MODULE_ORDER_TOTAL_SHIPPING_SORT_ORDER', E'200', E'Sort order of display.', 6, 2, NULL, E'2003-10-30 22:16:46', NULL, NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Allow Free Shipping', E'MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING', E'false', E'Do you want to allow free shipping?', 6, 3, NULL, E'2003-10-30 22:16:46', NULL, E'zen_cfg_select_option(array(\'true\', \'false\'),');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Free Shipping For Orders Over', E'MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING_OVER', E'50', E'Provide free shipping for orders over the set amount.', 6, 4, NULL, E'2003-10-30 22:16:46', E'currencies->format', NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Provide Free Shipping For Orders Made', E'MODULE_ORDER_TOTAL_SHIPPING_DESTINATION', E'national', E'Provide free shipping for orders sent to the set destination.', 6, 5, NULL, E'2003-10-30 22:16:46', NULL, E'zen_cfg_select_option(array(\'national\', \'international\', \'both\'),');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'This module is installed', E'MODULE_ORDER_TOTAL_SUBTOTAL_STATUS', E'true', E'', 6, 1, NULL, E'2003-10-30 22:16:49', NULL, E'zen_cfg_select_option(array(\'true\'),');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Sort Order', E'MODULE_ORDER_TOTAL_SUBTOTAL_SORT_ORDER', E'100', E'Sort order of display.', 6, 2, NULL, E'2003-10-30 22:16:49', NULL, NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'This module is installed', E'MODULE_ORDER_TOTAL_TAX_STATUS', E'true', E'', 6, 1, NULL, E'2003-10-30 22:16:52', NULL, E'zen_cfg_select_option(array(\'true\'),');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Sort Order', E'MODULE_ORDER_TOTAL_TAX_SORT_ORDER', E'300', E'Sort order of display.', 6, 2, NULL, E'2003-10-30 22:16:52', NULL, NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'This module is installed', E'MODULE_ORDER_TOTAL_TOTAL_STATUS', E'true', E'', 6, 1, NULL, E'2003-10-30 22:16:55', NULL, E'zen_cfg_select_option(array(\'true\'),');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Sort Order', E'MODULE_ORDER_TOTAL_TOTAL_SORT_ORDER', E'999', E'Sort order of display.', 6, 2, NULL, E'2003-10-30 22:16:55', NULL, NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Tax Class', E'MODULE_ORDER_TOTAL_COUPON_TAX_CLASS', E'0', E'Use the following tax class when treating Discount Coupon as Credit Note.', 6, 0, NULL, E'2003-10-30 22:16:36', E'zen_get_tax_class_title', E'zen_cfg_pull_down_tax_classes(');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Include Tax', E'MODULE_ORDER_TOTAL_COUPON_INC_TAX', E'false', E'Include Tax in calculation.', 6, 6, NULL, E'2003-10-30 22:16:36', NULL, E'zen_cfg_select_option(array(\'true\', \'false\'),');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Sort Order', E'MODULE_ORDER_TOTAL_COUPON_SORT_ORDER', E'280', E'Sort order of display.', 6, 2, NULL, E'2003-10-30 22:16:36', NULL, NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Include Shipping', E'MODULE_ORDER_TOTAL_COUPON_INC_SHIPPING', E'false', E'Include Shipping in calculation', 6, 5, NULL, E'2003-10-30 22:16:36', NULL, E'zen_cfg_select_option(array(\'true\', \'false\'),');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'This module is installed', E'MODULE_ORDER_TOTAL_COUPON_STATUS', E'true', E'', 6, 1, NULL, E'2003-10-30 22:16:36', NULL, E'zen_cfg_select_option(array(\'true\'),');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Re-calculate Tax', E'MODULE_ORDER_TOTAL_COUPON_CALC_TAX', E'Standard', E'Re-Calculate Tax', 6, 7, NULL, E'2003-10-30 22:16:36', NULL, E'zen_cfg_select_option(array(\'None\', \'Standard\', \'Credit Note\'),');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Admin Demo Status', E'ADMIN_DEMO', E'0', E'Admin Demo should be on?<br />0= off 1= on', 6, 0, E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Product option type Select', E'PRODUCTS_OPTIONS_TYPE_SELECT', E'0', E'The number representing the Select type of product option.', 0, NULL, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Text product option type', E'PRODUCTS_OPTIONS_TYPE_TEXT', E'1', E'Numeric value of the text product option type', 6, NULL, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Radio button product option type', E'PRODUCTS_OPTIONS_TYPE_RADIO', E'2', E'Numeric value of the radio button product option type', 6, NULL, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Check box product option type', E'PRODUCTS_OPTIONS_TYPE_CHECKBOX', E'3', E'Numeric value of the check box product option type', 6, NULL, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'File product option type', E'PRODUCTS_OPTIONS_TYPE_FILE', E'4', E'Numeric value of the file product option type', 6, NULL, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'ID for text and file products options values', E'PRODUCTS_OPTIONS_VALUES_TEXT_ID', E'0', E'Numeric value of the products_options_values_id used by the text and file attributes.', 6, NULL, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Upload prefix', E'UPLOAD_PREFIX', E'upload_', E'Prefix used to differentiate between upload options and other options', 0, NULL, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Text prefix', E'TEXT_PREFIX', E'txt_', E'Prefix used to differentiate between text option values and other option values', 0, NULL, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Read Only option type', E'PRODUCTS_OPTIONS_TYPE_READONLY', E'5', E'Numeric value of the file product option type', 6, NULL, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();







INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Products Info - Products Option Name Sort Order', E'PRODUCTS_OPTIONS_SORT_ORDER', E'0', E'Sort order of Option Names for Products Info<br />0= Sort Order, Option Name<br />1= Option Name', 18, 35, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (array(\'0\', \'1\'),');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Products Info - Product Option Value of Attributes Sort Order', E'PRODUCTS_OPTIONS_SORT_BY_PRICE', E'1', E'Sort order of Product Option Values of Attributes for Products Info<br />0= Sort Order, Price<br />1= Sort Order, Option Value Name', 18, 36, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (array(\'0\', \'1\'),');



-- test remove and only use products_options_images_per_row
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Product Info - Number of Attribute Images per Row', 'PRODUCTS_IMAGES_ATTRIBUTES_PER_ROW', '5', 'Product Info - Enter the number of attribute images to display per row<br />Default = 5', '18', '40', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Product Info - Show Option Values Name Below Attributes Image', E'PRODUCT_IMAGES_ATTRIBUTES_NAMES', E'1', E'Product Info - Show the name of the Option Value beneath the Attribute Image?<br />0= off 1= on', 18, 41, E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 

-- test remove and only use products_options_images_style
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Product Info - Show Option Values and Attributes Images for Radio Buttons and Checkboxes', 'PRODUCT_IMAGES_ATTRIBUTES_NAMES_COLUMN', '0', '0= Images Below Option Names<br />1= Element, Image and Option Value<br />2= Element, Image and Option Name Below<br />3= Option Name Below Element and Image<br />4= Element Below Image and Option Name<br />5= Element Above Image and Option Name', 18, 42, 'zen_cfg_select_option(array(\'0\', \'1\', \'2\', \'3\', \'4\', \'5\'), ', now());
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Product Info - Show Sales Discount Savings Status', E'SHOW_SALE_DISCOUNT_STATUS', E'1', E'Product Info - Show the amount of discount savings?<br />0= off 1= on', 18, 45, E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Product Info - Show Sales Discount Savings Dollars or Percentage', E'SHOW_SALE_DISCOUNT', E'1', E'Product Info - Show the amount of discount savings display as:<br />1= % off 2= $amount off', 18, 46, E'zen_cfg_select_option(array(\'1\', \'2\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Product Info - Show Sales Discount Savings Percentage Decimals', E'SHOW_SALE_DISCOUNT_DECIMALS', E'0', E'Product Info - Show discount savings display as a Percentage with how many decimals?:<br />Default= 0', 18, 47, NULL, now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Product Info - Price is Free Image or Text Status', E'OTHER_IMAGE_PRICE_IS_FREE_ON', E'1', E'Product Info - Show the Price is Free Image or Text on Displayed Price<br />0= Text<br />1= Image', 18, 50, E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Product Info - Price is Call for Price Image or Text Status', E'PRODUCTS_PRICE_IS_CALL_IMAGE_ON', E'1', E'Product Info - Show the Price is Call for Price Image or Text on Displayed Price<br />0= Text<br />1= Image', 18, 51, E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Product Quantity Box Status - Adding New Products', E'PRODUCTS_QTY_BOX_STATUS', E'1', E'What should the Default Quantity Box Status be set to when adding New Products?<br /><br />0= off<br />1= on<br />NOTE: This will show a Qty Box when ON and default the Add to Cart to 1', E'18', E'55', E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Product Reviews Require Approval', E'REVIEWS_APPROVAL', E'1', E'Do product reviews require approval?<br /><br />Note: When Review Status is off, it will also not show<br /><br />0= off 1= on', E'18', E'62', E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Meta Tags - Include Product Model in Title', E'META_TAG_INCLUDE_MODEL', E'1', E'Do you want to include the Product Model in the Meta Tag Title?<br /><br />0= off 1= on', E'18', E'69', E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Meta Tags - Include Product Price in Title', E'META_TAG_INCLUDE_PRICE', E'1', E'Do you want to include the Product Price in the Meta Tag Title?<br /><br />0= off 1= on', E'18', E'70', E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (E'Meta Tags Generated Description Maximum Length?', E'MAX_META_TAG_DESCRIPTION_LENGTH', E'50', E'Set Generated Meta Tag Description Maximum Length to (words) Default 50:', E'18', E'71', E'', E'', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Also Purchased Products Columns per Row', E'SHOW_PRODUCT_INFO_COLUMNS_ALSO_PURCHASED_PRODUCTS', E'3', E'Also Purchased Products Columns per Row<br />0= off or set the sort order', E'18', E'72', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\', \'3\', \'4\', \'5\', \'6\', \'7\', \'8\', \'9\', \'10\', \'11\', \'12\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Previous Next - Navigation Bar Position', E'PRODUCT_INFO_PREVIOUS_NEXT', E'1', E'Location of Previous/Next Navigation Bar<br />0= off<br />1= Top of Page<br />2= Bottom of Page<br />3= Both Top and Bottom of Page', 18, 21, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (array(array(\'id\'=>\'0\', \'text\'=>\'Off\'), array(\'id\'=>\'1\', \'text\'=>\'Top of Page\'), array(\'id\'=>\'2\', \'text\'=>\'Bottom of Page\'), array(\'id\'=>\'3\', \'text\'=>\'Both Top & Bottom of Page\')),');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Previous Next - Sort Order', E'PRODUCT_INFO_PREVIOUS_NEXT_SORT', E'1', E'Products Display Order by<br />0= Product ID<br />1= Product Name<br />2= Model<br />3= Price, Product Name<br />4= Price, Model<br />5= Product Name, Model<br />6= Product Sort Order', 18, 22, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (array(array(\'id\'=>\'0\', \'text\'=>\'Product ID\'), array(\'id\'=>\'1\', \'text\'=>\'Name\'), array(\'id\'=>\'2\', \'text\'=>\'Product Model\'), array(\'id\'=>\'3\', \'text\'=>\'Product Price - Name\'), array(\'id\'=>\'4\', \'text\'=>\'Product Price - Model\'), array(\'id\'=>\'5\', \'text\'=>\'Product Name - Model\'), array(\'id\'=>\'6\', \'text\'=>\'Product Sort Order\')),');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Previous Next - Button and Image Status', E'SHOW_PREVIOUS_NEXT_STATUS', E'0', E'Button and Product Image status settings are:<br />0= Off<br />1= On', 18, 20, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (array(array(\'id\'=>\'0\', \'text\'=>\'Off\'), array(\'id\'=>\'1\', \'text\'=>\'On\')),');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Previous Next - Button and Image Settings', E'SHOW_PREVIOUS_NEXT_IMAGES', E'0', E'Show Previous/Next Button and Product Image Settings<br />0= Button Only<br />1= Button and Product Image<br />2= Product Image Only', 18, 21, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (array(array(\'id\'=>\'0\', \'text\'=>\'Button Only\'), array(\'id\'=>\'1\', \'text\'=>\'Button and Product Image\'), array(\'id\'=>\'2\', \'text\'=>\'Product Image Only\')),');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (E'Previous Next - Image Width?', E'PREVIOUS_NEXT_IMAGE_WIDTH', E'50', E'Previous/Next Image Width?', E'18', E'22', E'', E'', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (E'Previous Next - Image Height?', E'PREVIOUS_NEXT_IMAGE_HEIGHT', E'40', E'Previous/Next Image Height?', E'18', E'23', E'', E'', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Previous Next - Navigation Includes Category Position', E'PRODUCT_INFO_CATEGORIES', E'1', E'Product\'s Category Image and Name Alignment Above Previous/Next Navigation Bar<br />0= off<br />1= Align Left<br />2= Align Center<br />3= Align Right', 18, 20, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (array(array(\'id\'=>\'0\', \'text\'=>\'Off\'), array(\'id\'=>\'1\', \'text\'=>\'Align Left\'), array(\'id\'=>\'2\', \'text\'=>\'Align Center\'), array(\'id\'=>\'3\', \'text\'=>\'Align Right\')),');


INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Previous Next - Navigation Includes Category Name and Image Status', E'PRODUCT_INFO_CATEGORIES_IMAGE_STATUS', E'2', E'Product\'s Category Image and Name Status<br />0= Category Name and Image always shows<br />1= Category Name only<br />2= Category Name and Image when not blank', 18, 20, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (array(array(\'id\'=>\'0\', \'text\'=>\'Category Name and Image Always\'), array(\'id\'=>\'1\', \'text\'=>\'Category Name only\'), array(\'id\'=>\'2\', \'text\'=>\'Category Name and Image when not blank\')),');




INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Column Width - Left Boxes', E'BOX_WIDTH_LEFT', E'150px', E'Width of the Left Column Boxes<br />px may be included<br />Default = 150px', 19, 1, NULL, E'2003-11-21 22:16:36', NULL, NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Column Width - Right Boxes', E'BOX_WIDTH_RIGHT', E'150px', E'Width of the Right Column Boxes<br />px may be included<br />Default = 150px', 19, 2, NULL, E'2003-11-21 22:16:36', NULL, NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Bread Crumbs Navigation Separator', E'BREAD_CRUMBS_SEPARATOR', E'&nbsp;::&nbsp;', E'Enter the separator symbol to appear between the Navigation Bread Crumb trail<br />Note: Include spaces with the &amp;nbsp; symbol if you want them part of the separator.<br />Default = &amp;nbsp;::&amp;nbsp;', 19, 3, NULL, E'2003-11-21 22:16:36', NULL, E'zen_cfg_textarea_small(');
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Define Breadcrumb Status', E'DEFINE_BREADCRUMB_STATUS', E'1', E'Enable the Breadcrumb Trail Links?<br />0= OFF<br />1= ON<br />2= Off for Home Page Only', 19, 4, E'zen_cfg_select_option(array(\'0\', \'1\', \'2\'), ', now());
 


INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Bestsellers - Number Padding', E'BEST_SELLERS_FILLER', E'&nbsp;', E'What do you want to Pad the numbers with?<br />Default = &amp;nbsp;', 19, 5, NULL, E'2003-11-21 22:16:36', NULL, E'zen_cfg_textarea_small(');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Bestsellers - Truncate Product Names', E'BEST_SELLERS_TRUNCATE', E'35', E'What size do you want to truncate the Product Names?<br />Default = 35', 19, 6, NULL, E'2003-11-21 22:16:36', NULL, NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Bestsellers - Truncate Product Names followed by ...', E'BEST_SELLERS_TRUNCATE_MORE', E'true', E'When truncated Product Names follow with ...<br />Default = true', 19, 7, E'2003-03-21 13:08:25', E'2003-03-21 11:42:47', NULL, E'zen_cfg_select_option(array(\'true\', \'false\'),');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Categories Box - Show Specials Link', E'SHOW_CATEGORIES_BOX_SPECIALS', E'true', E'Show Specials Link in the Categories Box', 19, 8, E'2003-03-21 13:08:25', E'2003-03-21 11:42:47', NULL, E'zen_cfg_select_option(array(\'true\', \'false\'),');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Categories Box - Show Products New Link', E'SHOW_CATEGORIES_BOX_PRODUCTS_NEW', E'true', E'Show Products New Link in the Categories Box', 19, 9, E'2003-03-21 13:08:25', E'2003-03-21 11:42:47', NULL, E'zen_cfg_select_option(array(\'true\', \'false\'),');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Shopping Cart Box Status', E'SHOW_SHOPPING_CART_BOX_STATUS', E'1', E'Shopping Cart Shows<br />0= Always<br />1= Only when full<br />2= Only when full but not when viewing the Shopping Cart', 19, 10, E'zen_cfg_select_option(array(\'0\', \'1\', \'2\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Categories Box - Show Featured Products Link', E'SHOW_CATEGORIES_BOX_FEATURED_PRODUCTS', E'true', E'Show Featured Products Link in the Categories Box', 19, 11, E'2003-03-21 13:08:25', E'2003-03-21 11:42:47', NULL, E'zen_cfg_select_option(array(\'true\', \'false\'),');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Categories Box - Show Products All Link', E'SHOW_CATEGORIES_BOX_PRODUCTS_ALL', E'true', E'Show Products All Link in the Categories Box', 19, 12, E'2003-03-21 13:08:25', E'2003-03-21 11:42:47', NULL, E'zen_cfg_select_option(array(\'true\', \'false\'),');
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Column Left Status - Global', E'COLUMN_LEFT_STATUS', E'1', E'Show Column Left, unless page override exists?<br />0= Column Left is always off<br />1= Column Left is on, unless page override', 19, 15, E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Column Right Status - Global', E'COLUMN_RIGHT_STATUS', E'1', E'Show Column Right, unless page override exists?<br />0= Column Right is always off<br />1= Column Right is on, unless page override', 19, 16, E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Column Width - Left', E'COLUMN_WIDTH_LEFT', E'150px', E'Width of the Left Column<br />px may be included<br />Default = 150px', 19, 20, NULL, E'2003-11-21 22:16:36', NULL, NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Column Width - Right', E'COLUMN_WIDTH_RIGHT', E'150px', E'Width of the Right Column<br />px may be included<br />Default = 150px', 19, 21, NULL, E'2003-11-21 22:16:36', NULL, NULL);
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Categories Separator between links Status', E'SHOW_CATEGORIES_SEPARATOR_LINK', E'1', E'Show Category Separator between Category Names and Links?<br />0= off<br />1= on', 19, 24, E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Categories Separator between the Category Name and Count', E'CATEGORIES_SEPARATOR', E'-&gt;', E'What separator do you want between the Category name and the count?<br />Default = -&amp;gt;', 19, 25, NULL, E'2003-11-21 22:16:36', NULL, E'zen_cfg_textarea_small(');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Categories Separator between the Category Name and Sub Categories', E'CATEGORIES_SEPARATOR_SUBS', E'|_&nbsp;', E'What separator do you want between the Category name and Sub Category Name?<br />Default = |_&amp;nbsp;', 19, 26, NULL, E'2004-03-25 22:16:36', NULL, E'zen_cfg_textarea_small(');
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Categories Count Prefix', E'CATEGORIES_COUNT_PREFIX', E'&nbsp;(', E'What do you want to Prefix the count with?<br />Default= (', 19, 27, NULL, E'2003-01-21 22:16:36', NULL, E'zen_cfg_textarea_small(');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Categories Count Suffix', E'CATEGORIES_COUNT_SUFFIX', E')', E'What do you want as a Suffix to the count?<br />Default= )', 19, 28, NULL, E'2003-01-21 22:16:36', NULL, E'zen_cfg_textarea_small(');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Categories SubCategories Indent', E'CATEGORIES_SUBCATEGORIES_INDENT', E'&nbsp;&nbsp;', E'What do you want to use as the subcategories indent?<br />Default= &nbsp;&nbsp;', 19, 29, NULL, E'2004-06-24 22:16:36', NULL, E'zen_cfg_textarea_small(');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Categories with 0 Products Status', E'CATEGORIES_COUNT_ZERO', E'0', E'Show Category Count for 0 Products?<br />0= off<br />1= on', 19, 30, E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Split Categories Box', E'CATEGORIES_SPLIT_DISPLAY', E'True', E'Split the categories box display by product type', 19, 31, E'zen_cfg_select_option(array(\'True\', \'False\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Shopping Cart - Show Totals', E'SHOW_TOTALS_IN_CART', E'1', E'Show Totals Above Shopping Cart?<br />0= off<br />1= on: Items Weight Amount<br />2= on: Items Weight Amount, but no weight when 0<br />3= on: Items Amount', 19, 31, E'zen_cfg_select_option(array(\'0\', \'1\', \'2\', \'3\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Customer Greeting - Show on Index Page', E'SHOW_CUSTOMER_GREETING', E'1', E'Always Show Customer Greeting on Index?<br />0= off<br />1= on', 19, 40, E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Categories - Always Show on Main Page', E'SHOW_CATEGORIES_ALWAYS', E'0', E'Always Show Categories on Main Page<br />0= off<br />1= on<br />Default category can be set to Top Level or a Specific Top Level', 19, 45, E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (E'Main Page - Opens with Category', E'CATEGORIES_START_MAIN', E'0', E'0= Top Level Categories<br />Or enter the Category ID#<br />Note: Sub Categories can also be used Example: 3_10', E'19', E'46', E'', E'', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Categories - Always Open to Show SubCategories', E'SHOW_CATEGORIES_SUBCATEGORIES_ALWAYS', E'1', E'Always Show Categories and SubCategories<br />0= off, just show Top Categories<br />1= on, Always show Categories and SubCategories when selected', 19, 47, E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (E'Banner Display Groups - Header Position 1', E'SHOW_BANNERS_GROUP_SET1', E'', E'The Banner Display Groups can be from 1 Banner Group or Multiple Banner Groups<br /><br />For Multiple Banner Groups enter the Banner Group Name separated by a colon <strong>:</strong><br /><br />Example: Wide-Banners:SideBox-Banners<br /><br />What Banner Group(s) do you want to use in the Header Position 1?<br />Leave blank for none', E'19', E'55', E'', E'', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (E'Banner Display Groups - Header Position 2', E'SHOW_BANNERS_GROUP_SET2', E'', E'The Banner Display Groups can be from 1 Banner Group or Multiple Banner Groups<br /><br />For Multiple Banner Groups enter the Banner Group Name separated by a colon <strong>:</strong><br /><br />Example: Wide-Banners:SideBox-Banners<br /><br />What Banner Group(s) do you want to use in the Header Position 2?<br />Leave blank for none', E'19', E'56', E'', E'', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (E'Banner Display Groups - Header Position 3', E'SHOW_BANNERS_GROUP_SET3', E'', E'The Banner Display Groups can be from 1 Banner Group or Multiple Banner Groups<br /><br />For Multiple Banner Groups enter the Banner Group Name separated by a colon <strong>:</strong><br /><br />Example: Wide-Banners:SideBox-Banners<br /><br />What Banner Group(s) do you want to use in the Header Position 3?<br />Leave blank for none', E'19', E'57', E'', E'', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (E'Banner Display Groups - Footer Position 1', E'SHOW_BANNERS_GROUP_SET4', E'', E'The Banner Display Groups can be from 1 Banner Group or Multiple Banner Groups<br /><br />For Multiple Banner Groups enter the Banner Group Name separated by a colon <strong>:</strong><br /><br />Example: Wide-Banners:SideBox-Banners<br /><br />What Banner Group(s) do you want to use in the Footer Position 1?<br />Leave blank for none', E'19', E'65', E'', E'', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (E'Banner Display Groups - Footer Position 2', E'SHOW_BANNERS_GROUP_SET5', E'', E'The Banner Display Groups can be from 1 Banner Group or Multiple Banner Groups<br /><br />For Multiple Banner Groups enter the Banner Group Name separated by a colon <strong>:</strong><br /><br />Example: Wide-Banners:SideBox-Banners<br /><br />What Banner Group(s) do you want to use in the Footer Position 2?<br />Leave blank for none', E'19', E'66', E'', E'', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (E'Banner Display Groups - Footer Position 3', E'SHOW_BANNERS_GROUP_SET6', E'Wide-Banners', E'The Banner Display Groups can be from 1 Banner Group or Multiple Banner Groups<br /><br />For Multiple Banner Groups enter the Banner Group Name separated by a colon <strong>:</strong><br /><br />Example: Wide-Banners:SideBox-Banners<br /><br />Default Group is Wide-Banners<br /><br />What Banner Group(s) do you want to use in the Footer Position 3?<br />Leave blank for none', E'19', E'67', E'', E'', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (E'Banner Display Groups - Side Box banner_box', E'SHOW_BANNERS_GROUP_SET7', E'SideBox-Banners', E'The Banner Display Groups can be from 1 Banner Group or Multiple Banner Groups<br /><br />For Multiple Banner Groups enter the Banner Group Name separated by a colon <strong>:</strong><br /><br />Example: Wide-Banners:SideBox-Banners<br />Default Group is SideBox-Banners<br /><br />What Banner Group(s) do you want to use in the Side Box - banner_box?<br />Leave blank for none', E'19', E'70', E'', E'', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (E'Banner Display Groups - Side Box banner_box2', E'SHOW_BANNERS_GROUP_SET8', E'SideBox-Banners', E'The Banner Display Groups can be from 1 Banner Group or Multiple Banner Groups<br /><br />For Multiple Banner Groups enter the Banner Group Name separated by a colon <strong>:</strong><br /><br />Example: Wide-Banners:SideBox-Banners<br />Default Group is SideBox-Banners<br /><br />What Banner Group(s) do you want to use in the Side Box - banner_box2?<br />Leave blank for none', E'19', E'71', E'', E'', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (E'Banner Display Group - Side Box banner_box_all', E'SHOW_BANNERS_GROUP_SET_ALL', E'BannersAll', E'The Banner Display Group may only be from one (1) Banner Group for the Banner All sidebox<br /><br />Default Group is BannersAll<br /><br />What Banner Group do you want to use in the Side Box - banner_box_all?<br />Leave blank for none', E'19', E'72', E'', E'', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Footer - Show IP Address status', E'SHOW_FOOTER_IP', E'1', E'Show Customer IP Address in the Footer<br />0= off<br />1= on<br />Should the Customer IP Address show in the footer?', 19, 80, E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (E'Product Discount Quantities - Add how many blank discounts?', E'DISCOUNT_QTY_ADD', E'5', E'How many blank discount quantities should be added for Product Pricing?', E'19', E'90', E'', E'', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (E'Product Discount Quantities - Display how many per row?', E'DISCOUNT_QUANTITY_PRICES_COLUMN', E'5', E'How many discount quantities should show per row on Product Info Pages?', E'19', E'95', E'', E'', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Categories/Products Display Sort Order', E'CATEGORIES_PRODUCTS_SORT_ORDER', E'0', E'Categories/Products Display Sort Order<br />0= Categories/Products Sort Order/Name<br />1= Categories/Products Name<br />2= Products Model<br />3= Products Qty+, Products Name<br />4= Products Qty-, Products Name<br />5= Products Price+, Products Name<br />6= Products Price+, Products Name', E'19', E'100', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\', \'3\', \'4\', \'5\', \'6\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Option Names and Values Global Add, Copy and Delete Features Status', E'OPTION_NAMES_VALUES_GLOBAL_STATUS', E'1', E'Option Names and Values Global Add, Copy and Delete Features Status<br />0= Hide Features<br />1= Show Features<br />2= Products Model', E'19', E'110', E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Categories-Tabs Menu ON/OFF', E'CATEGORIES_TABS_STATUS', E'1', E'Categories-Tabs<br />This enables the display of your store\'s categories as a menu across the top of your header. There are many potential creative uses for this.<br />0= Hide Categories Tabs<br />1= Show Categories Tabs', E'19', E'112', E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Site Map - include My Account Links?', E'SHOW_ACCOUNT_LINKS_ON_SITE_MAP', E'No', E'Should the links to My Account show up on the site-map?<br />Note: Spiders will try to index this page, and likely should not be sent to secure pages, since there is no benefit in indexing a login page.<br /><br />Default: false', 19, 115, E'zen_cfg_select_option(array(\'Yes\', \'No\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Skip 1-prod Categories', E'SKIP_SINGLE_PRODUCT_CATEGORIES', E'True', E'Skip single-product categories<br />If this option is set to True, then if the customer clicks on a link to a category which only contains a single item, then Zen Cart will take them directly to that product-page, rather than present them with another link to click in order to see the product.<br />Default: True', E'19', E'120', E'zen_cfg_select_option(array(\'True\', \'False\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Use split-login page', E'USE_SPLIT_LOGIN_MODE', E'False', E'The login page can be displayed in two modes: Split or Vertical.<br />In Split mode, the create-account options are accessed by clicking a button to get to the create-account page. In Vertical mode, the create-account input fields are all displayed inline, below the login field, making one less click for the customer to create their account.<br />Default: False', E'19', E'121', E'zen_cfg_select_option(array(\'True\', \'False\'), ', now());
 

-- CSS Buttons switch
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'CSS Buttons', E'IMAGE_USE_CSS_BUTTONS', E'No', E'CSS Buttons<br />Use CSS buttons instead of images (GIF/JPG)?<br />Button styles must be configured in the stylesheet if you enable this option.', E'19', E'147', E'zen_cfg_select_option(array(\'No\', \'Yes\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, use_function) VALUES (E'<strong>Down for Maintenance: ON/OFF</strong>', E'DOWN_FOR_MAINTENANCE', E'false', E'Down for Maintenance <br />(true=on false=off)', E'20', E'1', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now(), NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, use_function) VALUES (E'Down for Maintenance: filename', E'DOWN_FOR_MAINTENANCE_FILENAME', E'down_for_maintenance', E'Down for Maintenance filename<br />Note: Do not include the extension<br />Default=down_for_maintenance', E'20', E'2', E'', now(), NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, use_function) VALUES (E'Down for Maintenance: Hide Header', E'DOWN_FOR_MAINTENANCE_HEADER_OFF', E'false', E'Down for Maintenance: Hide Header <br />(true=hide false=show)', E'20', E'3', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now(), NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, use_function) VALUES (E'Down for Maintenance: Hide Column Left', E'DOWN_FOR_MAINTENANCE_COLUMN_LEFT_OFF', E'false', E'Down for Maintenance: Hide Column Left <br />(true=hide false=show)', E'20', E'4', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now(), NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, use_function) VALUES (E'Down for Maintenance: Hide Column Right', E'DOWN_FOR_MAINTENANCE_COLUMN_RIGHT_OFF', E'false', E'Down for Maintenance: Hide Column Right <br />(true=hide false=show)', E'20', E'5', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now(), NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, use_function) VALUES (E'Down for Maintenance: Hide Footer', E'DOWN_FOR_MAINTENANCE_FOOTER_OFF', E'false', E'Down for Maintenance: Hide Footer <br />(true=hide false=show)', E'20', E'6', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now(), NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, use_function) VALUES (E'Down for Maintenance: Hide Prices', E'DOWN_FOR_MAINTENANCE_PRICES_OFF', E'false', E'Down for Maintenance: Hide Prices <br />(true=hide false=show)', E'20', E'7', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now(), NULL);
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Down For Maintenance (exclude this IP-Address)', E'EXCLUDE_ADMIN_IP_FOR_MAINTENANCE', E'your IP (ADMIN)', E'This IP Address is able to access the website while it is Down For Maintenance (like webmaster)<br />To enter multiple IP Addresses, separate with a comma. If you do not know your IP Address, check in the Footer of your Shop.', 20, 8, E'2003-03-21 13:43:22', E'2003-03-21 21:20:07', NULL, NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'NOTICE PUBLIC Before going Down for Maintenance: ON/OFF', E'WARN_BEFORE_DOWN_FOR_MAINTENANCE', E'false', E'Give a WARNING some time before you put your website Down for Maintenance<br />(true=on false=off)<br />If you set the \'Down For Maintenance: ON/OFF\' to true this will automaticly be updated to false', 20, 9, E'2003-03-21 13:08:25', E'2003-03-21 11:42:47', NULL, E'zen_cfg_select_option(array(\'true\', \'false\'),');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Date and hours for notice before maintenance', E'PERIOD_BEFORE_DOWN_FOR_MAINTENANCE', E'15/05/2003 2-3 PM', E'Date and hours for notice before maintenance website, enter date and hours for maintenance website', 20, 10, E'2003-03-21 13:08:25', E'2003-03-21 11:42:47', NULL, NULL);
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Display when webmaster has enabled maintenance', E'DISPLAY_MAINTENANCE_TIME', E'false', E'Display when Webmaster has enabled maintenance <br />(true=on false=off)<br />', 20, 11, E'2003-03-21 13:08:25', E'2003-03-21 11:42:47', NULL, E'zen_cfg_select_option(array(\'true\', \'false\'),');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Display website maintenance period', E'DISPLAY_MAINTENANCE_PERIOD', E'false', E'Display Website maintenance period <br />(true=on false=off)<br />', 20, 12, E'2003-03-21 13:08:25', E'2003-03-21 11:42:47', NULL, E'zen_cfg_select_option(array(\'true\', \'false\'),');
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Website maintenance period', E'TEXT_MAINTENANCE_PERIOD_TIME', E'2h00', E'Enter Website Maintenance period (hh:mm)', 20, 13, E'2003-03-21 13:08:25', E'2003-03-21 11:42:47', NULL, NULL);
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Confirm Terms and Conditions During Checkout Procedure', E'DISPLAY_CONDITIONS_ON_CHECKOUT', E'false', E'Show the Terms and Conditions during the checkout procedure which the customer must agree to.', E'11', E'1', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Confirm Privacy Notice During Account Creation Procedure', E'DISPLAY_PRIVACY_CONDITIONS', E'false', E'Show the Privacy Notice during the account creation procedure which the customer must agree to.', E'11', E'2', E'zen_cfg_select_option(array(\'true\', \'false\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Image', E'PRODUCT_NEW_LIST_IMAGE', E'1102', E'Do you want to display the Product Image?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', E'21', E'1', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Quantity', E'PRODUCT_NEW_LIST_QUANTITY', E'1202', E'Do you want to display the Product Quantity?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', E'21', E'2', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Buy Now Button', E'PRODUCT_NEW_BUY_NOW', E'1300', E'Do you want to display the Product Buy Now Button<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', E'21', E'3', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Name', E'PRODUCT_NEW_LIST_NAME', E'2101', E'Do you want to display the Product Name?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', E'21', E'4', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Model', E'PRODUCT_NEW_LIST_MODEL', E'2201', E'Do you want to display the Product Model?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', E'21', E'5', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Manufacturer Name',E'PRODUCT_NEW_LIST_MANUFACTURER', E'2302', E'Do you want to display the Product Manufacturer Name?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', E'21', E'6', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Price', E'PRODUCT_NEW_LIST_PRICE', E'2402', E'Do you want to display the Product Price<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', E'21', E'7', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Weight', E'PRODUCT_NEW_LIST_WEIGHT', E'2502', E'Do you want to display the Product Weight?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', E'21', E'8', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Date Added', E'PRODUCT_NEW_LIST_DATE_ADDED', E'2601', E'Do you want to display the Product Date Added?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', E'21', E'9', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Display Product Description', E'PRODUCT_NEW_LIST_DESCRIPTION', E'1', E'Do you want to display the Product Description - First 150 characters?<br />0= off<br />1= on', E'21', E'10', E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Display Product Display - Default Sort Order', E'PRODUCT_NEW_LIST_SORT_DEFAULT', E'6', E'What Sort Order Default should be used for New Products Display?<br />Default= 6 for Date New to Old<br /><br />1= Products Name<br />2= Products Name Desc<br />3= Price low to high, Products Name<br />4= Price high to low, Products Name<br />5= Model<br />6= Date Added desc<br />7= Date Added<br />8= Product Sort Order', E'21', E'11', E'zen_cfg_select_option(array(\'1\', \'2\', \'3\', \'4\', \'5\', \'6\', \'7\', \'8\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Default Products New Group ID', E'PRODUCT_NEW_LIST_GROUP_ID', E'21', E'Warning: Only change this if your Products New Group ID has changed from the default of 21<br />What is the configuration_group_id for New Products Listings?', E'21', E'12', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Display Multiple Products Qty Box Status and Set Button Location', E'PRODUCT_NEW_LISTING_MULTIPLE_ADD_TO_CART', E'3', E'Do you want to display Add Multiple Products Qty Box and Set Button Location?<br />0= off<br />1= Top<br />2= Bottom<br />3= Both', E'21', E'25', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\', \'3\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Mask Upcoming Products from being include as New Products', E'SHOW_NEW_PRODUCTS_UPCOMING_MASKED', E'0', E'Do you want to mask Upcoming Products from being included as New Products in Listing, Sideboxes and Centerbox?<br />0= off<br />1= on', E'21', E'30', E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Image', E'PRODUCT_FEATURED_LIST_IMAGE', E'1102', E'Do you want to display the Product Image?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', E'22', E'1', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Quantity', E'PRODUCT_FEATURED_LIST_QUANTITY', E'1202', E'Do you want to display the Product Quantity?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', E'22', E'2', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Buy Now Button', E'PRODUCT_FEATURED_BUY_NOW', E'1300', E'Do you want to display the Product Buy Now Button<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', E'22', E'3', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Name', E'PRODUCT_FEATURED_LIST_NAME', E'2101', E'Do you want to display the Product Name?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', E'22', E'4', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Model', E'PRODUCT_FEATURED_LIST_MODEL', E'2201', E'Do you want to display the Product Model?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', E'22', E'5', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Manufacturer Name',E'PRODUCT_FEATURED_LIST_MANUFACTURER', E'2302', E'Do you want to display the Product Manufacturer Name?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', E'22', E'6', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Price', E'PRODUCT_FEATURED_LIST_PRICE', E'2402', E'Do you want to display the Product Price<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', E'22', E'7', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Weight', E'PRODUCT_FEATURED_LIST_WEIGHT', E'2502', E'Do you want to display the Product Weight?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', E'22', E'8', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Date Added', E'PRODUCT_FEATURED_LIST_DATE_ADDED', E'2601', E'Do you want to display the Product Date Added?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', E'22', E'9', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Display Product Description', E'PRODUCT_FEATURED_LIST_DESCRIPTION', E'1', E'Do you want to display the Product Description - First 150 characters?', E'22', E'10', E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Display Product Display - Default Sort Order', E'PRODUCT_FEATURED_LIST_SORT_DEFAULT', E'1', E'What Sort Order Default should be used for Featured Product Display?<br />Default= 1 for Product Name<br /><br />1= Products Name<br />2= Products Name Desc<br />3= Price low to high, Products Name<br />4= Price high to low, Products Name<br />5= Model<br />6= Date Added desc<br />7= Date Added<br />8= Product Sort Order', E'22', E'11', E'zen_cfg_select_option(array(\'1\', \'2\', \'3\', \'4\', \'5\', \'6\', \'7\', \'8\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Default Featured Products Group ID', E'PRODUCT_FEATURED_LIST_GROUP_ID', E'22', E'Warning: Only change this if your Featured Products Group ID has changed from the default of 22<br />What is the configuration_group_id for Featured Products Listings?', E'22', E'12', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Display Multiple Products Qty Box Status and Set Button Location', E'PRODUCT_FEATURED_LISTING_MULTIPLE_ADD_TO_CART', E'3', E'Do you want to display Add Multiple Products Qty Box and Set Button Location?<br />0= off<br />1= Top<br />2= Bottom<br />3= Both', E'22', E'25', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\', \'3\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Image', E'PRODUCT_ALL_LIST_IMAGE', E'1102', E'Do you want to display the Product Image?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', E'23', E'1', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Quantity', E'PRODUCT_ALL_LIST_QUANTITY', E'1202', E'Do you want to display the Product Quantity?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', E'23', E'2', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Buy Now Button', E'PRODUCT_ALL_BUY_NOW', E'1300', E'Do you want to display the Product Buy Now Button<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', E'23', E'3', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Name', E'PRODUCT_ALL_LIST_NAME', E'2101', E'Do you want to display the Product Name?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', E'23', E'4', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Model', E'PRODUCT_ALL_LIST_MODEL', E'2201', E'Do you want to display the Product Model?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', E'23', E'5', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Manufacturer Name',E'PRODUCT_ALL_LIST_MANUFACTURER', E'2302', E'Do you want to display the Product Manufacturer Name?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', E'23', E'6', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Price', E'PRODUCT_ALL_LIST_PRICE', E'2402', E'Do you want to display the Product Price<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', E'23', E'7', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Weight', E'PRODUCT_ALL_LIST_WEIGHT', E'2502', E'Do you want to display the Product Weight?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', E'23', E'8', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Display Product Date Added', E'PRODUCT_ALL_LIST_DATE_ADDED', E'2601', E'Do you want to display the Product Date Added?<br /><br />0= off<br />1st digit Left or Right<br />2nd and 3rd digit Sort Order<br />4th digit number of breaks after<br />', E'23', E'9', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Display Product Description', E'PRODUCT_ALL_LIST_DESCRIPTION', E'1', E'Do you want to display the Product Description - First 150 characters?', E'23', E'10', E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Display Product Display - Default Sort Order', E'PRODUCT_ALL_LIST_SORT_DEFAULT', E'1', E'What Sort Order Default should be used for All Products Display?<br />Default= 1 for Product Name<br /><br />1= Products Name<br />2= Products Name Desc<br />3= Price low to high, Products Name<br />4= Price high to low, Products Name<br />5= Model<br />6= Date Added desc<br />7= Date Added<br />8= Product Sort Order', E'23', E'11', E'zen_cfg_select_option(array(\'1\', \'2\', \'3\', \'4\', \'5\', \'6\', \'7\', \'8\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (E'Default Products All Group ID', E'PRODUCT_ALL_LIST_GROUP_ID', E'23', E'Warning: Only change this if your Products All Group ID has changed from the default of 23<br />What is the configuration_group_id for Products All Listings?', E'23', E'12', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Display Multiple Products Qty Box Status and Set Button Location', E'PRODUCT_ALL_LISTING_MULTIPLE_ADD_TO_CART', E'3', E'Do you want to display Add Multiple Products Qty Box and Set Button Location?<br />0= off<br />1= Top<br />2= Bottom<br />3= Both', E'23', E'25', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\', \'3\'), ', now());
 


INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Show New Products on Main Page', E'SHOW_PRODUCT_INFO_MAIN_NEW_PRODUCTS', E'1', E'Show New Products on Main Page<br />0= off or set the sort order', E'24', E'65', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\', \'3\', \'4\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Show Featured Products on Main Page', E'SHOW_PRODUCT_INFO_MAIN_FEATURED_PRODUCTS', E'2', E'Show Featured Products on Main Page<br />0= off or set the sort order', E'24', E'66', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\', \'3\', \'4\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Show Special Products on Main Page', E'SHOW_PRODUCT_INFO_MAIN_SPECIALS_PRODUCTS', E'3', E'Show Special Products on Main Page<br />0= off or set the sort order', E'24', E'67', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\', \'3\', \'4\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Show Upcoming Products on Main Page', E'SHOW_PRODUCT_INFO_MAIN_UPCOMING', E'4', E'Show Upcoming Products on Main Page<br />0= off or set the sort order', E'24', E'68', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\', \'3\', \'4\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Show New Products on Main Page - Category with SubCategories', E'SHOW_PRODUCT_INFO_CATEGORY_NEW_PRODUCTS', E'1', E'Show New Products on Main Page - Category with SubCategories<br />0= off or set the sort order', E'24', E'70', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\', \'3\', \'4\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Show Featured Products on Main Page - Category with SubCategories', E'SHOW_PRODUCT_INFO_CATEGORY_FEATURED_PRODUCTS', E'2', E'Show Featured Products on Main Page - Category with SubCategories<br />0= off or set the sort order', E'24', E'71', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\', \'3\', \'4\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Show Special Products on Main Page - Category with SubCategories', E'SHOW_PRODUCT_INFO_CATEGORY_SPECIALS_PRODUCTS', E'3', E'Show Special Products on Main Page - Category with SubCategories<br />0= off or set the sort order', E'24', E'72', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\', \'3\', \'4\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Show Upcoming Products on Main Page - Category with SubCategories', E'SHOW_PRODUCT_INFO_CATEGORY_UPCOMING', E'4', E'Show Upcoming Products on Main Page - Category with SubCategories<br />0= off or set the sort order', E'24', E'73', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\', \'3\', \'4\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Show New Products on Main Page - Errors and Missing Products Page', E'SHOW_PRODUCT_INFO_MISSING_NEW_PRODUCTS', E'1', E'Show New Products on Main Page - Errors and Missing Product<br />0= off or set the sort order', E'24', E'75', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\', \'3\', \'4\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Show Featured Products on Main Page - Errors and Missing Products Page', E'SHOW_PRODUCT_INFO_MISSING_FEATURED_PRODUCTS', E'2', E'Show Featured Products on Main Page - Errors and Missing Product<br />0= off or set the sort order', E'24', E'76', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\', \'3\', \'4\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Show Special Products on Main Page - Errors and Missing Products Page', E'SHOW_PRODUCT_INFO_MISSING_SPECIALS_PRODUCTS', E'3', E'Show Special Products on Main Page - Errors and Missing Product<br />0= off or set the sort order', E'24', E'77', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\', \'3\', \'4\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Show Upcoming Products on Main Page - Errors and Missing Products Page', E'SHOW_PRODUCT_INFO_MISSING_UPCOMING', E'4', E'Show Upcoming Products on Main Page - Errors and Missing Product<br />0= off or set the sort order', E'24', E'78', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\', \'3\', \'4\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Show New Products - below Product Listing', E'SHOW_PRODUCT_INFO_LISTING_BELOW_NEW_PRODUCTS', E'1', E'Show New Products below Product Listing<br />0= off or set the sort order', E'24', E'85', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\', \'3\', \'4\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Show Featured Products - below Product Listing', E'SHOW_PRODUCT_INFO_LISTING_BELOW_FEATURED_PRODUCTS', E'2', E'Show Featured Products below Product Listing<br />0= off or set the sort order', E'24', E'86', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\', \'3\', \'4\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Show Special Products - below Product Listing', E'SHOW_PRODUCT_INFO_LISTING_BELOW_SPECIALS_PRODUCTS', E'3', E'Show Special Products below Product Listing<br />0= off or set the sort order', E'24', E'87', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\', \'3\', \'4\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Show Upcoming Products - below Product Listing', E'SHOW_PRODUCT_INFO_LISTING_BELOW_UPCOMING', E'4', E'Show Upcoming Products below Product Listing<br />0= off or set the sort order', E'24', E'88', E'zen_cfg_select_option(array(\'0\', \'1\', \'2\', \'3\', \'4\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'New Products Columns per Row', E'SHOW_PRODUCT_INFO_COLUMNS_NEW_PRODUCTS', E'3', E'New Products Columns per Row', E'24', E'95', E'zen_cfg_select_option(array(\'1\', \'2\', \'3\', \'4\', \'5\', \'6\', \'7\', \'8\', \'9\', \'10\', \'11\', \'12\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Featured Products Columns per Row', E'SHOW_PRODUCT_INFO_COLUMNS_FEATURED_PRODUCTS', E'3', E'Featured Products Columns per Row', E'24', E'96', E'zen_cfg_select_option(array(\'1\', \'2\', \'3\', \'4\', \'5\', \'6\', \'7\', \'8\', \'9\', \'10\', \'11\', \'12\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Special Products Columns per Row', E'SHOW_PRODUCT_INFO_COLUMNS_SPECIALS_PRODUCTS', E'3', E'Special Products Columns per Row', E'24', E'97', E'zen_cfg_select_option(array(\'1\', \'2\', \'3\', \'4\', \'5\', \'6\', \'7\', \'8\', \'9\', \'10\', \'11\', \'12\'), ', now());
 

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'Filter Product Listing for Current Top Level Category When Enabled', E'SHOW_PRODUCT_INFO_ALL_PRODUCTS', E'1', E'Filter the products when Product Listing is enabled for current Main Category or show products from all categories?<br />0= Filter Off 1=Filter On ', E'24', E'100', E'zen_cfg_select_option(array(\'0\', \'1\'), ', now());
 

--Define Page Status
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Define Main Page Status', E'DEFINE_MAIN_PAGE_STATUS', E'1', E'Enable the Defined Main Page Link/Text?<br />0= Link ON, Define Text OFF<br />1= Link ON, Define Text ON<br />2= Link OFF, Define Text ON<br />3= Link OFF, Define Text OFF', E'25', E'60', now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (array(\'0\', \'1\', \'2\', \'3\'),');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Define Contact Us Status', E'DEFINE_CONTACT_US_STATUS', E'1', E'Enable the Defined Contact Us Link/Text?<br />0= Link ON, Define Text OFF<br />1= Link ON, Define Text ON<br />2= Link OFF, Define Text ON<br />3= Link OFF, Define Text OFF', E'25', E'61', now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (array(\'0\', \'1\', \'2\', \'3\'),');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Define Privacy Status', E'DEFINE_PRIVACY_STATUS', E'1', E'Enable the Defined Privacy Link/Text?<br />0= Link ON, Define Text OFF<br />1= Link ON, Define Text ON<br />2= Link OFF, Define Text ON<br />3= Link OFF, Define Text OFF', E'25', E'62', now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (array(\'0\', \'1\', \'2\', \'3\'),');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Define Shipping & Returns', E'DEFINE_SHIPPINGINFO_STATUS', E'1', E'Enable the Defined Shipping & Returns Link/Text?<br />0= Link ON, Define Text OFF<br />1= Link ON, Define Text ON<br />2= Link OFF, Define Text ON<br />3= Link OFF, Define Text OFF', E'25', E'63', now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (array(\'0\', \'1\', \'2\', \'3\'),');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Define Conditions of Use', E'DEFINE_CONDITIONS_STATUS', E'1', E'Enable the Defined Conditions of Use Link/Text?<br />0= Link ON, Define Text OFF<br />1= Link ON, Define Text ON<br />2= Link OFF, Define Text ON<br />3= Link OFF, Define Text OFF', E'25', E'64', now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (array(\'0\', \'1\', \'2\', \'3\'),');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Define Checkout Success', E'DEFINE_CHECKOUT_SUCCESS_STATUS', E'1', E'Enable the Defined Checkout Success Link/Text?<br />0= Link ON, Define Text OFF<br />1= Link ON, Define Text ON<br />2= Link OFF, Define Text ON<br />3= Link OFF, Define Text OFF', E'25', E'65', now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (array(\'0\', \'1\', \'2\', \'3\'),');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Define Discount Coupon', E'DEFINE_DISCOUNT_COUPON_STATUS', E'1', E'Enable the Defined Discount Coupon Link/Text?<br />0= Link ON, Define Text OFF<br />1= Link ON, Define Text ON<br />2= Link OFF, Define Text ON<br />3= Link OFF, Define Text OFF', E'25', E'66', now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (array(\'0\', \'1\', \'2\', \'3\'),');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Define Site Map Status', E'DEFINE_SITE_MAP_STATUS', E'1', E'Enable the Defined Site Map Link/Text?<br />0= Link ON, Define Text OFF<br />1= Link ON, Define Text ON<br />2= Link OFF, Define Text ON<br />3= Link OFF, Define Text OFF', E'25', E'67', now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (array(\'0\', \'1\', \'2\', \'3\'),');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Define Page-Not-Found Status', E'DEFINE_PAGE_NOT_FOUND_STATUS', E'1', E'Enable the Defined Page-Not-Found Text from define-pages?<br />0= Define Text OFF<br />1= Define Text ON', E'25', E'67', now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (array(\'0\', \'1\'),');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Define Page 2', E'DEFINE_PAGE_2_STATUS', E'1', E'Enable the Defined Page 2 Link/Text?<br />0= Link ON, Define Text OFF<br />1= Link ON, Define Text ON<br />2= Link OFF, Define Text ON<br />3= Link OFF, Define Text OFF', E'25', E'82', now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (array(\'0\', \'1\', \'2\', \'3\'),');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Define Page 3', E'DEFINE_PAGE_3_STATUS', E'1', E'Enable the Defined Page 3 Link/Text?<br />0= Link ON, Define Text OFF<br />1= Link ON, Define Text ON<br />2= Link OFF, Define Text ON<br />3= Link OFF, Define Text OFF', E'25', E'83', now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (array(\'0\', \'1\', \'2\', \'3\'),');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'Define Page 4', E'DEFINE_PAGE_4_STATUS', E'1', E'Enable the Defined Page 4 Link/Text?<br />0= Link ON, Define Text OFF<br />1= Link ON, Define Text ON<br />2= Link OFF, Define Text ON<br />3= Link OFF, Define Text OFF', E'25', E'84', now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (array(\'0\', \'1\', \'2\', \'3\'),');


--EZ-Pages settings
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'EZ-Pages Display Status - HeaderBar', E'EZPAGES_STATUS_HEADER', E'1', E'Display of EZ-Pages content can be Globally enabled/disabled for the Header Bar<br />0 = Off<br />1 = On<br />2= On ADMIN IP ONLY located in Website Maintenance<br />NOTE: Warning only shows to the Admin and not to the public', 30, 10, E'zen_cfg_select_option(array(\'0\', \'1\', \'2\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'EZ-Pages Display Status - FooterBar', E'EZPAGES_STATUS_FOOTER', E'1', E'Display of EZ-Pages content can be Globally enabled/disabled for the Footer Bar<br />0 = Off<br />1 = On<br />2= On ADMIN IP ONLY located in Website Maintenance<br />NOTE: Warning only shows to the Admin and not to the public', 30, 11, E'zen_cfg_select_option(array(\'0\', \'1\', \'2\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'EZ-Pages Display Status - Sidebox', E'EZPAGES_STATUS_SIDEBOX', E'1', E'Display of EZ-Pages content can be Globally enabled/disabled for the Sidebox<br />0 = Off<br />1 = On<br />2= On ADMIN IP ONLY located in Website Maintenance<br />NOTE: Warning only shows to the Admin and not to the public', 30, 12, E'zen_cfg_select_option(array(\'0\', \'1\', \'2\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'EZ-Pages Header Link Separator', E'EZPAGES_SEPARATOR_HEADER', E'&nbsp;::&nbsp;', E'EZ-Pages Header Link Separator<br />Default = &amp;nbsp;::&amp;nbsp;', 30, 20, NULL, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'EZ-Pages Footer Link Separator', E'EZPAGES_SEPARATOR_FOOTER', E'&nbsp;::&nbsp;', E'EZ-Pages Footer Link Separator<br />Default = &amp;nbsp;::&amp;nbsp;', 30, 21, NULL, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (E'EZ-Pages Prev/Next Buttons', E'EZPAGES_SHOW_PREV_NEXT_BUTTONS', E'2', E'Display Prev/Continue/Next buttons on EZ-Pages pages?<br />0=OFF (no buttons)<br />1=Continue<br />2=Prev/Continue/Next<br /><br />Default setting: 2.', 30, 30, E'zen_cfg_select_option(array(\'0\', \'1\', \'2\'), ', now());
 
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'EZ-Pages Table of Contents for Chapters Status', E'EZPAGES_SHOW_TABLE_CONTENTS', E'1', E'Enable EZ-Pages Table of Contents for Chapters?<br />0= OFF<br />1= ON', 30, 35, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES ();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (array(\'0\', \'1\'),');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'EZ-Pages Pages to disable headers', E'EZPAGES_DISABLE_HEADER_DISPLAY_LIST', E'', E'EZ-Pages pages on which to NOT display the normal header for your site.<br />Simply list page ID numbers separated by commas with no spaces.<br />Page ID numbers can be obtained from the EZ-Pages screen under Admin->Tools.<br />ie: 1,5,2<br />or leave blank.', 30, 40, NULL, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'EZ-Pages Pages to disable footers', E'EZPAGES_DISABLE_FOOTER_DISPLAY_LIST', E'', E'EZ-Pages pages on which to NOT display the normal footer for your site.<br />Simply list page ID numbers separated by commas with no spaces.<br />Page ID numbers can be obtained from the EZ-Pages screen under Admin->Tools.<br />ie: 3,7<br />or leave blank.', 30, 41, NULL, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'EZ-Pages Pages to disable left-column', E'EZPAGES_DISABLE_LEFTCOLUMN_DISPLAY_LIST', E'', E'EZ-Pages pages on which to NOT display the normal left column (of sideboxes) for your site.<br />Simply list page ID numbers separated by commas with no spaces.<br />Page ID numbers can be obtained from the EZ-Pages screen under Admin->Tools.<br />ie: 21<br />or leave blank.', 30, 42, NULL, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (');

INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (E'EZ-Pages Pages to disable right-column', E'EZPAGES_DISABLE_RIGHTCOLUMN_DISPLAY_LIST', E'', E'EZ-Pages pages on which to NOT display the normal right column (of sideboxes) for your site.<br />Simply list page ID numbers separated by commas with no spaces.<br />Page ID numbers can be obtained from the EZ-Pages screen under Admin->Tools.<br />ie: 3,82,13<br />or leave blank.', 30, 43, NULL, now();
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, last_modified, date_added, use_function, set_function) VALUES (');






INSERT INTO configuration_group VALUES (1, E'My Store', E'General information about my store', E'1', E'1');
 
INSERT INTO configuration_group VALUES (2, E'Minimum Values', E'The minimum values for functions / data', E'2', E'1');
 
INSERT INTO configuration_group VALUES (3, E'Maximum Values', E'The maximum values for functions / data', E'3', E'1');
 
INSERT INTO configuration_group VALUES (4, E'Images', E'Image parameters', E'4', E'1');
 
INSERT INTO configuration_group VALUES (5, E'Customer Details', E'Customer account configuration', E'5', E'1');
 
INSERT INTO configuration_group VALUES (6, E'Module Options', E'Hidden from configuration', E'6', E'0');
 
INSERT INTO configuration_group VALUES (7, E'Shipping/Packaging', E'Shipping options available at my store', E'7', E'1');
 
INSERT INTO configuration_group VALUES (8, E'Product Listing', E'Product Listing configuration options', E'8', E'1');
 
INSERT INTO configuration_group VALUES (9, E'Stock', E'Stock configuration options', E'9', E'1');
 
INSERT INTO configuration_group VALUES (10, E'Logging', E'Logging configuration options', E'10', E'1');
 
INSERT INTO configuration_group VALUES (11, E'Regulations', E'Regulation options', E'16', E'1');
 
INSERT INTO configuration_group VALUES (12, E'E-Mail Options', E'General settings for E-Mail transport and HTML E-Mails', E'12', E'1');
 
INSERT INTO configuration_group VALUES (13, E'Attribute Settings', E'Configure products attributes settings', E'13', E'1');
 
INSERT INTO configuration_group VALUES (14, E'GZip Compression', E'GZip compression options', E'14', E'1');
 
INSERT INTO configuration_group VALUES (15, E'Sessions', E'Session options', E'15', E'1');
 
INSERT INTO configuration_group VALUES (16, E'GV Coupons', E'Gift Vouchers and Coupons', E'16', E'1');
 
INSERT INTO configuration_group VALUES (17, E'Credit Cards', E'Credit Cards Accepted', E'17', E'1');
 
INSERT INTO configuration_group VALUES (18, E'Product Info', E'Product Info Display Options', E'18', E'1');
 
INSERT INTO configuration_group VALUES (19, E'Layout Settings', E'Layout Options', E'19', E'1');
 
INSERT INTO configuration_group VALUES (20, E'Website Maintenance', E'Website Maintenance Options', E'20', E'1');
 
INSERT INTO configuration_group VALUES (21, E'New Listing', E'New Products Listing', E'21', E'1');
 
INSERT INTO configuration_group VALUES (22, E'Featured Listing', E'Featured Products Listing', E'22', E'1');
 
INSERT INTO configuration_group VALUES (23, E'All Listing', E'All Products Listing', E'23', E'1');
 
INSERT INTO configuration_group VALUES (24, E'Index Listing', E'Index Products Listing', E'24', E'1');
 
INSERT INTO configuration_group VALUES (25, E'Define Page Status', E'Define Main Pages and HTMLArea Options', E'25', E'1');
 
INSERT INTO configuration_group VALUES (30, E'EZ-Pages Settings', E'EZ-Pages Settings', 30, E'1');
 

INSERT INTO countries VALUES (240,E'Aaland Islands',E'AX',E'ALA',E'1');
 
INSERT INTO countries VALUES (1,E'Afghanistan',E'AF',E'AFG',E'1');
 
INSERT INTO countries VALUES (2,E'Albania',E'AL',E'ALB',E'1');
 
INSERT INTO countries VALUES (3,E'Algeria',E'DZ',E'DZA',E'1');
 
INSERT INTO countries VALUES (4,E'American Samoa',E'AS',E'ASM',E'1');
 
INSERT INTO countries VALUES (5,E'Andorra',E'AD',E'AND',E'1');
 
INSERT INTO countries VALUES (6,E'Angola',E'AO',E'AGO',E'1');
 
INSERT INTO countries VALUES (7,E'Anguilla',E'AI',E'AIA',E'1');
 
INSERT INTO countries VALUES (8,E'Antarctica',E'AQ',E'ATA',E'1');
 
INSERT INTO countries VALUES (9,E'Antigua and Barbuda',E'AG',E'ATG',E'1');
 
INSERT INTO countries VALUES (10,E'Argentina',E'AR',E'ARG',E'1');
 
INSERT INTO countries VALUES (11,E'Armenia',E'AM',E'ARM',E'1');
 
INSERT INTO countries VALUES (12,E'Aruba',E'AW',E'ABW',E'1');
 
INSERT INTO countries VALUES (13,E'Australia',E'AU',E'AUS',E'1');
 
INSERT INTO countries VALUES (14,E'Austria',E'AT',E'AUT',E'5');
 
INSERT INTO countries VALUES (15,E'Azerbaijan',E'AZ',E'AZE',E'1');
 
INSERT INTO countries VALUES (16,E'Bahamas',E'BS',E'BHS',E'1');
 
INSERT INTO countries VALUES (17,E'Bahrain',E'BH',E'BHR',E'1');
 
INSERT INTO countries VALUES (18,E'Bangladesh',E'BD',E'BGD',E'1');
 
INSERT INTO countries VALUES (19,E'Barbados',E'BB',E'BRB',E'1');
 
INSERT INTO countries VALUES (20,E'Belarus',E'BY',E'BLR',E'1');
 
INSERT INTO countries VALUES (21,E'Belgium',E'BE',E'BEL',E'1');
 
INSERT INTO countries VALUES (22,E'Belize',E'BZ',E'BLZ',E'1');
 
INSERT INTO countries VALUES (23,E'Benin',E'BJ',E'BEN',E'1');
 
INSERT INTO countries VALUES (24,E'Bermuda',E'BM',E'BMU',E'1');
 
INSERT INTO countries VALUES (25,E'Bhutan',E'BT',E'BTN',E'1');
 
INSERT INTO countries VALUES (26,E'Bolivia',E'BO',E'BOL',E'1');
 
INSERT INTO countries VALUES (27,E'Bosnia and Herzegowina',E'BA',E'BIH',E'1');
 
INSERT INTO countries VALUES (28,E'Botswana',E'BW',E'BWA',E'1');
 
INSERT INTO countries VALUES (29,E'Bouvet Island',E'BV',E'BVT',E'1');
 
INSERT INTO countries VALUES (30,E'Brazil',E'BR',E'BRA',E'1');
 
INSERT INTO countries VALUES (31,E'British Indian Ocean Territory',E'IO',E'IOT',E'1');
 
INSERT INTO countries VALUES (32,E'Brunei Darussalam',E'BN',E'BRN',E'1');
 
INSERT INTO countries VALUES (33,E'Bulgaria',E'BG',E'BGR',E'1');
 
INSERT INTO countries VALUES (34,E'Burkina Faso',E'BF',E'BFA',E'1');
 
INSERT INTO countries VALUES (35,E'Burundi',E'BI',E'BDI',E'1');
 
INSERT INTO countries VALUES (36,E'Cambodia',E'KH',E'KHM',E'1');
 
INSERT INTO countries VALUES (37,E'Cameroon',E'CM',E'CMR',E'1');
 
INSERT INTO countries VALUES (38,E'Canada',E'CA',E'CAN',E'1');
 
INSERT INTO countries VALUES (39,E'Cape Verde',E'CV',E'CPV',E'1');
 
INSERT INTO countries VALUES (40,E'Cayman Islands',E'KY',E'CYM',E'1');
 
INSERT INTO countries VALUES (41,E'Central African Republic',E'CF',E'CAF',E'1');
 
INSERT INTO countries VALUES (42,E'Chad',E'TD',E'TCD',E'1');
 
INSERT INTO countries VALUES (43,E'Chile',E'CL',E'CHL',E'1');
 
INSERT INTO countries VALUES (44,E'China',E'CN',E'CHN',E'1');
 
INSERT INTO countries VALUES (45,E'Christmas Island',E'CX',E'CXR',E'1');
 
INSERT INTO countries VALUES (46,E'Cocos (Keeling) Islands',E'CC',E'CCK',E'1');
 
INSERT INTO countries VALUES (47,E'Colombia',E'CO',E'COL',E'1');
 
INSERT INTO countries VALUES (48,E'Comoros',E'KM',E'COM',E'1');
 
INSERT INTO countries VALUES (49,E'Congo',E'CG',E'COG',E'1');
 
INSERT INTO countries VALUES (50,E'Cook Islands',E'CK',E'COK',E'1');
 
INSERT INTO countries VALUES (51,E'Costa Rica',E'CR',E'CRI',E'1');
 
INSERT INTO countries VALUES (52,E'Cote D\'Ivoire',E'CI',E'CIV',E'1');
 
INSERT INTO countries VALUES (53,E'Croatia',E'HR',E'HRV',E'1');
 
INSERT INTO countries VALUES (54,E'Cuba',E'CU',E'CUB',E'1');
 
INSERT INTO countries VALUES (55,E'Cyprus',E'CY',E'CYP',E'1');
 
INSERT INTO countries VALUES (56,E'Czech Republic',E'CZ',E'CZE',E'1');
 
INSERT INTO countries VALUES (57,E'Denmark',E'DK',E'DNK',E'1');
 
INSERT INTO countries VALUES (58,E'Djibouti',E'DJ',E'DJI',E'1');
 
INSERT INTO countries VALUES (59,E'Dominica',E'DM',E'DMA',E'1');
 
INSERT INTO countries VALUES (60,E'Dominican Republic',E'DO',E'DOM',E'1');
 
INSERT INTO countries VALUES (61,E'East Timor',E'TP',E'TMP',E'1');
 
INSERT INTO countries VALUES (62,E'Ecuador',E'EC',E'ECU',E'1');
 
INSERT INTO countries VALUES (63,E'Egypt',E'EG',E'EGY',E'1');
 
INSERT INTO countries VALUES (64,E'El Salvador',E'SV',E'SLV',E'1');
 
INSERT INTO countries VALUES (65,E'Equatorial Guinea',E'GQ',E'GNQ',E'1');
 
INSERT INTO countries VALUES (66,E'Eritrea',E'ER',E'ERI',E'1');
 
INSERT INTO countries VALUES (67,E'Estonia',E'EE',E'EST',E'1');
 
INSERT INTO countries VALUES (68,E'Ethiopia',E'ET',E'ETH',E'1');
 
INSERT INTO countries VALUES (69,E'Falkland Islands (Malvinas)',E'FK',E'FLK',E'1');
 
INSERT INTO countries VALUES (70,E'Faroe Islands',E'FO',E'FRO',E'1');
 
INSERT INTO countries VALUES (71,E'Fiji',E'FJ',E'FJI',E'1');
 
INSERT INTO countries VALUES (72,E'Finland',E'FI',E'FIN',E'1');
 
INSERT INTO countries VALUES (73,E'France',E'FR',E'FRA',E'1');
 
INSERT INTO countries VALUES (74,E'France, Metropolitan',E'FX',E'FXX',E'1');
 
INSERT INTO countries VALUES (75,E'French Guiana',E'GF',E'GUF',E'1');
 
INSERT INTO countries VALUES (76,E'French Polynesia',E'PF',E'PYF',E'1');
 
INSERT INTO countries VALUES (77,E'French Southern Territories',E'TF',E'ATF',E'1');
 
INSERT INTO countries VALUES (78,E'Gabon',E'GA',E'GAB',E'1');
 
INSERT INTO countries VALUES (79,E'Gambia',E'GM',E'GMB',E'1');
 
INSERT INTO countries VALUES (80,E'Georgia',E'GE',E'GEO',E'1');
 
INSERT INTO countries VALUES (81,E'Germany',E'DE',E'DEU',E'5');
 
INSERT INTO countries VALUES (82,E'Ghana',E'GH',E'GHA',E'1');
 
INSERT INTO countries VALUES (83,E'Gibraltar',E'GI',E'GIB',E'1');
 
INSERT INTO countries VALUES (84,E'Greece',E'GR',E'GRC',E'1');
 
INSERT INTO countries VALUES (85,E'Greenland',E'GL',E'GRL',E'1');
 
INSERT INTO countries VALUES (86,E'Grenada',E'GD',E'GRD',E'1');
 
INSERT INTO countries VALUES (87,E'Guadeloupe',E'GP',E'GLP',E'1');
 
INSERT INTO countries VALUES (88,E'Guam',E'GU',E'GUM',E'1');
 
INSERT INTO countries VALUES (89,E'Guatemala',E'GT',E'GTM',E'1');
 
INSERT INTO countries VALUES (90,E'Guinea',E'GN',E'GIN',E'1');
 
INSERT INTO countries VALUES (91,E'Guinea-bissau',E'GW',E'GNB',E'1');
 
INSERT INTO countries VALUES (92,E'Guyana',E'GY',E'GUY',E'1');
 
INSERT INTO countries VALUES (93,E'Haiti',E'HT',E'HTI',E'1');
 
INSERT INTO countries VALUES (94,E'Heard and Mc Donald Islands',E'HM',E'HMD',E'1');
 
INSERT INTO countries VALUES (95,E'Honduras',E'HN',E'HND',E'1');
 
INSERT INTO countries VALUES (96,E'Hong Kong',E'HK',E'HKG',E'1');
 
INSERT INTO countries VALUES (97,E'Hungary',E'HU',E'HUN',E'1');
 
INSERT INTO countries VALUES (98,E'Iceland',E'IS',E'ISL',E'1');
 
INSERT INTO countries VALUES (99,E'India',E'IN',E'IND',E'1');
 
INSERT INTO countries VALUES (100,E'Indonesia',E'ID',E'IDN',E'1');
 
INSERT INTO countries VALUES (101,E'Iran (Islamic Republic of)',E'IR',E'IRN',E'1');
 
INSERT INTO countries VALUES (102,E'Iraq',E'IQ',E'IRQ',E'1');
 
INSERT INTO countries VALUES (103,E'Ireland',E'IE',E'IRL',E'1');
 
INSERT INTO countries VALUES (104,E'Israel',E'IL',E'ISR',E'1');
 
INSERT INTO countries VALUES (105,E'Italy',E'IT',E'ITA',E'1');
 
INSERT INTO countries VALUES (106,E'Jamaica',E'JM',E'JAM',E'1');
 
INSERT INTO countries VALUES (107,E'Japan',E'JP',E'JPN',E'1');
 
INSERT INTO countries VALUES (108,E'Jordan',E'JO',E'JOR',E'1');
 
INSERT INTO countries VALUES (109,E'Kazakhstan',E'KZ',E'KAZ',E'1');
 
INSERT INTO countries VALUES (110,E'Kenya',E'KE',E'KEN',E'1');
 
INSERT INTO countries VALUES (111,E'Kiribati',E'KI',E'KIR',E'1');
 
INSERT INTO countries VALUES (112,E'Korea, Democratic People\'s Republic of',E'KP',E'PRK',E'1');
 
INSERT INTO countries VALUES (113,E'Korea, Republic of',E'KR',E'KOR',E'1');
 
INSERT INTO countries VALUES (114,E'Kuwait',E'KW',E'KWT',E'1');
 
INSERT INTO countries VALUES (115,E'Kyrgyzstan',E'KG',E'KGZ',E'1');
 
INSERT INTO countries VALUES (116,E'Lao People\'s Democratic Republic',E'LA',E'LAO',E'1');
 
INSERT INTO countries VALUES (117,E'Latvia',E'LV',E'LVA',E'1');
 
INSERT INTO countries VALUES (118,E'Lebanon',E'LB',E'LBN',E'1');
 
INSERT INTO countries VALUES (119,E'Lesotho',E'LS',E'LSO',E'1');
 
INSERT INTO countries VALUES (120,E'Liberia',E'LR',E'LBR',E'1');
 
INSERT INTO countries VALUES (121,E'Libyan Arab Jamahiriya',E'LY',E'LBY',E'1');
 
INSERT INTO countries VALUES (122,E'Liechtenstein',E'LI',E'LIE',E'1');
 
INSERT INTO countries VALUES (123,E'Lithuania',E'LT',E'LTU',E'1');
 
INSERT INTO countries VALUES (124,E'Luxembourg',E'LU',E'LUX',E'1');
 
INSERT INTO countries VALUES (125,E'Macau',E'MO',E'MAC',E'1');
 
INSERT INTO countries VALUES (126,E'Macedonia, The Former Yugoslav Republic of',E'MK',E'MKD',E'1');
 
INSERT INTO countries VALUES (127,E'Madagascar',E'MG',E'MDG',E'1');
 
INSERT INTO countries VALUES (128,E'Malawi',E'MW',E'MWI',E'1');
 
INSERT INTO countries VALUES (129,E'Malaysia',E'MY',E'MYS',E'1');
 
INSERT INTO countries VALUES (130,E'Maldives',E'MV',E'MDV',E'1');
 
INSERT INTO countries VALUES (131,E'Mali',E'ML',E'MLI',E'1');
 
INSERT INTO countries VALUES (132,E'Malta',E'MT',E'MLT',E'1');
 
INSERT INTO countries VALUES (133,E'Marshall Islands',E'MH',E'MHL',E'1');
 
INSERT INTO countries VALUES (134,E'Martinique',E'MQ',E'MTQ',E'1');
 
INSERT INTO countries VALUES (135,E'Mauritania',E'MR',E'MRT',E'1');
 
INSERT INTO countries VALUES (136,E'Mauritius',E'MU',E'MUS',E'1');
 
INSERT INTO countries VALUES (137,E'Mayotte',E'YT',E'MYT',E'1');
 
INSERT INTO countries VALUES (138,E'Mexico',E'MX',E'MEX',E'1');
 
INSERT INTO countries VALUES (139,E'Micronesia, Federated States of',E'FM',E'FSM',E'1');
 
INSERT INTO countries VALUES (140,E'Moldova, Republic of',E'MD',E'MDA',E'1');
 
INSERT INTO countries VALUES (141,E'Monaco',E'MC',E'MCO',E'1');
 
INSERT INTO countries VALUES (142,E'Mongolia',E'MN',E'MNG',E'1');
 
INSERT INTO countries VALUES (143,E'Montserrat',E'MS',E'MSR',E'1');
 
INSERT INTO countries VALUES (144,E'Morocco',E'MA',E'MAR',E'1');
 
INSERT INTO countries VALUES (145,E'Mozambique',E'MZ',E'MOZ',E'1');
 
INSERT INTO countries VALUES (146,E'Myanmar',E'MM',E'MMR',E'1');
 
INSERT INTO countries VALUES (147,E'Namibia',E'NA',E'NAM',E'1');
 
INSERT INTO countries VALUES (148,E'Nauru',E'NR',E'NRU',E'1');
 
INSERT INTO countries VALUES (149,E'Nepal',E'NP',E'NPL',E'1');
 
INSERT INTO countries VALUES (150,E'Netherlands',E'NL',E'NLD',E'1');
 
INSERT INTO countries VALUES (151,E'Netherlands Antilles',E'AN',E'ANT',E'1');
 
INSERT INTO countries VALUES (152,E'New Caledonia',E'NC',E'NCL',E'1');
 
INSERT INTO countries VALUES (153,E'New Zealand',E'NZ',E'NZL',E'1');
 
INSERT INTO countries VALUES (154,E'Nicaragua',E'NI',E'NIC',E'1');
 
INSERT INTO countries VALUES (155,E'Niger',E'NE',E'NER',E'1');
 
INSERT INTO countries VALUES (156,E'Nigeria',E'NG',E'NGA',E'1');
 
INSERT INTO countries VALUES (157,E'Niue',E'NU',E'NIU',E'1');
 
INSERT INTO countries VALUES (158,E'Norfolk Island',E'NF',E'NFK',E'1');
 
INSERT INTO countries VALUES (159,E'Northern Mariana Islands',E'MP',E'MNP',E'1');
 
INSERT INTO countries VALUES (160,E'Norway',E'NO',E'NOR',E'1');
 
INSERT INTO countries VALUES (161,E'Oman',E'OM',E'OMN',E'1');
 
INSERT INTO countries VALUES (162,E'Pakistan',E'PK',E'PAK',E'1');
 
INSERT INTO countries VALUES (163,E'Palau',E'PW',E'PLW',E'1');
 
INSERT INTO countries VALUES (164,E'Panama',E'PA',E'PAN',E'1');
 
INSERT INTO countries VALUES (165,E'Papua New Guinea',E'PG',E'PNG',E'1');
 
INSERT INTO countries VALUES (166,E'Paraguay',E'PY',E'PRY',E'1');
 
INSERT INTO countries VALUES (167,E'Peru',E'PE',E'PER',E'1');
 
INSERT INTO countries VALUES (168,E'Philippines',E'PH',E'PHL',E'1');
 
INSERT INTO countries VALUES (169,E'Pitcairn',E'PN',E'PCN',E'1');
 
INSERT INTO countries VALUES (170,E'Poland',E'PL',E'POL',E'1');
 
INSERT INTO countries VALUES (171,E'Portugal',E'PT',E'PRT',E'1');
 
INSERT INTO countries VALUES (172,E'Puerto Rico',E'PR',E'PRI',E'1');
 
INSERT INTO countries VALUES (173,E'Qatar',E'QA',E'QAT',E'1');
 
INSERT INTO countries VALUES (174,E'Reunion',E'RE',E'REU',E'1');
 
INSERT INTO countries VALUES (175,E'Romania',E'RO',E'ROM',E'1');
 
INSERT INTO countries VALUES (176,E'Russian Federation',E'RU',E'RUS',E'1');
 
INSERT INTO countries VALUES (177,E'Rwanda',E'RW',E'RWA',E'1');
 
INSERT INTO countries VALUES (178,E'Saint Kitts and Nevis',E'KN',E'KNA',E'1');
 
INSERT INTO countries VALUES (179,E'Saint Lucia',E'LC',E'LCA',E'1');
 
INSERT INTO countries VALUES (180,E'Saint Vincent and the Grenadines',E'VC',E'VCT',E'1');
 
INSERT INTO countries VALUES (181,E'Samoa',E'WS',E'WSM',E'1');
 
INSERT INTO countries VALUES (182,E'San Marino',E'SM',E'SMR',E'1');
 
INSERT INTO countries VALUES (183,E'Sao Tome and Principe',E'ST',E'STP',E'1');
 
INSERT INTO countries VALUES (184,E'Saudi Arabia',E'SA',E'SAU',E'1');
 
INSERT INTO countries VALUES (185,E'Senegal',E'SN',E'SEN',E'1');
 
INSERT INTO countries VALUES (186,E'Seychelles',E'SC',E'SYC',E'1');
 
INSERT INTO countries VALUES (187,E'Sierra Leone',E'SL',E'SLE',E'1');
 
INSERT INTO countries VALUES (188,E'Singapore',E'SG',E'SGP', E'4');
 
INSERT INTO countries VALUES (189,E'Slovakia (Slovak Republic)',E'SK',E'SVK',E'1');
 
INSERT INTO countries VALUES (190,E'Slovenia',E'SI',E'SVN',E'1');
 
INSERT INTO countries VALUES (191,E'Solomon Islands',E'SB',E'SLB',E'1');
 
INSERT INTO countries VALUES (192,E'Somalia',E'SO',E'SOM',E'1');
 
INSERT INTO countries VALUES (193,E'South Africa',E'ZA',E'ZAF',E'1');
 
INSERT INTO countries VALUES (194,E'South Georgia and the South Sandwich Islands',E'GS',E'SGS',E'1');
 
INSERT INTO countries VALUES (195,E'Spain',E'ES',E'ESP',E'3');
 
INSERT INTO countries VALUES (196,E'Sri Lanka',E'LK',E'LKA',E'1');
 
INSERT INTO countries VALUES (197,E'St. Helena',E'SH',E'SHN',E'1');
 
INSERT INTO countries VALUES (198,E'St. Pierre and Miquelon',E'PM',E'SPM',E'1');
 
INSERT INTO countries VALUES (199,E'Sudan',E'SD',E'SDN',E'1');
 
INSERT INTO countries VALUES (200,E'Suriname',E'SR',E'SUR',E'1');
 
INSERT INTO countries VALUES (201,E'Svalbard and Jan Mayen Islands',E'SJ',E'SJM',E'1');
 
INSERT INTO countries VALUES (202,E'Swaziland',E'SZ',E'SWZ',E'1');
 
INSERT INTO countries VALUES (203,E'Sweden',E'SE',E'SWE',E'1');
 
INSERT INTO countries VALUES (204,E'Switzerland',E'CH',E'CHE',E'1');
 
INSERT INTO countries VALUES (205,E'Syrian Arab Republic',E'SY',E'SYR',E'1');
 
INSERT INTO countries VALUES (206,E'Taiwan',E'TW',E'TWN',E'1');
 
INSERT INTO countries VALUES (207,E'Tajikistan',E'TJ',E'TJK',E'1');
 
INSERT INTO countries VALUES (208,E'Tanzania, United Republic of',E'TZ',E'TZA',E'1');
 
INSERT INTO countries VALUES (209,E'Thailand',E'TH',E'THA',E'1');
 
INSERT INTO countries VALUES (210,E'Togo',E'TG',E'TGO',E'1');
 
INSERT INTO countries VALUES (211,E'Tokelau',E'TK',E'TKL',E'1');
 
INSERT INTO countries VALUES (212,E'Tonga',E'TO',E'TON',E'1');
 
INSERT INTO countries VALUES (213,E'Trinidad and Tobago',E'TT',E'TTO',E'1');
 
INSERT INTO countries VALUES (214,E'Tunisia',E'TN',E'TUN',E'1');
 
INSERT INTO countries VALUES (215,E'Turkey',E'TR',E'TUR',E'1');
 
INSERT INTO countries VALUES (216,E'Turkmenistan',E'TM',E'TKM',E'1');
 
INSERT INTO countries VALUES (217,E'Turks and Caicos Islands',E'TC',E'TCA',E'1');
 
INSERT INTO countries VALUES (218,E'Tuvalu',E'TV',E'TUV',E'1');
 
INSERT INTO countries VALUES (219,E'Uganda',E'UG',E'UGA',E'1');
 
INSERT INTO countries VALUES (220,E'Ukraine',E'UA',E'UKR',E'1');
 
INSERT INTO countries VALUES (221,E'United Arab Emirates',E'AE',E'ARE',E'1');
 
INSERT INTO countries VALUES (222,E'United Kingdom',E'GB',E'GBR',E'6');
 
INSERT INTO countries VALUES (223,E'United States',E'US',E'USA', E'2');
 
INSERT INTO countries VALUES (224,E'United States Minor Outlying Islands',E'UM',E'UMI',E'1');
 
INSERT INTO countries VALUES (225,E'Uruguay',E'UY',E'URY',E'1');
 
INSERT INTO countries VALUES (226,E'Uzbekistan',E'UZ',E'UZB',E'1');
 
INSERT INTO countries VALUES (227,E'Vanuatu',E'VU',E'VUT',E'1');
 
INSERT INTO countries VALUES (228,E'Vatican City State (Holy See)',E'VA',E'VAT',E'1');
 
INSERT INTO countries VALUES (229,E'Venezuela',E'VE',E'VEN',E'1');
 
INSERT INTO countries VALUES (230,E'Viet Nam',E'VN',E'VNM',E'1');
 
INSERT INTO countries VALUES (231,E'Virgin Islands (British)',E'VG',E'VGB',E'1');
 
INSERT INTO countries VALUES (232,E'Virgin Islands (U.S.)',E'VI',E'VIR',E'1');
 
INSERT INTO countries VALUES (233,E'Wallis and Futuna Islands',E'WF',E'WLF',E'1');
 
INSERT INTO countries VALUES (234,E'Western Sahara',E'EH',E'ESH',E'1');
 
INSERT INTO countries VALUES (235,E'Yemen',E'YE',E'YEM',E'1');
 
INSERT INTO countries VALUES (236,E'Yugoslavia',E'YU',E'YUG',E'1');
 
INSERT INTO countries VALUES (237,E'Zaire',E'ZR',E'ZAR',E'1');
 
INSERT INTO countries VALUES (238,E'Zambia',E'ZM',E'ZMB',E'1');
 
INSERT INTO countries VALUES (239,E'Zimbabwe',E'ZW',E'ZWE',E'1');
 

INSERT INTO currencies VALUES (1,E'US Dollar',E'USD',E'$',E'',E'.',E',',E'2',E'1.0000', now());
 
INSERT INTO currencies VALUES (2,E'Euro',E'EUR',E'&euro;',E'',E'.',E',',E'2',E'0.7811', now());
 
INSERT INTO currencies VALUES (3,E'GB Pound',E'GBP',E'&pound;',E'',E'.',E',',E'2',E'0.5289', now());
 
INSERT INTO currencies VALUES (4,E'Canadian Dollar',E'CAD',E'$',E'',E'.',E',',E'2',E'1.1113', now());
 
INSERT INTO currencies VALUES (5,E'Australian Dollar',E'AUD',E'$',E'',E'.',E',',E'2',E'1.3097', now());
 

--INSERT INTO currencies VALUES (6,'Japanese Yen','JPY','&yen;','','.',',','2','116.3889', now());
INSERT INTO languages VALUES (1,E'English',E'en',E'icon.gif',E'english',1);
 

INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'default_template_settings', E'banner_box_all.php', 1, 1, 5, 0, 0);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'default_template_settings', E'banner_box.php', 1, 0, 300, 1, 127);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'default_template_settings', E'banner_box2.php', 1, 1, 15, 1, 15);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'default_template_settings', E'best_sellers.php', 1, 1, 30, 70, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'default_template_settings', E'categories.php', 1, 0, 10, 10, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'default_template_settings', E'currencies.php', 1, 1, 80, 60, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'default_template_settings', E'document_categories.php', 1, 0, 0, 0, 0);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'default_template_settings', E'ezpages.php', 1, 1, -1, 2, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'default_template_settings', E'featured.php', 1, 0, 45, 0, 0);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'default_template_settings', E'information.php', 1, 0, 50, 40, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'default_template_settings', E'languages.php', 1, 1, 70, 50, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'default_template_settings', E'manufacturers.php', 1, 0, 30, 20, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'default_template_settings', E'manufacturer_info.php', 1, 1, 35, 95, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'default_template_settings', E'more_information.php', 1, 0, 200, 200, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'default_template_settings', E'music_genres.php', 1, 1, 0, 0, 0);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'default_template_settings', E'order_history.php', 1, 1, 0, 0, 0);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'default_template_settings', E'product_notifications.php', 1, 1, 55, 85, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'default_template_settings', E'record_companies.php', 1, 1, 0, 0, 0);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'default_template_settings', E'reviews.php', 1, 0, 40, 0, 0);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'default_template_settings', E'search.php', 1, 1, 10, 0, 0);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'default_template_settings', E'search_header.php', 0, 0, 0, 0, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'default_template_settings', E'shopping_cart.php', 1, 1, 20, 30, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'default_template_settings', E'specials.php', 1, 1, 45, 0, 0);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'default_template_settings', E'tell_a_friend.php', 1, 1, 65, 0, 0);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'default_template_settings', E'whats_new.php', 1, 0, 20, 0, 0);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'default_template_settings', E'whos_online.php', 1, 1, 200, 200, 1);
 

INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'template_default', E'banner_box_all.php', 1, 1, 5, 0, 0);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'template_default', E'banner_box.php', 1, 0, 300, 1, 127);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'template_default', E'banner_box2.php', 1, 1, 15, 1, 15);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'template_default', E'best_sellers.php', 1, 1, 30, 70, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'template_default', E'categories.php', 1, 0, 10, 10, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'template_default', E'currencies.php', 1, 1, 80, 60, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'template_default', E'ezpages.php', 1, 1, -1, 2, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'template_default', E'featured.php', 1, 0, 45, 0, 0);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'template_default', E'information.php', 1, 0, 50, 40, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'template_default', E'languages.php', 1, 1, 70, 50, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'template_default', E'manufacturers.php', 1, 0, 30, 20, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'template_default', E'manufacturer_info.php', 1, 1, 35, 95, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'template_default', E'more_information.php', 1, 0, 200, 200, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'template_default', E'my_broken_box.php', 1, 0, 0, 0, 0);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'template_default', E'order_history.php', 1, 1, 0, 0, 0);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'template_default', E'product_notifications.php', 1, 1, 55, 85, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'template_default', E'reviews.php', 1, 0, 40, 0, 0);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'template_default', E'search.php', 1, 1, 10, 0, 0);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'template_default', E'search_header.php', 0, 0, 0, 0, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'template_default', E'shopping_cart.php', 1, 1, 20, 30, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'template_default', E'specials.php', 1, 1, 45, 0, 0);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'template_default', E'tell_a_friend.php', 1, 1, 65, 0, 0);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'template_default', E'whats_new.php', 1, 0, 20, 0, 0);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'template_default', E'whos_online.php', 1, 1, 200, 200, 1);
 

INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'classic', E'banner_box.php', 1, 0, 300, 1, 127);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'classic', E'banner_box2.php', 1, 1, 15, 1, 15);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'classic', E'banner_box_all.php', 1, 1, 5, 0, 0);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'classic', E'best_sellers.php', 1, 1, 30, 70, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'classic', E'categories.php', 1, 0, 10, 10, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'classic', E'currencies.php', 1, 1, 80, 60, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'classic', E'document_categories.php', 1, 0, 0, 0, 0);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'classic', E'ezpages.php', 1, 1, -1, 2, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'classic', E'featured.php', 1, 0, 45, 0, 0);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'classic', E'information.php', 1, 0, 50, 40, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'classic', E'languages.php', 1, 1, 70, 50, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'classic', E'manufacturers.php', 1, 0, 30, 20, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'classic', E'manufacturer_info.php', 1, 1, 35, 95, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'classic', E'more_information.php', 1, 0, 200, 200, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'classic', E'music_genres.php', 1, 1, 0, 0, 0);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'classic', E'order_history.php', 1, 1, 0, 0, 0);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'classic', E'product_notifications.php', 1, 1, 55, 85, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'classic', E'record_companies.php', 1, 1, 0, 0, 0);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'classic', E'reviews.php', 1, 0, 40, 0, 0);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'classic', E'search.php', 1, 1, 10, 0, 0);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'classic', E'search_header.php', 0, 0, 0, 0, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'classic', E'shopping_cart.php', 1, 1, 20, 30, 1);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'classic', E'specials.php', 1, 1, 45, 0, 0);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'classic', E'tell_a_friend.php', 1, 1, 65, 0, 0);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'classic', E'whats_new.php', 1, 0, 20, 0, 0);
 
INSERT INTO layout_boxes (layout_template, layout_box_name, layout_box_status, layout_box_location, layout_box_sort_order, layout_box_sort_order_single, layout_box_status_single) VALUES (E'classic', E'whos_online.php', 1, 1, 200, 200, 1);
 

INSERT INTO orders_status VALUES ( E'1', E'1', E'Pending');
 
INSERT INTO orders_status VALUES ( E'2', E'1', E'Processing');
 
INSERT INTO orders_status VALUES ( E'3', E'1', E'Delivered');
 
INSERT INTO orders_status VALUES ( E'4', E'1', E'Update');
 

INSERT INTO product_types VALUES (1, E'Product - General', E'product', E'1', E'Y', E'', now();
INSERT INTO product_types VALUES ();

INSERT INTO product_types VALUES (2, E'Product - Music', E'product_music', E'1', E'Y', E'', now();
INSERT INTO product_types VALUES ();

INSERT INTO product_types VALUES (3, E'Document - General', E'document_general', E'3', E'N', E'', now();
INSERT INTO product_types VALUES ();

INSERT INTO product_types VALUES (4, E'Document - Product', E'document_product', E'3', E'Y', E'', now();
INSERT INTO product_types VALUES ();

INSERT INTO product_types VALUES (5, E'Product - Free Shipping', E'product_free_shipping', E'1', E'Y', E'', now();
INSERT INTO product_types VALUES ();


INSERT INTO products_options_types (products_options_types_id, products_options_types_name) VALUES (0, E' --DROPdown');
 
INSERT INTO products_options_types (products_options_types_id, products_options_types_name) VALUES (1, E'Text');
 
INSERT INTO products_options_types (products_options_types_id, products_options_types_name) VALUES (2, E'Radio');
 
INSERT INTO products_options_types (products_options_types_id, products_options_types_name) VALUES (3, E'Checkbox');
 
INSERT INTO products_options_types (products_options_types_id, products_options_types_name) VALUES (4, E'File');
 
INSERT INTO products_options_types (products_options_types_id, products_options_types_name) VALUES (5, E'Read Only');
 

INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (0, 1, E'TEXT');
 

-- USA/Florida
INSERT INTO tax_rates VALUES (1, 1, 1, 1, 7.0, E'FL TAX 7.0%', now();
INSERT INTO tax_rates VALUES ();

INSERT INTO geo_zones (geo_zone_id, geo_zone_name, geo_zone_description, date_added) VALUES (1,E'Florida',E'Florida local sales tax zone',now());
 
INSERT INTO zones_to_geo_zones (association_id, zone_country_id, zone_id, geo_zone_id, date_added) VALUES (1,223,18,1,now());
 
INSERT INTO tax_class (tax_class_id, tax_class_title, tax_class_description, date_added) VALUES (1, E'Taxable Goods', E'The following types of products are included: non-food, services, etc', now());
 

-- USA
INSERT INTO zones VALUES (1,223,E'AL',E'Alabama');
 
INSERT INTO zones VALUES (2,223,E'AK',E'Alaska');
 
INSERT INTO zones VALUES (3,223,E'AS',E'American Samoa');
 
INSERT INTO zones VALUES (4,223,E'AZ',E'Arizona');
 
INSERT INTO zones VALUES (5,223,E'AR',E'Arkansas');
 
INSERT INTO zones VALUES (6,223,E'AF',E'Armed Forces Africa');
 
INSERT INTO zones VALUES (7,223,E'AA',E'Armed Forces Americas');
 
INSERT INTO zones VALUES (8,223,E'AC',E'Armed Forces Canada');
 
INSERT INTO zones VALUES (9,223,E'AE',E'Armed Forces Europe');
 
INSERT INTO zones VALUES (10,223,E'AM',E'Armed Forces Middle East');
 
INSERT INTO zones VALUES (11,223,E'AP',E'Armed Forces Pacific');
 
INSERT INTO zones VALUES (12,223,E'CA',E'California');
 
INSERT INTO zones VALUES (13,223,E'CO',E'Colorado');
 
INSERT INTO zones VALUES (14,223,E'CT',E'Connecticut');
 
INSERT INTO zones VALUES (15,223,E'DE',E'Delaware');
 
INSERT INTO zones VALUES (16,223,E'DC',E'District of Columbia');
 
INSERT INTO zones VALUES (17,223,E'FM',E'Federated States Of Micronesia');
 
INSERT INTO zones VALUES (18,223,E'FL',E'Florida');
 
INSERT INTO zones VALUES (19,223,E'GA',E'Georgia');
 
INSERT INTO zones VALUES (20,223,E'GU',E'Guam');
 
INSERT INTO zones VALUES (21,223,E'HI',E'Hawaii');
 
INSERT INTO zones VALUES (22,223,E'ID',E'Idaho');
 
INSERT INTO zones VALUES (23,223,E'IL',E'Illinois');
 
INSERT INTO zones VALUES (24,223,E'IN',E'Indiana');
 
INSERT INTO zones VALUES (25,223,E'IA',E'Iowa');
 
INSERT INTO zones VALUES (26,223,E'KS',E'Kansas');
 
INSERT INTO zones VALUES (27,223,E'KY',E'Kentucky');
 
INSERT INTO zones VALUES (28,223,E'LA',E'Louisiana');
 
INSERT INTO zones VALUES (29,223,E'ME',E'Maine');
 
INSERT INTO zones VALUES (30,223,E'MH',E'Marshall Islands');
 
INSERT INTO zones VALUES (31,223,E'MD',E'Maryland');
 
INSERT INTO zones VALUES (32,223,E'MA',E'Massachusetts');
 
INSERT INTO zones VALUES (33,223,E'MI',E'Michigan');
 
INSERT INTO zones VALUES (34,223,E'MN',E'Minnesota');
 
INSERT INTO zones VALUES (35,223,E'MS',E'Mississippi');
 
INSERT INTO zones VALUES (36,223,E'MO',E'Missouri');
 
INSERT INTO zones VALUES (37,223,E'MT',E'Montana');
 
INSERT INTO zones VALUES (38,223,E'NE',E'Nebraska');
 
INSERT INTO zones VALUES (39,223,E'NV',E'Nevada');
 
INSERT INTO zones VALUES (40,223,E'NH',E'New Hampshire');
 
INSERT INTO zones VALUES (41,223,E'NJ',E'New Jersey');
 
INSERT INTO zones VALUES (42,223,E'NM',E'New Mexico');
 
INSERT INTO zones VALUES (43,223,E'NY',E'New York');
 
INSERT INTO zones VALUES (44,223,E'NC',E'North Carolina');
 
INSERT INTO zones VALUES (45,223,E'ND',E'North Dakota');
 
INSERT INTO zones VALUES (46,223,E'MP',E'Northern Mariana Islands');
 
INSERT INTO zones VALUES (47,223,E'OH',E'Ohio');
 
INSERT INTO zones VALUES (48,223,E'OK',E'Oklahoma');
 
INSERT INTO zones VALUES (49,223,E'OR',E'Oregon');
 
INSERT INTO zones VALUES (50,163,E'PW',E'Palau');
 
INSERT INTO zones VALUES (51,223,E'PA',E'Pennsylvania');
 
INSERT INTO zones VALUES (52,223,E'PR',E'Puerto Rico');
 
INSERT INTO zones VALUES (53,223,E'RI',E'Rhode Island');
 
INSERT INTO zones VALUES (54,223,E'SC',E'South Carolina');
 
INSERT INTO zones VALUES (55,223,E'SD',E'South Dakota');
 
INSERT INTO zones VALUES (56,223,E'TN',E'Tennessee');
 
INSERT INTO zones VALUES (57,223,E'TX',E'Texas');
 
INSERT INTO zones VALUES (58,223,E'UT',E'Utah');
 
INSERT INTO zones VALUES (59,223,E'VT',E'Vermont');
 
INSERT INTO zones VALUES (60,223,E'VI',E'Virgin Islands');
 
INSERT INTO zones VALUES (61,223,E'VA',E'Virginia');
 
INSERT INTO zones VALUES (62,223,E'WA',E'Washington');
 
INSERT INTO zones VALUES (63,223,E'WV',E'West Virginia');
 
INSERT INTO zones VALUES (64,223,E'WI',E'Wisconsin');
 
INSERT INTO zones VALUES (65,223,E'WY',E'Wyoming');
 

-- Canada
INSERT INTO zones VALUES (66,38,E'AB',E'Alberta');
 
INSERT INTO zones VALUES (67,38,E'BC',E'British Columbia');
 
INSERT INTO zones VALUES (68,38,E'MB',E'Manitoba');
 
INSERT INTO zones VALUES (69,38,E'NF',E'Newfoundland');
 
INSERT INTO zones VALUES (70,38,E'NB',E'New Brunswick');
 
INSERT INTO zones VALUES (71,38,E'NS',E'Nova Scotia');
 
INSERT INTO zones VALUES (72,38,E'NT',E'Northwest Territories');
 
INSERT INTO zones VALUES (73,38,E'NU',E'Nunavut');
 
INSERT INTO zones VALUES (74,38,E'ON',E'Ontario');
 
INSERT INTO zones VALUES (75,38,E'PE',E'Prince Edward Island');
 
INSERT INTO zones VALUES (76,38,E'QC',E'Quebec');
 
INSERT INTO zones VALUES (77,38,E'SK',E'Saskatchewan');
 
INSERT INTO zones VALUES (78,38,E'YT',E'Yukon Territory');
 

-- Germany
INSERT INTO zones VALUES (79,81,E'NDS',E'Niedersachsen');
 
INSERT INTO zones VALUES (80,81,E'BAW',E'Baden-Wrttemberg');
 
INSERT INTO zones VALUES (81,81,E'BAY',E'Bayern');
 
INSERT INTO zones VALUES (82,81,E'BER',E'Berlin');
 
INSERT INTO zones VALUES (83,81,E'BRG',E'Brandenburg');
 
INSERT INTO zones VALUES (84,81,E'BRE',E'Bremen');
 
INSERT INTO zones VALUES (85,81,E'HAM',E'Hamburg');
 
INSERT INTO zones VALUES (86,81,E'HES',E'Hessen');
 
INSERT INTO zones VALUES (87,81,E'MEC',E'Mecklenburg-Vorpommern');
 
INSERT INTO zones VALUES (88,81,E'NRW',E'Nordrhein-Westfalen');
 
INSERT INTO zones VALUES (89,81,E'RHE',E'Rheinland-Pfalz');
 
INSERT INTO zones VALUES (90,81,E'SAR',E'Saarland');
 
INSERT INTO zones VALUES (91,81,E'SAS',E'Sachsen');
 
INSERT INTO zones VALUES (92,81,E'SAC',E'Sachsen-Anhalt');
 
INSERT INTO zones VALUES (93,81,E'SCN',E'Schleswig-Holstein');
 
INSERT INTO zones VALUES (94,81,E'THE',E'Thringen');
 

-- Austria
INSERT INTO zones VALUES (95,14,E'WI',E'Wien');
 
INSERT INTO zones VALUES (96,14,E'NO',E'Niedersterreich');
 
INSERT INTO zones VALUES (97,14,E'OO',E'Obersterreich');
 
INSERT INTO zones VALUES (98,14,E'SB',E'Salzburg');
 
INSERT INTO zones VALUES (99,14,E'KN',E'Kärtnen');
 
INSERT INTO zones VALUES (100,14,E'ST',E'Steiermark');
 
INSERT INTO zones VALUES (101,14,E'TI',E'Tirol');
 
INSERT INTO zones VALUES (102,14,E'BL',E'Burgenland');
 
INSERT INTO zones VALUES (103,14,E'VB',E'Voralberg');
 

-- Swizterland
INSERT INTO zones VALUES (104,204,E'AG',E'Aargau');
 
INSERT INTO zones VALUES (105,204,E'AI',E'Appenzell Innerrhoden');
 
INSERT INTO zones VALUES (106,204,E'AR',E'Appenzell Ausserrhoden');
 
INSERT INTO zones VALUES (107,204,E'BE',E'Bern');
 
INSERT INTO zones VALUES (108,204,E'BL',E'Basel-Landschaft');
 
INSERT INTO zones VALUES (109,204,E'BS',E'Basel-Stadt');
 
INSERT INTO zones VALUES (110,204,E'FR',E'Freiburg');
 
INSERT INTO zones VALUES (111,204,E'GE',E'Genf');
 
INSERT INTO zones VALUES (112,204,E'GL',E'Glarus');
 
INSERT INTO zones VALUES (113,204,E'JU',E'Graubnden');
 
INSERT INTO zones VALUES (114,204,E'JU',E'Jura');
 
INSERT INTO zones VALUES (115,204,E'LU',E'Luzern');
 
INSERT INTO zones VALUES (116,204,E'NE',E'Neuenburg');
 
INSERT INTO zones VALUES (117,204,E'NW',E'Nidwalden');
 
INSERT INTO zones VALUES (118,204,E'OW',E'Obwalden');
 
INSERT INTO zones VALUES (119,204,E'SG',E'St. Gallen');
 
INSERT INTO zones VALUES (120,204,E'SH',E'Schaffhausen');
 
INSERT INTO zones VALUES (121,204,E'SO',E'Solothurn');
 
INSERT INTO zones VALUES (122,204,E'SZ',E'Schwyz');
 
INSERT INTO zones VALUES (123,204,E'TG',E'Thurgau');
 
INSERT INTO zones VALUES (124,204,E'TI',E'Tessin');
 
INSERT INTO zones VALUES (125,204,E'UR',E'Uri');
 
INSERT INTO zones VALUES (126,204,E'VD',E'Waadt');
 
INSERT INTO zones VALUES (127,204,E'VS',E'Wallis');
 
INSERT INTO zones VALUES (128,204,E'ZG',E'Zug');
 
INSERT INTO zones VALUES (129,204,E'ZH',E'Zrich');
 

-- Spain
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'A Corua',E'A Corua');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Alava',E'Alava');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Albacete',E'Albacete');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Alicante',E'Alicante');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Almeria',E'Almeria');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Asturias',E'Asturias');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Avila',E'Avila');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Badajoz',E'Badajoz');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Baleares',E'Baleares');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Barcelona',E'Barcelona');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Burgos',E'Burgos');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Caceres',E'Caceres');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Cadiz',E'Cadiz');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Cantabria',E'Cantabria');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Castellon',E'Castellon');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Ceuta',E'Ceuta');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Ciudad Real',E'Ciudad Real');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Cordoba',E'Cordoba');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Cuenca',E'Cuenca');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Girona',E'Girona');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Granada',E'Granada');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Guadalajara',E'Guadalajara');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Guipuzcoa',E'Guipuzcoa');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Huelva',E'Huelva');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Huesca',E'Huesca');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Jaen',E'Jaen');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'La Rioja',E'La Rioja');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Las Palmas',E'Las Palmas');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Leon',E'Leon');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Lleida',E'Lleida');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Lugo',E'Lugo');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Madrid',E'Madrid');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Malaga',E'Malaga');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Melilla',E'Melilla');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Murcia',E'Murcia');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Navarra',E'Navarra');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Ourense',E'Ourense');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Palencia',E'Palencia');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Pontevedra',E'Pontevedra');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Salamanca',E'Salamanca');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Santa Cruz de Tenerife',E'Santa Cruz de Tenerife');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Segovia',E'Segovia');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Sevilla',E'Sevilla');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Soria',E'Soria');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Tarragona',E'Tarragona');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Teruel',E'Teruel');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Toledo',E'Toledo');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Valencia',E'Valencia');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Valladolid',E'Valladolid');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Vizcaya',E'Vizcaya');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Zamora',E'Zamora');
 
INSERT INTO zones (zone_country_id, zone_code, zone_name) VALUES (195,E'Zaragoza',E'Zaragoza');
 

--australian zones
INSERT INTO zones VALUES (NULL, 13, E'ACT', E'Australian Capital Territory');
 
INSERT INTO zones VALUES (NULL, 13, E'NSW', E'New South Wales');
 
INSERT INTO zones VALUES (NULL, 13, E'NT', E'Northern Territory');
 
INSERT INTO zones VALUES (NULL, 13, E'QLD', E'Queensland');
 
INSERT INTO zones VALUES (NULL, 13, E'SA', E'South Australia');
 
INSERT INTO zones VALUES (NULL, 13, E'TAS', E'Tasmania');
 
INSERT INTO zones VALUES (NULL, 13, E'VIC', E'Victoria');
 
INSERT INTO zones VALUES (NULL, 13, E'WA', E'Western Australia');
 


INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Model Number', E'SHOW_PRODUCT_INFO_MODEL', E'1', E'Display Model Number on Product Info 0= off 1= on', E'1', E'1', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Weight', E'SHOW_PRODUCT_INFO_WEIGHT', E'1', E'Display Weight on Product Info 0= off 1= on', E'1', E'2', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Attribute Weight', E'SHOW_PRODUCT_INFO_WEIGHT_ATTRIBUTES', E'1', E'Display Attribute Weight on Product Info 0= off 1= on', E'1', E'3', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Manufacturer', E'SHOW_PRODUCT_INFO_MANUFACTURER', E'1', E'Display Manufacturer Name on Product Info 0= off 1= on', E'1', E'4', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Quantity in Shopping Cart', E'SHOW_PRODUCT_INFO_IN_CART_QTY', E'1', E'Display Quantity in Current Shopping Cart on Product Info 0= off 1= on', E'1', E'5', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Quantity in Stock', E'SHOW_PRODUCT_INFO_QUANTITY', E'1', E'Display Quantity in Stock on Product Info 0= off 1= on', E'1', E'6', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Product Reviews Count', E'SHOW_PRODUCT_INFO_REVIEWS_COUNT', E'1', E'Display Product Reviews Count on Product Info 0= off 1= on', E'1', E'7', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Product Reviews Button', E'SHOW_PRODUCT_INFO_REVIEWS', E'1', E'Display Product Reviews Button on Product Info 0= off 1= on', E'1', E'8', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Date Available', E'SHOW_PRODUCT_INFO_DATE_AVAILABLE', E'1', E'Display Date Available on Product Info 0= off 1= on', E'1', E'9', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Date Added', E'SHOW_PRODUCT_INFO_DATE_ADDED', E'1', E'Display Date Added on Product Info 0= off 1= on', E'1', E'10', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Product URL', E'SHOW_PRODUCT_INFO_URL', E'1', E'Display URL on Product Info 0= off 1= on', E'1', E'11', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Product Additional Images', E'SHOW_PRODUCT_INFO_ADDITIONAL_IMAGES', E'1', E'Display Additional Images on Product Info 0= off 1= on', E'1', E'13', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 

INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Starting At text on Price', E'SHOW_PRODUCT_INFO_STARTING_AT', E'1', E'Display Starting At text on products with attributes Product Info 0= off 1= on', E'1', E'12', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 

INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Product Tell a Friend button', E'SHOW_PRODUCT_INFO_TELL_A_FRIEND', E'1', E'Display the Tell a Friend button on Product Info<br /><br />Note: Turning this setting off does not affect the Tell a Friend box in the columns and turning off the Tell a Friend box does not affect the button<br />0= off 1= on', E'1', E'15', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Product Free Shipping Image Status - Catalog', E'SHOW_PRODUCT_INFO_ALWAYS_FREE_SHIPPING_IMAGE_SWITCH', E'0', E'Show the Free Shipping image/text in the catalog?', E'1', E'16', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
--admin defaults
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, use_function, set_function, date_added) VALUES (E'Product Price Tax Class Default - When adding new products?', E'DEFAULT_PRODUCT_TAX_CLASS_ID', E'0', E'What should the Product Price Tax Class Default ID be when adding new products?', E'1', E'100', E'', E'', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Product Virtual Default Status - Skip Shipping Address - When adding new products?', E'DEFAULT_PRODUCT_PRODUCTS_VIRTUAL', E'0', E'Default Virtual Product status to be ON when adding new products?', E'1', E'101', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 

INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Product Free Shipping Default Status - Normal Shipping Rules - When adding new products?', E'DEFAULT_PRODUCT_PRODUCTS_IS_ALWAYS_FREE_SHIPPING', E'0', E'What should the Default Free Shipping status be when adding new products?<br />Yes, Always Free Shipping ON<br />No, Always Free Shipping OFF<br />Special, Product/Download Requires Shipping', E'1', E'102', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes, Always ON\'), array(\'id\'=>\'0\', \'text\'=>\'No, Always OFF\'), array(\'id\'=>\'2\', \'text\'=>\'Special\')), ', now());
 


INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Model Number', E'SHOW_PRODUCT_MUSIC_INFO_MODEL', E'1', E'Display Model Number on Product Info 0= off 1= on', E'2', E'1', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Weight', E'SHOW_PRODUCT_MUSIC_INFO_WEIGHT', E'0', E'Display Weight on Product Info 0= off 1= on', E'2', E'2', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Attribute Weight', E'SHOW_PRODUCT_MUSIC_INFO_WEIGHT_ATTRIBUTES', E'1', E'Display Attribute Weight on Product Info 0= off 1= on', E'2', E'3', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Artist', E'SHOW_PRODUCT_MUSIC_INFO_ARTIST', E'1', E'Display Artists Name on Product Info 0= off 1= on', E'2', E'4', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Music Genre', E'SHOW_PRODUCT_MUSIC_INFO_GENRE', E'1', E'Display Music Genre on Product Info 0= off 1= on', E'2', E'4', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Record Company', E'SHOW_PRODUCT_MUSIC_INFO_RECORD_COMPANY', E'1', E'Display Record Company on Product Info 0= off 1= on', E'2', E'4', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Quantity in Shopping Cart', E'SHOW_PRODUCT_MUSIC_INFO_IN_CART_QTY', E'1', E'Display Quantity in Current Shopping Cart on Product Info 0= off 1= on', E'2', E'5', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Quantity in Stock', E'SHOW_PRODUCT_MUSIC_INFO_QUANTITY', E'0', E'Display Quantity in Stock on Product Info 0= off 1= on', E'2', E'6', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Product Reviews Count', E'SHOW_PRODUCT_MUSIC_INFO_REVIEWS_COUNT', E'1', E'Display Product Reviews Count on Product Info 0= off 1= on', E'2', E'7', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Product Reviews Button', E'SHOW_PRODUCT_MUSIC_INFO_REVIEWS', E'1', E'Display Product Reviews Button on Product Info 0= off 1= on', E'2', E'8', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Date Available', E'SHOW_PRODUCT_MUSIC_INFO_DATE_AVAILABLE', E'1', E'Display Date Available on Product Info 0= off 1= on', E'2', E'9', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Date Added', E'SHOW_PRODUCT_MUSIC_INFO_DATE_ADDED', E'1', E'Display Date Added on Product Info 0= off 1= on', E'2', E'10', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 

INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Starting At text on Price', E'SHOW_PRODUCT_MUSIC_INFO_STARTING_AT', E'1', E'Display Starting At text on products with attributes Product Info 0= off 1= on', E'2', E'12', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Product Additional Images', E'SHOW_PRODUCT_MUSIC_INFO_ADDITIONAL_IMAGES', E'1', E'Display Additional Images on Product Info 0= off 1= on', E'2', E'13', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 

INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Product Tell a Friend button', E'SHOW_PRODUCT_MUSIC_INFO_TELL_A_FRIEND', E'1', E'Display the Tell a Friend button on Product Info<br /><br />Note: Turning this setting off does not affect the Tell a Friend box in the columns and turning off the Tell a Friend box does not affect the button<br />0= off 1= on', E'2', E'15', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Product Free Shipping Image Status - Catalog', E'SHOW_PRODUCT_MUSIC_INFO_ALWAYS_FREE_SHIPPING_IMAGE_SWITCH', E'0', E'Show the Free Shipping image/text in the catalog?', E'2', E'16', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
--admin defaults
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, use_function, set_function, date_added) VALUES (E'Product Price Tax Class Default - When adding new products?', E'DEFAULT_PRODUCT_MUSIC_TAX_CLASS_ID', E'0', E'What should the Product Price Tax Class Default ID be when adding new products?', E'2', E'100', E'', E'', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Product Virtual Default Status - Skip Shipping Address - When adding new products?', E'DEFAULT_PRODUCT_MUSIC_PRODUCTS_VIRTUAL', E'0', E'Default Virtual Product status to be ON when adding new products?', E'2', E'101', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Product Free Shipping Default Status - Normal Shipping Rules - When adding new products?', E'DEFAULT_PRODUCT_MUSIC_PRODUCTS_IS_ALWAYS_FREE_SHIPPING', E'0', E'What should the Default Free Shipping status be when adding new products?<br />Yes, Always Free Shipping ON<br />No, Always Free Shipping OFF<br />Special, Product/Download Requires Shipping', E'2', E'102', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes, Always ON\'), array(\'id\'=>\'0\', \'text\'=>\'No, Always OFF\'), array(\'id\'=>\'2\', \'text\'=>\'Special\')), ', now());
 


INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Product Reviews Count', E'SHOW_DOCUMENT_GENERAL_INFO_REVIEWS_COUNT', E'1', E'Display Product Reviews Count on Product Info 0= off 1= on', E'3', E'7', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Product Reviews Button', E'SHOW_DOCUMENT_GENERAL_INFO_REVIEWS', E'1', E'Display Product Reviews Button on Product Info 0= off 1= on', E'3', E'8', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Date Available', E'SHOW_DOCUMENT_GENERAL_INFO_DATE_AVAILABLE', E'1', E'Display Date Available on Product Info 0= off 1= on', E'3', E'9', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Date Added', E'SHOW_DOCUMENT_GENERAL_INFO_DATE_ADDED', E'1', E'Display Date Added on Product Info 0= off 1= on', E'3', E'10', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Product Tell a Friend button', E'SHOW_DOCUMENT_GENERAL_INFO_TELL_A_FRIEND', E'1', E'Display the Tell a Friend button on Product Info<br /><br />Note: Turning this setting off does not affect the Tell a Friend box in the columns and turning off the Tell a Friend box does not affect the button<br />0= off 1= on', E'3', E'15', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Product URL', E'SHOW_DOCUMENT_GENERAL_INFO_URL', E'1', E'Display URL on Product Info 0= off 1= on', E'3', E'11', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Product Additional Images', E'SHOW_DOCUMENT_GENERAL_INFO_ADDITIONAL_IMAGES', E'1', E'Display Additional Images on Product Info 0= off 1= on', E'3', E'13', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 



--admin defaults
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Model Number', E'SHOW_DOCUMENT_PRODUCT_INFO_MODEL', E'1', E'Display Model Number on Product Info 0= off 1= on', E'4', E'1', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Weight', E'SHOW_DOCUMENT_PRODUCT_INFO_WEIGHT', E'0', E'Display Weight on Product Info 0= off 1= on', E'4', E'2', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Attribute Weight', E'SHOW_DOCUMENT_PRODUCT_INFO_WEIGHT_ATTRIBUTES', E'1', E'Display Attribute Weight on Product Info 0= off 1= on', E'4', E'3', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Manufacturer', E'SHOW_DOCUMENT_PRODUCT_INFO_MANUFACTURER', E'1', E'Display Manufacturer Name on Product Info 0= off 1= on', E'4', E'4', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Quantity in Shopping Cart', E'SHOW_DOCUMENT_PRODUCT_INFO_IN_CART_QTY', E'1', E'Display Quantity in Current Shopping Cart on Product Info 0= off 1= on', E'4', E'5', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Quantity in Stock', E'SHOW_DOCUMENT_PRODUCT_INFO_QUANTITY', E'0', E'Display Quantity in Stock on Product Info 0= off 1= on', E'4', E'6', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Product Reviews Count', E'SHOW_DOCUMENT_PRODUCT_INFO_REVIEWS_COUNT', E'1', E'Display Product Reviews Count on Product Info 0= off 1= on', E'4', E'7', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Product Reviews Button', E'SHOW_DOCUMENT_PRODUCT_INFO_REVIEWS', E'1', E'Display Product Reviews Button on Product Info 0= off 1= on', E'4', E'8', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Date Available', E'SHOW_DOCUMENT_PRODUCT_INFO_DATE_AVAILABLE', E'1', E'Display Date Available on Product Info 0= off 1= on', E'4', E'9', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Date Added', E'SHOW_DOCUMENT_PRODUCT_INFO_DATE_ADDED', E'1', E'Display Date Added on Product Info 0= off 1= on', E'4', E'10', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Product URL', E'SHOW_DOCUMENT_PRODUCT_INFO_URL', E'1', E'Display URL on Product Info 0= off 1= on', E'4', E'11', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Product Additional Images', E'SHOW_DOCUMENT_PRODUCT_INFO_ADDITIONAL_IMAGES', E'1', E'Display Additional Images on Product Info 0= off 1= on', E'4', E'13', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 


INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Starting At text on Price', E'SHOW_DOCUMENT_PRODUCT_INFO_STARTING_AT', E'1', E'Display Starting At text on products with attributes Product Info 0= off 1= on', E'4', E'12', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 

INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Product Tell a Friend button', E'SHOW_DOCUMENT_PRODUCT_INFO_TELL_A_FRIEND', E'1', E'Display the Tell a Friend button on Product Info<br /><br />Note: Turning this setting off does not affect the Tell a Friend box in the columns and turning off the Tell a Friend box does not affect the button<br />0= off 1= on', E'4', E'15', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Product Free Shipping Image Status - Catalog', E'SHOW_DOCUMENT_PRODUCT_INFO_ALWAYS_FREE_SHIPPING_IMAGE_SWITCH', E'0', E'Show the Free Shipping image/text in the catalog?', E'4', E'16', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
--admin defaults
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, use_function, set_function, date_added) VALUES (E'Product Price Tax Class Default - When adding new products?', E'DEFAULT_DOCUMENT_PRODUCT_TAX_CLASS_ID', E'0', E'What should the Product Price Tax Class Default ID be when adding new products?', E'4', E'100', E'', E'', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Product Virtual Default Status - Skip Shipping Address - When adding new products?', E'DEFAULT_DOCUMENT_PRODUCT_PRODUCTS_VIRTUAL', E'0', E'Default Virtual Product status to be ON when adding new products?', E'4', E'101', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Product Free Shipping Default Status - Normal Shipping Rules - When adding new products?', E'DEFAULT_DOCUMENT_PRODUCT_PRODUCTS_IS_ALWAYS_FREE_SHIPPING', E'0', E'What should the Default Free Shipping status be when adding new products?<br />Yes, Always Free Shipping ON<br />No, Always Free Shipping OFF<br />Special, Product/Download Requires Shipping', E'4', E'102', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes, Always ON\'), array(\'id\'=>\'0\', \'text\'=>\'No, Always OFF\'), array(\'id\'=>\'2\', \'text\'=>\'Special\')), ', now());
 


INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Model Number', E'SHOW_PRODUCT_FREE_SHIPPING_INFO_MODEL', E'1', E'Display Model Number on Product Info 0= off 1= on', E'5', E'1', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Weight', E'SHOW_PRODUCT_FREE_SHIPPING_INFO_WEIGHT', E'0', E'Display Weight on Product Info 0= off 1= on', E'5', E'2', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Attribute Weight', E'SHOW_PRODUCT_FREE_SHIPPING_INFO_WEIGHT_ATTRIBUTES', E'1', E'Display Attribute Weight on Product Info 0= off 1= on', E'5', E'3', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Manufacturer', E'SHOW_PRODUCT_FREE_SHIPPING_INFO_MANUFACTURER', E'1', E'Display Manufacturer Name on Product Info 0= off 1= on', E'5', E'4', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Quantity in Shopping Cart', E'SHOW_PRODUCT_FREE_SHIPPING_INFO_IN_CART_QTY', E'1', E'Display Quantity in Current Shopping Cart on Product Info 0= off 1= on', E'5', E'5', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Quantity in Stock', E'SHOW_PRODUCT_FREE_SHIPPING_INFO_QUANTITY', E'1', E'Display Quantity in Stock on Product Info 0= off 1= on', E'5', E'6', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Product Reviews Count', E'SHOW_PRODUCT_FREE_SHIPPING_INFO_REVIEWS_COUNT', E'1', E'Display Product Reviews Count on Product Info 0= off 1= on', E'5', E'7', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Product Reviews Button', E'SHOW_PRODUCT_FREE_SHIPPING_INFO_REVIEWS', E'1', E'Display Product Reviews Button on Product Info 0= off 1= on', E'5', E'8', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Date Available', E'SHOW_PRODUCT_FREE_SHIPPING_INFO_DATE_AVAILABLE', E'0', E'Display Date Available on Product Info 0= off 1= on', E'5', E'9', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Date Added', E'SHOW_PRODUCT_FREE_SHIPPING_INFO_DATE_ADDED', E'1', E'Display Date Added on Product Info 0= off 1= on', E'5', E'10', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Product URL', E'SHOW_PRODUCT_FREE_SHIPPING_INFO_URL', E'1', E'Display URL on Product Info 0= off 1= on', E'5', E'11', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Product Additional Images', E'SHOW_PRODUCT_FREE_SHIPPING_INFO_ADDITIONAL_IMAGES', E'1', E'Display Additional Images on Product Info 0= off 1= on', E'5', E'13', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 

INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Starting At text on Price', E'SHOW_PRODUCT_FREE_SHIPPING_INFO_STARTING_AT', E'1', E'Display Starting At text on products with attributes Product Info 0= off 1= on', E'5', E'12', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 

INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Product Tell a Friend button', E'SHOW_PRODUCT_FREE_SHIPPING_INFO_TELL_A_FRIEND', E'1', E'Display the Tell a Friend button on Product Info<br /><br />Note: Turning this setting off does not affect the Tell a Friend box in the columns and turning off the Tell a Friend box does not affect the button<br />0= off 1= on', E'5', E'15', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Product Free Shipping Image Status - Catalog', E'SHOW_PRODUCT_FREE_SHIPPING_INFO_ALWAYS_FREE_SHIPPING_IMAGE_SWITCH', E'1', E'Show the Free Shipping image/text in the catalog?', E'5', E'16', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
--admin defaults
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, use_function, set_function, date_added) VALUES (E'Product Price Tax Class Default - When adding new products?', E'DEFAULT_PRODUCT_FREE_SHIPPING_TAX_CLASS_ID', E'0', E'What should the Product Price Tax Class Default ID be when adding new products?', E'5', E'100', E'', E'', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Product Virtual Default Status - Skip Shipping Address - When adding new products?', E'DEFAULT_PRODUCT_FREE_SHIPPING_PRODUCTS_VIRTUAL', E'0', E'Default Virtual Product status to be ON when adding new products?', E'5', E'101', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Product Free Shipping Default Status - Normal Shipping Rules - When adding new products?', E'DEFAULT_PRODUCT_FREE_SHIPPING_PRODUCTS_IS_ALWAYS_FREE_SHIPPING', E'1', E'What should the Default Free Shipping status be when adding new products?<br />Yes, Always Free Shipping ON<br />No, Always Free Shipping OFF<br />Special, Product/Download Requires Shipping', E'5', E'102', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes, Always ON\'), array(\'id\'=>\'0\', \'text\'=>\'No, Always OFF\'), array(\'id\'=>\'2\', \'text\'=>\'Special\')), ', now());
 

--insert product type layout settings for meta-tags
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Metatags Title Default - Product Title', E'SHOW_PRODUCT_INFO_METATAGS_TITLE_STATUS', E'1', E'Display Product Title in Meta Tags Title 0= off 1= on', E'1', E'50', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Metatags Title Default - Product Name', E'SHOW_PRODUCT_INFO_METATAGS_PRODUCTS_NAME_STATUS', E'1', E'Display Product Name in Meta Tags Title 0= off 1= on', E'1', E'51', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Metatags Title Default - Product Model', E'SHOW_PRODUCT_INFO_METATAGS_MODEL_STATUS', E'1', E'Display Product Model in Meta Tags Title 0= off 1= on', E'1', E'52', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Metatags Title Default - Product Price', E'SHOW_PRODUCT_INFO_METATAGS_PRICE_STATUS', E'1', E'Display Product Price in Meta Tags Title 0= off 1= on', E'1', E'53', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Metatags Title Default - Product Tagline', E'SHOW_PRODUCT_INFO_METATAGS_TITLE_TAGLINE_STATUS', E'1', E'Display Product Tagline in Meta Tags Title 0= off 1= on', E'1', E'54', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 

INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Metatags Title Default - Product Title', E'SHOW_PRODUCT_MUSIC_INFO_METATAGS_TITLE_STATUS', E'1', E'Display Product Title in Meta Tags Title 0= off 1= on', E'2', E'50', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Metatags Title Default - Product Name', E'SHOW_PRODUCT_MUSIC_INFO_METATAGS_PRODUCTS_NAME_STATUS', E'1', E'Display Product Name in Meta Tags Title 0= off 1= on', E'2', E'51', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Metatags Title Default - Product Model', E'SHOW_PRODUCT_MUSIC_INFO_METATAGS_MODEL_STATUS', E'1', E'Display Product Model in Meta Tags Title 0= off 1= on', E'2', E'52', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Metatags Title Default - Product Price', E'SHOW_PRODUCT_MUSIC_INFO_METATAGS_PRICE_STATUS', E'1', E'Display Product Price in Meta Tags Title 0= off 1= on', E'2', E'53', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Metatags Title Default - Product Tagline', E'SHOW_PRODUCT_MUSIC_INFO_METATAGS_TITLE_TAGLINE_STATUS', E'1', E'Display Product Tagline in Meta Tags Title 0= off 1= on', E'2', E'54', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 

INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Metatags Title Default - Document Title', E'SHOW_DOCUMENT_GENERAL_INFO_METATAGS_TITLE_STATUS', E'1', E'Display Document Title in Meta Tags Title 0= off 1= on', E'3', E'50', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Metatags Title Default - Document Name', E'SHOW_DOCUMENT_GENERAL_INFO_METATAGS_PRODUCTS_NAME_STATUS', E'1', E'Display Document Name in Meta Tags Title 0= off 1= on', E'3', E'51', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Metatags Title Default - Document Tagline', E'SHOW_DOCUMENT_GENERAL_INFO_METATAGS_TITLE_TAGLINE_STATUS', E'1', E'Display Document Tagline in Meta Tags Title 0= off 1= on', E'3', E'54', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 

INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Metatags Title Default - Document Title', E'SHOW_DOCUMENT_PRODUCT_INFO_METATAGS_TITLE_STATUS', E'1', E'Display Document Title in Meta Tags Title 0= off 1= on', E'4', E'50', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Metatags Title Default - Document Name', E'SHOW_DOCUMENT_PRODUCT_INFO_METATAGS_PRODUCTS_NAME_STATUS', E'1', E'Display Document Name in Meta Tags Title 0= off 1= on', E'4', E'51', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Metatags Title Default - Document Model', E'SHOW_DOCUMENT_PRODUCT_INFO_METATAGS_MODEL_STATUS', E'1', E'Display Document Model in Meta Tags Title 0= off 1= on', E'4', E'52', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Metatags Title Default - Document Price', E'SHOW_DOCUMENT_PRODUCT_INFO_METATAGS_PRICE_STATUS', E'1', E'Display Document Price in Meta Tags Title 0= off 1= on', E'4', E'53', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Metatags Title Default - Document Tagline', E'SHOW_DOCUMENT_PRODUCT_INFO_METATAGS_TITLE_TAGLINE_STATUS', E'1', E'Display Document Tagline in Meta Tags Title 0= off 1= on', E'4', E'54', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 

INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Metatags Title Default - Product Title', E'SHOW_PRODUCT_FREE_SHIPPING_INFO_METATAGS_TITLE_STATUS', E'1', E'Display Product Title in Meta Tags Title 0= off 1= on', E'5', E'50', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Metatags Title Default - Product Name', E'SHOW_PRODUCT_FREE_SHIPPING_INFO_METATAGS_PRODUCTS_NAME_STATUS', E'1', E'Display Product Name in Meta Tags Title 0= off 1= on', E'5', E'51', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Metatags Title Default - Product Model', E'SHOW_PRODUCT_FREE_SHIPPING_INFO_METATAGS_MODEL_STATUS', E'1', E'Display Product Model in Meta Tags Title 0= off 1= on', E'5', E'52', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Metatags Title Default - Product Price', E'SHOW_PRODUCT_FREE_SHIPPING_INFO_METATAGS_PRICE_STATUS', E'1', E'Display Product Price in Meta Tags Title 0= off 1= on', E'5', E'53', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'Show Metatags Title Default - Product Tagline', E'SHOW_PRODUCT_FREE_SHIPPING_INFO_METATAGS_TITLE_TAGLINE_STATUS', E'1', E'Display Product Tagline in Meta Tags Title 0= off 1= on', E'5', E'54', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'True\'), array(\'id\'=>\'0\', \'text\'=>\'False\')), ', now());
 

--## eof: meta tags database updates and changes
--insert product type layout settings
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'PRODUCT Attribute is Display Only - Default', E'DEFAULT_PRODUCT_ATTRIBUTES_DISPLAY_ONLY', E'0', E'PRODUCT Attribute is Display Only<br />Used For Display Purposes Only<br />0= No 1= Yes', E'1', E'200', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'PRODUCT Attribute is Free - Default', E'DEFAULT_PRODUCT_ATTRIBUTE_IS_FREE', E'1', E'PRODUCT Attribute is Free<br />Attribute is Free When Product is Free<br />0= No 1= Yes', E'1', E'201', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'PRODUCT Attribute is Default - Default', E'DEFAULT_PRODUCT_ATTRIBUTES_DEFAULT', E'0', E'PRODUCT Attribute is Default<br />Default Attribute to be Marked Selected<br />0= No 1= Yes', E'1', E'202', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'PRODUCT Attribute is Discounted - Default', E'DEFAULT_PRODUCT_ATTRIBUTES_DISCOUNTED', E'1', E'PRODUCT Attribute is Discounted<br />Apply Discounts Used by Product Special/Sale<br />0= No 1= Yes', E'1', E'203', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'PRODUCT Attribute is Included in Base Price - Default', E'DEFAULT_PRODUCT_ATTRIBUTES_PRICE_BASE_INCLUDED', E'1', E'PRODUCT Attribute is Included in Base Price<br />Include in Base Price When Priced by Attributes<br />0= No 1= Yes', E'1', E'204', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'PRODUCT Attribute is Required - Default', E'DEFAULT_PRODUCT_ATTRIBUTES_REQUIRED', E'0', E'PRODUCT Attribute is Required<br />Attribute Required for Text<br />0= No 1= Yes', E'1', E'205', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'PRODUCT Attribute Price Prefix - Default', E'DEFAULT_PRODUCT_PRICE_PREFIX', E'1', E'PRODUCT Attribute Price Prefix<br />Default Attribute Price Prefix for Adding<br />Blank, + or -', E'1', E'206', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'0\', \'text\'=>\'Blank\'), array(\'id\'=>\'1\', \'text\'=>\'+\'), array(\'id\'=>\'2\', \'text\'=>\'-\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'PRODUCT Attribute Weight Prefix - Default', E'DEFAULT_PRODUCT_PRODUCTS_ATTRIBUTES_WEIGHT_PREFIX', E'1', E'PRODUCT Attribute Weight Prefix<br />Default Attribute Weight Prefix<br />Blank, + or -', E'1', E'207', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'0\', \'text\'=>\'Blank\'), array(\'id\'=>\'1\', \'text\'=>\'+\'), array(\'id\'=>\'2\', \'text\'=>\'-\')), ', now());
 

INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'MUSIC Attribute is Display Only - Default', E'DEFAULT_PRODUCT_MUSIC_ATTRIBUTES_DISPLAY_ONLY', E'0', E'MUSIC Attribute is Display Only<br />Used For Display Purposes Only<br />0= No 1= Yes', E'2', E'200', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'MUSIC Attribute is Free - Default', E'DEFAULT_PRODUCT_MUSIC_ATTRIBUTE_IS_FREE', E'1', E'MUSIC Attribute is Free<br />Attribute is Free When Product is Free<br />0= No 1= Yes', E'2', E'201', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'MUSIC Attribute is Default - Default', E'DEFAULT_PRODUCT_MUSIC_ATTRIBUTES_DEFAULT', E'0', E'MUSIC Attribute is Default<br />Default Attribute to be Marked Selected<br />0= No 1= Yes', E'2', E'202', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'MUSIC Attribute is Discounted - Default', E'DEFAULT_PRODUCT_MUSIC_ATTRIBUTES_DISCOUNTED', E'1', E'MUSIC Attribute is Discounted<br />Apply Discounts Used by Product Special/Sale<br />0= No 1= Yes', E'2', E'203', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'MUSIC Attribute is Included in Base Price - Default', E'DEFAULT_PRODUCT_MUSIC_ATTRIBUTES_PRICE_BASE_INCLUDED', E'1', E'MUSIC Attribute is Included in Base Price<br />Include in Base Price When Priced by Attributes<br />0= No 1= Yes', E'2', E'204', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'MUSIC Attribute is Required - Default', E'DEFAULT_PRODUCT_MUSIC_ATTRIBUTES_REQUIRED', E'0', E'MUSIC Attribute is Required<br />Attribute Required for Text<br />0= No 1= Yes', E'2', E'205', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'MUSIC Attribute Price Prefix - Default', E'DEFAULT_PRODUCT_MUSIC_PRICE_PREFIX', E'1', E'MUSIC Attribute Price Prefix<br />Default Attribute Price Prefix for Adding<br />Blank, + or -', E'2', E'206', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'0\', \'text\'=>\'Blank\'), array(\'id\'=>\'1\', \'text\'=>\'+\'), array(\'id\'=>\'2\', \'text\'=>\'-\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'MUSIC Attribute Weight Prefix - Default', E'DEFAULT_PRODUCT_MUSIC_PRODUCTS_ATTRIBUTES_WEIGHT_PREFIX', E'1', E'MUSIC Attribute Weight Prefix<br />Default Attribute Weight Prefix<br />Blank, + or -', E'2', E'207', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'0\', \'text\'=>\'Blank\'), array(\'id\'=>\'1\', \'text\'=>\'+\'), array(\'id\'=>\'2\', \'text\'=>\'-\')), ', now());
 

INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'DOCUMENT GENERAL Attribute is Display Only - Default', E'DEFAULT_DOCUMENT_GENERAL_ATTRIBUTES_DISPLAY_ONLY', E'0', E'DOCUMENT GENERAL Attribute is Display Only<br />Used For Display Purposes Only<br />0= No 1= Yes', E'3', E'200', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'DOCUMENT GENERAL Attribute is Free - Default', E'DEFAULT_DOCUMENT_GENERAL_ATTRIBUTE_IS_FREE', E'1', E'DOCUMENT GENERAL Attribute is Free<br />Attribute is Free When Product is Free<br />0= No 1= Yes', E'3', E'201', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'DOCUMENT GENERAL Attribute is Default - Default', E'DEFAULT_DOCUMENT_GENERAL_ATTRIBUTES_DEFAULT', E'0', E'DOCUMENT GENERAL Attribute is Default<br />Default Attribute to be Marked Selected<br />0= No 1= Yes', E'3', E'202', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'DOCUMENT GENERAL Attribute is Discounted - Default', E'DEFAULT_DOCUMENT_GENERAL_ATTRIBUTES_DISCOUNTED', E'1', E'DOCUMENT GENERAL Attribute is Discounted<br />Apply Discounts Used by Product Special/Sale<br />0= No 1= Yes', E'3', E'203', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'DOCUMENT GENERAL Attribute is Included in Base Price - Default', E'DEFAULT_DOCUMENT_GENERAL_ATTRIBUTES_PRICE_BASE_INCLUDED', E'1', E'DOCUMENT GENERAL Attribute is Included in Base Price<br />Include in Base Price When Priced by Attributes<br />0= No 1= Yes', E'3', E'204', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'DOCUMENT GENERAL Attribute is Required - Default', E'DEFAULT_DOCUMENT_GENERAL_ATTRIBUTES_REQUIRED', E'0', E'DOCUMENT GENERAL Attribute is Required<br />Attribute Required for Text<br />0= No 1= Yes', E'3', E'205', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'DOCUMENT GENERAL Attribute Price Prefix - Default', E'DEFAULT_DOCUMENT_GENERAL_PRICE_PREFIX', E'1', E'DOCUMENT GENERAL Attribute Price Prefix<br />Default Attribute Price Prefix for Adding<br />Blank, + or -', E'3', E'206', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'0\', \'text\'=>\'Blank\'), array(\'id\'=>\'1\', \'text\'=>\'+\'), array(\'id\'=>\'2\', \'text\'=>\'-\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'DOCUMENT GENERAL Attribute Weight Prefix - Default', E'DEFAULT_DOCUMENT_GENERAL_PRODUCTS_ATTRIBUTES_WEIGHT_PREFIX', E'1', E'DOCUMENT GENERAL Attribute Weight Prefix<br />Default Attribute Weight Prefix<br />Blank, + or -', E'3', E'207', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'0\', \'text\'=>\'Blank\'), array(\'id\'=>\'1\', \'text\'=>\'+\'), array(\'id\'=>\'2\', \'text\'=>\'-\')), ', now());
 

INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'DOCUMENT PRODUCT Attribute is Display Only - Default', E'DEFAULT_DOCUMENT_PRODUCT_ATTRIBUTES_DISPLAY_ONLY', E'0', E'DOCUMENT PRODUCT Attribute is Display Only<br />Used For Display Purposes Only<br />0= No 1= Yes', E'4', E'200', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'DOCUMENT PRODUCT Attribute is Free - Default', E'DEFAULT_DOCUMENT_PRODUCT_ATTRIBUTE_IS_FREE', E'1', E'DOCUMENT PRODUCT Attribute is Free<br />Attribute is Free When Product is Free<br />0= No 1= Yes', E'4', E'201', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'DOCUMENT PRODUCT Attribute is Default - Default', E'DEFAULT_DOCUMENT_PRODUCT_ATTRIBUTES_DEFAULT', E'0', E'DOCUMENT PRODUCT Attribute is Default<br />Default Attribute to be Marked Selected<br />0= No 1= Yes', E'4', E'202', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'DOCUMENT PRODUCT Attribute is Discounted - Default', E'DEFAULT_DOCUMENT_PRODUCT_ATTRIBUTES_DISCOUNTED', E'1', E'DOCUMENT PRODUCT Attribute is Discounted<br />Apply Discounts Used by Product Special/Sale<br />0= No 1= Yes', E'4', E'203', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'DOCUMENT PRODUCT Attribute is Included in Base Price - Default', E'DEFAULT_DOCUMENT_PRODUCT_ATTRIBUTES_PRICE_BASE_INCLUDED', E'1', E'DOCUMENT PRODUCT Attribute is Included in Base Price<br />Include in Base Price When Priced by Attributes<br />0= No 1= Yes', E'4', E'204', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'DOCUMENT PRODUCT Attribute is Required - Default', E'DEFAULT_DOCUMENT_PRODUCT_ATTRIBUTES_REQUIRED', E'0', E'DOCUMENT PRODUCT Attribute is Required<br />Attribute Required for Text<br />0= No 1= Yes', E'4', E'205', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'DOCUMENT PRODUCT Attribute Price Prefix - Default', E'DEFAULT_DOCUMENT_PRODUCT_PRICE_PREFIX', E'1', E'DOCUMENT PRODUCT Attribute Price Prefix<br />Default Attribute Price Prefix for Adding<br />Blank, + or -', E'4', E'206', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'0\', \'text\'=>\'Blank\'), array(\'id\'=>\'1\', \'text\'=>\'+\'), array(\'id\'=>\'2\', \'text\'=>\'-\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'DOCUMENT PRODUCT Attribute Weight Prefix - Default', E'DEFAULT_DOCUMENT_PRODUCT_PRODUCTS_ATTRIBUTES_WEIGHT_PREFIX', E'1', E'DOCUMENT PRODUCT Attribute Weight Prefix<br />Default Attribute Weight Prefix<br />Blank, + or -', E'4', E'207', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'0\', \'text\'=>\'Blank\'), array(\'id\'=>\'1\', \'text\'=>\'+\'), array(\'id\'=>\'2\', \'text\'=>\'-\')), ', now());
 

INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'PRODUCT FREE SHIPPING Attribute is Display Only - Default', E'DEFAULT_PRODUCT_FREE_SHIPPING_ATTRIBUTES_DISPLAY_ONLY', E'0', E'PRODUCT FREE SHIPPING Attribute is Display Only<br />Used For Display Purposes Only<br />0= No 1= Yes', E'5', E'201', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'PRODUCT FREE SHIPPING Attribute is Free - Default', E'DEFAULT_PRODUCT_FREE_SHIPPING_ATTRIBUTE_IS_FREE', E'1', E'PRODUCT FREE SHIPPING Attribute is Free<br />Attribute is Free When Product is Free<br />0= No 1= Yes', E'5', E'201', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'PRODUCT FREE SHIPPING Attribute is Default - Default', E'DEFAULT_PRODUCT_FREE_SHIPPING_ATTRIBUTES_DEFAULT', E'0', E'PRODUCT FREE SHIPPING Attribute is Default<br />Default Attribute to be Marked Selected<br />0= No 1= Yes', E'5', E'202', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'PRODUCT FREE SHIPPING Attribute is Discounted - Default', E'DEFAULT_PRODUCT_FREE_SHIPPING_ATTRIBUTES_DISCOUNTED', E'1', E'PRODUCT FREE SHIPPING Attribute is Discounted<br />Apply Discounts Used by Product Special/Sale<br />0= No 1= Yes', E'5', E'203', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'PRODUCT FREE SHIPPING Attribute is Included in Base Price - Default', E'DEFAULT_PRODUCT_FREE_SHIPPING_ATTRIBUTES_PRICE_BASE_INCLUDED', E'1', E'PRODUCT FREE SHIPPING Attribute is Included in Base Price<br />Include in Base Price When Priced by Attributes<br />0= No 1= Yes', E'5', E'204', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'PRODUCT FREE SHIPPING Attribute is Required - Default', E'DEFAULT_PRODUCT_FREE_SHIPPING_ATTRIBUTES_REQUIRED', E'0', E'PRODUCT FREE SHIPPING Attribute is Required<br />Attribute Required for Text<br />0= No 1= Yes', E'5', E'205', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'1\', \'text\'=>\'Yes\'), array(\'id\'=>\'0\', \'text\'=>\'No\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'PRODUCT FREE SHIPPING Attribute Price Prefix - Default', E'DEFAULT_PRODUCT_FREE_SHIPPING_PRICE_PREFIX', E'1', E'PRODUCT FREE SHIPPING Attribute Price Prefix<br />Default Attribute Price Prefix for Adding<br />Blank, + or -', E'5', E'206', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'0\', \'text\'=>\'Blank\'), array(\'id\'=>\'1\', \'text\'=>\'+\'), array(\'id\'=>\'2\', \'text\'=>\'-\')), ', now());
 
INSERT INTO product_type_layout (configuration_title, configuration_key, configuration_value, configuration_description, product_type_id, sort_order, set_function, date_added) VALUES (E'PRODUCT FREE SHIPPING Attribute Weight Prefix - Default', E'DEFAULT_PRODUCT_FREE_SHIPPING_PRODUCTS_ATTRIBUTES_WEIGHT_PREFIX', E'1', E'PRODUCT FREE SHIPPING Attribute Weight Prefix<br />Default Attribute Weight Prefix<br />Blank, + or -', E'5', E'207', E'zen_cfg_select_ --DROP_down(array(array(\'id\'=>\'0\', \'text\'=>\'Blank\'), array(\'id\'=>\'1\', \'text\'=>\'+\'), array(\'id\'=>\'2\', \'text\'=>\'-\')), ', now());
 


--## eof: attribute default database updates and changes
--# Insert the default queries for all customers and all newsletter subscribers
INSERT INTO query_builder ( query_id , query_category , query_name , query_description , query_string , query_keys_list ) VALUES ( E'1', E'email', E'All Customers', E'Returns all customers name and email address for sending mass emails (ie: for newsletters, coupons, GV\'s, messages, etc).', E'select customers_email_address, customers_firstname, customers_lastname from TABLE_CUSTOMERS order by customers_lastname, customers_firstname, customers_email_address', E'');
 
INSERT INTO query_builder ( query_id , query_category , query_name , query_description , query_string , query_keys_list ) VALUES ( E'2', E'email,newsletters', E'All Newsletter Subscribers', E'Returns name and email address of newsletter subscribers', E'select customers_firstname, customers_lastname, customers_email_address from TABLE_CUSTOMERS where customers_newsletter = \'1\'', E'');
 
INSERT INTO query_builder ( query_id , query_category , query_name , query_description , query_string , query_keys_list ) VALUES ( E'3', E'email,newsletters', E'Dormant Customers (>3months) (Subscribers)', E'Subscribers who HAVE purchased something, but have NOT purchased for at least three months.', E'select o.date_purchased, c.customers_email_address, c.customers_lastname, c.customers_firstname from TABLE_CUSTOMERS c, TABLE_ORDERS o WHERE c.customers_id = o.customers_id AND c.customers_newsletter = 1 GROUP BY c.customers_email_address HAVING max(o.date_purchased) <= subdate(now(),INTERVAL 3 MONTH) ORDER BY c.customers_lastname, c.customers_firstname ASC', E'');
 
INSERT INTO query_builder ( query_id , query_category , query_name , query_description , query_string , query_keys_list ) VALUES ( E'4', E'email,newsletters', E'Active customers in past 3 months (Subscribers)', E'Newsletter subscribers who are also active customers (purchased something) in last 3 months.', E'select c.customers_email_address, c.customers_lastname, c.customers_firstname from TABLE_CUSTOMERS c, TABLE_ORDERS o where c.customers_newsletter = \'1\' AND c.customers_id = o.customers_id and o.date_purchased > subdate(now(),INTERVAL 3 MONTH) GROUP BY c.customers_email_address order by c.customers_lastname, c.customers_firstname ASC', E'');
 
INSERT INTO query_builder ( query_id , query_category , query_name , query_description , query_string , query_keys_list ) VALUES ( E'5', E'email,newsletters', E'Active customers in past 3 months (Regardless of subscription status)', E'All active customers (purchased something) in last 3 months, ignoring newsletter-subscription status.', E'select c.customers_email_address, c.customers_lastname, c.customers_firstname from TABLE_CUSTOMERS c, TABLE_ORDERS o WHERE c.customers_id = o.customers_id and o.date_purchased > subdate(now(),INTERVAL 3 MONTH) GROUP BY c.customers_email_address order by c.customers_lastname, c.customers_firstname ASC', E'');
 
INSERT INTO query_builder ( query_id , query_category , query_name , query_description , query_string , query_keys_list ) VALUES ( E'6', E'email,newsletters', E'Administrator', E'Just the email account of the current administrator', E'select \'ADMIN\' as customers_firstname, admin_name as customers_lastname, admin_email as customers_email_address from TABLE_ADMIN where admin_id = $SESSION:admin_id', E'');
 



--
-- end of Query-Builder Setup
--
--
-- Dumping data for table get_terms_to_filter
--
INSERT INTO get_terms_to_filter VALUES (E'manufacturers_id', E'TABLE_MANUFACTURERS', E'manufacturers_name');
 
INSERT INTO get_terms_to_filter VALUES (E'music_genre_id', E'TABLE_MUSIC_GENRE', E'music_genre_name');
 
INSERT INTO get_terms_to_filter VALUES (E'record_company_id', E'TABLE_RECORD_COMPANY', E'record_company_name');
 


--
-- Dumping data for table project_version
--
INSERT INTO project_version (project_version_id, project_version_key, project_version_major, project_version_minor, project_version_patch1, project_version_patch1_source, project_version_patch2, project_version_patch2_source, project_version_comment, project_version_date_applied) VALUES (1, E'Zen-Cart Main', E'1', E'3.7.1', E'', E'', E'', E'', E'Fresh Installation', now());
 
INSERT INTO project_version (project_version_id, project_version_key, project_version_major, project_version_minor, project_version_patch1, project_version_patch1_source, project_version_patch2, project_version_patch2_source, project_version_comment, project_version_date_applied) VALUES (2, E'Zen-Cart Database', E'1', E'3.7.1', E'', E'', E'', E'', E'Fresh Installation', now());
 
INSERT INTO project_version_history (project_version_id, project_version_key, project_version_major, project_version_minor, project_version_patch, project_version_comment, project_version_date_applied) VALUES (1, E'Zen-Cart Main', E'1', E'3.7.1', E'', E'Fresh Installation', now());
 
INSERT INTO project_version_history (project_version_id, project_version_key, project_version_major, project_version_minor, project_version_patch, project_version_comment, project_version_date_applied) VALUES (2, E'Zen-Cart Database', E'1', E'3.7.1', E'', E'Fresh Installation', now());
 

