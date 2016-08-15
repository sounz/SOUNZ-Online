module FrbrHelper
   include ActionController::Pagination

unloadable



  #Note: due to the unloadable constraint above, we cannot use actual class objects here
  FRBR_CLASS_NAMES = ['Manifestation', 'Work', 'Expression', 'Role', 'Superwork', 'Event',
     'Resource', 'Concept']

  #FIXME - sort out Distinction / DistinctionInstance


  # A generic FRBR find to be called from methods inside FRBR objects.  An example of this would be
  # generic_frbr_find(:works, :is_composed_by, :contributors)
  def find_related_frbr_objects_by_class_and_id( entity_type1, entity_type1_id, relationship_type_symbol, entity_type2_plural )
    #Take the plural and remove the s? from the end
    x = entity_type2_plural.to_s
    entity_type2 = x[6, x.length-8]

    lower_case_relationship_type_symbol = relationship_type_symbol.to_s.downcase.to_sym
    perform_rel_id = RelationshipType.find_by_symbol(lower_case_relationship_type_symbol).relationship_type_id


    entity1_relationship_classname = Inflector.camelize(entity_type1.to_s)+"Relationship"
    entity2_relationship_classname = Inflector.camelize(entity_type2.to_s)+"Relationship"

    entity1_class = entity1_relationship_classname.constantize
    entity2_class = entity2_relationship_classname.constantize

    sql = entity_type1.tableize.singularize+"_id = ? and relationship_type_id = ?"
    wrs = entity1_class.find(:all,
     :conditions => [sql,entity_type1_id, perform_rel_id])
  
    #get the relevant relationship ids
    rel_ids = wrs.map{|wr| wr.relationship_id}
    
    #Find the inverse relationship
    crs = entity2_class.find(:all, :conditions => ["relationship_id in (?)",rel_ids])

    #In the case of when a FRBR rel maps back to an object of the same time you need to remove the
    #original objects.  The problem was raised in WR50413
    for wr in wrs
      crs.delete(wr)
    end

    result = crs.map{|cr| cr.send(entity_type2.to_s)}
    sort_field = SORT_FIELDS[entity_type2.to_sym]
    if entity_type2.to_sym == :distinction_instance
      sorted_result = result.sort_by{|object| [object.distinction.award_name.downcase]}
    elsif entity_type2.to_sym == :expression
    	sorted_result = result.sort_by{|object| [object.work.work_title.downcase]}
    elsif entity_type2.to_sym == :event
   	 sorted_result = result.sort_by{|object| -object.event_start.to_i}
    else
   	 sorted_result = result.sort_by{|object| [object.send(sort_field).downcase]}
    end

    return sorted_result
  end


  SORT_FIELDS = {
    :venue => :venue_name,
    #:expression => :expression_title,
    :concept => :concept_name,
    :manifestation => :manifestation_title,
    :work => :work_title,
    :superwork => :superwork_title,
    :resource => :resource_title,
    :event => :event_title,
    :distinction => :award_name,
    #:contributor => :description,
    :role => :contributor_description
  }


  #As method is mixed in we have direct access to the object itself
  def find_related_frbr_objects( relationship_type_symbol, entity_type2_plural)
    logger.debug "+++++++++++++++++++++"
    logger.debug "FIND RELATATED FRBR OBJECTS: #{relationship_type_symbol}, #{entity_type2_plural}"
    class_name = self.class.to_s
    entity_id = self.id

    logger.debug "Seeking the following: #{class_name} of #{id} #{relationship_type_symbol} #{entity_type2_plural}"

    result = find_related_frbr_objects_by_class_and_id(class_name, entity_id, relationship_type_symbol, entity_type2_plural)
    logger.debug "Done seek"
    logger.debug "/FIND RELATATED FRBR OBJECTS"
    result
  end

=begin
select * from contributor_relationships,relationships  where contributor_id = 1024
 and relationship_type_id = 35 and
 relationships.relationship_id = contributor_relationships.relationship_id and
  entity_type='manifestation';
=end

  # Count by FRBR does an SQL query to find out how many of the current object are related to say works
  # or venues, constrained by a given relationship
  def count_by_frbr(login, relationship_type_symbol, entity_type2_plural)
    logger.debug "COUNT_BY_FRBR"
    logger.debug "++++Relationship type symbol is #{relationship_type_symbol}"
    relationship_type_id = RelationshipType.find_by_symbol(relationship_type_symbol).relationship_type_id
    x = entity_type2_plural.to_s
    entity_type_1 = self.class.to_s
    entity_type_1 = Inflector.tableize(entity_type_1)
    entity_type_1 = Inflector.singularize(entity_type_1)
    entity_type_2 = x[9,x.length-11]

