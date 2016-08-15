--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

BEGIN;

CREATE SEQUENCE address_book_address_book_id_seq;
CREATE SEQUENCE address_format_address_format_id_seq;
CREATE SEQUENCE admin_admin_id_seq;
CREATE SEQUENCE admin_activity_log_log_id_seq;
CREATE SEQUENCE authorizenet_id_seq;
CREATE SEQUENCE banners_banners_id_seq;
CREATE SEQUENCE banners_history_banners_history_id_seq;
CREATE SEQUENCE categories_categories_id_seq;
CREATE SEQUENCE configuration_configuration_id_seq;
CREATE SEQUENCE configuration_group_configuration_group_id_seq;
CREATE SEQUENCE countries_countries_id_seq;
CREATE SEQUENCE coupon_email_track_unique_id_seq;
CREATE SEQUENCE coupon_gv_queue_unique_id_seq;
CREATE SEQUENCE coupon_redeem_track_unique_id_seq;
CREATE SEQUENCE coupon_restrict_restrict_id_seq;
CREATE SEQUENCE coupons_coupon_id_seq;
CREATE SEQUENCE currencies_currencies_id_seq;
CREATE SEQUENCE customers_customers_id_seq;
CREATE SEQUENCE customers_basket_customers_basket_id_seq;
CREATE SEQUENCE customers_basket_attributes_customers_basket_attributes_id_seq;
CREATE SEQUENCE email_archive_archive_id_seq;
CREATE SEQUENCE ezpages_pages_id_seq;
CREATE SEQUENCE featured_featured_id_seq;
CREATE SEQUENCE files_uploaded_files_uploaded_id_seq;
CREATE SEQUENCE geo_zones_geo_zone_id_seq;
CREATE SEQUENCE group_pricing_group_id_seq;
CREATE SEQUENCE languages_languages_id_seq;
CREATE SEQUENCE layout_boxes_layout_id_seq;
CREATE SEQUENCE manufacturers_manufacturers_id_seq;
CREATE SEQUENCE media_clips_clip_id_seq;
CREATE SEQUENCE media_manager_media_id_seq;
CREATE SEQUENCE media_types_type_id_seq;
CREATE SEQUENCE music_genre_music_genre_id_seq;
CREATE SEQUENCE newsletters_newsletters_id_seq;
CREATE SEQUENCE orders_orders_id_seq;
CREATE SEQUENCE orders_products_orders_products_id_seq;
CREATE SEQUENCE orders_products_attributes_orders_products_attributes_id_seq;
CREATE SEQUENCE orders_products_download_orders_products_download_id_seq;
CREATE SEQUENCE orders_status_history_orders_status_history_id_seq;
CREATE SEQUENCE orders_total_orders_total_id_seq;
CREATE SEQUENCE paypal_paypal_ipn_id_seq;
CREATE SEQUENCE paypal_payment_status_payment_status_id_seq;
CREATE SEQUENCE paypal_payment_status_history_payment_status_history_id_seq;
CREATE SEQUENCE paypal_session_unique_id_seq;
CREATE SEQUENCE paypal_testing_paypal_ipn_id_seq;
CREATE SEQUENCE product_type_layout_configuration_id_seq;
CREATE SEQUENCE product_types_type_id_seq;
CREATE SEQUENCE products_products_id_seq;
CREATE SEQUENCE products_attributes_products_attributes_id_seq;
CREATE SEQUENCE products_description_products_id_seq;
CREATE SEQUENCE ucts_options_products_options_values_to_products_options_id_seq;
CREATE SEQUENCE project_version_project_version_id_seq;
CREATE SEQUENCE project_version_history_project_version_id_seq;
CREATE SEQUENCE query_builder_query_id_seq;
CREATE SEQUENCE record_artists_artists_id_seq;
CREATE SEQUENCE record_company_record_company_id_seq;
CREATE SEQUENCE reviews_reviews_id_seq;
CREATE SEQUENCE salemaker_sales_sale_id_seq;
CREATE SEQUENCE specials_specials_id_seq;
CREATE SEQUENCE tax_class_tax_class_id_seq;
CREATE SEQUENCE tax_rates_tax_rates_id_seq;
CREATE SEQUENCE template_select_template_id_seq;
CREATE SEQUENCE upgrade_exceptions_upgrade_exception_id_seq;
CREATE SEQUENCE zones_zone_id_seq;
CREATE SEQUENCE zones_to_geo_zones_association_id_seq;

