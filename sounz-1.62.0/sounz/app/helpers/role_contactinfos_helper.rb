module RoleContactinfosHelper
  
  #--------------------------------------------------------------
  #- Return contactinfo_types of organisation role_contactinfos -
  #--------------------------------------------------------------
  def get_organisation_contactinfo_types(role_id)
    contactinfo_types = Array.new
    if role_id != nil
      role = Role.find(role_id)
      role_contactinfos = role.role_contactinfos
      if !role_contactinfos.blank?
        for role_contactinfo in role_contactinfos
          contactinfo_types.push(role_contactinfo.contactinfo_type)
        end
      end
    end
    return contactinfo_types
  end
  
  #----------------------------------------
  #- Return preferred role_contactinfo_id -
  #----------------------------------------
  def get_preferred_role_contactinfo(role_contactinfos)
    id = nil
    if !role_contactinfos.blank?
      for role_contactinfo in role_contactinfos
        if role_contactinfo.preferred == true
          id = role_contactinfo.role_contactinfo_id
        else 
          if role_contactinfo.preferred == false && id == nil
            id = role_contactinfo.role_contactinfo_id
          end
        end
      end
    end
  end
  
  # FIXME when the display of three contact infos of the role on 
  # the same page is changed to the display of just one contact info 
  # (role_contactinfo) selected by user,
  # this method won't be needed 
  #-------------------------------------------------------
  #- Return saved contact lists associated with the role -
  #-------------------------------------------------------
  def get_role_saved_contact_lists(role)
    saved_contact_lists = Array.new
    if role != nil
      role_contactinfos = role.role_contactinfos
      if !role_contactinfos.blank?
        for role_contactinfo in role_contactinfos
          role_contactinfo.saved_contact_lists.each do |s|
            saved_contact_lists.push(s.saved_contact_list_id)
          end
        end
      end
    end
    logger.debug "********* ROLE SAVED CONTACT LISTS are #{saved_contact_lists} "
    return saved_contact_lists  
  end
  
end
