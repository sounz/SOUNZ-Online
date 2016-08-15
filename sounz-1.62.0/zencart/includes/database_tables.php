<?php
/**
 * database_tables.php
 * Defines the database table names used in the project
 *
 * @package initSystem
 * @copyright Copyright 2003-2005 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: database_tables.php 4862 2006-10-29 21:34:18Z drbyte $
 * @private
 */

if (!defined('DB_PREFIX')) define('DB_PREFIX', '');
#define('TABLE_ADDRESS_BOOK', DB_PREFIX . 'address_book');
define('TABLE_ADDRESS_BOOK', 'sounz_zencart_address_book');
define('ZENCART_TABLE_ADDRESS_BOOK', 'zencartaddress_book');

define ('SOUNZ_ITEM_TABLE','items');

define('TABLE_ADMIN', DB_PREFIX . 'admin');
define('TABLE_ADMIN_ACTIVITY_LOG', DB_PREFIX . 'admin_activity_log');
define('TABLE_ADDRESS_FORMAT', DB_PREFIX . 'address_format');
define('TABLE_AUTHORIZENET', DB_PREFIX . 'authorizenet');
define('TABLE_BANNERS', DB_PREFIX . 'banners');
define('TABLE_BANNERS_HISTORY', DB_PREFIX . 'banners_history');
define('TABLE_CATEGORIES', DB_PREFIX . 'categories');
define('TABLE_CATEGORIES_DESCRIPTION', DB_PREFIX . 'categories_description');
define('TABLE_CONFIGURATION', DB_PREFIX . 'configuration');
define('TABLE_CONFIGURATION_GROUP', DB_PREFIX . 'configuration_group');
define('TABLE_COUNTER', DB_PREFIX . 'counter');
define('TABLE_COUNTER_HISTORY', DB_PREFIX . 'counter_history');
#define('TABLE_COUNTRIES', DB_PREFIX . 'countries');
define('TABLE_COUNTRIES', 'sounz_zencart_countries');
define('TABLE_COUPON_GV_QUEUE', DB_PREFIX . 'coupon_gv_queue');
define('TABLE_COUPON_GV_CUSTOMER', DB_PREFIX . 'coupon_gv_customer');
define('TABLE_COUPON_EMAIL_TRACK', DB_PREFIX . 'coupon_email_track');
define('TABLE_COUPON_REDEEM_TRACK', DB_PREFIX . 'coupon_redeem_track');
define('TABLE_COUPON_RESTRICT', DB_PREFIX . 'coupon_restrict');
define('TABLE_COUPONS', DB_PREFIX . 'coupons');
define('TABLE_COUPONS_DESCRIPTION', DB_PREFIX . 'coupons_description');
define('TABLE_CURRENCIES', DB_PREFIX . 'currencies');
#define('TABLE_CUSTOMERS', DB_PREFIX . 'customers');
define('TABLE_CUSTOMERS', 'sounz_zencart_customers');
define('TABLE_CUSTOMERS_BASKET', DB_PREFIX . 'customers_basket');
define('TABLE_CUSTOMERS_BASKET_ATTRIBUTES', DB_PREFIX . 'customers_basket_attributes');
define('TABLE_CUSTOMERS_INFO', DB_PREFIX . 'customers_info');
define('TABLE_DB_CACHE', DB_PREFIX . 'db_cache');
define('TABLE_EMAIL_ARCHIVE', DB_PREFIX . 'email_archive');
define('TABLE_EZPAGES', DB_PREFIX . 'ezpages');
define('TABLE_FEATURED', DB_PREFIX . 'featured');
define('TABLE_FILES_UPLOADED', DB_PREFIX . 'files_uploaded');
define('TABLE_GROUP_PRICING', DB_PREFIX . 'group_pricing');
define('TABLE_GET_TERMS_TO_FILTER', DB_PREFIX . 'get_terms_to_filter');
define('TABLE_LANGUAGES', DB_PREFIX . 'languages');
define('TABLE_LAYOUT_BOXES', DB_PREFIX . 'layout_boxes');
define('TABLE_MANUFACTURERS', DB_PREFIX . 'manufacturers');
define('TABLE_MANUFACTURERS_INFO', DB_PREFIX . 'manufacturers_info');
define('TABLE_META_TAGS_PRODUCTS_DESCRIPTION', DB_PREFIX . 'meta_tags_products_description');
define('TABLE_METATAGS_CATEGORIES_DESCRIPTION', DB_PREFIX . 'meta_tags_categories_description');
define('TABLE_NEWSLETTERS', DB_PREFIX . 'newsletters');
define('TABLE_ORDERS', DB_PREFIX . 'orders');
define('TABLE_ORDERS_PRODUCTS', DB_PREFIX . 'orders_products');
define('TABLE_ORDERS_PRODUCTS_ATTRIBUTES', DB_PREFIX . 'orders_products_attributes');
define('TABLE_ORDERS_PRODUCTS_DOWNLOAD', DB_PREFIX . 'orders_products_download');
define('TABLE_ORDERS_STATUS', DB_PREFIX . 'orders_status');
define('TABLE_ORDERS_STATUS_HISTORY', DB_PREFIX . 'orders_status_history');
define('TABLE_ORDERS_TYPE', DB_PREFIX . 'orders_type');
define('TABLE_ORDERS_TOTAL', DB_PREFIX . 'orders_total');
define('TABLE_PAYPAL', DB_PREFIX . 'paypal');
define('TABLE_PAYPAL_SESSION', DB_PREFIX . 'paypal_session');
define('TABLE_PAYPAL_PAYMENT_STATUS', DB_PREFIX . 'paypal_payment_status');
define('TABLE_PAYPAL_PAYMENT_STATUS_HISTORY', DB_PREFIX . 'paypal_payment_status_history');
define('TABLE_PAYPAL_TESTING', DB_PREFIX . 'paypal_testing');
#define('TABLE_PRODUCTS', DB_PREFIX . 'products');
define('TABLE_PRODUCTS', 'sounz_zencart_products');
define('TABLE_PRODUCT_TYPES', DB_PREFIX . 'product_types');
define('TABLE_PRODUCT_TYPE_LAYOUT', DB_PREFIX . 'product_type_layout');
define('TABLE_PRODUCT_TYPES_TO_CATEGORY', DB_PREFIX . 'product_types_to_category');

