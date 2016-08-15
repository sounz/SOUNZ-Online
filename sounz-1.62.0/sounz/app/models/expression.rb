class Expression < ActiveRecord::Base
  include FrbrHelper
  include FrbrMethodsExpression
  
	set_primary_key "expression_id"
	set_sequence_name "expressions_expression_id_seq" 
  
  belongs_to :status
	has_many :expression_relationships
	has_many :relationships, 
	         :through => :expression_relationships,
	         :select => "expression_relationships.relationship_type_id, relationships.*",
	         :dependent => :destroy
	         
  belongs_to :work
  belongs_to :mode
  
  #FIXME: Do we wish to destroy the manifestations?  They can exist stand alone
  has_many :expression_manifestations, :dependent => :destroy
  has_many :manifestations, :through => :expression_manifestations
  
  has_many :expression_access_rights
  has_many :access_rights, :through => :expression_access_rights
  
  has_many :expression_languages, :dependent => :destroy
  has_and_belongs_to_many :languages, :join_table => :expression_languages
  
  validates_presence_of :work, :expression_title, :status, :mode, :updated_by
  validates_associated :work, :status, :mode
  
  validates_format_of :duration, 
					  :if => Proc.new {|expression| ( expression.duration != nil) },
					  :with => DURATION_REGEX,
					  :message=> "must be of the format |number|:|00 to 59|:|00 to 59|"  
 
  #Updated by relationship 

  validates_presence_of :login_updated_by
  #validates_associated :login_updated_by

  belongs_to :login_updated_by, 
            :class_name => 'Login',
            :foreign_key => :updated_by

  
            validates_inclusion_of :players_count, 
            :in => 0..50,
            :allow_nil => true,
            :message => "is not between 0 and 50",
            :if => ModelHelper.only_check_if_not_empty( :players_count)
            
            validates_numericality_of :players_count,
            :allow_nil => true,
            :only_integer => true,
            :if => ModelHelper.only_check_if_not_empty( :players_count)
            
            
  
  validates_length_of :expression_title, :in => 2..100,
  :allow_nil => false,
  :message => "is not between 2 and 100 chars"
  
  
  acts_as_solr  :fields =>[
  	                       :frbr_ui_desc_for_solr,
						   :title_for_solr,
						   {:title_as_string_for_solr => :string},
						   :mode_for_solr,
						   :edition_for_solr,
						   {:expression_start_for_solr => :string },
						   {:expression_finish_for_solr => :string },
						   :premiere_status_for_solr,
						   :partial_expression_for_solr,
						   :has_manifestation_for_solr,
						   :players_count_for_solr,
						   :restriction_for_solr,
						   :general_note_for_solr,
						   :internal_note_for_solr,
						   :relationships_for_solr,
						   :relationship_type_ids_for_solr,
						   :status_for_solr
                          ]  
  
  # methods for solr indexing
  def frbr_ui_desc_for_solr
    return FinderHelper.strip(frbr_ui_desc)
  end
  
  def title_for_solr
  	return FinderHelper.strip(expression_title)
  end
  
  def title_as_string_for_solr
    return FinderHelper.strip(expression_title).downcase
  end
  
  def mode_for_solr
  	return mode_id
  end
  
  def edition_for_solr
  	return FinderHelper.strip(edition)
  end  
  
  def expression_start_for_solr
   # return expression_start.iso8601[0,19]+'Z'
   start_date = expression_start
      
   return FinderHelper.date_for_solr_ymd(start_date)
  end
  
  def expression_finish_for_solr
   # return expression_finish.iso8601[0,19]+'Z'
   finish_date = expression_finish
      
   return FinderHelper.date_for_solr_ymd(finish_date)
  end
  
  def premiere_status_for_solr
  	return FinderHelper.strip(premiere)
  end
  
  def partial_expression_for_solr
  	partial_expression ? 1 : 0
  end 
  
  def has_manifestation_for_solr
  	manifestations.blank? ? 1 : 0
  end
  
  def players_count_for_solr
  	return players_count
  end
  
  def restriction_for_solr
  	return FinderHelper.strip(use_restriction_note)
  end
  
  def general_note_for_solr
  	return FinderHelper.strip(general_note)
  end
  
  def internal_note_for_solr
  	return FinderHelper.strip(internal_note)
  end    
  
  #- Return all the expression relationships with the appended frbr_ui_desc of the related entity
  #  in the following format: relationship type description + " " + related entity frbr_ui_desc + ";"
  #  Used in Expression Advanced Search
  def relationships_for_solr
    relationships_for_solr = Array.new
	
	expression_relationships.each do |er|
      relationship_type_desc = RelationshipType.find(:first, :conditions => ['relationship_type_id =?', er.relationship_type_id]).relationship_type_desc
    
	  relationship = Relationship.find(:first, :conditions => ['relationship_id =?', er.relationship_id])
	  
	  expression_entity_type_id = EntityType.find(:first, :select => 'entity_type_id', :conditions => ['entity_type =?', 'expression']).entity_type_id
    
	  if relationship.entity_type_id == expression_entity_type_id
	  	related_entity_type_id = relationship.ent_entity_type_id
	  elsif relationship.ent_entity_type_id == expression_entity_type_id
	  	related_entity_type_id = relationship.entity_type_id
	  end
	  
	  related_entity_type = EntityType.find(related_entity_type_id).entity_type
	  
	  related_entity_relationship = (related_entity_type.camelize.to_s + "Relationship").constantize.find(:first, :conditions => ['relationship_id =?', relationship.relationship_id]) 
    
	  related_entity_id = related_entity_relationship.send(related_entity_type +'_id')
	  related_entity = related_entity_type.camelize.to_s.constantize.find(related_entity_id)
	  
	  relationships_for_solr.push(FinderHelper.strip(relationship_type_desc).downcase + " " + FinderHelper.strip(related_entity.frbr_ui_desc.downcase))
	  
    end
	
	return relationships_for_solr.join('; ')
	
  end
  
  def relationship_type_ids_for_solr
  	expression_relationships.map{|er| er.relationship_type.relationship_type_id}.join(', ')
  end
  
  def status_for_solr
  	return status_id
  end
  #Use in the hard association helper
  def tooltip
    result = TimeHelper.dby_date(expression_start)
    result << ","
    result << edition.to_s
    result << "|"
    result << general_note
    result
  end
  
  #Add a check here 
  def validate
    errors.add(:expression_start, "must be provided if a finish time exists") if expression_start.blank? and !expression_finish.blank?
    
    if !expression_start.blank? and !expression_finish.blank?
      #both are non blank if we get this far 
       if expression_finish < expression_start
       errors.add(:expression_finish, "must be after start date") 
       end
     end
  end
   
   def premieres_as_list
     hash={'Not applicable'=>'NA ','New Zealand'=>'NZ ','World'=>'W  '}
     return hash.sort{|a,b| a[1]<=>b[1]}
   end
   
   
   def self.premiere_statuses
     {
       :not_applicable => 'NA',
       :new_zealand => 'NZ',
       :world_premiere => 'W',

     }
   end

   def self.editions
     {
       :original => 'ORG',
       :revision_following_performance => 'RFP',
       :general_revision => 'GEN'

     }
   end
   
   
   def self.premieres_statuses
     hash={'Not applicable'=>'NA ','New Zealand'=>'NZ ','World'=>'W  '}
     return hash.sort{|a,b| a[1]<=>b[1]}
   end   
   
   
   
   # If the start and finish times are on the same calendar day then we have a one day only event
   def is_one_day_only?
     result = true
      
     if expression_start == nil and expression_finish != nil
       result = false
     elsif expression_start != nil and expression_finish == nil
       result = false
     #The following means that the nil case will already be catered for
     elsif  expression_start != expression_finish
       if (expression_start.day==expression_finish.day) and 
         (expression_start.month==expression_finish.month) and 
         (expression_start.year==expression_finish.year) 
        result = true
      else
        result = false
      end
     end
     
     result
   end
   
   
   def is_performance?
    return mode == Mode::PERFORMANCE
   end
   
   
   def contains_nil_dates
     !(expression_start != nil and expression_finish != nil)
   end
   
   
   def get_premiere_as_string
    result = ''
    
    if !premiere.blank?
      p = premiere.strip
      if p == 'W'
        result = 'World Premiere'
      elsif p == 'NA'
        result = "Other"
      elsif p == 'NZ'
        result = 'NZ Premiere'
      end
    end
    result
   end
   

   
   def get_edition_as_string
     result = ""
     if !edition.blank?
       if edition == 'ORG'
          result = 'Original'
       elsif edition == 'RFP'
          result = 'Revision Following Performance'
       elsif edition == 'GEN'
          result = 'General Revision'
       end
     end
     result
   end
   
   
   
   #- Get all the performers for an expression - these consist of the follwing FRBR relationships
   #      * performs
  #       * exhibits
   #      * improvises
   #      * broadcasts
   def all_performers
     return broadcasters+performers+exhibitors+improvisors
   end
   
   
   #The venue is linked from expression with events happening at, and events is held at venue
   def venue
     result = nil
     events_array = events_happening_at
     if !events_array.blank?
       venues_array = events_array[0].venues_held_at
       result = venues_array[0] if !venues_array.blank?
     end
     
     result
     
   end
    
   
   #---------------------------------------------------
   #- Helper method for view, as nil field is allowed -
   #---------------------------------------------------
   def partial_information
     result = "******"
     if partial_expression == nil
       result  = "Not specified"
     elsif partial_expression == false
       result = "No"
    else
      result = "Yes"
    end
    
    return result
   end
   
   
   
   #---------------------------------------------------------------------------------------------
   #- Save the expression and also update the FRBR relationships for the expression to the work -
   #---------------------------------------------------------------------------------------------
   def save_with_frbr
     logger.debug "Saving with frbr for work"
    begin
      transaction do
        logger.debug "**TRACE1**"
        save! #This will throw an exception if it fails
        logger.debug "**TRACE2 expression has id #{self.expression_id}**"
        update_frbr_for_expression_work_relationship(self.updated_by) #This also throws an exception if it fails
        logger.debug "**TRACE3 - relationship added"
       end
    rescue Exception => e
        logger.error "Exception: #{e.class}: #{e.message}\n\t#{e.backtrace.join("\n\t")}"
      
       logger.debug "**TRACE4**"
       return false
    end
     
     logger.debug "TRACEDONE"
     #Got this far so all good
    return true
   end
   
   
   #----------------------------------------------------------------------------------------------------
   #- Update the attributes of the expression from an update, and fix the FRBR relationships if needbe -
   #----------------------------------------------------------------------------------------------------
   def update_attributes_with_frbr(parameters, login)
     begin
       transaction do
         logger.debug "** UPDATING PARAMS FOR EXPRESSION FROM FORM **"
         update_attributes!(parameters) #this throws an exeption if it fails
         logger.debug "Expression work is #{self.work.work_title}"
         update_frbr_for_expression_work_relationship(login)
         #Got this far so all good
         return true
       end
      rescue Exception => e
          logger.debug "Exception: #{e.class}: #{e.message}\n\t#{e.backtrace.join("\n\t")}"
        return false
      end
   end
   
   
   #- Update the FRBR association for expression to work by doing the following -
   #  * Delete any existing expression to work links
   #  * Add the new one (that for expression.work) - in effect "expression is realisation_of expression.work"
   def update_frbr_for_expression_work_relationship(login)
     RelationshipHelper.delete_all_frbr_relationships(:expression, self.expression_id, :is_realisation_of) 
     raise if !RelationshipHelper.add_frbr_relationship(:expression, self.expression_id, :is_realisation_of, 
        :work, self.work.work_id, login )
   end
   
  
   #This is used in the pages for all the various lists e.g. compositions, performances etc
   def frbr_listing_description
     return ""
   end
    
        
