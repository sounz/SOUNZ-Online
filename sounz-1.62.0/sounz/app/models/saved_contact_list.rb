class SavedContactList < ActiveRecord::Base
  set_primary_key :saved_contact_list_id
  
  has_many :saved_role_contactinfos
  has_and_belongs_to_many :role_contactinfos, :join_table => :saved_role_contactinfos
    
  #Updated by relationship 
  validates_presence_of :login_updated_by
  #validates_associated :login_updated_by
  
  belongs_to :login_updated_by, 
            :class_name => 'Login',
            :foreign_key => :updated_by
  
  acts_as_dropdown :text => "list_name", :order => "list_name ASC"

  #---------------------------------------------------
  #- Return role_contactinfos sorted by contact name -
  #---------------------------------------------------
  def role_contactinfos_sorted
    role_contactinfos.sort{|rc, orc| rc.role.role_contact_name <=> orc.role.role_contact_name } 
  end
  
  
  #----------------------------------------
  #- Add role_contactinfo to contact list -
  #----------------------------------------
  def add_contact(new_role_contactinfo)
    updated_correctly = false
    puts "Adding contact to saved contact list"
    
    # don't save if role_contactinfos is already in contact list
    if !role_contactinfos.include?(new_role_contactinfo)
      role_contactinfos << new_role_contactinfo
      # update all role_contactinfo for solr indexing
      #new_role_contactinfo.save
      
      updated_correctly = true 
    end
    
    return updated_correctly
    
  end
  
  #----------------------------------------
  #- Add role_contactinfo to contact list -
  #----------------------------------------
  def remove_contact(role_contactinfo)
    successful_deletion = false
    puts "Removing contact from saved contact list"
    if role_contactinfos.include?(role_contactinfo)
      role_contactinfos.delete(role_contactinfo)
      
      # update all role_contactinfo for solr indexing
      #role_contactinfo.save
      
      successful_deletion = true
    end
    return successful_deletion
  end
  
  # Return the saved contact list based on the saved list name param
  def self.get_saved_list_by_name(saved_list_name)
  	return SavedContactList.find(:first, :conditions => ['LOWER(list_name) =?', saved_list_name.downcase])
  end
  
  #------------------
  #- Accessor for all the contributors: contributors
  #------------------
  #def contributors
  #  return people+organisations
  #end
  
  
end
