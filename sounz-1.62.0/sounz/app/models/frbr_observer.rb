class FrbrObserver < ActiveRecord::Observer
   observe Manifestation, Work, Expression, Role, Superwork, Event, Resource, Concept, Contributor
 
  include FrbrHelper
  
  # temporally disabling re-indexing of all associated objects
  # by changing after_ to non existent method
  def after_save_not(object)
    
    RAILS_DEFAULT_LOGGER.debug "DEBUG: FRBR_UPDATE AFTER SAVED:#{object}"
    associated_frbr_objects = get_associated_objects(object)
    RAILS_DEFAULT_LOGGER.debug "DEBUG: FRBR_UPDATE:#{associated_frbr_objects.uniq.length}"
    
	Work.index_objects(associated_frbr_objects.uniq)  
  
  end
  
  #
  # Accumulate all associated objects of the object to be destroyed
  #
  def before_destroy_not(object)
    
	RAILS_DEFAULT_LOGGER.debug "DEBUG: FRBR_UPDATE BEFORE DESTROY:#{object}"
	associated_frbr_objects = get_associated_objects(object)
	all_associated_frbr_objects = associated_frbr_objects
	associated_frbr_objects.each do |as|
	  all_associated_frbr_objects = all_associated_frbr_objects + FrbrHelper.associated_frbr_objects(as)
	end
	@@associated_frbr_objects = { object.id => all_associated_frbr_objects.uniq }	
	RAILS_DEFAULT_LOGGER.debug "DEBUG: FRBR_UPDATE:#{@@associated_frbr_objects[object.id].length}"
  
  end
  
  #
  # Re-index associated objects of the object that was destroyed
  #
  def after_destroy_not(object)
  	
  	RAILS_DEFAULT_LOGGER.debug "DEBUG: FRBR_UPDATE AFTER DESTROY:#{object}"
	associated_frbr_objects = @@associated_frbr_objects[object.id]
	@@associated_frbr_objects.delete(object.id)
	RAILS_DEFAULT_LOGGER.debug "DEBUG: FRBR_UPDATE:#{associated_frbr_objects.length}"
    
	Work.index_objects(associated_frbr_objects)  
  
  end  
  
 # ActiveRecord::Base.connection.tables.map {|t| t.classify}

private

  def get_associated_objects(object)
	frbr_object = object #The FRBR object is the object saved/to be destroyed, other than these special cases below
    frbr_object = object.role if object.class == Contributor     
	associated_frbr_objects = FrbrHelper.associated_frbr_objects(frbr_object)
	
	return associated_frbr_objects
  end

end