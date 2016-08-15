class MemberTypePrivilege < ActiveRecord::Base

set_primary_key :member_type_privilege_id
set_sequence_name "member_type_privileges_member_type_privilege_id_seq"


belongs_to :privilege
belongs_to :member_type

end
