module ProjectsHelper

  #--------------------------
  #- Return project manager -
  #--------------------------
  def get_project_manager(project)
    manager_id = nil
    if !project.blank?
      manager = ProjectTeamMember.find(:first, :conditions => ['project_id =? and manager =?', 
                                                                project.project_id, 't'])
      manager_id = manager.person_id unless manager.blank?
    end                                                          
    return manager_id  
  end
end
