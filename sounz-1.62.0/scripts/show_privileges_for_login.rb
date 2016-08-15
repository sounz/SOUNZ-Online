#!/usr/bin/env ../sounz/script/runner

username = ARGV[0]
login = Login.find(:first, :conditions => ["username = ?",username])
memberships = login.memberships

all_member_types = []

memberships.map{|m| all_member_types << m.member_type}
all_member_types.flatten!
all_member_types.uniq!

for member_type in all_member_types.sort_by{|s| s.member_type_desc}
  puts member_type.member_type_desc.upcase
  puts "================"
  for member_type_privilege in member_type.member_type_privileges
    puts member_type_privilege.privilege.privilege_name
  end
  puts
end

puts "#{username} is superuser?  #{login.is_superuser?}"

