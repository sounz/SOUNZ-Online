class ControllerRestrictionHelper

  #Check if a login has permission to use the desired controller and action
  # - if the user is a superuser they do
  # - otherwise check privileges
  # - if the login is blank (ie not logged on) only check can view public privilege
  # - the status of the object being shown.  Note this can be nil, in which case the check is ignored.
  #   The reason for this is that its not possible to check the status after a controller action as the
  #   controller will have already called render, making another redirect / render not possible
  def self.login_has_permission?(http_method_sym, the_controller, the_action, the_id, the_login, status_in_context)
    username_debug = "Not logged in"
    username_debug = the_login.username if !the_login.blank?
    logger.debug "CHECKING LOGIN:#{username_debug}"
     allowed = false
     assigned_privileges = [Privilege::CAN_VIEW_PUBLIC]
     
     #Check we have a login
      if !the_login.blank?
        member_types = the_login.memberships.map{|m| m.member_type}.flatten.uniq
        
        #The login is a superuser
        if member_types.include?(MemberType::SUPERUSER)
          allowed = true
        
        #Check the privileges if not a super user
        else
          member_type_privileges = member_types.map{|mt| mt.member_type_privileges}
          assigned_privileges = member_type_privileges.flatten.map{|mtp| mtp.privilege}
          allowed = has_permission?(http_method_sym, the_controller, the_action, the_id, assigned_privileges, status_in_context)
        end
      
      #This is the case of checking for the can view public privelge, with no login assigned
      else
        allowed = has_permission?(http_method_sym, the_controller, the_action, the_id, assigned_privileges, status_in_context)
      end
      allowed
  end

  #Check if the desired controller and action are permitted by a list of privileges
  def self.has_permission?(http_method_sym, the_controller, the_action, the_id, privileges, status_in_context)
     logger.debug "CHECKING PERMISSIONS"
     assigned_privileges = [Privilege::CAN_VIEW_PUBLIC]

      if !@login.blank?
        member_type_privileges = @login.memberships.map{|m|m.member_type}.map{|mt| mt.member_type_privileges}
        assigned_privileges = member_type_privileges.flatten.map{|mtp| mtp.privilege}
      end
      
      
    #Assume the page is unavailable
    allowed = false
    logger.debug "CONTROLLER:"+the_controller
    logger.debug "ACTION:"+the_action
    logger.debug "ID:#{the_id}"
    logger.debug "PRIV:#{privileges.map{|p| p.privilege_name}.join(',')}"
    
    
    
    
    #Look for an explicit permission
    sql = "controller_name = ? and (controller_action=? or controller_action = 'ALL') "+
      "and privilege_id in (?) and http_verb = ?"
      
    controller_restriction = nil
    
    #This is the case when the status has to be checked further down the line
    if status_in_context.blank?
      controller_restriction = ControllerRestriction.find(:first, 
        :conditions => [sql,
          the_controller.to_s,
          the_action.to_s,
          privileges.map{|p|p.privilege_id.to_i},
          http_method_sym.to_s
      ])
      
      logger.debug "CONTROLLER RESTRICTINO FOUND:#{controller_restriction != nil}"
      
    #We have a status so check it
    else
      sql << " and status_id = ? "
       controller_restriction = ControllerRestriction.find(:first, 
          :conditions => [sql,
            the_controller.to_s,
            the_action.to_s,
            privileges.map{|p|p.privilege_id.to_i},
            http_method_sym.to_s,
            status_in_context.status_id.to_i
        ])
            logger.debug "CONTROLLER RESTRICTINO FOUND:#{controller_restriction != nil}"
    end
    
    
        logger.debug "CHECKING Controller restriction: " + controller_restriction.to_yaml
        
    #This is will only match if a particular condition is set
    allowed = true if !controller_restriction.blank?
    
    logger.debug "CHECK 1, allowed is #{allowed}"
    
=begin    
    #Now check for the allow all case
    controller_restriction = ControllerRestriction.find(:first, 
        :conditions => ["controller_name = ? and controller_action='*' and privilege_id in (?)",
          the_controller,
          privileges.map{|p|p.privilege_id}
    ])
    allowed = true if !controller_restriction.blank?
      
    logger.debug "PERMISSION IS:#{allowed}"
=end    
    
    return allowed  

  end
  
  
  
  #If the user is a superuser or has CAN_VIEW_TAP privilege
  def self.has_permission_to_search_non_public_tap?(the_login)
    result = false
    
    if the_login.blank?
      result = false
    elsif the_login.is_superuser?
      result = true
    else
      member_types = the_login.memberships.map{|m| m.member_type}.flatten.uniq
      member_type_privileges = member_types.map{|mt| mt.member_type_privileges}
      assigned_privileges = member_type_privileges.flatten.map{|mtp| mtp.privilege}.uniq
      result = assigned_privileges.include?(Privilege::CAN_VIEW_TAP)
    end
    result
  end
  
  

  def self.logger
    RAILS_DEFAULT_LOGGER
  end
  
  # ControllerRestrictionHelper.has_permission?(controller_name, action_name, session[:intended_id], assigned_privileges)  
  
end