def frbr_type
  "expression"
end

def frbr_id
expression_id
end

def frbr_ui_desc
expression_title
end


#These methods are used when rendering lists of FRBR objects, e.g. a composers writings
#The naming needs to be common to maintain a single partial for list rendering
def frbr_list_title
  expression_title
end

def frbr_list_description
  ""
end


def frbr_relationships
      frbr_relationships=Array.new()
      for rel in relationships.uniq
        reltype=RelationshipType.find(rel.relationship_type_id)
        
        #Choose the entity_type that does not match this one.
        #Where both are the same, it does not matter which we pick
        my_entity=EntityType.entityTypeToId(rel.ent_entity_type_id)
        if EntityType.entityTypeToId(rel.ent_entity_type_id) == frbr_type() then 
          my_entity= EntityType.entityTypeToId(rel.entity_type_id)
        end
        
        related_objects=eval('rel.'+my_entity+'s')
        
        for related_object in related_objects
          if rel.entity_type_id == rel.ent_entity_type_id then
            if related_object.id != id then
              frbr_relationships.push(FrbrRelationship.new(related_object,reltype.relationship_type_desc,my_entity))
            end
          else 
          frbr_relationships.push(FrbrRelationship.new(related_object,reltype.relationship_type_desc,my_entity))
          end
        end
      end
    frbr_relationships
    end

    def duration_human_readable
      result = ""
      if  !duration.blank?
        result = TimeHelper.convert_duration_to_hours_and_minutes(duration)
      end
      result
    end  
end