=begin
    logger.debug "Self class is #{self.class}"
    logger.debug "E1, E2 = #{entity_type_1}, #{entity_type_2}"

    entity1_relationship_classname = Inflector.camelize(entity_type_1.to_s)+"Relationship"
      sql = entity_type_1.to_s+"_id = ? and relationship_type_id = ?"
      logger.debug "FRBR FIND SQL is " + sql.to_s
entity1_relationship_classname = "DistinctionRelationship" if entity1_relationship_classname == "DistinctionInstanceRelationship"


    entity1_class = entity1_relationship_classname.constantize

    #FIXME - make more efficient
     wrs = entity1_class.find(:all,
     :conditions => [sql,self.id, relationship_type_id])


     #select * from work_relationships where relationship_id in (select relationship_id from concept_relationships
     # where concept_id = 540);
=end
     #c = Concept.find(540); c.number_of_influenced_works
     sql = "select count(*) from #{entity_type_2}_relationships inner join #{entity_type_2}s using (#{entity_type_2}_id) where relationship_id in "
     sql << "(select relationship_id from #{entity_type_1}_relationships where #{entity_type_1}_id = #{self.id} "+
     "and relationship_type_id = #{relationship_type_id})"

     # check if a user is allowed to see those relationships?
     model = entity_type_2.camelize.constantize.send('new')
     if !PrivilegesHelper.has_permission?(login, 'CAN_VIEW_TAP') && model.respond_to?("status_id")
       sql << " and status_id =#{Status::PUBLISHED.status_id}"
     end

     #Avoid counting the original relationships in the self referential case
     if entity_type_1 == entity_type_2
       sql << " and (#{entity_type_1}_id != #{self.id})"
     end

     #sql.gsub!("distinction_instance_relationships", "distinction_relationships")
     logger.debug "FRBR HELPER: sql #{sql}"
     sql_result = ActiveRecord::Base.connection.select_one(sql)
     value= sql_result['count']

     return value.to_i #wrs.length
  end



  def self.find_frbr_object(params)
    type=Inflector.camelize(params[:type])
    object=eval(type+".find("+params["object_id"]+")")
  end


  #Check if a given class is a FRBR object
  def self.is_frbr_object?(model_class)
    return FRBR_CLASS_NAMES.include?(model_class.to_s) #DDefinied in environment.rb
  end

  #w = Work.find(:first); FrbrHelper.reindex_associated_frbr_objects(w)

  #Find *all* of the object associated with a given frbr entity
  #This does the following
  # * gets a list of the relevant relationships from the frbr objects relationship table
  # * iterates through all the other frbr object rel tables looking for the other half of the rel,
  #   and the associated object
  def self.associated_frbr_objects(frbr_object)
    prefix = convert_frbr_class_to_table_name_prefix(frbr_object)
    relationship_table = prefix+'_relationships'
    model_for_relationship_table = relationship_table.singularize.camelize.constantize

    #ids are prefixed, e.g. work_id
    frbr_id = frbr_object.send(prefix+"_id")
      puts "FRBR_UPDATE: rel table to search is #{relationship_table}"
    conditions = "#{prefix}_id = ?"
    puts "#{model_for_relationship_table}.find(:all, :conditions => [#{conditions}, #{frbr_id}])"
    source_relationships = model_for_relationship_table.find(:all, :conditions => [conditions, frbr_id])
    rel_ids = []
    source_relationships.map{|wr| rel_ids << wr.relationship_id}

    associated_objects = []
    for destination_object_class_name in FRBR_CLASS_NAMES
      puts "CHECKING:#{destination_object_class_name}"
      relationship_table_name = destination_object_class_name.tableize.singularize+"_relationships"
      destination_object_class_small = destination_object_class_name.to_s.downcase

      #get the actual relationships
      conditions = "relationship_id in ?"
      relationship_table_class = relationship_table_name.singularize.camelize.constantize

      #get the objects
      relationships_to_the_source = relationship_table_class.find(:all, :conditions => ["relationship_id in (?)", rel_ids])
      relationships_to_the_source.map{|r| associated_objects << r.send(destination_object_class_small)}
    end

    associated_objects

  end


  def self.convert_frbr_class_to_table_name_prefix(frbr_object)
    frbr_object.class.to_s.downcase
  end

  def self.convert_frbr_table_name_to_class(frbr_object)
    #frbr_object.class.to_s.lowercase
  end


  #Get the page title for a ruby method - this is used to display the links at the bottom of FRBR objects.
  #As an example this could be Compositions (40), Writings(2) etc
  def self.get_page_title_for_method(method_name)
    title = "UNDEFINED"
    veer = ValidEntityEntityRelationship.find(:first, :conditions => ["ruby_method_name=?",method_name])
    title = veer.page_title if !veer.blank?
    title
  end








end

