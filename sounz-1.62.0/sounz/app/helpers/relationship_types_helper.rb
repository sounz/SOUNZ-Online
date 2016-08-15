module RelationshipTypesHelper
  
  
  
  
   def self.check_valid_relationships_exist(entity_type_symbol)

      entity_type = EntityType.find_by_symbol(entity_type_symbol)
      #puts "===="
      #puts entity_type.entity_type.to_s
      #puts "===="
      valid_eers = ValidEntityEntityRelationship.find(:all, :conditions => ["entity_type_from_id  = ?",entity_type.id])

      instance_class = Inflector.constantize(entity_type_symbol.to_s.capitalize)
      instance = instance_class.send('find', :first)
     
      
      #puts "The entity type *#{entity_type.entity_type}* is being checked with instance #{instance}"
      for veer in valid_eers
        relationship_type = RelationshipType.find(veer.relationship_type_id)
        entity_type_to = EntityType.find(veer.entity_type_to_id)
        
        ruby_method_name = veer.ruby_method_name
        #puts "CHECKING: #{ruby_method_name}"
        
        if !instance.respond_to?(ruby_method_name)
          #puts "#{entity_type_symbol} did not respond to valid method #{ruby_method_name}"
        end
        ##puts veer.ruby_method_name+":\t"+entity_type.entity_type+' ' +relationship_type.relationship_type_desc+" "+entity_type_to.entity_type
      end



      return valid_eers.length
   end
   
   
  
  #Provide a list of all the relationship types that are valid
  def self.show_valid_relationships_for_all_types
    show_valid_relationship_types_for(:work)

 #   show_valid_relationship_types_for(:expression)
 #   show_valid_relationship_types_for(:venue)
 #   show_valid_relationship_types_for(:event)
 #   show_valid_relationship_types_for(:superwork)
 #   show_valid_relationship_types_for(:distinction_instance)
 #   show_valid_relationship_types_for(:concept)
 #   show_valid_relationship_types_for(:manifestation)
 #   show_valid_relationship_types_for(:resource)
 #   show_valid_relationship_types_for(:item) 

  end
  
  
  
  #This returns a list of all the valid relationship types for a given entity type.  For example
  #show_valid_relationship_types_for(:work)
  def self.show_valid_relationship_types_for(entity_type_symbol)
     Work.logger.debug("ENTITY TYPE SYMBOL #{entity_type_symbol}")
     #special case
     #if entity_type_symbol.to_s=='distinction'
     #  entity_type_symbol='distinction_instance'.to_sym
     #end
     entity_type = EntityType.find_by_symbol(entity_type_symbol)
     Work.logger.debug("ENTITY_TYPE #{entity_type}")
     valid_eers = ValidEntityEntityRelationship.find(:all, :conditions => ["entity_type_from_id  = ?",entity_type.entity_type_id])
     
     for veer in valid_eers
       relationship_type = RelationshipType.find(veer.relationship_type_id)
       entity_type_to = EntityType.find(veer.entity_type_to_id)
       
      # puts veer.ruby_method_name+":\t"+entity_type.entity_type+' ' +relationship_type.relationship_type_desc+" "+entity_type_to.entity_type
     end
          
     for veer in valid_eers
       relationship_type = RelationshipType.find(veer.relationship_type_id)
       inverse_relationship_type = RelationshipType.find(relationship_type.inverse)
       inverse_veer = ValidEntityEntityRelationship.find(:first, :conditions =>
        ["relationship_type_id = ? and entity_type_from_id = ? and entity_type_to_id = ?",
          inverse_relationship_type.relationship_type_id, veer.entity_type_to_id, veer.entity_type_from_id])
       entity_type_to = EntityType.find(veer.entity_type_to_id)
       #puts  inverse_veer.ruby_method_name+":\t"+entity_type_to.entity_type+' ' +inverse_relationship_type.relationship_type_desc+" "+entity_type.entity_type
     end
      
     return valid_eers
  end
  
  
  
  #Find out which entity types a given entity type can match to, and return them in an array
  def self.show_valid_entity_to_types(entity_type_symbol)
    entity_to_ids = RelationshipTypesHelper.show_valid_relationship_types_for(entity_type_symbol).map{|v|v.entity_type_to_id}.uniq
    entities = EntityType.find(:all, :conditions => ["entity_type_id in (?)", entity_to_ids])
    entities
  end
  
  
  
  #Find out which entity types a given entity type can match to for a given relationship, and return them in
  #an array.
  def self.show_relationship_types_for(entity_type_symbol)
    relationship_type_ids =  RelationshipTypesHelper.show_valid_relationship_types_for(entity_type_symbol).map{|v|v.relationship_type_id}.uniq
    relationship_types = RelationshipType.find(:all, 
      :conditions => ["relationship_type_id in (?)", relationship_type_ids],
      :order => 'relationship_type_desc')
    if relationship_types == nil
      relationship_types=[]
    end
    relationship_types
  end
  
  
  #Show the valid target types for a given entity from type and a relationship id
  def self.show_valid_target_entity_types_for(entity_type_symbol, relationship_type_id)
    veers = show_valid_relationship_types_for(entity_type_symbol)
    result = []
    for veer in veers
      if veer.relationship_type_id == relationship_type_id
        result << veer
      end
    end
    result.map {|r| r.entity_type_to_id  }
  end
  
  
  
