-- Patch for SOUNZ database upgrade
-- 1.33.0 to 1.34.0
--

BEGIN;

-- WR#61419 - 'SOUNZtender Bidding Form' provider form

CREATE SEQUENCE prov_bids_prov_bid_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

CREATE TABLE prov_bids (
    prov_bid_id int4 NOT NULL DEFAULT nextval('prov_bids_prov_bid_id_seq'::regclass),
    status_id int4 NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    phone_home text,
    phone_work text,
    phone_mobile text,
    phone_fax text,
    postal_address text NOT NULL,
    postcode text NOT NULL,
    is_group_bid bool NOT NULL DEFAULT false,
    group_name text,
    bidder_name text NOT NULL,
    bid text NOT NULL,
    bid_amount numeric NOT NULL DEFAULT 0.00,
    terms_agreed bool NOT NULL DEFAULT false,
    pay_method text,
    pay_method_other text,
    bid_notes text,
    send_donor_info bool NOT NULL DEFAULT false,
    send_bequest_info bool NOT NULL DEFAULT false,
    send_sounz_email_updates bool NOT NULL DEFAULT false,
    send_sounz_news_post bool NOT NULL DEFAULT false,
    send_sounz_news_email bool NOT NULL DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    submitted_by int4
);

-- Privileges
INSERT INTO privileges (privilege_name, privilege_desc) VALUES ('CAN_EDIT_BID_PROV_FORM', 'User can edit bidding submissions');

INSERT INTO member_type_privileges (member_type_id, privilege_id) VALUES
  ((SELECT member_type_id FROM member_types WHERE member_type_desc = 'Administrator'),
   (SELECT privilege_id FROM privileges WHERE privilege_name = 'CAN_EDIT_BID_PROV_FORM'));

-- Settings
INSERT INTO settings (setting_name, setting_value) VALUES ('prov_bid_recipient', 'project@sounz.org.nz');

-- Controller restrictions
-- Restriction for /prov_bids/ALL, for a status of Pending and privilege CAN_EDIT_BID_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_bids', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BID_PROV_FORM')
);

-- Restriction for /prov_bids/ALL, for a status of Pending and privilege CAN_EDIT_BID_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_bids', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BID_PROV_FORM')
);

-- Restriction for /prov_bids/ALL, for a status of Pending and privilege CAN_EDIT_BID_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_bids', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BID_PROV_FORM')
);

-- Restriction for /prov_bids/ALL, for a status of Approved and privilege CAN_EDIT_BID_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_bids', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BID_PROV_FORM')
);

-- Restriction for /prov_bids/ALL, for a status of Approved and privilege CAN_EDIT_BID_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_bids', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BID_PROV_FORM')
);

-- Restriction for /prov_bids/ALL, for a status of Approved and privilege CAN_EDIT_BID_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_bids', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Approved'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BID_PROV_FORM')
);

-- Restriction for /prov_bids/ALL, for a status of Masked and privilege CAN_EDIT_BID_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_bids', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BID_PROV_FORM')
);

-- Restriction for /prov_bids/ALL, for a status of Masked and privilege CAN_EDIT_BID_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_bids', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BID_PROV_FORM')
);

-- Restriction for /prov_bids/ALL, for a status of Masked and privilege CAN_EDIT_BID_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_bids', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Masked'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BID_PROV_FORM')
);

-- Restriction for /prov_bids/ALL, for a status of Withdrawn and privilege CAN_EDIT_BID_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_bids', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BID_PROV_FORM')
);

-- Restriction for /prov_bids/ALL, for a status of Withdrawn and privilege CAN_EDIT_BID_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_bids', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BID_PROV_FORM')
);

-- Restriction for /prov_bids/ALL, for a status of Withdrawn and privilege CAN_EDIT_BID_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_bids', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Withdrawn'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BID_PROV_FORM')
);

-- Restriction for /prov_bids/ALL, for a status of Published and privilege CAN_EDIT_BID_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_bids', 'ALL', 'get',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BID_PROV_FORM')
);

-- Restriction for /prov_bids/ALL, for a status of Published and privilege CAN_EDIT_BID_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_bids', 'ALL', 'put',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BID_PROV_FORM')
);

-- Restriction for /prov_bids/ALL, for a status of Published and privilege CAN_EDIT_BID_PROV_FORM
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_bids', 'ALL', 'delete',
(select status_id from publishing_statuses where status_desc = 'Published'),
		(select privilege_id from privileges where privilege_name = 'CAN_EDIT_BID_PROV_FORM')
);

-- Restriction for /prov_bids/new, for a status of Pending and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_bids', 'new', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /prov_bids/new, for a status of Pending and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_bids', 'new', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /prov_bids/create, for a status of Pending and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_bids', 'create', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /prov_bids/create, for a status of Pending and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_bids', 'create', 'post',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

-- Restriction for /prov_bids/show_confirmation, for a status of Pending and privilege CAN_VIEW_PUBLIC
insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values
('prov_bids', 'show_confirmation', 'get',
(select status_id from publishing_statuses where status_desc = 'Pending'),
		(select privilege_id from privileges where privilege_name = 'CAN_VIEW_PUBLIC')
);

COMMIT;