module SessionStorageHelper
    #------------------
  #- Obtain the current person from the session
  #------------------
  
  def get_person_from_session
    person_id = session[:selected_person_id]
    @person = Person.find(person_id)
  end
  
  #----------------------------------------------
  #- Clear the selected person from the session -
  #----------------------------------------------
  def clear_person_from_session
  session[:selected_person_id] = nil
  end
  
  #---------------------------------
  #- Set the person in the session -
  #---------------------------------
  def set_person_in_session(person)
  session[:selected_person_id] = person.id
  end
  
  #---------------------------------------
  #- Get the list of selected contacts -
  #---------------------------------------
  def get_contacts_in_finder
     return session[:contacts_in_finder]
  end
  
  
  #---------------------------------------
  #- Clear the list of selected contacts -
  #---------------------------------------
  def clear_contacts_in_finder
      session[:contacts_in_finder] = nil
  end
  
  
  #---------------------------------------
  #- Set the list of selected contacts -
  #---------------------------------------
  def set_contacts_in_finder(contacts)
      session[:contacts_in_finder] = contacts
  end
  
  
  #- Store the click back details for a popup - this consists of the following
  #<ul>
  #<li><i>source_div_to_update</i> - the div in the original form that is to be updated</li>
  #<li><i>controller_name</i> - the name of the controller whose action will replace this</li>
  #<li><i>action_name</i> - the name of the instigated action</li>
  #</ul>
  def set_popup_callback(target_controller, target_action, source_form_target_div)
   session[:popup_callback]={:source_div_to_update => source_form_target_div,
   :controller_name => target_controller,
   :action_name => target_action
   
   }
  end
  
  def clear_popup_callback
  session[:popup_callback] = nil
  end
end