--
-- Name: zencartaddress_book; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartaddress_book (
    address_book_id integer DEFAULT nextval('address_book_address_book_id_seq'::regclass) NOT NULL,
    customers_id integer DEFAULT 0 NOT NULL,
    entry_gender character(1) DEFAULT ''::bpchar NOT NULL,
    entry_company character varying(32),
    entry_firstname character varying(32) DEFAULT ''::character varying NOT NULL,
    entry_lastname character varying(32) DEFAULT ''::character varying NOT NULL,
    entry_street_address character varying(64) DEFAULT ''::character varying NOT NULL,
    entry_suburb character varying(32),
    entry_postcode character varying(10) DEFAULT ''::character varying NOT NULL,
    entry_city character varying(32) DEFAULT ''::character varying NOT NULL,
    entry_state character varying(32),
    entry_country_id integer DEFAULT 0 NOT NULL,
    entry_zone_id integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.zencartaddress_book OWNER TO sounz;

--
-- Name: zencartaddress_format; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartaddress_format (
    address_format_id integer DEFAULT nextval('address_format_address_format_id_seq'::regclass) NOT NULL,
    address_format character varying(128) DEFAULT ''::character varying NOT NULL,
    address_summary character varying(48) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.zencartaddress_format OWNER TO sounz;

--
-- Name: zencartadmin; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartadmin (
    admin_id integer DEFAULT nextval('admin_admin_id_seq'::regclass) NOT NULL,
    admin_name character varying(32) DEFAULT ''::character varying NOT NULL,
    admin_email character varying(96) DEFAULT ''::character varying NOT NULL,
    admin_pass character varying(40) DEFAULT ''::character varying NOT NULL,
    admin_level smallint DEFAULT (1)::smallint NOT NULL
);


ALTER TABLE public.zencartadmin OWNER TO sounz;

--
-- Name: zencartadmin_activity_log; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartadmin_activity_log (
    log_id integer DEFAULT nextval('admin_activity_log_log_id_seq'::regclass) NOT NULL,
    access_date timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    admin_id integer DEFAULT 0 NOT NULL,
    page_accessed character varying(80) DEFAULT ''::character varying NOT NULL,
    page_parameters text,
    ip_address character varying(15) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.zencartadmin_activity_log OWNER TO sounz;

--
-- Name: zencartauthorizenet; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartauthorizenet (
    id integer DEFAULT nextval('authorizenet_id_seq'::regclass) NOT NULL,
    customer_id integer DEFAULT 0 NOT NULL,
    order_id integer DEFAULT 0 NOT NULL,
    response_code integer DEFAULT 0 NOT NULL,
    response_text character varying(255) DEFAULT ''::character varying NOT NULL,
    authorization_type text NOT NULL,
    transaction_id integer DEFAULT 0 NOT NULL,
    sent text NOT NULL,
    received text NOT NULL,
    "time" character varying(50) DEFAULT ''::character varying NOT NULL,
    session_id character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.zencartauthorizenet OWNER TO sounz;

--
-- Name: zencartbanners; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartbanners (
    banners_id integer DEFAULT nextval('banners_banners_id_seq'::regclass) NOT NULL,
    banners_title character varying(64) DEFAULT ''::character varying NOT NULL,
    banners_url character varying(255) DEFAULT ''::character varying NOT NULL,
    banners_image character varying(64) DEFAULT ''::character varying NOT NULL,
    banners_group character varying(15) DEFAULT ''::character varying NOT NULL,
    banners_html_text text,
    expires_impressions integer DEFAULT 0,
    expires_date timestamp without time zone,
    date_scheduled timestamp without time zone,
    date_added timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    date_status_change timestamp without time zone,
    status integer DEFAULT 1 NOT NULL,
    banners_open_new_windows integer DEFAULT 1 NOT NULL,
    banners_on_ssl integer DEFAULT 1 NOT NULL,
    banners_sort_order integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.zencartbanners OWNER TO sounz;

--
-- Name: zencartbanners_history; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartbanners_history (
    banners_history_id integer DEFAULT nextval('banners_history_banners_history_id_seq'::regclass) NOT NULL,
    banners_id integer DEFAULT 0 NOT NULL,
    banners_shown integer DEFAULT 0 NOT NULL,
    banners_clicked integer DEFAULT 0 NOT NULL,
    banners_history_date timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE public.zencartbanners_history OWNER TO sounz;

--
-- Name: zencartcategories; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartcategories (
    categories_id integer DEFAULT nextval('categories_categories_id_seq'::regclass) NOT NULL,
    categories_image character varying(64),
    parent_id integer DEFAULT 0 NOT NULL,
    sort_order integer,
    date_added timestamp without time zone,
    last_modified timestamp without time zone,
    categories_status smallint DEFAULT (1)::smallint NOT NULL
);


ALTER TABLE public.zencartcategories OWNER TO sounz;

--
-- Name: zencartcategories_description; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartcategories_description (
    categories_id integer DEFAULT 0 NOT NULL,
    language_id integer DEFAULT 1 NOT NULL,
    categories_name character varying(32) DEFAULT ''::character varying NOT NULL,
    categories_description text NOT NULL
);


ALTER TABLE public.zencartcategories_description OWNER TO sounz;

--
-- Name: zencartconfiguration; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartconfiguration (
    configuration_id integer DEFAULT nextval('configuration_configuration_id_seq'::regclass) NOT NULL,
    configuration_title text NOT NULL,
    configuration_key character varying(255) DEFAULT ''::character varying NOT NULL,
    configuration_value text NOT NULL,
    configuration_description text NOT NULL,
    configuration_group_id integer DEFAULT 0 NOT NULL,
    sort_order integer,
    last_modified timestamp without time zone,
    date_added timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    use_function text,
    set_function text
);


ALTER TABLE public.zencartconfiguration OWNER TO sounz;

--
-- Name: zencartconfiguration_group; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartconfiguration_group (
    configuration_group_id integer DEFAULT nextval('configuration_group_configuration_group_id_seq'::regclass) NOT NULL,
    configuration_group_title character varying(64) DEFAULT ''::character varying NOT NULL,
    configuration_group_description character varying(255) DEFAULT ''::character varying NOT NULL,
    sort_order integer,
    visible integer DEFAULT 1
);


ALTER TABLE public.zencartconfiguration_group OWNER TO sounz;

--
-- Name: zencartcounter; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartcounter (
    startdate character(8),
    counter integer
);


ALTER TABLE public.zencartcounter OWNER TO sounz;

--
-- Name: zencartcounter_history; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartcounter_history (
    startdate character(8),
    counter integer,
    session_counter integer
);


ALTER TABLE public.zencartcounter_history OWNER TO sounz;

--
-- Name: zencartcountries; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartcountries (
    countries_id integer DEFAULT nextval('countries_countries_id_seq'::regclass) NOT NULL,
    countries_name character varying(64) DEFAULT ''::character varying NOT NULL,
    countries_iso_code_2 character(2) DEFAULT ''::bpchar NOT NULL,
    countries_iso_code_3 character(3) DEFAULT ''::bpchar NOT NULL,
    address_format_id integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.zencartcountries OWNER TO sounz;

--
-- Name: zencartcoupon_email_track; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartcoupon_email_track (
    unique_id integer DEFAULT nextval('coupon_email_track_unique_id_seq'::regclass) NOT NULL,
    coupon_id integer DEFAULT 0 NOT NULL,
    customer_id_sent integer DEFAULT 0 NOT NULL,
    sent_firstname character varying(32),
    sent_lastname character varying(32),
    emailed_to character varying(32),
    date_sent timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE public.zencartcoupon_email_track OWNER TO sounz;

--
-- Name: zencartcoupon_gv_customer; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartcoupon_gv_customer (
    customer_id integer DEFAULT 0 NOT NULL,
    amount numeric(15,4) DEFAULT 0.0000 NOT NULL
);


ALTER TABLE public.zencartcoupon_gv_customer OWNER TO sounz;

--
-- Name: zencartcoupon_gv_queue; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartcoupon_gv_queue (
    unique_id integer DEFAULT nextval('coupon_gv_queue_unique_id_seq'::regclass) NOT NULL,
    customer_id integer DEFAULT 0 NOT NULL,
    order_id integer DEFAULT 0 NOT NULL,
    amount numeric(15,4) DEFAULT 0.0000 NOT NULL,
    date_created timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    ipaddr character varying(32) DEFAULT ''::character varying NOT NULL,
    release_flag character(1) DEFAULT 'N'::bpchar NOT NULL
);


ALTER TABLE public.zencartcoupon_gv_queue OWNER TO sounz;

--
-- Name: zencartcoupon_redeem_track; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartcoupon_redeem_track (
    unique_id integer DEFAULT nextval('coupon_redeem_track_unique_id_seq'::regclass) NOT NULL,
    coupon_id integer DEFAULT 0 NOT NULL,
    customer_id integer DEFAULT 0 NOT NULL,
    redeem_date timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    redeem_ip character varying(32) DEFAULT ''::character varying NOT NULL,
    order_id integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.zencartcoupon_redeem_track OWNER TO sounz;

--
-- Name: zencartcoupon_restrict; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartcoupon_restrict (
    restrict_id integer DEFAULT nextval('coupon_restrict_restrict_id_seq'::regclass) NOT NULL,
    coupon_id integer DEFAULT 0 NOT NULL,
    product_id integer DEFAULT 0 NOT NULL,
    category_id integer DEFAULT 0 NOT NULL,
    coupon_restrict character(1) DEFAULT 'N'::bpchar NOT NULL
);


ALTER TABLE public.zencartcoupon_restrict OWNER TO sounz;

--
-- Name: zencartcoupons; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartcoupons (
    coupon_id integer DEFAULT nextval('coupons_coupon_id_seq'::regclass) NOT NULL,
    coupon_type character(1) DEFAULT 'F'::bpchar NOT NULL,
    coupon_code character varying(32) DEFAULT ''::character varying NOT NULL,
    coupon_amount numeric(15,4) DEFAULT 0.0000 NOT NULL,
    coupon_minimum_order numeric(15,4) DEFAULT 0.0000 NOT NULL,
    coupon_start_date timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    coupon_expire_date timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    uses_per_coupon integer DEFAULT 1 NOT NULL,
    uses_per_user integer DEFAULT 0 NOT NULL,
    restrict_to_products character varying(255),
    restrict_to_categories character varying(255),
    restrict_to_customers text,
    coupon_active character(1) DEFAULT 'Y'::bpchar NOT NULL,
    date_created timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    date_modified timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    coupon_zone_restriction integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.zencartcoupons OWNER TO sounz;

--
-- Name: zencartcoupons_description; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartcoupons_description (
    coupon_id integer DEFAULT 0 NOT NULL,
    language_id integer DEFAULT 0 NOT NULL,
    coupon_name character varying(32) DEFAULT ''::character varying NOT NULL,
    coupon_description text
);


ALTER TABLE public.zencartcoupons_description OWNER TO sounz;

--
-- Name: zencartcurrencies; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartcurrencies (
    currencies_id integer DEFAULT nextval('currencies_currencies_id_seq'::regclass) NOT NULL,
    title character varying(32) DEFAULT ''::character varying NOT NULL,
    code character(3) DEFAULT ''::bpchar NOT NULL,
    symbol_left character varying(24),
    symbol_right character varying(24),
    decimal_point character(1),
    thousands_point character(1),
    decimal_places character(1),
    value double precision,
    last_updated timestamp without time zone
);


ALTER TABLE public.zencartcurrencies OWNER TO sounz;

--
-- Name: zencartcustomers; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartcustomers (
    customers_id integer DEFAULT nextval('customers_customers_id_seq'::regclass) NOT NULL,
    customers_gender character(1) DEFAULT ''::bpchar NOT NULL,
    customers_firstname character varying(32) DEFAULT ''::character varying NOT NULL,
    customers_lastname character varying(32) DEFAULT ''::character varying NOT NULL,
    customers_dob timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    customers_email_address character varying(96) DEFAULT ''::character varying NOT NULL,
    customers_nick character varying(96) DEFAULT ''::character varying NOT NULL,
    customers_default_address_id integer DEFAULT 0 NOT NULL,
    customers_telephone character varying(32) DEFAULT ''::character varying NOT NULL,
    customers_fax character varying(32),
    customers_password character varying(40) DEFAULT ''::character varying NOT NULL,
    customers_newsletter character(1),
    customers_group_pricing integer DEFAULT 0 NOT NULL,
    customers_email_format character varying(4) DEFAULT 'TEXT'::character varying NOT NULL,
    customers_authorization integer DEFAULT 0 NOT NULL,
    customers_referral character varying(32) DEFAULT ''::character varying NOT NULL,
    customers_paypal_payerid character varying(20) DEFAULT ''::character varying NOT NULL,
    customers_paypal_ec smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.zencartcustomers OWNER TO sounz;

--
-- Name: zencartcustomers_basket; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartcustomers_basket (
    customers_basket_id integer DEFAULT nextval('customers_basket_customers_basket_id_seq'::regclass) NOT NULL,
    customers_id integer DEFAULT 0 NOT NULL,
    products_id text NOT NULL,
    customers_basket_quantity double precision DEFAULT (0)::double precision NOT NULL,
    final_price numeric(15,4) DEFAULT 0.0000 NOT NULL,
    customers_basket_date_added character varying(8)
);


ALTER TABLE public.zencartcustomers_basket OWNER TO sounz;

--
-- Name: zencartcustomers_basket_attributes; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartcustomers_basket_attributes (
    customers_basket_attributes_id integer DEFAULT nextval('customers_basket_attributes_customers_basket_attributes_id_seq'::regclass) NOT NULL,
    customers_id integer DEFAULT 0 NOT NULL,
    products_id text NOT NULL,
    products_options_id character varying(64) DEFAULT '0'::character varying NOT NULL,
    products_options_value_id integer DEFAULT 0 NOT NULL,
    products_options_value_text bytea,
    products_options_sort_order text NOT NULL
);


ALTER TABLE public.zencartcustomers_basket_attributes OWNER TO sounz;

--
-- Name: zencartcustomers_info; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartcustomers_info (
    customers_info_id integer DEFAULT 0 NOT NULL,
    customers_info_date_of_last_logon timestamp without time zone,
    customers_info_number_of_logons integer,
    customers_info_date_account_created timestamp without time zone,
    customers_info_date_account_last_modified timestamp without time zone,
    global_product_notifications integer DEFAULT 0
);


ALTER TABLE public.zencartcustomers_info OWNER TO sounz;

--
-- Name: zencartcustomers_wishlist; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartcustomers_wishlist (
    products_id integer DEFAULT 0 NOT NULL,
    customers_id integer DEFAULT 0 NOT NULL,
    products_model character varying(13),
    products_name character varying(64) DEFAULT ''::character varying NOT NULL,
    products_price numeric(8,2) DEFAULT 0.00 NOT NULL,
    final_price numeric(8,2) DEFAULT 0.00 NOT NULL,
    products_quantity integer DEFAULT 0 NOT NULL,
    wishlist_name character varying(64)
);


ALTER TABLE public.zencartcustomers_wishlist OWNER TO sounz;

--
-- Name: zencartdb_cache; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartdb_cache (
    cache_entry_name character varying(64) DEFAULT ''::character varying NOT NULL,
    cache_data bytea,
    cache_entry_created integer
);


ALTER TABLE public.zencartdb_cache OWNER TO sounz;

--
-- Name: zencartemail_archive; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartemail_archive (
    archive_id integer DEFAULT nextval('email_archive_archive_id_seq'::regclass) NOT NULL,
    email_to_name character varying(96) DEFAULT ''::character varying NOT NULL,
    email_to_address character varying(96) DEFAULT ''::character varying NOT NULL,
    email_from_name character varying(96) DEFAULT ''::character varying NOT NULL,
    email_from_address character varying(96) DEFAULT ''::character varying NOT NULL,
    email_subject character varying(255) DEFAULT ''::character varying NOT NULL,
    email_html text NOT NULL,
    email_text text NOT NULL,
    date_sent timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    module character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.zencartemail_archive OWNER TO sounz;

--
-- Name: zencartezpages; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartezpages (
    pages_id integer DEFAULT nextval('ezpages_pages_id_seq'::regclass) NOT NULL,
    languages_id integer DEFAULT 1 NOT NULL,
    pages_title character varying(64) DEFAULT ''::character varying NOT NULL,
    alt_url character varying(255) DEFAULT ''::character varying NOT NULL,
    alt_url_external character varying(255) DEFAULT ''::character varying NOT NULL,
    pages_html_text text,
    status_header integer DEFAULT 1 NOT NULL,
    status_sidebox integer DEFAULT 1 NOT NULL,
    status_footer integer DEFAULT 1 NOT NULL,
    status_toc integer DEFAULT 1 NOT NULL,
    header_sort_order integer DEFAULT 0 NOT NULL,
    sidebox_sort_order integer DEFAULT 0 NOT NULL,
    footer_sort_order integer DEFAULT 0 NOT NULL,
    toc_sort_order integer DEFAULT 0 NOT NULL,
    page_open_new_window integer DEFAULT 0 NOT NULL,
    page_is_ssl integer DEFAULT 0 NOT NULL,
    toc_chapter integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.zencartezpages OWNER TO sounz;

--
-- Name: zencartfeatured; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartfeatured (
    featured_id integer DEFAULT nextval('featured_featured_id_seq'::regclass) NOT NULL,
    products_id integer DEFAULT 0 NOT NULL,
    featured_date_added timestamp without time zone,
    featured_last_modified timestamp without time zone,
    expires_date date DEFAULT '0001-01-01'::date NOT NULL,
    date_status_change timestamp without time zone,
    status integer DEFAULT 1 NOT NULL,
    featured_date_available date DEFAULT '0001-01-01'::date NOT NULL
);


ALTER TABLE public.zencartfeatured OWNER TO sounz;

--
-- Name: zencartfiles_uploaded; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartfiles_uploaded (
    files_uploaded_id integer DEFAULT nextval('files_uploaded_files_uploaded_id_seq'::regclass) NOT NULL,
    sesskey character varying(32),
    customers_id integer,
    files_uploaded_name character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.zencartfiles_uploaded OWNER TO sounz;

--
-- Name: zencartgeo_zones; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartgeo_zones (
    geo_zone_id integer DEFAULT nextval('geo_zones_geo_zone_id_seq'::regclass) NOT NULL,
    geo_zone_name character varying(32) DEFAULT ''::character varying NOT NULL,
    geo_zone_description character varying(255) DEFAULT ''::character varying NOT NULL,
    last_modified timestamp without time zone,
    date_added timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE public.zencartgeo_zones OWNER TO sounz;

--
-- Name: zencartget_terms_to_filter; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartget_terms_to_filter (
    get_term_name character varying(255) DEFAULT ''::character varying NOT NULL,
    get_term_table character varying(64) NOT NULL,
    get_term_name_field character varying(64) NOT NULL
);


ALTER TABLE public.zencartget_terms_to_filter OWNER TO sounz;

--
-- Name: zencartgroup_pricing; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartgroup_pricing (
    group_id integer DEFAULT nextval('group_pricing_group_id_seq'::regclass) NOT NULL,
    group_name character varying(32) DEFAULT ''::character varying NOT NULL,
    group_percentage numeric(5,2) DEFAULT 0.00 NOT NULL,
    last_modified timestamp without time zone,
    date_added timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE public.zencartgroup_pricing OWNER TO sounz;

--
-- Name: zencartlanguages; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartlanguages (
    languages_id integer DEFAULT nextval('languages_languages_id_seq'::regclass) NOT NULL,
    name character varying(32) DEFAULT ''::character varying NOT NULL,
    code character(2) DEFAULT ''::bpchar NOT NULL,
    image character varying(64),
    directory character varying(32),
    sort_order integer
);


ALTER TABLE public.zencartlanguages OWNER TO sounz;

--
-- Name: zencartlayout_boxes; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartlayout_boxes (
    layout_id integer DEFAULT nextval('layout_boxes_layout_id_seq'::regclass) NOT NULL,
    layout_template character varying(64) DEFAULT ''::character varying NOT NULL,
    layout_box_name character varying(64) DEFAULT ''::character varying NOT NULL,
    layout_box_status smallint DEFAULT (0)::smallint NOT NULL,
    layout_box_location smallint DEFAULT (0)::smallint NOT NULL,
    layout_box_sort_order integer DEFAULT 0 NOT NULL,
    layout_box_sort_order_single integer DEFAULT 0 NOT NULL,
    layout_box_status_single smallint DEFAULT (0)::smallint NOT NULL
);


ALTER TABLE public.zencartlayout_boxes OWNER TO sounz;

--
-- Name: zencartmanufacturers; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartmanufacturers (
    manufacturers_id integer DEFAULT nextval('manufacturers_manufacturers_id_seq'::regclass) NOT NULL,
    manufacturers_name character varying(32) DEFAULT ''::character varying NOT NULL,
    manufacturers_image character varying(64),
    date_added timestamp without time zone,
    last_modified timestamp without time zone
);


ALTER TABLE public.zencartmanufacturers OWNER TO sounz;

--
-- Name: zencartmanufacturers_info; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartmanufacturers_info (
    manufacturers_id integer DEFAULT 0 NOT NULL,
    languages_id integer DEFAULT 0 NOT NULL,
    manufacturers_url character varying(255) DEFAULT ''::character varying NOT NULL,
    url_clicked integer DEFAULT 0 NOT NULL,
    date_last_click timestamp without time zone
);


ALTER TABLE public.zencartmanufacturers_info OWNER TO sounz;

--
-- Name: zencartmedia_clips; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartmedia_clips (
    clip_id integer DEFAULT nextval('media_clips_clip_id_seq'::regclass) NOT NULL,
    media_id integer DEFAULT 0 NOT NULL,
    clip_type smallint DEFAULT (0)::smallint NOT NULL,
    clip_filename text NOT NULL,
    date_added timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    last_modified timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE public.zencartmedia_clips OWNER TO sounz;

--
-- Name: zencartmedia_manager; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartmedia_manager (
    media_id integer DEFAULT nextval('media_manager_media_id_seq'::regclass) NOT NULL,
    media_name character varying(255) DEFAULT ''::character varying NOT NULL,
    last_modified timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    date_added timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE public.zencartmedia_manager OWNER TO sounz;

--
-- Name: zencartmedia_to_products; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartmedia_to_products (
    media_id integer DEFAULT 0 NOT NULL,
    product_id integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.zencartmedia_to_products OWNER TO sounz;

--
-- Name: zencartmedia_types; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartmedia_types (
    type_id integer DEFAULT nextval('media_types_type_id_seq'::regclass) NOT NULL,
    type_name character varying(64) DEFAULT ''::character varying NOT NULL,
    type_ext character varying(8) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.zencartmedia_types OWNER TO sounz;

--
-- Name: zencartmeta_tags_categories_description; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartmeta_tags_categories_description (
    categories_id integer NOT NULL,
    language_id integer DEFAULT 1 NOT NULL,
    metatags_title character varying(255) DEFAULT ''::character varying NOT NULL,
    metatags_keywords text,
    metatags_description text
);


ALTER TABLE public.zencartmeta_tags_categories_description OWNER TO sounz;

--
-- Name: zencartmeta_tags_products_description; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartmeta_tags_products_description (
    products_id integer NOT NULL,
    language_id integer DEFAULT 1 NOT NULL,
    metatags_title character varying(255) DEFAULT ''::character varying NOT NULL,
    metatags_keywords text,
    metatags_description text
);


ALTER TABLE public.zencartmeta_tags_products_description OWNER TO sounz;

--
-- Name: zencartmusic_genre; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartmusic_genre (
    music_genre_id integer DEFAULT nextval('music_genre_music_genre_id_seq'::regclass) NOT NULL,
    music_genre_name character varying(32) DEFAULT ''::character varying NOT NULL,
    date_added timestamp without time zone,
    last_modified timestamp without time zone
);


ALTER TABLE public.zencartmusic_genre OWNER TO sounz;

--
-- Name: zencartnewsletters; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartnewsletters (
    newsletters_id integer DEFAULT nextval('newsletters_newsletters_id_seq'::regclass) NOT NULL,
    title character varying(255) DEFAULT ''::character varying NOT NULL,
    content text NOT NULL,
    content_html text NOT NULL,
    module character varying(255) DEFAULT ''::character varying NOT NULL,
    date_added timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    date_sent timestamp without time zone,
    status integer,
    locked integer DEFAULT 0
);


ALTER TABLE public.zencartnewsletters OWNER TO sounz;

--
-- Name: zencartorders; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartorders (
    orders_id integer DEFAULT nextval('orders_orders_id_seq'::regclass) NOT NULL,
    customers_id integer DEFAULT 0 NOT NULL,
    customers_name character varying(64) DEFAULT ''::character varying NOT NULL,
    customers_company character varying(32),
    customers_street_address character varying(64) DEFAULT ''::character varying NOT NULL,
    customers_suburb character varying(32),
    customers_city character varying(32) DEFAULT ''::character varying NOT NULL,
    customers_postcode character varying(10) DEFAULT ''::character varying NOT NULL,
    customers_state character varying(32),
    customers_country character varying(32) DEFAULT ''::character varying NOT NULL,
    customers_telephone character varying(32) DEFAULT ''::character varying NOT NULL,
    customers_email_address character varying(96) DEFAULT ''::character varying NOT NULL,
    customers_address_format_id integer DEFAULT 0 NOT NULL,
    delivery_name character varying(64) DEFAULT ''::character varying NOT NULL,
    delivery_company character varying(32),
    delivery_street_address character varying(64) DEFAULT ''::character varying NOT NULL,
    delivery_suburb character varying(32),
    delivery_city character varying(32) DEFAULT ''::character varying NOT NULL,
    delivery_postcode character varying(10) DEFAULT ''::character varying NOT NULL,
    delivery_state character varying(32),
    delivery_country character varying(32) DEFAULT ''::character varying NOT NULL,
    delivery_address_format_id integer DEFAULT 0 NOT NULL,
    billing_name character varying(64) DEFAULT ''::character varying NOT NULL,
    billing_company character varying(32),
    billing_street_address character varying(64) DEFAULT ''::character varying NOT NULL,
    billing_suburb character varying(32),
    billing_city character varying(32) DEFAULT ''::character varying NOT NULL,
    billing_postcode character varying(10) DEFAULT ''::character varying NOT NULL,
    billing_state character varying(32),
    billing_country character varying(32) DEFAULT ''::character varying NOT NULL,
    billing_address_format_id integer DEFAULT 0 NOT NULL,
    payment_method character varying(128) DEFAULT ''::character varying NOT NULL,
    payment_module_code character varying(32) DEFAULT ''::character varying NOT NULL,
    shipping_method character varying(128) DEFAULT ''::character varying NOT NULL,
    shipping_module_code character varying(32) DEFAULT ''::character varying NOT NULL,
    coupon_code character varying(32) DEFAULT ''::character varying NOT NULL,
    cc_type character varying(20),
    cc_owner character varying(64),
    cc_number character varying(32),
    cc_expires character varying(4),
    cc_cvv bytea,
    last_modified timestamp without time zone,
    date_purchased timestamp without time zone,
    orders_status integer DEFAULT 0 NOT NULL,
    orders_date_finished timestamp without time zone,
    currency character(3),
    currency_value numeric(14,6),
    order_total numeric(14,2),
    order_tax numeric(14,2),
    paypal_ipn_id integer DEFAULT 0 NOT NULL,
    ip_address character varying(96) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.zencartorders OWNER TO sounz;

--
-- Name: zencartorders_products; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartorders_products (
    orders_products_id integer DEFAULT nextval('orders_products_orders_products_id_seq'::regclass) NOT NULL,
    orders_id integer DEFAULT 0 NOT NULL,
    products_id integer DEFAULT 0 NOT NULL,
    products_model character varying(32),
    products_name character varying(64) DEFAULT ''::character varying NOT NULL,
    products_price numeric(15,4) DEFAULT 0.0000 NOT NULL,
    final_price numeric(15,4) DEFAULT 0.0000 NOT NULL,
    products_tax numeric(7,4) DEFAULT 0.0000 NOT NULL,
    products_quantity double precision DEFAULT (0)::double precision NOT NULL,
    onetime_charges numeric(15,4) DEFAULT 0.0000 NOT NULL,
    products_priced_by_attribute smallint DEFAULT (0)::smallint NOT NULL,
    product_is_free smallint DEFAULT (0)::smallint NOT NULL,
    products_discount_type smallint DEFAULT (0)::smallint NOT NULL,
    products_discount_type_from smallint DEFAULT (0)::smallint NOT NULL,
    products_prid text NOT NULL
);


ALTER TABLE public.zencartorders_products OWNER TO sounz;

--
-- Name: zencartorders_products_attributes; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartorders_products_attributes (
    orders_products_attributes_id integer DEFAULT nextval('orders_products_attributes_orders_products_attributes_id_seq'::regclass) NOT NULL,
    orders_id integer DEFAULT 0 NOT NULL,
    orders_products_id integer DEFAULT 0 NOT NULL,
    products_options character varying(32) DEFAULT ''::character varying NOT NULL,
    products_options_values bytea NOT NULL,
    options_values_price numeric(15,4) DEFAULT 0.0000 NOT NULL,
    price_prefix character(1) DEFAULT ''::bpchar NOT NULL,
    product_attribute_is_free smallint DEFAULT (0)::smallint NOT NULL,
    products_attributes_weight double precision DEFAULT (0)::double precision NOT NULL,
    products_attributes_weight_prefix character(1) DEFAULT ''::bpchar NOT NULL,
    attributes_discounted smallint DEFAULT (1)::smallint NOT NULL,
    attributes_price_base_included smallint DEFAULT (1)::smallint NOT NULL,
    attributes_price_onetime numeric(15,4) DEFAULT 0.0000 NOT NULL,
    attributes_price_factor numeric(15,4) DEFAULT 0.0000 NOT NULL,
    attributes_price_factor_offset numeric(15,4) DEFAULT 0.0000 NOT NULL,
    attributes_price_factor_onetime numeric(15,4) DEFAULT 0.0000 NOT NULL,
    attributes_price_factor_onetime_offset numeric(15,4) DEFAULT 0.0000 NOT NULL,
    attributes_qty_prices text,
    attributes_qty_prices_onetime text,
    attributes_price_words numeric(15,4) DEFAULT 0.0000 NOT NULL,
    attributes_price_words_free integer DEFAULT 0 NOT NULL,
    attributes_price_letters numeric(15,4) DEFAULT 0.0000 NOT NULL,
    attributes_price_letters_free integer DEFAULT 0 NOT NULL,
    products_options_id integer DEFAULT 0 NOT NULL,
    products_options_values_id integer DEFAULT 0 NOT NULL,
    products_prid text NOT NULL
);


ALTER TABLE public.zencartorders_products_attributes OWNER TO sounz;

--
-- Name: zencartorders_products_download; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartorders_products_download (
    orders_products_download_id integer DEFAULT nextval('orders_products_download_orders_products_download_id_seq'::regclass) NOT NULL,
    orders_id integer DEFAULT 0 NOT NULL,
    orders_products_id integer DEFAULT 0 NOT NULL,
    orders_products_filename character varying(255) DEFAULT ''::character varying NOT NULL,
    orders_products_filename_2 character varying(255),
    download_maxdays integer DEFAULT 0 NOT NULL,
    download_count integer DEFAULT 0 NOT NULL,
    products_prid text NOT NULL
);


ALTER TABLE public.zencartorders_products_download OWNER TO sounz;

--
-- Name: zencartorders_status; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartorders_status (
    orders_status_id integer DEFAULT 0 NOT NULL,
    language_id integer DEFAULT 1 NOT NULL,
    orders_status_name character varying(32) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.zencartorders_status OWNER TO sounz;

--
-- Name: zencartorders_status_history; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartorders_status_history (
    orders_status_history_id integer DEFAULT nextval('orders_status_history_orders_status_history_id_seq'::regclass) NOT NULL,
    orders_id integer DEFAULT 0 NOT NULL,
    orders_status_id integer DEFAULT 0 NOT NULL,
    date_added timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    customer_notified integer DEFAULT 0,
    comments text
);


ALTER TABLE public.zencartorders_status_history OWNER TO sounz;

--
-- Name: zencartorders_total; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartorders_total (
    orders_total_id integer DEFAULT nextval('orders_total_orders_total_id_seq'::regclass) NOT NULL,
    orders_id integer DEFAULT 0 NOT NULL,
    title character varying(255) DEFAULT ''::character varying NOT NULL,
    text character varying(255) DEFAULT ''::character varying NOT NULL,
    value numeric(15,4) DEFAULT 0.0000 NOT NULL,
    "class" character varying(32) DEFAULT ''::character varying NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.zencartorders_total OWNER TO sounz;

--
-- Name: zencartpaypal; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartpaypal (
    paypal_ipn_id integer DEFAULT nextval('paypal_paypal_ipn_id_seq'::regclass) NOT NULL,
    zen_order_id integer DEFAULT 0 NOT NULL,
    txn_type character varying(40) DEFAULT ''::character varying NOT NULL,
    reason_code character varying(40),
    payment_type character varying(40) DEFAULT ''::character varying NOT NULL,
    payment_status character varying(32) DEFAULT ''::character varying NOT NULL,
    pending_reason character varying(32),
    invoice character varying(128),
    mc_currency character(3) DEFAULT ''::bpchar NOT NULL,
    first_name character varying(32) DEFAULT ''::character varying NOT NULL,
    last_name character varying(32) DEFAULT ''::character varying NOT NULL,
    payer_business_name character varying(128),
    address_name character varying(64),
    address_street character varying(254),
    address_city character varying(120),
    address_state character varying(120),
    address_zip character varying(10),
    address_country character varying(64),
    address_status character varying(11),
    payer_email character varying(128) DEFAULT ''::character varying NOT NULL,
    payer_id character varying(32) DEFAULT ''::character varying NOT NULL,
    payer_status character varying(10) DEFAULT ''::character varying NOT NULL,
    payment_date timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    business character varying(128) DEFAULT ''::character varying NOT NULL,
    receiver_email character varying(128) DEFAULT ''::character varying NOT NULL,
    receiver_id character varying(32) DEFAULT ''::character varying NOT NULL,
    txn_id character varying(20) DEFAULT ''::character varying NOT NULL,
    parent_txn_id character varying(20),
    num_cart_items smallint DEFAULT (1)::smallint NOT NULL,
    mc_gross numeric(7,2) DEFAULT 0.00 NOT NULL,
    mc_fee numeric(7,2) DEFAULT 0.00 NOT NULL,
    payment_gross numeric(7,2),
    payment_fee numeric(7,2),
    settle_amount numeric(7,2),
    settle_currency character(3),
    exchange_rate numeric(4,2),
    notify_version numeric(2,1) DEFAULT 0.0 NOT NULL,
    verify_sign character varying(128) DEFAULT ''::character varying NOT NULL,
    last_modified timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    date_added timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    memo text,
    CONSTRAINT zencartpaypal_num_cart_items_check CHECK ((num_cart_items >= 0)),
    CONSTRAINT zencartpaypal_zen_order_id_check CHECK ((zen_order_id >= 0))
);


ALTER TABLE public.zencartpaypal OWNER TO sounz;

--
-- Name: zencartpaypal_payment_status; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartpaypal_payment_status (
    payment_status_id integer DEFAULT nextval('paypal_payment_status_payment_status_id_seq'::regclass) NOT NULL,
    payment_status_name character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.zencartpaypal_payment_status OWNER TO sounz;

--
-- Name: zencartpaypal_payment_status_history; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartpaypal_payment_status_history (
    payment_status_history_id integer DEFAULT nextval('paypal_payment_status_history_payment_status_history_id_seq'::regclass) NOT NULL,
    paypal_ipn_id integer DEFAULT 0 NOT NULL,
    txn_id character varying(64) DEFAULT ''::character varying NOT NULL,
    parent_txn_id character varying(64) DEFAULT ''::character varying NOT NULL,
    payment_status character varying(17) DEFAULT ''::character varying NOT NULL,
    pending_reason character varying(14),
    date_added timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE public.zencartpaypal_payment_status_history OWNER TO sounz;

--
-- Name: zencartpaypal_session; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartpaypal_session (
    unique_id integer DEFAULT nextval('paypal_session_unique_id_seq'::regclass) NOT NULL,
    session_id text NOT NULL,
    saved_session bytea NOT NULL,
    expiry integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.zencartpaypal_session OWNER TO sounz;

--
-- Name: zencartpaypal_testing; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartpaypal_testing (
    paypal_ipn_id integer DEFAULT nextval('paypal_testing_paypal_ipn_id_seq'::regclass) NOT NULL,
    zen_order_id integer DEFAULT 0 NOT NULL,
    custom character varying(255) DEFAULT ''::character varying NOT NULL,
    txn_type character varying(40) DEFAULT ''::character varying NOT NULL,
    reason_code character varying(40),
    payment_type character varying(40) DEFAULT ''::character varying NOT NULL,
    payment_status character varying(32) DEFAULT ''::character varying NOT NULL,
    pending_reason character varying(32),
    invoice character varying(128),
    mc_currency character(3) DEFAULT ''::bpchar NOT NULL,
    first_name character varying(32) DEFAULT ''::character varying NOT NULL,
    last_name character varying(32) DEFAULT ''::character varying NOT NULL,
    payer_business_name character varying(128),
    address_name character varying(64),
    address_street character varying(254),
    address_city character varying(120),
    address_state character varying(120),
    address_zip character varying(10),
    address_country character varying(64),
    address_status character varying(11),
    payer_email character varying(128) DEFAULT ''::character varying NOT NULL,
    payer_id character varying(32) DEFAULT ''::character varying NOT NULL,
    payer_status character varying(10) DEFAULT ''::character varying NOT NULL,
    payment_date timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    business character varying(128) DEFAULT ''::character varying NOT NULL,
    receiver_email character varying(128) DEFAULT ''::character varying NOT NULL,
    receiver_id character varying(32) DEFAULT ''::character varying NOT NULL,
    txn_id character varying(20) DEFAULT ''::character varying NOT NULL,
    parent_txn_id character varying(20),
    num_cart_items smallint DEFAULT (1)::smallint NOT NULL,
    mc_gross numeric(7,2) DEFAULT 0.00 NOT NULL,
    mc_fee numeric(7,2) DEFAULT 0.00 NOT NULL,
    payment_gross numeric(7,2),
    payment_fee numeric(7,2),
    settle_amount numeric(7,2),
    settle_currency character(3),
    exchange_rate numeric(4,2),
    notify_version numeric(2,1) DEFAULT 0.0 NOT NULL,
    verify_sign character varying(128) DEFAULT ''::character varying NOT NULL,
    last_modified timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    date_added timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    memo text,
    CONSTRAINT zencartpaypal_testing_num_cart_items_check CHECK ((num_cart_items >= 0)),
    CONSTRAINT zencartpaypal_testing_zen_order_id_check CHECK ((zen_order_id >= 0))
);


ALTER TABLE public.zencartpaypal_testing OWNER TO sounz;

--
-- Name: zencartproduct_music_extra; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartproduct_music_extra (
    products_id integer DEFAULT 0 NOT NULL,
    artists_id integer DEFAULT 0 NOT NULL,
    record_company_id integer DEFAULT 0 NOT NULL,
    music_genre_id integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.zencartproduct_music_extra OWNER TO sounz;

--
-- Name: zencartproduct_type_layout; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartproduct_type_layout (
    configuration_id integer DEFAULT nextval('product_type_layout_configuration_id_seq'::regclass) NOT NULL,
    configuration_title text NOT NULL,
    configuration_key character varying(255) DEFAULT ''::character varying NOT NULL,
    configuration_value text NOT NULL,
    configuration_description text NOT NULL,
    product_type_id integer DEFAULT 0 NOT NULL,
    sort_order integer,
    last_modified timestamp without time zone,
    date_added timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    use_function text,
    set_function text
);


ALTER TABLE public.zencartproduct_type_layout OWNER TO sounz;

--
-- Name: zencartproduct_types; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartproduct_types (
    type_id integer DEFAULT nextval('product_types_type_id_seq'::regclass) NOT NULL,
    type_name character varying(255) DEFAULT ''::character varying NOT NULL,
    type_handler character varying(255) DEFAULT ''::character varying NOT NULL,
    type_master_type integer DEFAULT 1 NOT NULL,
    allow_add_to_cart character(1) DEFAULT 'Y'::bpchar NOT NULL,
    default_image character varying(255) DEFAULT ''::character varying NOT NULL,
    date_added timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    last_modified timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE public.zencartproduct_types OWNER TO sounz;

--
-- Name: zencartproduct_types_to_category; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartproduct_types_to_category (
    product_type_id integer DEFAULT 0 NOT NULL,
    category_id integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.zencartproduct_types_to_category OWNER TO sounz;

--
-- Name: zencartproducts; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartproducts (
    products_id integer DEFAULT nextval('products_products_id_seq'::regclass) NOT NULL,
    products_type integer DEFAULT 1 NOT NULL,
    products_quantity double precision DEFAULT (0)::double precision NOT NULL,
    products_model character varying(32),
    products_image character varying(64),
    products_price numeric(15,4) DEFAULT 0.0000 NOT NULL,
    products_virtual smallint DEFAULT (0)::smallint NOT NULL,
    products_date_added timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    products_last_modified timestamp without time zone,
    products_date_available timestamp without time zone,
    products_weight double precision DEFAULT (0)::double precision NOT NULL,
    products_status smallint DEFAULT (0)::smallint NOT NULL,
    products_tax_class_id integer DEFAULT 0 NOT NULL,
    manufacturers_id integer,
    products_ordered double precision DEFAULT (0)::double precision NOT NULL,
    products_quantity_order_min double precision DEFAULT (1)::double precision NOT NULL,
    products_quantity_order_units double precision DEFAULT (1)::double precision NOT NULL,
    products_priced_by_attribute smallint DEFAULT (0)::smallint NOT NULL,
    product_is_free smallint DEFAULT (0)::smallint NOT NULL,
    product_is_call smallint DEFAULT (0)::smallint NOT NULL,
    products_quantity_mixed smallint DEFAULT (0)::smallint NOT NULL,
    product_is_always_free_shipping smallint DEFAULT (0)::smallint NOT NULL,
    products_qty_box_status smallint DEFAULT (1)::smallint NOT NULL,
    products_quantity_order_max double precision DEFAULT (0)::double precision NOT NULL,
    products_sort_order integer DEFAULT 0 NOT NULL,
    products_discount_type smallint DEFAULT (0)::smallint NOT NULL,
    products_discount_type_from smallint DEFAULT (0)::smallint NOT NULL,
    products_price_sorter numeric(15,4) DEFAULT 0.0000 NOT NULL,
    master_categories_id integer DEFAULT 0 NOT NULL,
    products_mixed_discount_quantity smallint DEFAULT (1)::smallint NOT NULL,
    metatags_title_status smallint DEFAULT (0)::smallint NOT NULL,
    metatags_products_name_status smallint DEFAULT (0)::smallint NOT NULL,
    metatags_model_status smallint DEFAULT (0)::smallint NOT NULL,
    metatags_price_status smallint DEFAULT (0)::smallint NOT NULL,
    metatags_title_tagline_status smallint DEFAULT (0)::smallint NOT NULL
);


ALTER TABLE public.zencartproducts OWNER TO sounz;

--
-- Name: zencartproducts_attributes; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartproducts_attributes (
    products_attributes_id integer DEFAULT nextval('products_attributes_products_attributes_id_seq'::regclass) NOT NULL,
    products_id integer DEFAULT 0 NOT NULL,
    options_id integer DEFAULT 0 NOT NULL,
    options_values_id integer DEFAULT 0 NOT NULL,
    options_values_price numeric(15,4) DEFAULT 0.0000 NOT NULL,
    price_prefix character(1) DEFAULT ''::bpchar NOT NULL,
    products_options_sort_order integer DEFAULT 0 NOT NULL,
    product_attribute_is_free smallint DEFAULT (0)::smallint NOT NULL,
    products_attributes_weight double precision DEFAULT (0)::double precision NOT NULL,
    products_attributes_weight_prefix character(1) DEFAULT ''::bpchar NOT NULL,
    attributes_display_only smallint DEFAULT (0)::smallint NOT NULL,
    attributes_default smallint DEFAULT (0)::smallint NOT NULL,
    attributes_discounted smallint DEFAULT (1)::smallint NOT NULL,
    attributes_image character varying(64),
    attributes_price_base_included smallint DEFAULT (1)::smallint NOT NULL,
    attributes_price_onetime numeric(15,4) DEFAULT 0.0000 NOT NULL,
    attributes_price_factor numeric(15,4) DEFAULT 0.0000 NOT NULL,
    attributes_price_factor_offset numeric(15,4) DEFAULT 0.0000 NOT NULL,
    attributes_price_factor_onetime numeric(15,4) DEFAULT 0.0000 NOT NULL,
    attributes_price_factor_onetime_offset numeric(15,4) DEFAULT 0.0000 NOT NULL,
    attributes_qty_prices text,
    attributes_qty_prices_onetime text,
    attributes_price_words numeric(15,4) DEFAULT 0.0000 NOT NULL,
    attributes_price_words_free integer DEFAULT 0 NOT NULL,
    attributes_price_letters numeric(15,4) DEFAULT 0.0000 NOT NULL,
    attributes_price_letters_free integer DEFAULT 0 NOT NULL,
    attributes_required smallint DEFAULT (0)::smallint NOT NULL
);


ALTER TABLE public.zencartproducts_attributes OWNER TO sounz;

--
-- Name: zencartproducts_attributes_download; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartproducts_attributes_download (
    products_attributes_id integer DEFAULT 0 NOT NULL,
    products_attributes_filename character varying(255) DEFAULT ''::character varying NOT NULL,
    products_attributes_maxdays integer DEFAULT 0,
    products_attributes_maxcount integer DEFAULT 0
);


ALTER TABLE public.zencartproducts_attributes_download OWNER TO sounz;

--
-- Name: zencartproducts_description; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartproducts_description (
    products_id integer DEFAULT nextval('products_description_products_id_seq'::regclass) NOT NULL,
    language_id integer DEFAULT 1 NOT NULL,
    products_name character varying(64) DEFAULT ''::character varying NOT NULL,
    products_description text,
    products_url character varying(255),
    products_viewed integer DEFAULT 0
);


ALTER TABLE public.zencartproducts_description OWNER TO sounz;

--
-- Name: zencartproducts_discount_quantity; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartproducts_discount_quantity (
    discount_id integer DEFAULT 0 NOT NULL,
    products_id integer DEFAULT 0 NOT NULL,
    discount_qty double precision DEFAULT (0)::double precision NOT NULL,
    discount_price numeric(15,4) DEFAULT 0.0000 NOT NULL
);


ALTER TABLE public.zencartproducts_discount_quantity OWNER TO sounz;

--
-- Name: zencartproducts_notifications; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartproducts_notifications (
    products_id integer DEFAULT 0 NOT NULL,
    customers_id integer DEFAULT 0 NOT NULL,
    date_added timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE public.zencartproducts_notifications OWNER TO sounz;

--
-- Name: zencartproducts_options; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartproducts_options (
    products_options_id integer DEFAULT 0 NOT NULL,
    language_id integer DEFAULT 1 NOT NULL,
    products_options_name character varying(32) DEFAULT ''::character varying NOT NULL,
    products_options_sort_order integer DEFAULT 0 NOT NULL,
    products_options_type integer DEFAULT 0 NOT NULL,
    products_options_length smallint DEFAULT (32)::smallint NOT NULL,
    products_options_comment character varying(64),
    products_options_size smallint DEFAULT (32)::smallint NOT NULL,
    products_options_images_per_row integer DEFAULT 5,
    products_options_images_style integer DEFAULT 0,
    products_options_rows smallint DEFAULT (1)::smallint NOT NULL
);


ALTER TABLE public.zencartproducts_options OWNER TO sounz;

--
-- Name: zencartproducts_options_types; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartproducts_options_types (
    products_options_types_id integer DEFAULT 0 NOT NULL,
    products_options_types_name character varying(32)
);


ALTER TABLE public.zencartproducts_options_types OWNER TO sounz;

--
-- Name: zencartproducts_options_values; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartproducts_options_values (
    products_options_values_id integer DEFAULT 0 NOT NULL,
    language_id integer DEFAULT 1 NOT NULL,
    products_options_values_name character varying(64) DEFAULT ''::character varying NOT NULL,
    products_options_values_sort_order integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.zencartproducts_options_values OWNER TO sounz;

--
-- Name: zencartproducts_options_values_to_products_options; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartproducts_options_values_to_products_options (
    products_options_values_to_products_options_id integer DEFAULT nextval('ucts_options_products_options_values_to_products_options_id_seq'::regclass) NOT NULL,
    products_options_id integer DEFAULT 0 NOT NULL,
    products_options_values_id integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.zencartproducts_options_values_to_products_options OWNER TO sounz;

--
-- Name: zencartproducts_to_categories; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartproducts_to_categories (
    products_id integer DEFAULT 0 NOT NULL,
    categories_id integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.zencartproducts_to_categories OWNER TO sounz;

--
-- Name: zencartproject_version; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartproject_version (
    project_version_id integer DEFAULT nextval('project_version_project_version_id_seq'::regclass) NOT NULL,
    project_version_key character varying(40) DEFAULT ''::character varying NOT NULL,
    project_version_major character varying(20) DEFAULT ''::character varying NOT NULL,
    project_version_minor character varying(20) DEFAULT ''::character varying NOT NULL,
    project_version_patch1 character varying(20) DEFAULT ''::character varying NOT NULL,
    project_version_patch2 character varying(20) DEFAULT ''::character varying NOT NULL,
    project_version_patch1_source character varying(20) DEFAULT ''::character varying NOT NULL,
    project_version_patch2_source character varying(20) DEFAULT ''::character varying NOT NULL,
    project_version_comment character varying(250) DEFAULT ''::character varying NOT NULL,
    project_version_date_applied timestamp without time zone DEFAULT '0001-01-01 01:01:01'::timestamp without time zone NOT NULL
);


ALTER TABLE public.zencartproject_version OWNER TO sounz;

--
-- Name: zencartproject_version_history; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartproject_version_history (
    project_version_id integer DEFAULT nextval('project_version_history_project_version_id_seq'::regclass) NOT NULL,
    project_version_key character varying(40) DEFAULT ''::character varying NOT NULL,
    project_version_major character varying(20) DEFAULT ''::character varying NOT NULL,
    project_version_minor character varying(20) DEFAULT ''::character varying NOT NULL,
    project_version_patch character varying(20) DEFAULT ''::character varying NOT NULL,
    project_version_comment character varying(250) DEFAULT ''::character varying NOT NULL,
    project_version_date_applied timestamp without time zone DEFAULT '0001-01-01 01:01:01'::timestamp without time zone NOT NULL
);


ALTER TABLE public.zencartproject_version_history OWNER TO sounz;

--
-- Name: zencartquery_builder; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartquery_builder (
    query_id integer DEFAULT nextval('query_builder_query_id_seq'::regclass) NOT NULL,
    query_category character varying(40) DEFAULT ''::character varying NOT NULL,
    query_name character varying(80) DEFAULT ''::character varying NOT NULL,
    query_description text NOT NULL,
    query_string text NOT NULL,
    query_keys_list text NOT NULL
);


ALTER TABLE public.zencartquery_builder OWNER TO sounz;

--
-- Name: zencartrecord_artists; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartrecord_artists (
    artists_id integer DEFAULT nextval('record_artists_artists_id_seq'::regclass) NOT NULL,
    artists_name character varying(32) DEFAULT ''::character varying NOT NULL,
    artists_image character varying(64),
    date_added timestamp without time zone,
    last_modified timestamp without time zone
);


ALTER TABLE public.zencartrecord_artists OWNER TO sounz;

--
-- Name: zencartrecord_artists_info; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartrecord_artists_info (
    artists_id integer DEFAULT 0 NOT NULL,
    languages_id integer DEFAULT 0 NOT NULL,
    artists_url character varying(255) DEFAULT ''::character varying NOT NULL,
    url_clicked integer DEFAULT 0 NOT NULL,
    date_last_click timestamp without time zone
);


ALTER TABLE public.zencartrecord_artists_info OWNER TO sounz;

--
-- Name: zencartrecord_company; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartrecord_company (
    record_company_id integer DEFAULT nextval('record_company_record_company_id_seq'::regclass) NOT NULL,
    record_company_name character varying(32) DEFAULT ''::character varying NOT NULL,
    record_company_image character varying(64),
    date_added timestamp without time zone,
    last_modified timestamp without time zone
);


ALTER TABLE public.zencartrecord_company OWNER TO sounz;

--
-- Name: zencartrecord_company_info; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartrecord_company_info (
    record_company_id integer DEFAULT 0 NOT NULL,
    languages_id integer DEFAULT 0 NOT NULL,
    record_company_url character varying(255) DEFAULT ''::character varying NOT NULL,
    url_clicked integer DEFAULT 0 NOT NULL,
    date_last_click timestamp without time zone
);


ALTER TABLE public.zencartrecord_company_info OWNER TO sounz;

--
-- Name: zencartreviews; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartreviews (
    reviews_id integer DEFAULT nextval('reviews_reviews_id_seq'::regclass) NOT NULL,
    products_id integer DEFAULT 0 NOT NULL,
    customers_id integer,
    customers_name character varying(64) DEFAULT ''::character varying NOT NULL,
    reviews_rating integer,
    date_added timestamp without time zone,
    last_modified timestamp without time zone,
    reviews_read integer DEFAULT 0 NOT NULL,
    status integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.zencartreviews OWNER TO sounz;

--
-- Name: zencartreviews_description; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartreviews_description (
    reviews_id integer DEFAULT 0 NOT NULL,
    languages_id integer DEFAULT 0 NOT NULL,
    reviews_text text NOT NULL
);


ALTER TABLE public.zencartreviews_description OWNER TO sounz;

--
-- Name: zencartsalemaker_sales; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartsalemaker_sales (
    sale_id integer DEFAULT nextval('salemaker_sales_sale_id_seq'::regclass) NOT NULL,
    sale_status smallint DEFAULT (0)::smallint NOT NULL,
    sale_name character varying(30) DEFAULT ''::character varying NOT NULL,
    sale_deduction_value numeric(15,4) DEFAULT 0.0000 NOT NULL,
    sale_deduction_type smallint DEFAULT (0)::smallint NOT NULL,
    sale_pricerange_from numeric(15,4) DEFAULT 0.0000 NOT NULL,
    sale_pricerange_to numeric(15,4) DEFAULT 0.0000 NOT NULL,
    sale_specials_condition smallint DEFAULT (0)::smallint NOT NULL,
    sale_categories_selected text,
    sale_categories_all text,
    sale_date_start date DEFAULT '0001-01-01'::date NOT NULL,
    sale_date_end date DEFAULT '0001-01-01'::date NOT NULL,
    sale_date_added date DEFAULT '0001-01-01'::date NOT NULL,
    sale_date_last_modified date DEFAULT '0001-01-01'::date NOT NULL,
    sale_date_status_change date DEFAULT '0001-01-01'::date NOT NULL
);


ALTER TABLE public.zencartsalemaker_sales OWNER TO sounz;

--
-- Name: zencartsessions; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartsessions (
    sesskey character varying(32) DEFAULT ''::character varying NOT NULL,
    expiry integer DEFAULT 0 NOT NULL,
    value text NOT NULL,
    CONSTRAINT zencartsessions_expiry_check CHECK ((expiry >= 0))
);


ALTER TABLE public.zencartsessions OWNER TO sounz;

--
-- Name: zencartspecials; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartspecials (
    specials_id integer DEFAULT nextval('specials_specials_id_seq'::regclass) NOT NULL,
    products_id integer DEFAULT 0 NOT NULL,
    specials_new_products_price numeric(15,4) DEFAULT 0.0000 NOT NULL,
    specials_date_added timestamp without time zone,
    specials_last_modified timestamp without time zone,
    expires_date date DEFAULT '0001-01-01'::date NOT NULL,
    date_status_change timestamp without time zone,
    status integer DEFAULT 1 NOT NULL,
    specials_date_available date DEFAULT '0001-01-01'::date NOT NULL
);


ALTER TABLE public.zencartspecials OWNER TO sounz;

--
-- Name: zencarttax_class; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencarttax_class (
    tax_class_id integer DEFAULT nextval('tax_class_tax_class_id_seq'::regclass) NOT NULL,
    tax_class_title character varying(32) DEFAULT ''::character varying NOT NULL,
    tax_class_description character varying(255) DEFAULT ''::character varying NOT NULL,
    last_modified timestamp without time zone,
    date_added timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE public.zencarttax_class OWNER TO sounz;

--
-- Name: zencarttax_rates; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencarttax_rates (
    tax_rates_id integer DEFAULT nextval('tax_rates_tax_rates_id_seq'::regclass) NOT NULL,
    tax_zone_id integer DEFAULT 0 NOT NULL,
    tax_class_id integer DEFAULT 0 NOT NULL,
    tax_priority integer DEFAULT 1,
    tax_rate numeric(7,4) DEFAULT 0.0000 NOT NULL,
    tax_description character varying(255) DEFAULT ''::character varying NOT NULL,
    last_modified timestamp without time zone,
    date_added timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE public.zencarttax_rates OWNER TO sounz;

--
-- Name: zencarttemplate_select; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencarttemplate_select (
    template_id integer DEFAULT nextval('template_select_template_id_seq'::regclass) NOT NULL,
    template_dir character varying(64) DEFAULT ''::character varying NOT NULL,
    template_language character varying(64) DEFAULT '0'::character varying NOT NULL
);


ALTER TABLE public.zencarttemplate_select OWNER TO sounz;

--
-- Name: zencartupgrade_exceptions; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartupgrade_exceptions (
    upgrade_exception_id integer DEFAULT nextval('upgrade_exceptions_upgrade_exception_id_seq'::regclass) NOT NULL,
    sql_file character varying(50),
    reason character varying(200),
    errordate timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone,
    sqlstatement text
);


ALTER TABLE public.zencartupgrade_exceptions OWNER TO sounz;

--
-- Name: zencartwhos_online; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartwhos_online (
    customer_id integer,
    full_name character varying(64) DEFAULT ''::character varying NOT NULL,
    session_id character varying(128) DEFAULT ''::character varying NOT NULL,
    ip_address character varying(15) DEFAULT ''::character varying NOT NULL,
    time_entry character varying(14) DEFAULT ''::character varying NOT NULL,
    time_last_click character varying(14) DEFAULT ''::character varying NOT NULL,
    last_page_url character varying(255) DEFAULT ''::character varying NOT NULL,
    host_address text NOT NULL,
    user_agent character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.zencartwhos_online OWNER TO sounz;

--
-- Name: zencartzones; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartzones (
    zone_id integer DEFAULT nextval('zones_zone_id_seq'::regclass) NOT NULL,
    zone_country_id integer DEFAULT 0 NOT NULL,
    zone_code character varying(32) DEFAULT ''::character varying NOT NULL,
    zone_name character varying(32) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.zencartzones OWNER TO sounz;

--
-- Name: zencartzones_to_geo_zones; Type: TABLE; Schema: public; Owner: sounz; Tablespace: 
--

CREATE TABLE zencartzones_to_geo_zones (
    association_id integer DEFAULT nextval('zones_to_geo_zones_association_id_seq'::regclass) NOT NULL,
    zone_country_id integer DEFAULT 0 NOT NULL,
    zone_id integer,
    geo_zone_id integer,
    last_modified timestamp without time zone,
    date_added timestamp without time zone DEFAULT '0001-01-01 00:00:00'::timestamp without time zone NOT NULL
);


ALTER TABLE public.zencartzones_to_geo_zones OWNER TO sounz;

--
-- Name: zencartaddress_book_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartaddress_book
    ADD CONSTRAINT zencartaddress_book_pkey PRIMARY KEY (address_book_id);


--
-- Name: zencartaddress_format_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartaddress_format
    ADD CONSTRAINT zencartaddress_format_pkey PRIMARY KEY (address_format_id);


--
-- Name: zencartadmin_activity_log_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartadmin_activity_log
    ADD CONSTRAINT zencartadmin_activity_log_pkey PRIMARY KEY (log_id);


--
-- Name: zencartadmin_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartadmin
    ADD CONSTRAINT zencartadmin_pkey PRIMARY KEY (admin_id);


--
-- Name: zencartauthorizenet_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartauthorizenet
    ADD CONSTRAINT zencartauthorizenet_pkey PRIMARY KEY (id);


--
-- Name: zencartbanners_history_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartbanners_history
    ADD CONSTRAINT zencartbanners_history_pkey PRIMARY KEY (banners_history_id);


--
-- Name: zencartbanners_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartbanners
    ADD CONSTRAINT zencartbanners_pkey PRIMARY KEY (banners_id);


--
-- Name: zencartcategories_description_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartcategories_description
    ADD CONSTRAINT zencartcategories_description_pkey PRIMARY KEY (categories_id, language_id);


--
-- Name: zencartcategories_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartcategories
    ADD CONSTRAINT zencartcategories_pkey PRIMARY KEY (categories_id);


--
-- Name: zencartconfiguration_configuration_key_key; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartconfiguration
    ADD CONSTRAINT zencartconfiguration_configuration_key_key UNIQUE (configuration_key);


--
-- Name: zencartconfiguration_group_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartconfiguration_group
    ADD CONSTRAINT zencartconfiguration_group_pkey PRIMARY KEY (configuration_group_id);


--
-- Name: zencartconfiguration_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartconfiguration
    ADD CONSTRAINT zencartconfiguration_pkey PRIMARY KEY (configuration_id);


--
-- Name: zencartcountries_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartcountries
    ADD CONSTRAINT zencartcountries_pkey PRIMARY KEY (countries_id);


--
-- Name: zencartcoupon_email_track_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartcoupon_email_track
    ADD CONSTRAINT zencartcoupon_email_track_pkey PRIMARY KEY (unique_id);


--
-- Name: zencartcoupon_gv_customer_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartcoupon_gv_customer
    ADD CONSTRAINT zencartcoupon_gv_customer_pkey PRIMARY KEY (customer_id);


--
-- Name: zencartcoupon_gv_queue_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartcoupon_gv_queue
    ADD CONSTRAINT zencartcoupon_gv_queue_pkey PRIMARY KEY (unique_id);


--
-- Name: zencartcoupon_redeem_track_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartcoupon_redeem_track
    ADD CONSTRAINT zencartcoupon_redeem_track_pkey PRIMARY KEY (unique_id);


--
-- Name: zencartcoupon_restrict_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartcoupon_restrict
    ADD CONSTRAINT zencartcoupon_restrict_pkey PRIMARY KEY (restrict_id);


--
-- Name: zencartcoupons_description_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartcoupons_description
    ADD CONSTRAINT zencartcoupons_description_pkey PRIMARY KEY (coupon_id, language_id);


--
-- Name: zencartcoupons_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartcoupons
    ADD CONSTRAINT zencartcoupons_pkey PRIMARY KEY (coupon_id);


--
-- Name: zencartcurrencies_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartcurrencies
    ADD CONSTRAINT zencartcurrencies_pkey PRIMARY KEY (currencies_id);


--
-- Name: zencartcustomers_basket_attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartcustomers_basket_attributes
    ADD CONSTRAINT zencartcustomers_basket_attributes_pkey PRIMARY KEY (customers_basket_attributes_id);


--
-- Name: zencartcustomers_basket_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartcustomers_basket
    ADD CONSTRAINT zencartcustomers_basket_pkey PRIMARY KEY (customers_basket_id);


--
-- Name: zencartcustomers_info_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartcustomers_info
    ADD CONSTRAINT zencartcustomers_info_pkey PRIMARY KEY (customers_info_id);


--
-- Name: zencartcustomers_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartcustomers
    ADD CONSTRAINT zencartcustomers_pkey PRIMARY KEY (customers_id);


--
-- Name: zencartdb_cache_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartdb_cache
    ADD CONSTRAINT zencartdb_cache_pkey PRIMARY KEY (cache_entry_name);


--
-- Name: zencartemail_archive_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartemail_archive
    ADD CONSTRAINT zencartemail_archive_pkey PRIMARY KEY (archive_id);


--
-- Name: zencartezpages_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartezpages
    ADD CONSTRAINT zencartezpages_pkey PRIMARY KEY (pages_id);


--
-- Name: zencartfeatured_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartfeatured
    ADD CONSTRAINT zencartfeatured_pkey PRIMARY KEY (featured_id);


--
-- Name: zencartfiles_uploaded_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartfiles_uploaded
    ADD CONSTRAINT zencartfiles_uploaded_pkey PRIMARY KEY (files_uploaded_id);


--
-- Name: zencartgeo_zones_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartgeo_zones
    ADD CONSTRAINT zencartgeo_zones_pkey PRIMARY KEY (geo_zone_id);


--
-- Name: zencartget_terms_to_filter_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartget_terms_to_filter
    ADD CONSTRAINT zencartget_terms_to_filter_pkey PRIMARY KEY (get_term_name);


--
-- Name: zencartgroup_pricing_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartgroup_pricing
    ADD CONSTRAINT zencartgroup_pricing_pkey PRIMARY KEY (group_id);


--
-- Name: zencartlanguages_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartlanguages
    ADD CONSTRAINT zencartlanguages_pkey PRIMARY KEY (languages_id);


--
-- Name: zencartlayout_boxes_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartlayout_boxes
    ADD CONSTRAINT zencartlayout_boxes_pkey PRIMARY KEY (layout_id);


--
-- Name: zencartmanufacturers_info_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartmanufacturers_info
    ADD CONSTRAINT zencartmanufacturers_info_pkey PRIMARY KEY (manufacturers_id, languages_id);


--
-- Name: zencartmanufacturers_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartmanufacturers
    ADD CONSTRAINT zencartmanufacturers_pkey PRIMARY KEY (manufacturers_id);


--
-- Name: zencartmedia_clips_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartmedia_clips
    ADD CONSTRAINT zencartmedia_clips_pkey PRIMARY KEY (clip_id);


--
-- Name: zencartmedia_manager_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartmedia_manager
    ADD CONSTRAINT zencartmedia_manager_pkey PRIMARY KEY (media_id);


--
-- Name: zencartmedia_types_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartmedia_types
    ADD CONSTRAINT zencartmedia_types_pkey PRIMARY KEY (type_id);


--
-- Name: zencartmeta_tags_categories_description_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartmeta_tags_categories_description
    ADD CONSTRAINT zencartmeta_tags_categories_description_pkey PRIMARY KEY (categories_id, language_id);


--
-- Name: zencartmeta_tags_products_description_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartmeta_tags_products_description
    ADD CONSTRAINT zencartmeta_tags_products_description_pkey PRIMARY KEY (products_id, language_id);


--
-- Name: zencartmusic_genre_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartmusic_genre
    ADD CONSTRAINT zencartmusic_genre_pkey PRIMARY KEY (music_genre_id);


--
-- Name: zencartnewsletters_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartnewsletters
    ADD CONSTRAINT zencartnewsletters_pkey PRIMARY KEY (newsletters_id);


--
-- Name: zencartorders_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartorders
    ADD CONSTRAINT zencartorders_pkey PRIMARY KEY (orders_id);


--
-- Name: zencartorders_products_attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartorders_products_attributes
    ADD CONSTRAINT zencartorders_products_attributes_pkey PRIMARY KEY (orders_products_attributes_id);


--
-- Name: zencartorders_products_download_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartorders_products_download
    ADD CONSTRAINT zencartorders_products_download_pkey PRIMARY KEY (orders_products_download_id);


--
-- Name: zencartorders_products_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartorders_products
    ADD CONSTRAINT zencartorders_products_pkey PRIMARY KEY (orders_products_id);


--
-- Name: zencartorders_status_history_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartorders_status_history
    ADD CONSTRAINT zencartorders_status_history_pkey PRIMARY KEY (orders_status_history_id);


--
-- Name: zencartorders_status_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartorders_status
    ADD CONSTRAINT zencartorders_status_pkey PRIMARY KEY (orders_status_id, language_id);


--
-- Name: zencartorders_total_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartorders_total
    ADD CONSTRAINT zencartorders_total_pkey PRIMARY KEY (orders_total_id);


--
-- Name: zencartpaypal_payment_status_history_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartpaypal_payment_status_history
    ADD CONSTRAINT zencartpaypal_payment_status_history_pkey PRIMARY KEY (payment_status_history_id);


--
-- Name: zencartpaypal_payment_status_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartpaypal_payment_status
    ADD CONSTRAINT zencartpaypal_payment_status_pkey PRIMARY KEY (payment_status_id);


--
-- Name: zencartpaypal_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartpaypal
    ADD CONSTRAINT zencartpaypal_pkey PRIMARY KEY (paypal_ipn_id, txn_id);


--
-- Name: zencartpaypal_session_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartpaypal_session
    ADD CONSTRAINT zencartpaypal_session_pkey PRIMARY KEY (unique_id);


--
-- Name: zencartpaypal_testing_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartpaypal_testing
    ADD CONSTRAINT zencartpaypal_testing_pkey PRIMARY KEY (paypal_ipn_id, txn_id);


--
-- Name: zencartproduct_music_extra_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartproduct_music_extra
    ADD CONSTRAINT zencartproduct_music_extra_pkey PRIMARY KEY (products_id);


--
-- Name: zencartproduct_type_layout_configuration_key_key; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartproduct_type_layout
    ADD CONSTRAINT zencartproduct_type_layout_configuration_key_key UNIQUE (configuration_key);


--
-- Name: zencartproduct_type_layout_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartproduct_type_layout
    ADD CONSTRAINT zencartproduct_type_layout_pkey PRIMARY KEY (configuration_id);


--
-- Name: zencartproduct_types_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartproduct_types
    ADD CONSTRAINT zencartproduct_types_pkey PRIMARY KEY (type_id);


--
-- Name: zencartproducts_attributes_download_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartproducts_attributes_download
    ADD CONSTRAINT zencartproducts_attributes_download_pkey PRIMARY KEY (products_attributes_id);


--
-- Name: zencartproducts_attributes_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartproducts_attributes
    ADD CONSTRAINT zencartproducts_attributes_pkey PRIMARY KEY (products_attributes_id);


--
-- Name: zencartproducts_description_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartproducts_description
    ADD CONSTRAINT zencartproducts_description_pkey PRIMARY KEY (products_id, language_id);


--
-- Name: zencartproducts_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartproducts_notifications
    ADD CONSTRAINT zencartproducts_notifications_pkey PRIMARY KEY (products_id, customers_id);


--
-- Name: zencartproducts_options_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartproducts_options
    ADD CONSTRAINT zencartproducts_options_pkey PRIMARY KEY (products_options_id, language_id);


--
-- Name: zencartproducts_options_types_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartproducts_options_types
    ADD CONSTRAINT zencartproducts_options_types_pkey PRIMARY KEY (products_options_types_id);


--
-- Name: zencartproducts_options_values_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartproducts_options_values
    ADD CONSTRAINT zencartproducts_options_values_pkey PRIMARY KEY (products_options_values_id, language_id);


--
-- Name: zencartproducts_options_values_to_products_options_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartproducts_options_values_to_products_options
    ADD CONSTRAINT zencartproducts_options_values_to_products_options_pkey PRIMARY KEY (products_options_values_to_products_options_id);


--
-- Name: zencartproducts_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartproducts
    ADD CONSTRAINT zencartproducts_pkey PRIMARY KEY (products_id);


--
-- Name: zencartproducts_to_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartproducts_to_categories
    ADD CONSTRAINT zencartproducts_to_categories_pkey PRIMARY KEY (products_id, categories_id);


--
-- Name: zencartproject_version_history_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartproject_version_history
    ADD CONSTRAINT zencartproject_version_history_pkey PRIMARY KEY (project_version_id);


--
-- Name: zencartproject_version_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartproject_version
    ADD CONSTRAINT zencartproject_version_pkey PRIMARY KEY (project_version_id);


--
-- Name: zencartproject_version_project_version_key_key; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartproject_version
    ADD CONSTRAINT zencartproject_version_project_version_key_key UNIQUE (project_version_key);


--
-- Name: zencartquery_builder_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartquery_builder
    ADD CONSTRAINT zencartquery_builder_pkey PRIMARY KEY (query_id);


--
-- Name: zencartquery_builder_query_name_key; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartquery_builder
    ADD CONSTRAINT zencartquery_builder_query_name_key UNIQUE (query_name);


--
-- Name: zencartrecord_artists_info_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartrecord_artists_info
    ADD CONSTRAINT zencartrecord_artists_info_pkey PRIMARY KEY (artists_id, languages_id);


--
-- Name: zencartrecord_artists_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartrecord_artists
    ADD CONSTRAINT zencartrecord_artists_pkey PRIMARY KEY (artists_id);


--
-- Name: zencartrecord_company_info_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartrecord_company_info
    ADD CONSTRAINT zencartrecord_company_info_pkey PRIMARY KEY (record_company_id, languages_id);


--
-- Name: zencartrecord_company_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartrecord_company
    ADD CONSTRAINT zencartrecord_company_pkey PRIMARY KEY (record_company_id);


--
-- Name: zencartreviews_description_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartreviews_description
    ADD CONSTRAINT zencartreviews_description_pkey PRIMARY KEY (reviews_id, languages_id);


--
-- Name: zencartreviews_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartreviews
    ADD CONSTRAINT zencartreviews_pkey PRIMARY KEY (reviews_id);


--
-- Name: zencartsalemaker_sales_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartsalemaker_sales
    ADD CONSTRAINT zencartsalemaker_sales_pkey PRIMARY KEY (sale_id);


--
-- Name: zencartsessions_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartsessions
    ADD CONSTRAINT zencartsessions_pkey PRIMARY KEY (sesskey);


--
-- Name: zencartspecials_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartspecials
    ADD CONSTRAINT zencartspecials_pkey PRIMARY KEY (specials_id);


--
-- Name: zencarttax_class_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencarttax_class
    ADD CONSTRAINT zencarttax_class_pkey PRIMARY KEY (tax_class_id);


--
-- Name: zencarttax_rates_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencarttax_rates
    ADD CONSTRAINT zencarttax_rates_pkey PRIMARY KEY (tax_rates_id);


--
-- Name: zencarttemplate_select_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencarttemplate_select
    ADD CONSTRAINT zencarttemplate_select_pkey PRIMARY KEY (template_id);


--
-- Name: zencartupgrade_exceptions_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartupgrade_exceptions
    ADD CONSTRAINT zencartupgrade_exceptions_pkey PRIMARY KEY (upgrade_exception_id);


--
-- Name: zencartzones_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartzones
    ADD CONSTRAINT zencartzones_pkey PRIMARY KEY (zone_id);


--
-- Name: zencartzones_to_geo_zones_pkey; Type: CONSTRAINT; Schema: public; Owner: sounz; Tablespace: 
--

ALTER TABLE ONLY zencartzones_to_geo_zones
    ADD CONSTRAINT zencartzones_to_geo_zones_pkey PRIMARY KEY (association_id);


--
-- Name: address_book_customers_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX address_book_customers_id_idx ON zencartaddress_book USING btree (customers_id);


--
-- Name: admin_activity_log_access_date_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX admin_activity_log_access_date_idx ON zencartadmin_activity_log USING btree (access_date);


--
-- Name: admin_activity_log_ip_address_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX admin_activity_log_ip_address_idx ON zencartadmin_activity_log USING btree (ip_address);


--
-- Name: admin_activity_log_page_accessed_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX admin_activity_log_page_accessed_idx ON zencartadmin_activity_log USING btree (page_accessed);


--
-- Name: admin_admin_email_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX admin_admin_email_idx ON zencartadmin USING btree (admin_email);


--
-- Name: admin_admin_name_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX admin_admin_name_idx ON zencartadmin USING btree (admin_name);


--
-- Name: banners_1_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX banners_1_idx ON zencartbanners USING btree (status, banners_group);


--
-- Name: banners_date_scheduled_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX banners_date_scheduled_idx ON zencartbanners USING btree (date_scheduled);


--
-- Name: banners_expires_date_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX banners_expires_date_idx ON zencartbanners USING btree (expires_date);


--
-- Name: banners_history_banners_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX banners_history_banners_id_idx ON zencartbanners_history USING btree (banners_id);


--
-- Name: categories_1_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX categories_1_idx ON zencartcategories USING btree (parent_id, categories_id);


--
-- Name: categories_categories_status_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX categories_categories_status_idx ON zencartcategories USING btree (categories_status);


--
-- Name: categories_description_categories_name_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX categories_description_categories_name_idx ON zencartcategories_description USING btree (categories_name);


--
-- Name: categories_sort_order_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX categories_sort_order_idx ON zencartcategories USING btree (sort_order);


--
-- Name: configuration_1_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX configuration_1_idx ON zencartconfiguration USING btree (configuration_key, configuration_value);


--
-- Name: configuration_configuration_group_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX configuration_configuration_group_id_idx ON zencartconfiguration USING btree (configuration_group_id);


--
-- Name: configuration_group_visible_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX configuration_group_visible_idx ON zencartconfiguration_group USING btree (visible);


--
-- Name: countries_address_format_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX countries_address_format_id_idx ON zencartcountries USING btree (address_format_id);


--
-- Name: countries_countries_iso_code_2_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX countries_countries_iso_code_2_idx ON zencartcountries USING btree (countries_iso_code_2);


--
-- Name: countries_countries_iso_code_3_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX countries_countries_iso_code_3_idx ON zencartcountries USING btree (countries_iso_code_3);


--
-- Name: countries_countries_name_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX countries_countries_name_idx ON zencartcountries USING btree (countries_name);


--
-- Name: coupon_email_track_coupon_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX coupon_email_track_coupon_id_idx ON zencartcoupon_email_track USING btree (coupon_id);


--
-- Name: coupon_gv_queue_1_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX coupon_gv_queue_1_idx ON zencartcoupon_gv_queue USING btree (customer_id, order_id);


--
-- Name: coupon_gv_queue_release_flag_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX coupon_gv_queue_release_flag_idx ON zencartcoupon_gv_queue USING btree (release_flag);


--
-- Name: coupon_redeem_track_coupon_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX coupon_redeem_track_coupon_id_idx ON zencartcoupon_redeem_track USING btree (coupon_id);


--
-- Name: coupon_restrict_1_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX coupon_restrict_1_idx ON zencartcoupon_restrict USING btree (coupon_id, product_id);


--
-- Name: coupons_1_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX coupons_1_idx ON zencartcoupons USING btree (coupon_active, coupon_type);


--
-- Name: coupons_coupon_code_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX coupons_coupon_code_idx ON zencartcoupons USING btree (coupon_code);


--
-- Name: coupons_coupon_type_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX coupons_coupon_type_idx ON zencartcoupons USING btree (coupon_type);


--
-- Name: customers_basket_attributes_1_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX customers_basket_attributes_1_idx ON zencartcustomers_basket_attributes USING btree (customers_id, products_id);


--
-- Name: customers_basket_customers_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX customers_basket_customers_id_idx ON zencartcustomers_basket USING btree (customers_id);


--
-- Name: customers_customers_email_address_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX customers_customers_email_address_idx ON zencartcustomers USING btree (customers_email_address);


--
-- Name: customers_customers_group_pricing_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX customers_customers_group_pricing_idx ON zencartcustomers USING btree (customers_group_pricing);


--
-- Name: customers_customers_newsletter_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX customers_customers_newsletter_idx ON zencartcustomers USING btree (customers_newsletter);


--
-- Name: customers_customers_nick_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX customers_customers_nick_idx ON zencartcustomers USING btree (customers_nick);


--
-- Name: customers_customers_referral_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX customers_customers_referral_idx ON zencartcustomers USING btree (customers_referral);


--
-- Name: email_archive_email_to_address_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX email_archive_email_to_address_idx ON zencartemail_archive USING btree (email_to_address);


--
-- Name: email_archive_module_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX email_archive_module_idx ON zencartemail_archive USING btree (module);


--
-- Name: ezpages_languages_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX ezpages_languages_id_idx ON zencartezpages USING btree (languages_id);


--
-- Name: ezpages_status_footer_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX ezpages_status_footer_idx ON zencartezpages USING btree (status_footer);


--
-- Name: ezpages_status_header_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX ezpages_status_header_idx ON zencartezpages USING btree (status_header);


--
-- Name: ezpages_status_sidebox_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX ezpages_status_sidebox_idx ON zencartezpages USING btree (status_sidebox);


--
-- Name: ezpages_status_toc_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX ezpages_status_toc_idx ON zencartezpages USING btree (status_toc);


--
-- Name: featured_expires_date_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX featured_expires_date_idx ON zencartfeatured USING btree (expires_date);


--
-- Name: featured_featured_date_available_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX featured_featured_date_available_idx ON zencartfeatured USING btree (featured_date_available);


--
-- Name: featured_products_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX featured_products_id_idx ON zencartfeatured USING btree (products_id);


--
-- Name: featured_status_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX featured_status_idx ON zencartfeatured USING btree (status);


--
-- Name: files_uploaded_customers_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX files_uploaded_customers_id_idx ON zencartfiles_uploaded USING btree (customers_id);


--
-- Name: languages_name_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX languages_name_idx ON zencartlanguages USING btree (name);


--
-- Name: layout_boxes_1_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX layout_boxes_1_idx ON zencartlayout_boxes USING btree (layout_template, layout_box_name);


--
-- Name: layout_boxes_layout_box_sort_order_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX layout_boxes_layout_box_sort_order_idx ON zencartlayout_boxes USING btree (layout_box_sort_order);


--
-- Name: layout_boxes_layout_box_status_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX layout_boxes_layout_box_status_idx ON zencartlayout_boxes USING btree (layout_box_status);


--
-- Name: manufacturers_manufacturers_name_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX manufacturers_manufacturers_name_idx ON zencartmanufacturers USING btree (manufacturers_name);


--
-- Name: media_clips_clip_type_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX media_clips_clip_type_idx ON zencartmedia_clips USING btree (clip_type);


--
-- Name: media_clips_media_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX media_clips_media_id_idx ON zencartmedia_clips USING btree (media_id);


--
-- Name: media_manager_media_name_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX media_manager_media_name_idx ON zencartmedia_manager USING btree (media_name);


--
-- Name: media_to_products_1_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX media_to_products_1_idx ON zencartmedia_to_products USING btree (media_id, product_id);


--
-- Name: media_types_type_name_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX media_types_type_name_idx ON zencartmedia_types USING btree (type_name);


--
-- Name: music_genre_music_genre_name_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX music_genre_music_genre_name_idx ON zencartmusic_genre USING btree (music_genre_name);


--
-- Name: orders_1_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX orders_1_idx ON zencartorders USING btree (orders_status, orders_id, customers_id);


--
-- Name: orders_date_purchased_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX orders_date_purchased_idx ON zencartorders USING btree (date_purchased);


--
-- Name: orders_products_1_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX orders_products_1_idx ON zencartorders_products USING btree (orders_id, products_id);


--
-- Name: orders_products_attributes_1_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX orders_products_attributes_1_idx ON zencartorders_products_attributes USING btree (orders_id, orders_products_id);


--
-- Name: orders_products_download_orders_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX orders_products_download_orders_id_idx ON zencartorders_products_download USING btree (orders_id);


--
-- Name: orders_products_download_orders_products_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX orders_products_download_orders_products_id_idx ON zencartorders_products_download USING btree (orders_products_id);


--
-- Name: orders_status_history_1_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX orders_status_history_1_idx ON zencartorders_status_history USING btree (orders_id, orders_status_id);


--
-- Name: orders_status_orders_status_name_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX orders_status_orders_status_name_idx ON zencartorders_status USING btree (orders_status_name);


--
-- Name: orders_total_class_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX orders_total_class_idx ON zencartorders_total USING btree ("class");


--
-- Name: orders_total_orders_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX orders_total_orders_id_idx ON zencartorders_total USING btree (orders_id);


--
-- Name: paypal_payment_status_history_paypal_ipn_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX paypal_payment_status_history_paypal_ipn_id_idx ON zencartpaypal_payment_status_history USING btree (paypal_ipn_id);


--
-- Name: paypal_session_session_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX paypal_session_session_id_idx ON zencartpaypal_session USING btree (session_id);


--
-- Name: paypal_testing_zen_order_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX paypal_testing_zen_order_id_idx ON zencartpaypal_testing USING btree (zen_order_id);


--
-- Name: paypal_zen_order_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX paypal_zen_order_id_idx ON zencartpaypal USING btree (zen_order_id);


--
-- Name: product_music_extra_artists_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX product_music_extra_artists_id_idx ON zencartproduct_music_extra USING btree (artists_id);


--
-- Name: product_music_extra_music_genre_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX product_music_extra_music_genre_id_idx ON zencartproduct_music_extra USING btree (music_genre_id);


--
-- Name: product_music_extra_record_company_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX product_music_extra_record_company_id_idx ON zencartproduct_music_extra USING btree (record_company_id);


--
-- Name: product_type_layout_1_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX product_type_layout_1_idx ON zencartproduct_type_layout USING btree (configuration_key, configuration_value);


--
-- Name: product_types_to_category_category_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX product_types_to_category_category_id_idx ON zencartproduct_types_to_category USING btree (category_id);


--
-- Name: product_types_to_category_product_type_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX product_types_to_category_product_type_id_idx ON zencartproduct_types_to_category USING btree (product_type_id);


--
-- Name: product_types_type_master_type_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX product_types_type_master_type_idx ON zencartproduct_types USING btree (type_master_type);


--
-- Name: products_attributes_1_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX products_attributes_1_idx ON zencartproducts_attributes USING btree (products_id, options_id, options_values_id);


--
-- Name: products_attributes_products_options_sort_order_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX products_attributes_products_options_sort_order_idx ON zencartproducts_attributes USING btree (products_options_sort_order);


--
-- Name: products_description_products_name_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX products_description_products_name_idx ON zencartproducts_description USING btree (products_name);


--
-- Name: products_discount_quantity_1_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX products_discount_quantity_1_idx ON zencartproducts_discount_quantity USING btree (products_id, discount_qty);


--
-- Name: products_manufacturers_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX products_manufacturers_id_idx ON zencartproducts USING btree (manufacturers_id);


--
-- Name: products_master_categories_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX products_master_categories_id_idx ON zencartproducts USING btree (master_categories_id);


--
-- Name: products_options_language_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX products_options_language_id_idx ON zencartproducts_options USING btree (language_id);


--
-- Name: products_options_products_options_name_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX products_options_products_options_name_idx ON zencartproducts_options USING btree (products_options_name);


--
-- Name: products_options_products_options_sort_order_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX products_options_products_options_sort_order_idx ON zencartproducts_options USING btree (products_options_sort_order);


--
-- Name: products_options_values_products_options_values_name_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX products_options_values_products_options_values_name_idx ON zencartproducts_options_values USING btree (products_options_values_name);


--
-- Name: products_options_values_products_options_values_sort_order_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX products_options_values_products_options_values_sort_order_idx ON zencartproducts_options_values USING btree (products_options_values_sort_order);


--
-- Name: products_products_date_added_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX products_products_date_added_idx ON zencartproducts USING btree (products_date_added);


--
-- Name: products_products_date_available_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX products_products_date_available_idx ON zencartproducts USING btree (products_date_available);


--
-- Name: products_products_model_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX products_products_model_idx ON zencartproducts USING btree (products_model);


--
-- Name: products_products_ordered_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX products_products_ordered_idx ON zencartproducts USING btree (products_ordered);


--
-- Name: products_products_price_sorter_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX products_products_price_sorter_idx ON zencartproducts USING btree (products_price_sorter);


--
-- Name: products_products_sort_order_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX products_products_sort_order_idx ON zencartproducts USING btree (products_sort_order);


--
-- Name: products_products_status_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX products_products_status_idx ON zencartproducts USING btree (products_status);


--
-- Name: products_to_categories_1_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX products_to_categories_1_idx ON zencartproducts_to_categories USING btree (categories_id, products_id);


--
-- Name: record_artists_artists_name_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX record_artists_artists_name_idx ON zencartrecord_artists USING btree (artists_name);


--
-- Name: record_company_record_company_name_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX record_company_record_company_name_idx ON zencartrecord_company USING btree (record_company_name);


--
-- Name: reviews_customers_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX reviews_customers_id_idx ON zencartreviews USING btree (customers_id);


--
-- Name: reviews_date_added_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX reviews_date_added_idx ON zencartreviews USING btree (date_added);


--
-- Name: reviews_products_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX reviews_products_id_idx ON zencartreviews USING btree (products_id);


--
-- Name: reviews_status_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX reviews_status_idx ON zencartreviews USING btree (status);


--
-- Name: salemaker_sales_sale_date_end_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX salemaker_sales_sale_date_end_idx ON zencartsalemaker_sales USING btree (sale_date_end);


--
-- Name: salemaker_sales_sale_date_start_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX salemaker_sales_sale_date_start_idx ON zencartsalemaker_sales USING btree (sale_date_start);


--
-- Name: salemaker_sales_sale_status_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX salemaker_sales_sale_status_idx ON zencartsalemaker_sales USING btree (sale_status);


--
-- Name: specials_expires_date_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX specials_expires_date_idx ON zencartspecials USING btree (expires_date);


--
-- Name: specials_products_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX specials_products_id_idx ON zencartspecials USING btree (products_id);


--
-- Name: specials_specials_date_available_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX specials_specials_date_available_idx ON zencartspecials USING btree (specials_date_available);


--
-- Name: specials_status_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX specials_status_idx ON zencartspecials USING btree (status);


--
-- Name: tax_rates_tax_class_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX tax_rates_tax_class_id_idx ON zencarttax_rates USING btree (tax_class_id);


--
-- Name: tax_rates_tax_zone_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX tax_rates_tax_zone_id_idx ON zencarttax_rates USING btree (tax_zone_id);


--
-- Name: template_select_template_language_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX template_select_template_language_idx ON zencarttemplate_select USING btree (template_language);


--
-- Name: tions_values_to_products_options_products_options_values_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX tions_values_to_products_options_products_options_values_id_idx ON zencartproducts_options_values_to_products_options USING btree (products_options_values_id);


--
-- Name: ucts_options_values_to_products_options_products_options_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX ucts_options_values_to_products_options_products_options_id_idx ON zencartproducts_options_values_to_products_options USING btree (products_options_id);


--
-- Name: whos_online_customer_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX whos_online_customer_id_idx ON zencartwhos_online USING btree (customer_id);


--
-- Name: whos_online_ip_address_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX whos_online_ip_address_idx ON zencartwhos_online USING btree (ip_address);


--
-- Name: whos_online_last_page_url_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX whos_online_last_page_url_idx ON zencartwhos_online USING btree (last_page_url);


--
-- Name: whos_online_session_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX whos_online_session_id_idx ON zencartwhos_online USING btree (session_id);


--
-- Name: whos_online_time_entry_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX whos_online_time_entry_idx ON zencartwhos_online USING btree (time_entry);


--
-- Name: whos_online_time_last_click_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX whos_online_time_last_click_idx ON zencartwhos_online USING btree (time_last_click);


--
-- Name: zones_to_geo_zones_1_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX zones_to_geo_zones_1_idx ON zencartzones_to_geo_zones USING btree (geo_zone_id, zone_country_id, zone_id);


--
-- Name: zones_zone_code_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX zones_zone_code_idx ON zencartzones USING btree (zone_code);


--
-- Name: zones_zone_country_id_idx; Type: INDEX; Schema: public; Owner: sounz; Tablespace: 
--

CREATE INDEX zones_zone_country_id_idx ON zencartzones USING btree (zone_country_id);


--
-- PostgreSQL database dump complete
--

COMMIT;