#  def self.populate_entity_relationships_table

 def self.populate  
    #Do the common ones
    distinctions
    concepts
    
    #Works - coordinates refer to patchwork quilt spreadsheet
    #B4, C2
    add_restriction(:work, :is_child_of, :superwork, ["parent_superworks", "work_children"], nil, false)
    add_restriction(:work, :is_evidence_of, :superwork, ["superwork_evidences", "works_evidenced"])
    add_restriction(:work, :draws_source_material_from, :superwork,  ["superworks_from_whom_source_material_is_drawn", "works_to_whom_source_material_is_provided"])
    add_restriction(:work, :is_influenced_by, :superwork, ["superwork_influences", "influences_these_works"])
    
    #C4
    add_restriction(:work, :draws_source_material_from, :work, ["works_from_whom_source_material_is_drawn", "works_to_whom_source_material_is_provided"])
    add_restriction(:work, :is_influenced_by, :work, ["work_influences", "influences_these_works"])
    
    #D4, C5
    #FIXME: Scilla, missing has parts
    
    #AKA performances
    add_restriction(:work, :is_realised_through, :expression, ["realisations", "works_realised_through"], nil, false)
    add_restriction(:expression, :is_part_of, :work, ["parent_work", "expression_parts"]) # CHECK
    
    
    add_restriction(:work, :is_described_by, :resource, ["descriptive_resources", "works_described"])
    add_restriction(:superwork, :is_described_by, :resource, ["descriptive_resources", "superworks_described"])
    add_restriction(:expression, :is_described_by, :resource, ["descriptive_resources", "expressions_described"])
    add_restriction(:manifestation, :is_described_by, :resource, ["descriptive_resources", "manifestations_described"])
    add_restriction(:manifestation, :is_documented_by, :resource, ["documentative_resources", "manifestations_described"])
     
    add_restriction(:work, :is_commissioned_for, :event, ["event_commissions", "commissioned_works"])
    
    #role
    #B13, L3
    add_restriction(:role, :conceives, :superwork, ["conceptions", "conceived_superworks"])
    
    #puts "== DOING roleS WITH WORK =="
    #C13, L4
    add_restriction(:role, :composes, :work, ["compositions", "composers"], nil, false)
    add_restriction(:role, :improvises, :work, ["improvised_works", "improvisors"])
    add_restriction(:role, :writes, :work, ["writings", "writers"])
    add_restriction(:role, :arranges, :work, ["arrangements", "arrangers"])
    add_restriction(:role, :creates, :work, ["creations", "creaters"])
    add_restriction(:role, :commissions, :work, ["commissioned_works", "commissioners"])
    add_restriction(:role, :selects, :work, ["selected_works", "selectors"])
    add_restriction(:role, :funds, :work, ["funded_works", "funder"])
    
    #puts "== DOING roleS WITH EXPRESSIONS =="
    #D13, L5
    add_restriction(:role, :performs, :expression, ["performances", "performers"])
    add_restriction(:role, :exhibits, :expression, ["exhibitions", "exhibitors"])
    add_restriction(:role, :presents, :expression, ["presentations", "presenters"])
    add_restriction(:role, :improvises, :expression, ["improvised_expressions", "improvisors"])
    add_restriction(:role, :broadcasts, :expression, ["broadcasted_expressions", "broadcasters"])
    add_restriction(:role, :notates, :expression, ["notations", "notators"])
    add_restriction(:role, :compiles, :expression, ["compilations", "compilers"])
    
    #puts "==== roleS / MANIFESTATIONS ===="
    #E13, L6
     add_restriction(:role, :records, :manifestation, ["recordings", "recorders"])
     add_restriction(:role, :publishes, :manifestation, ["published_manifestations", "publishers"])
     add_restriction(:role, :licenses, :manifestation, ["licensed_manifestations", "licensers"])
     add_restriction(:role, :releases, :manifestation, ["released_manifestations", "releasers"])
     add_restriction(:role, :sells, :manifestation, ["sold_manifestations", "sellers"])
     
     #G13, L8
     add_restriction(:role, :is_described_by, :resource, ["descriptive_resource", "roles_described"]) #MISMATCH ON SPREADSHEET
     add_restriction(:role, :writes, :resource, ["written_resources", "writers"])
     add_restriction(:role, :records, :resource, ["recorded_resources", "recorders"])
     add_restriction(:role, :publishes, :resource, ["published_resources", "publishers"])
     add_restriction(:role, :licenses, :resource, ["licensed_resources", "licensers"])
     add_restriction(:role, :releases, :resource, ["released_resources", "releasers"])
     add_restriction(:role, :sells, :resource, ["sold_resources", "sellers"])
     
     #puts "=== role / EVENTS ==="
     #H13, L9
     add_restriction(:role, :presents, :event, ["presented_events", "presenters"])
     add_restriction(:role, :performs, :event, ["performed_events", "performers"])
     add_restriction(:role, :funds, :event, ["funded_events", "funders"])
     add_restriction(:role, :broadcasts, :event, ["broadcasted_events", "broadcasters"])
     add_restriction(:role, :records, :event, ["recorded_events", "recorders"])
     add_restriction(:role, :sells, :event, ["sold_events", "sellers"])
     add_restriction(:role, :manages, :event, ["managed_events", "managers"])
     
     #puts "== roleS / VENUES =="
     add_restriction(:role, :manages, :venue, ["managed_venues", "managers"])
     add_restriction(:role, :owns, :venue, ["owned_venues", "owners"])
     add_restriction(:role, :performs_at, :venue, ["performed_venues", "performers"])
     
     #FIXME Error in spreadsheet
     add_restriction(:role, :identifies_with, :concept, ["concepts_identifies_with", "roles_who_identify"])
     add_restriction(:role, :is_influenced_by, :concept, ["influential_concepts", "roles_influenced"])
     add_restriction(:role, :writes_according_to, :concept, ["writes_according_to", "writings_affected_by"])#
     add_restriction(:role, :performs_according_to, :concept, ["performs_according_to", "performance_affected_by"])
    
    
        
     add_restriction(:expression, :is_embodied_in, :manifestation, ["embodied_manifestations", "expressions_embodied"], nil,false)
    
     
     #puts "== role / DISTINCTIONS =="
     add_restriction(:role, :presents, :distinction_instance, ["presented_distinctions", "presenters"])
     add_restriction(:role, :funds_or_sponsors, :distinction_instance, ["funded_or_sponsored_distinctions", "distinctions_funded_or_awarded"])
     add_restriction(:role, :administers, :distinction_instance, ["presented_distinctions", "presenters"])
     
     
  
     #puts "=== DISTINCTIONS / CONCEPTS === "
     add_restriction(:distinction_instance, :has_as_its_genre, :concept, ["concept_genres", "genred_distinctions"])
     
     #puts "=== EVENTS ==="
     add_restriction(:event, :has_presented, :expression, ["presented_expressions","events_expressed_at"])
     add_restriction(:event, :has_happening, :expression, ["happening_expressions","events_happening_at"], nil, false)
     add_restriction(:event, :has_commissioned, :expression, ["commissioned_expressions","events_commissioned_at"])
     
     add_restriction(:event, :launches, :manifestation, ["manifestations_launched","events_launched_at"])
     add_restriction(:event, :launches, :resource, ["resources_launched","events_launched_at"])
     
     
     add_restriction(:venue, :presents, :event, ["presented_events","venues_presented_at"])
     add_restriction(:venue, :holds, :event, ["held_events","venues_held_at"],nil, false)
     
     
     #TODO leave identity to last
     
      
     add_restriction(:manifestation, :is_the_recording_of, :manifestation, ["original_manifestation_for_recording", "recordings_as_manifestations"])
     add_restriction(:manifestation, :is_the_publication_of, :manifestation, ["original_manifestation_for_publication", "publications_as_manifestations"])

     add_restriction(:manifestation, :is_related_to, :manifestation, ["related_manifestations",nil])
     add_restriction(:resource, :is_related_to, :resource, ["related_resources",nil])
     add_restriction(:event, :is_related_to, :event, ["related_events",nil])
     add_restriction(:venue, :is_related_to, :venue, ["related_resources",nil])
     add_restriction(:concept, :is_related_to, :concept, ["related_concepts",nil])

     add_restriction(:role, :works_with, :role, ["roles_working_with","roles_worked_with_by"])
     add_restriction(:role, :commissions, :role, ["roles_commissioned",nil])
     add_restriction(:role, :funds, :role, ["roles_funded",nil])
     
      ####  NEED SCILLA DECISION    add_restriction(:superwork, :is_conceived_within, :concept, ["concepts_conceived_within", "superworks_conceived_in_this_concept"])
     
       
     
      add_restriction(:superwork, :draws_source_material_from, :superwork, ["superworks_from_whom_source_material_is_drawn", "superworks_to_whom_source_material_is_provided"])
      
      add_restriction(:superwork, :is_influenced_by, :concept, ["influential_concepts", "influenced_superworks"])
      add_restriction(:superwork, :is_inspired_by, :concept, ["inspirational_concepts", "inspired_superworks"])
     
      add_restriction(:superwork, :is_influenced_by, :superwork, ["superwork_influences", "superworks_influenced"])
     

      #Dedications - scilla email, June 5, 0839
      add_restriction(:work, :is_dedicated_to, :role, ["roles_dedicated", "works_dedicated"])
      add_restriction(:manifestation, :is_dedicated_to, :role, ["roles_dedicated", "manifestations_dedicated"])
      add_restriction(:resource, :is_dedicated_to, :role, ["roles_dedicated", "resources_dedicated"])
  
      #Events, such as tours require sub events
      add_restriction(:event, :includes, :event, ["included_events", "is_included_in_these_events"])
      
      #Venues, idea of one venue being linked to another
      add_restriction(:venue, :things_in_common_with, :venue, ["venues_has_commonalities_with", "venues_things_in_common_with"])
  
      #Work orchestration and arrangement
      add_restriction(:work, :is_arrangement_of, :work, ["is_arrangment_of","is_arranged_as"])
      add_restriction(:work, :is_orchestration_of, :work, ["is_orchestration_of","is_orchestrated_as"])
  end
  
  
  
  
  def self.distinctions
    #puts "DOING DISTINCTIONS*******"
    for thing_type in [:work, :expression, :manifestation, :resource, :event, :venue, :role]
      #puts thing_type
      add_restriction(thing_type, :receives, :distinction_instance, ["distinctions", thing_type.to_s+"s_awarded"])
    end
  end
  
  def self.concepts
    for thing_type in [:work, :manifestation, :resource, :event]
      #puts thing_type
      add_restriction(thing_type, :is_influenced_by, :concept, ["concept_influences", "influenced_"+thing_type.to_s+"s"])
      add_restriction(thing_type, :has_as_its_theme, :concept, ["concept_themes", "themed_"+thing_type.to_s+"s"])
      add_restriction(thing_type, :has_as_its_genre, :concept, ["concept_genres", "genred_"+thing_type.to_s+"s"]) 
    end
  end
  
  
  def self.add_restriction(entity_type_from_sym, relationship_type_sym, entity_type_to_sym, ruby_method_names,
     page_titles = nil, editable=true)
    relationship_type = RelationshipType.find_by_symbol(relationship_type_sym)
    entity_type_from = EntityType.find_by_symbol(entity_type_from_sym)
    entity_type_to = EntityType.find_by_symbol(entity_type_to_sym)
    
    #puts "Entity type from is #{entity_type_from.entity_type}"
    #puts "Entity type to is #{entity_type_to.entity_type}"
    
    #If the page titles are not specified it is assumped they are they same as the method names
    if page_titles == nil
      page_titles = ruby_method_names.clone
      for i in 0..page_titles.length
        x = Inflector.titleize(page_titles[i])
        page_titles[i] = x
      end
    end
    
  #  #puts "Page titles are #{page_titles}"
    
    veer1 = ValidEntityEntityRelationship::new
    veer1.relationship_type_id = relationship_type.relationship_type_id
    veer1.entity_type_from_id = entity_type_from.entity_type_id
    veer1.entity_type_to_id = entity_type_to.entity_type_id
    veer1.ruby_method_name = ruby_method_names[0]
    veer1.user_maintainable = editable
    veer1.page_title = page_titles[0]
    