#define('TABLE_PRODUCTS_ATTRIBUTES', DB_PREFIX . 'products_attributes');
define('TABLE_PRODUCTS_ATTRIBUTES', 'sounz_zencart_product_attributes');

#define('TABLE_PRODUCTS_ATTRIBUTES_DOWNLOAD', DB_PREFIX . 'products_attributes_download');
define('TABLE_PRODUCTS_ATTRIBUTES_DOWNLOAD', 'sounz_zencart_product_attributes_download');

#define('TABLE_PRODUCTS_DESCRIPTION', DB_PREFIX . 'products_description');
define('TABLE_PRODUCTS_DESCRIPTION', 'sounz_zencart_products_description');
define('TABLE_PRODUCTS_DISCOUNT_QUANTITY', DB_PREFIX . 'products_discount_quantity');
define('TABLE_PRODUCTS_NOTIFICATIONS', DB_PREFIX . 'products_notifications');
define('TABLE_PRODUCTS_OPTIONS', DB_PREFIX . 'products_options');
define('TABLE_PRODUCTS_OPTIONS_VALUES', DB_PREFIX . 'products_options_values');
define('TABLE_PRODUCTS_OPTIONS_VALUES_TO_PRODUCTS_OPTIONS', DB_PREFIX . 'products_options_values_to_products_options');
define('TABLE_PRODUCTS_OPTIONS_TYPES', DB_PREFIX . 'products_options_types');
#define('TABLE_PRODUCTS_TO_CATEGORIES', DB_PREFIX . 'products_to_categories');
define('TABLE_PRODUCTS_TO_CATEGORIES', 'sounz_zencart_products_to_categories');
define('TABLE_PROJECT_VERSION', DB_PREFIX . 'project_version');
define('TABLE_PROJECT_VERSION_HISTORY', DB_PREFIX . 'project_version_history');
define('TABLE_QUERY_BUILDER', DB_PREFIX . 'query_builder');
define('TABLE_REVIEWS', DB_PREFIX . 'reviews');
define('TABLE_REVIEWS_DESCRIPTION', DB_PREFIX . 'reviews_description');
define('TABLE_SALEMAKER_SALES', DB_PREFIX . 'salemaker_sales');
define('TABLE_SESSIONS', DB_PREFIX . 'sessions');
define('TABLE_SPECIALS', DB_PREFIX . 'specials');
define('TABLE_TEMPLATE_SELECT', DB_PREFIX . 'template_select');
define('TABLE_TAX_CLASS', DB_PREFIX . 'tax_class');
define('TABLE_TAX_RATES', DB_PREFIX . 'tax_rates');
define('TABLE_GEO_ZONES', DB_PREFIX . 'geo_zones');
define('TABLE_ZONES_TO_GEO_ZONES', DB_PREFIX . 'zones_to_geo_zones');
define('TABLE_UPGRADE_EXCEPTIONS', DB_PREFIX . 'upgrade_exceptions');
define('TABLE_WISHLIST', DB_PREFIX . 'customers_wishlist');
define('TABLE_WHOS_ONLINE', DB_PREFIX . 'whos_online');
define('TABLE_ZONES', DB_PREFIX . 'zones');

