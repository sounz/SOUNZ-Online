class PasswordChangeRequest < ActiveRecord::Base
  set_primary_key :password_change_request_id
  
   validates_presence_of :activation_key
   
   belongs_to :login_requested_by, 
             :class_name => 'Login',
             :foreign_key => :requested_by_login_id 
   
   #Expire a password change request that is more than 10 mins old
   def expired?
     (Time.now - created_at) > 1.week
   end
   
   
   
  
end
