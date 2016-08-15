#!/usr/bin/env ../sounz/script/runner

# Usage: ruby set_testing_configurations.rb test_email

test_email = ARGV[0]

if !test_email.blank?
# settings - replace all emails in settings to test email
ActiveRecord::Base.connection.execute("UPDATE settings SET setting_value='#{test_email}' WHERE setting_value ILIKE '%@%'")

# zencartconfiguration

# DPS testing configurations
ActiveRecord::Base.connection.execute("UPDATE zencartconfiguration SET configuration_value='SOUNZ_dev' WHERE configuration_key='MODULE_PAYMENT_DPSACCESS_USERID'")
ActiveRecord::Base.connection.execute("UPDATE zencartconfiguration SET configuration_value='0e33b0f5bc5cd948ced947f37b5c0d8a9a021d9b26989dfb' WHERE configuration_key='MODULE_PAYMENT_DPSACCESS_DESKEY'")
ActiveRecord::Base.connection.execute("UPDATE zencartconfiguration SET configuration_value='fa6b4bb6cf092d8b' WHERE configuration_key='MODULE_PAYMENT_DPSACCESS_MACKEY'")

ActiveRecord::Base.connection.execute("UPDATE zencartconfiguration SET configuration_value='SOUNZ_dev' WHERE configuration_key='MODULE_PAYMENT_DPS_PXPAY_USERID'")
ActiveRecord::Base.connection.execute("UPDATE zencartconfiguration SET configuration_value='0e33b0f5bc5cd948ced947f37b5c0d8a9a021d9b26989dfbfa6b4bb6cf092d8b' WHERE configuration_key='MODULE_PAYMENT_DPS_PXPAY_KEY'")

# replace all emails in zencartconfiguration to test email
ActiveRecord::Base.connection.execute("UPDATE zencartconfiguration SET configuration_value='#{test_email}' WHERE configuration_value ILIKE '%@%'")

else
  puts "ERROR: No testing email has been provided"
end  
