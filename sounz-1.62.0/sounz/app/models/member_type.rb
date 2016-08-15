class MemberType < ActiveRecord::Base

set_primary_key :member_type_id
set_sequence_name "member_types_member_type_id_seq"

has_many :member_type_privileges
#has_many :privileges, :through => :member_type_privileges
has_many :memberships


SUPERUSER = MemberType.find(:first, :conditions => ['member_type_desc=?',"Superuser"])

def self.memberTypeToId(typename)

matchingtypes=MemberType.find(:all, :conditions => ['member_type_desc=?',typename])
  if matchingtypes != nil
    return matchingtypes.first
  end
return nil

end


end
