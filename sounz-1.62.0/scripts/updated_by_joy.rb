for thing in [:superworks,:works, :contributors, :expressions,:manifestations,:events,:venues,:distinctions,
  :items, :resources, :samples, :concepts, :distinction_instances,:contactinfos,:people, :organisations,
  :communications, :marketing_campaigns, :campaign_mailouts, :projects, :saved_contact_lists, :mailout_contacts,
  :saved_searches, :media_items 
  ]
  
  #logins?
  puts "update #{thing} set updated_by = 1;"
  
  
end