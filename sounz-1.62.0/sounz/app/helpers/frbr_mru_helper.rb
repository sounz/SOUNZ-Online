module FrbrMruHelper
  
   protected
   
   #Search for the most recently edited entity type instances, given a login
   #To override the default amount of 10, passed amount=N in the method call
   def find_mru_entity_types(entity_type, login, amount = 10, already_chosen_ids=[])
     klass = Inflector.constantize(entity_type.entity_type.to_s.camelize)
     
     #This is the case where we have no previously chosen objects,e.g. expressions of a manifestation
     if already_chosen_ids.blank?
       @mru_frbr_objects = klass.find(:all, :limit => amount, 
  #Not useful due to batch upload user        :conditions => ["updated_by = ?", login.login_id],
          :order => 'updated_at desc'
       )
     
     #we need to append a not in clause
     else
       thing_id = entity_type.entity_type + "_id"
       @mru_frbr_objects = klass.find(:all, :limit => amount, 
           :conditions => ["#{thing_id} not in (?)",  already_chosen_ids],
           :order => 'updated_at desc'
        )
     end
     
   end
   
end
