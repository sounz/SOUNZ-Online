module PrivilegesHelper
  
  #This is a central call for the view logic as to whether or not to show links on pages.
  #As an example, you can do PrivilegesHelper.has_permission?(@login, 'CAN_EDIT_TAP')
  #Check the privileges table for allowed verbs.
  # FIXME: Currently this returns true if logged in, false otherwise
  
  def self.getPrivilegeList
    privileges=Privilege.find(:all)
    privs=[]
    for priv in privileges
    privs << priv
    end
    return privs
  end
  
  def self.getVerbList
    privileges=Privilege.find(:all)
    verbs=[]
    for priv in privileges
    verbs << priv.privilege_name
    end
    return verbs
  end
  
  PRIVS = self.getPrivilegeList
  VERBS = self.getVerbList
  
  
  
  def self.has_permission?(myLogin, verb)
    if !VERBS.include?(verb)
      raise ArgumentError, "Verb #{verb} is not supported"
    end
    
    if !myLogin.blank?
      #check users member type against the privileges
      #find our user
      
      if myLogin.class.to_s=='Login'
        myLogin=myLogin.login_id
      end
      if myLogin != nil
        l=Login.find(myLogin)
        
        #Super user is always true
        if l.is_superuser?
          return true
        else
          p=Privilege.find(:all,:conditions => ['privilege_name=?',verb]).first
          if p != nil && l != nil
            for mt in l.member_types
              for mp in mt.member_type_privileges
                Work.logger.debug("MEMBER PRIVILEGE: #{mp.privilege_id}")
                if mp.privilege_id==(p.id)
                  return true
                end
              end
            end
          end
        end
      else
        return false
      end
    
    else
      #anonymous users are granted the 'VIEW PUBLIC' privilege and nothing else
    
      if verb=='CAN_VIEW_PUBLIC'
        return true
      end
    
    end
    
    
    
    return false
  end
  
  # -------------------------------------------------------------
  # - Check if an object can be viewed                          -
  # - Object can be viewed if:
  # -   a user has 'CAN_VIEW_TAP' privilege
  # -   object has status id field and it is 'Published'
  # -   object does not have status id field
  # -------------------------------------------------------------
  def self.has_link_permission?(login, object)
    link_permitted = false
    
    if self.has_permission?(login, 'CAN_VIEW_TAP')
      link_permitted = true
	  
	elsif object.class == Role
	  link_permitted = true if !object.contributor.blank? && object.contributor.status_id == Status::PUBLISHED.status_id	
      
    elsif object.respond_to?("status_id")
        
      if object.status_id == Status::PUBLISHED.status_id
        link_permitted = true       
      else
        link_permitted = false
      end
      
    else
      link_permitted = true
    end
    
    return link_permitted
  end
  
  # ---------------------------------------------
  # - Returns array of objects filtered based on 
  # - user privileges and object status if relevant
  # ---------------------------------------------
  def self.permitted_objects(login, objects)
    permitted_objects = Array.new
    	
	objects = [objects].flatten
	
	objects.each do |o|
	 
      if self.has_permission?(login, 'CAN_VIEW_TAP')
        permitted_objects.push(o)
      
      elsif o.class == Role
      	permitted_objects.push(o) if !o.contributor.blank? && o.contributor.status_id == Status::PUBLISHED.status_id
		
      elsif o.respond_to?("status_id")
      	if o.status_id == Status::PUBLISHED.status_id
          permitted_objects.push(o)
        end
      
      else
        permitted_objects.push(o)
      end
    end
	
    return permitted_objects
  end

  
end
