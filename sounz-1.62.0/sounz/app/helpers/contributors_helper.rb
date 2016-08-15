module ContributorsHelper
  
  #Decide which route to return, e.g. composer, performer, funder etc for a given role
  def self.get_link_depending_on_role_type(role, login)
    raise ArgumentError, "Role does not have a contributor" if role.contributor.blank?
    role_type = role.role_type
   
    result = "/"
    
    if role_type.is_venue?
      result << "contributor/venue"

    else
      grouping = role_type.role_type_group
      
      case grouping
      
      when "composer"
        result << "contributor/composer"
      when "performer"
        result << "contributor/performer"
      when "commissioner"
        result << "contributor/commissioner"
      when "presenter"
        result << "contributor/presenter"
      when "publisher"
        result << "contributor/publisher"
      when "writer"
        result << "contributor/writer"
      else
        result << "contributor/composer"
      end
      
      
    end
    
    contributor = Contributor.find(:first, :conditions => ["role_id = ?", role.role_id])
    result << "/#{contributor.contributor_id}"
    
    if PrivilegesHelper.has_link_permission?(login, contributor)
      anchor = '<a href="'
      anchor << result
      anchor << '">'
      anchor << contributor.role.contributor_names
      anchor << "</a>"
    else
      anchor = ''
    end
    anchor
  end
end
