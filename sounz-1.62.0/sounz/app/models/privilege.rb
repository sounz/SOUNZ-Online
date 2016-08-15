class Privilege < ActiveRecord::Base

set_primary_key :privilege_id
set_sequence_name "privileges_privilege_id_seq"

has_many :member_type_privileges, :dependent => :destroy
has_many :member_types, :through => :member_type_privileges

#Constants for each priv
CAN_VIEW_PUBLIC = Privilege.find(:first, :conditions => ["privilege_name = ?","CAN_VIEW_PUBLIC"])

CAN_EDIT_TAP = Privilege.find(:first, :conditions => ["privilege_name = ?","CAN_EDIT_TAP"])
CAN_PUBLISH_TAP = Privilege.find(:first, :conditions => ["privilege_name = ?","CAN_PUBLISH_TAP"])
CAN_VIEW_TAP = Privilege.find(:first, :conditions => ["privilege_name = ?","CAN_VIEW_TAP"])

CAN_EDIT_CONTRIBUTOR_PROFILE = Privilege.find(:first, :conditions => ["privilege_name = ?","CAN_EDIT_CONTRIBUTOR_PROFILE"])
CAN_PUBLISH_CONTRIBUTOR_PROFILE = Privilege.find(:first, :conditions => ["privilege_name = ?","CAN_PUBLISH_CONTRIBUTOR_PROFILE"])

CAN_EDIT_DISTINCTION = Privilege.find(:first, :conditions => ["privilege_name = ?","CAN_EDIT_DISTINCTION"])
CAN_PUBLISH_DISTINCTION = Privilege.find(:first, :conditions => ["privilege_name = ?","CAN_PUBLISH_DISTINCTION"])

CAN_EDIT_CRM = Privilege.find(:first, :conditions => ["privilege_name = ?","CAN_EDIT_CRM"])
CAN_PUBLISH_CRM = Privilege.find(:first, :conditions => ["privilege_name = ?","CAN_PUBLISH_CRM"])

CAN_EDIT_EVENT = Privilege.find(:first, :conditions => ["privilege_name = ?","CAN_EDIT_EVENT"])
CAN_PUBLISH_EVENT = Privilege.find(:first, :conditions => ["privilege_name = ?","CAN_PUBLISH_EVENT"])

CAN_SAVE_SEARCH = Privilege.find(:first, :conditions => ["privilege_name = ?","CAN_SAVE_SEARCH"])

IS_AUTHENTICATED = Privilege.find(:first, :conditions => ["privilege_name = ?","IS_AUTHENTICATED"])

CAN_ACCESS_LIBRARY = Privilege.find(:first, :conditions => ["privilege_name = ?","CAN_ACCESS_LIBRARY"])

CAN_EDIT_CONTENT = Privilege.find(:first, :conditions => ["privilege_name = ?","CAN_EDIT_CONTENT"])

CAN_EDIT_PRIVILEGE = Privilege.find(:first, :conditions => ["privilege_name = ?","CAN_EDIT_PRIVILEGE"])

CAN_EDIT_LOGIN = Privilege.find(:first, :conditions => ["privilege_name = ?","CAN_EDIT_LOGIN"])

CAN_EDIT_PROJECT = Privilege.find(:first, :conditions => ["privilege_name = ?","CAN_EDIT_PROJECT"])

CAN_EDIT_BORROWED_ITEM = Privilege.find(:first, :conditions => ["privilege_name = ?","CAN_EDIT_BORROWED_ITEM"])

CAN_EDIT_SALES_HISTORY = Privilege.find(:first, :conditions => ["privilege_name = ?","CAN_EDIT_SALES_HISTORY"])

# privileges for provider forms
CAN_EDIT_CONTACT_UPDATE_PROV_FORM = Privilege.find(:first, :conditions => ["privilege_name = ?","CAN_EDIT_CONTACT_UPDATE_PROV_FORM"])
CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM = Privilege.find(:first, :conditions => ["privilege_name = ?","CAN_EDIT_CONTRIBUTOR_PROFILE_PROV_FORM"])
CAN_EDIT_COMPOSER_BIO_PROV_FORM = Privilege.find(:first, :conditions => ["privilege_name = ?","CAN_EDIT_COMPOSER_BIO_PROV_FORM"])
CAN_EDIT_EVENT_PROV_FORM = Privilege.find(:first, :conditions => ["privilege_name = ?","CAN_EDIT_EVENT_PROV_FORM"])
CAN_EDIT_WORK_UPDATE_PROV_FORM = Privilege.find(:first, :conditions => ["privilege_name = ?","CAN_EDIT_WORK_UPDATE_PROV_FORM"])
CAN_EDIT_FEEDBACK_PROV_FORM = Privilege.find(:first, :conditions => ["privilege_name = ?","CAN_EDIT_FEEDBACK_PROV_FORM"])
CAN_EDIT_PRODUCT_PROV_FORM = Privilege.find(:first, :conditions => ["privilege_name = ?","CAN_EDIT_PRODUCT_PROV_FORM"])
CAN_EDIT_BID_PROV_FORM = Privilege.find(:first, :conditions => ["privilege_name = ?","CAN_EDIT_BID_PROV_FORM"])

end