#added by pete to support postgres sequence lastval 
define('TABLE_ADDRESS_BOOK_SEQ','address_book_address_booktest_id_seq');
define('TABLE_ADMIN_SEQ','admin_admin_id_seq');
define('TABLE_ADMIN_ACTIVITY_LOG_SEQ','admin_activity_log_admin_activity_log_id_seq');
define('TABLE_ADDRESS_FORMAT_SEQ','address_format_address_format_id_seq');
define('TABLE_AUTHORIZENET_SEQ','authorizenet_authorizenet_id_seq');
define('TABLE_BANNERS_SEQ','banners_banners_id_seq');
define('TABLE_BANNERS_HISTORY_SEQ','banners_history_banners_history_id_seq');
define('TABLE_CATEGORIES_SEQ','categories_categories_id_seq');
define('TABLE_CATEGORIES_DESCRIPTION_SEQ','categories_description_categories_description_id_seq');
define('TABLE_CONFIGURATION_SEQ','configuration_configuration_id_seq');
define('TABLE_CONFIGURATION_GROUP_SEQ','configuration_group_configuration_group_id_seq');
define('TABLE_COUNTER_SEQ','counter_counter_id_seq');
define('TABLE_COUNTER_HISTORY_SEQ','counter_history_counter_history_id_seq');
define('TABLE_COUNTRIES_SEQ','countries_countries_id_seq');
define('TABLE_COUPON_GV_QUEUE_SEQ','coupon_gv_queue_coupon_gv_queue_id_seq');
define('TABLE_COUPON_GV_CUSTOMER_SEQ','coupon_gv_customer_coupon_gv_customer_id_seq');
define('TABLE_COUPON_EMAIL_TRACK_SEQ','coupon_email_track_coupon_email_track_id_seq');
define('TABLE_COUPON_REDEEM_TRACK_SEQ','coupon_redeem_track_coupon_redeem_track_id_seq');
define('TABLE_COUPON_RESTRICT_SEQ','coupon_restrict_coupon_restrict_id_seq');
define('TABLE_COUPONS_SEQ','coupons_coupons_id_seq');
define('TABLE_COUPONS_DESCRIPTION_SEQ','coupons_description_coupons_description_id_seq');
define('TABLE_CURRENCIES_SEQ','currencies_currencies_id_seq');
define('TABLE_CUSTOMERS_SEQ','customers_customers_id_seq');
define('TABLE_CUSTOMERS_BASKET_SEQ','customers_basket_customers_basket_id_seq');
define('TABLE_CUSTOMERS_BASKET_ATTRIBUTES_SEQ','customers_basket_attributes_customers_basket_attributes_id_seq');
define('TABLE_CUSTOMERS_INFO_SEQ','customers_info_customers_info_id_seq');
define('TABLE_DB_CACHE_SEQ','db_cache_db_cache_id_seq');
define('TABLE_EMAIL_ARCHIVE_SEQ','email_archive_email_archive_id_seq');
define('TABLE_EZPAGES_SEQ','ezpages_ezpages_id_seq');
define('TABLE_FEATURED_SEQ','featured_featured_id_seq');
define('TABLE_FILES_UPLOADED_SEQ','files_uploaded_files_uploaded_id_seq');
define('TABLE_GROUP_PRICING_SEQ','group_pricing_group_pricing_id_seq');
define('TABLE_GET_TERMS_TO_FILTER_SEQ','get_terms_to_filter_get_terms_to_filter_id_seq');
define('TABLE_LANGUAGES_SEQ','languages_languages_id_seq');
define('TABLE_LAYOUT_BOXES_SEQ','layout_boxes_layout_boxes_id_seq');
define('TABLE_MANUFACTURERS_SEQ','manufacturers_manufacturers_id_seq');
define('TABLE_MANUFACTURERS_INFO_SEQ','manufacturers_info_manufacturers_info_id_seq');
define('TABLE_META_TAGS_PRODUCTS_DESCRIPTION_SEQ','meta_tags_products_description_meta_tags_products_description_id_seq');
define('TABLE_METATAGS_CATEGORIES_DESCRIPTION_SEQ','meta_tags_categories_description_meta_tags_categories_description_id_seq');
define('TABLE_NEWSLETTERS_SEQ','newsletters_newsletters_id_seq');
define('TABLE_ORDERS_SEQ','orders_orders_id_seq');
define('TABLE_ORDERS_PRODUCTS_SEQ','orders_products_orders_products_id_seq');
define('TABLE_ORDERS_PRODUCTS_ATTRIBUTES_SEQ','orders_products_attributes_orders_products_attributes_id_seq');
define('TABLE_ORDERS_PRODUCTS_DOWNLOAD_SEQ','orders_products_download_orders_products_download_id_seq');
define('TABLE_ORDERS_STATUS_SEQ','orders_status_orders_status_id_seq');
define('TABLE_ORDERS_STATUS_HISTORY_SEQ','orders_status_history_orders_status_history_id_seq');
define('TABLE_ORDERS_TYPE_SEQ','orders_type_orders_type_id_seq');
define('TABLE_ORDERS_TOTAL_SEQ','orders_total_orders_total_id_seq');
define('TABLE_PAYPAL_SEQ','paypal_paypal_id_seq');
define('TABLE_PAYPAL_SESSION_SEQ','paypal_session_paypal_session_id_seq');
define('TABLE_PAYPAL_PAYMENT_STATUS_SEQ','paypal_payment_status_paypal_payment_status_id_seq');
define('TABLE_PAYPAL_PAYMENT_STATUS_HISTORY_SEQ','paypal_payment_status_history_paypal_payment_status_history_id_seq');
define('TABLE_PAYPAL_TESTING_SEQ','paypal_testing_paypal_testing_id_seq');
define('TABLE_PRODUCTS_SEQ','products_products_id_seq');
define('TABLE_PRODUCT_TYPES_SEQ','product_types_product_types_id_seq');
define('TABLE_PRODUCT_TYPE_LAYOUT_SEQ','product_type_layout_product_type_layout_id_seq');
define('TABLE_PRODUCT_TYPES_TO_CATEGORY_SEQ','product_types_to_category_product_types_to_category_id_seq');
define('TABLE_PRODUCTS_ATTRIBUTES_SEQ','products_attributes_products_attributes_id_seq');
define('TABLE_PRODUCTS_ATTRIBUTES_DOWNLOAD_SEQ','products_attributes_download_products_attributes_download_id_seq');
define('TABLE_PRODUCTS_DESCRIPTION_SEQ','products_description_products_description_id_seq');
define('TABLE_PRODUCTS_DISCOUNT_QUANTITY_SEQ','products_discount_quantity_products_discount_quantity_id_seq');
define('TABLE_PRODUCTS_NOTIFICATIONS_SEQ','products_notifications_products_notifications_id_seq');
define('TABLE_PRODUCTS_OPTIONS_SEQ','products_options_products_options_id_seq');
define('TABLE_PRODUCTS_OPTIONS_VALUES_SEQ','products_options_values_products_options_values_id_seq');
define('TABLE_PRODUCTS_OPTIONS_VALUES_TO_PRODUCTS_OPTIONS_SEQ','products_options_values_to_products_options_products_options_values_to_products_options_id_seq');
define('TABLE_PRODUCTS_OPTIONS_TYPES_SEQ','products_options_types_products_options_types_id_seq');
define('TABLE_PRODUCTS_TO_CATEGORIES_SEQ','products_to_categories_products_to_categories_id_seq');
define('TABLE_PROJECT_VERSION_SEQ','project_version_project_version_id_seq');
define('TABLE_PROJECT_VERSION_HISTORY_SEQ','project_version_history_project_version_history_id_seq');
define('TABLE_QUERY_BUILDER_SEQ','query_builder_query_builder_id_seq');
define('TABLE_REVIEWS_SEQ','reviews_reviews_id_seq');
define('TABLE_REVIEWS_DESCRIPTION_SEQ','reviews_description_reviews_description_id_seq');
define('TABLE_SALEMAKER_SALES_SEQ','salemaker_sales_salemaker_sales_id_seq');
define('TABLE_SESSIONS_SEQ','sessions_sessions_id_seq');
define('TABLE_SPECIALS_SEQ','specials_specials_id_seq');
define('TABLE_TEMPLATE_SELECT_SEQ','template_select_template_select_id_seq');
define('TABLE_TAX_CLASS_SEQ','tax_class_tax_class_id_seq');
define('TABLE_TAX_RATES_SEQ','tax_rates_tax_rates_id_seq');
define('TABLE_GEO_ZONES_SEQ','geo_zones_geo_zones_id_seq');
define('TABLE_ZONES_TO_GEO_ZONES_SEQ','zones_to_geo_zones_zones_to_geo_zones_id_seq');
define('TABLE_UPGRADE_EXCEPTIONS_SEQ','upgrade_exceptions_upgrade_exceptions_id_seq');
define('TABLE_WISHLIST_SEQ','customers_wishlist_customers_wishlist_id_seq');
define('TABLE_WHOS_ONLINE_SEQ','whos_online_whos_online_id_seq');
define('TABLE_ZONES_SEQ','zones_zones_id_seq');
?>