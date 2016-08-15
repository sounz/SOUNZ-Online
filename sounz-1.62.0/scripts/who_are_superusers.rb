#!/usr/bin/env ../sounz/script/runner
logins = Login.find(:all)

puts "THE FOLLOWING USERS ARE SUPERUSERS"
for login in logins
  puts login.username if login.is_superuser?
end