#    #puts veer1.to_yaml
    
    veer1.save
    
    ##puts "** veer 1 saved **"
    inverse_method = ruby_method_names[1]
    if !inverse_method.blank?
      #Do the inverse
      veer2 = ValidEntityEntityRelationship::new
      veer2.relationship_type_id = relationship_type.inverse
      veer2.entity_type_to_id = entity_type_from.entity_type_id
      veer2.entity_type_from_id = entity_type_to.entity_type_id
      veer2.ruby_method_name = inverse_method
      veer2.page_title = page_titles[1]
      veer2.user_maintainable = editable
      veer2.save
    end
    
    
  end
  
  
  
  
  def self.test
    c= role.find(1001)
    #puts "Number of composition objects is #{c.compositions.length}"
    #puts "NUmber of compositions method returns #{c.number_of_compositions}"
    
    #puts "Number of creations objects is #{c.creations.length}"
    #puts "NUmber of creations method returns #{c.number_of_creations}"
  end
  
  
  def self.test_rels
    for entity_from_sym in [:work, :venue]
      veers = show_valid_relationship_types_for(entity_from_sym)
      rel_ids = veers.map{|v| v.relationship_type_id}
      for relationship_type_id in rel_ids
        puts RelationshipType.find(relationship_type_id).relationship_type_desc
        valid_target_entity_ids = RelationshipTypesHelper.show_valid_target_entity_types_for(entity_from_sym, relationship_type_id)
        valid_target_entities = valid_target_entity_ids.map{|e_id| EntityType.find(e_id)}
        puts valid_target_entities.length.to_s+":"+valid_target_entities.map{|e|e.entity_type}.join('*')
        puts
      end
    end
  end


end
