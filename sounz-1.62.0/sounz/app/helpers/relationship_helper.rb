class RelationshipHelper
  
  
  
  #Example input
  # :venue, 69, :is_managed_by, :contributor, 100
  #FIXME - transactionalise this
  def self.add_frbr_relationship(type_a_name_symbol, type_a_id, relationship_symbol, type_b_name_symbol, type_b_id, login_id)
    relationship = Relationship.new()
  
    type_a=EntityType.find(:first, :conditions => ["entity_type = ?",type_a_name_symbol.to_s])
   type_b=EntityType.find(:first, :conditions => ["entity_type = ?",type_b_name_symbol.to_s])
    
   # puts "adding rels"
    relationship.updated_by = login_id
    relationship.entity_type_id=type_a.entity_type_id
    relationship.ent_entity_type_id=type_b.entity_type_id

    relationship_type = RelationshipType.find_by_symbol relationship_symbol

    valid = true
    if relationship.save
        invreltype=RelationshipType.find(relationship_type).inverse
        valid = relationship.make_inter_relationship(relationship.id,type_a,type_a_id,relationship_type.id)
        valid = valid && relationship.make_inter_relationship(relationship.id,type_b,type_b_id,invreltype)

        object=eval(Inflector.camelize(type_a.entity_type)+".find("+type_a_id.to_s+")")
        
        #Now its SOLR time - reindex both ends of the relationship
        instance_a = type_a.entity_type.camelize.constantize.find(type_a_id.to_s)
        instance_b = type_b.entity_type.camelize.constantize.find(type_b_id.to_s)
        
        if instance_a.respond_to?('solr_save')
            instance_a.send('save')
        end
        
        if instance_b.respond_to?('solr_save')
            instance_b.send('save')
        end
       
    else
        valid = false
    end
    
    return valid
  end
  
  
  #Delete an existing FRBR relationship - this invovles finding the relevant relationship id
  #and then thwacking it
  def self.delete_frbr_relationship(type_a_name_symbol, type_a_id, relationship_symbol, type_b_name_symbol, type_b_id)
  
    #find the relationship type
    type_a=EntityType.find(:first, :conditions => ["entity_type = ?",type_a_name_symbol.to_s])
    type_b=EntityType.find(:first, :conditions => ["entity_type = ?",type_b_name_symbol.to_s])
    relationship_type = RelationshipType.find_by_symbol relationship_symbol
    inverse_relationship_type_id = relationship_type.inverse

    #An example query looks like this
    #select relationship_id from relationships where relationship_id in (select relationship_id from 
    #work _relationships where work_id = 12447 and relationship_type_id = 24)
    
    type_a_string = type_a.entity_type.tableize.singularize #Use the object, if its nil then we have an invalid entity type
    relationships_table_a = type_a_string + "_relationships"
    
    type_b_string = type_b.entity_type.tableize.singularize
    relationships_table_b = type_b_string+"_relationships"
    
    #we need to get the items that are either side of the FRBR relationship that is being deleted, prior 
    #to reindexing
    
  #  relationship_a = relationships_table_a.camelize.singularize.constantize.find(:first, 
  #  :conditions =>["#{type_a_string}_id = ? and relationship_type_id",type_a_id,relationship_type.relationship_type_id])
    
    
    #select relationship_id from #{relationships_table_a} where "+
    #" #{type_a_string}_id = ?  and relationship_type_id = ?
    
    
    
    #There *SHOULD* be only one
    joining_relationship = Relationship.find(:first, :conditions => 
      ["relationship_id in (select relationship_id from #{relationships_table_a} where "+
      " #{type_a_string}_id = ?  and relationship_type_id = ?) and relationship_id in "+
      "(select relationship_id from #{relationships_table_b} where #{type_b_string}_id=? "+
      "and relationship_type_id = ?)",
       type_a_id, relationship_type.relationship_type_id, 
       type_b_id, inverse_relationship_type_id]
     )
    
    destroy_relationship_and_update_solr(joining_relationship)
  end
  
  
  
  # Find all the frbr relationships between 2 objects of a given type
  # e.g. find_frbr_relationships(:work, :12443, :is_composed_by )
  def self.find_frbr_relationships(type_a_name_symbol, type_a_id, relationship_symbol)
  
    #find the relationship type
    type_a=EntityType.find(:first, :conditions => ["entity_type = ?",type_a_name_symbol.to_s])
    relationship_type = RelationshipType.find_by_symbol relationship_symbol

    #An example query looks like this
    #select relationship_id from relationships where relationship_id in (select relationship_id from 
    #work _relationships where work_id = 12447 and relationship_type_id = 24)
    
    type_a_string = type_a.entity_type.tableize.singularize #Use the object, if its nil then we have an invalid entity type
    relationships_table = type_a_string + "_relationships"
    return Relationship.find(:all, :conditions => 
      ["relationship_id in (select relationship_id from #{relationships_table} where #{type_a_string}_id = ? "+
      " and relationship_type_id = ?)", type_a_id, relationship_type.relationship_type_id]
     )

  end
  
  
  #Delete all the frbr relationships associated with a source object, where hte relationship type is also provided
  def self.delete_all_frbr_relationships(type_a_name_symbol, type_a_id, relationship_symbol)
    relationships = find_frbr_relationships(type_a_name_symbol, type_a_id, relationship_symbol)
    for relationship in relationships
      destroy_relationship_and_update_solr(relationship)
    end
  end
  
  

  #Delete a relationship and update the SOLR ends as the related objects are detached
  def self.destroy_relationship_and_update_solr(relationship)
    if !relationship.blank?
      #FIXME - check for distinction instance
      type_a = EntityType.find(relationship.entity_type_id)
      type_b = EntityType.find(relationship.ent_entity_type_id)
      RAILS_DEFAULT_LOGGER.debug type_a
      RAILS_DEFAULT_LOGGER.debug type_b
      
      
      type_a_string = type_a.entity_type.tableize.singularize #Use the object, if its nil then we have an invalid entity type
      relationships_table_a = type_a_string + "_relationship"
      #relationships_table_a = "distinction_relationship" if type_a_string == "distinction_instance"
      
      type_a_rel = relationships_table_a.camelize.constantize.find(:first,
       :conditions => ["relationship_id = ?", relationship.relationship_id])
      
      RAILS_DEFAULT_LOGGER.debug "REL FOR TYPE A:#{type_a_rel}"

      type_b_string = type_b.entity_type.tableize.singularize
      relationships_table_b = type_b_string+"_relationship"
      #relationships_table_b = "distinction_relationship" if type_b_string == "distinction_instance"
      
       type_b_rel = relationships_table_b.camelize.constantize.find(:first,
         :conditions => ["relationship_id = ?", relationship.relationship_id])
      
    
      type_a_object = type_a_rel.send(type_a_string)
      type_b_object = type_b_rel.send(type_b_string)
      
      RAILS_DEFAULT_LOGGER.debug "TYPE A OBJ:#{type_a_object}"
      RAILS_DEFAULT_LOGGER.debug "TYPE B OBJ:#{type_b_object}"
      
      relationship.destroy #Do this prior to solr saving
            
      if type_a_object.respond_to?('solr_save')
          type_a_object.send('save')
      end

      if type_b_object.respond_to?('solr_save')
          type_b_object.send('save')
      end
      

    end
  end
  
  # - Create copy of a relationship of one object for another object of the same class
  #   WR#50282 - cloning Expression/Event
  def self.copy_frbr_relationships(object, object_relationship, login)
  	  success = true
	  
	  type_a_name = EntityType.find(object_relationship.relationship.entity_type_id).entity_type
	  #RAILS_DEFAULT_LOGGER.debug "DEBUG: type_a_name #{type_a_name}"
	  
	  type_b_name = EntityType.find(object_relationship.relationship.ent_entity_type_id).entity_type
	  #RAILS_DEFAULT_LOGGER.debug "DEBUG: type_b_name #{type_b_name}"
	  
	  if type_a_name.camelize.constantize == object.class
	  	#RAILS_DEFAULT_LOGGER.debug "DEBUG: object.class #{object.class}"
		type_a_id = object.id
		#RAILS_DEFAULT_LOGGER.debug "DEBUG: type_a_id #{type_a_id}"
		type_b_id = (type_b_name.camelize.to_s + "Relationship").constantize.find(:first, :conditions => ['relationship_id =?', object_relationship.relationship_id]).send(type_b_name +'_id')
	    #RAILS_DEFAULT_LOGGER.debug "DEBUG: type_b_id #{type_b_id}"
	  else
	  	type_a_id = (type_a_name.camelize.to_s + "Relationship").constantize.find(:first, :conditions => ['relationship_id =?', object_relationship.relationship_id]).send(type_a_name +'_id')
	    #RAILS_DEFAULT_LOGGER.debug "DEBUG: type_a_id #{type_a_id}"
		type_b_id = object.id
		#RAILS_DEFAULT_LOGGER.debug "DEBUG: type_b_id #{type_b_id}"
	  end
	  
	  type_a_relationship = (type_a_name.camelize.to_s + "Relationship").constantize.find(:first, :conditions => ['relationship_id =?', object_relationship.relationship_id])
	  relationship_symbol = type_a_relationship.relationship_type.relationship_type_desc.strip.downcase.gsub(' ', '_').to_sym
	  
	  # first, cases for hard relationships - exceptions  
	  if object.class == Expression
	  	# WR#50282 - Scilla's note dated 11:20 07-04-2008
		if ['is_exhibited_by','is_improvised_by','is_performed_by'].include? relationship_symbol.to_s
	  	  success = false if !add_frbr_relationship(type_a_name.to_sym, type_a_id, relationship_symbol, type_b_name.to_sym, type_b_id, login.login_id)
	  	end
	  		
	  elsif object.class == Event
	  	# WR#50282 - Scilla's note dated 14:24 03-04-2008
	  	if ['has_as_its_genre','has_as_its_theme','includes','is_held_at','is_included_in','is_influenced_by','is_presented_by'].include? relationship_symbol.to_s
	      success = false if !add_frbr_relationship(type_a_name.to_sym, type_a_id, relationship_symbol, type_b_name.to_sym, type_b_id, login.login_id)
	  	end
      else
      	success = false if !add_frbr_relationship(type_a_name.to_sym, type_a_id, relationship_symbol, type_b_name.to_sym, type_b_id, login.login_id)
	  end
	  
	  return success
  
  end
  
end