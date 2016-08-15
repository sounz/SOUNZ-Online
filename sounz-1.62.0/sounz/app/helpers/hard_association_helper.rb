module HardAssociationHelper
  include ModelAsStringHelper

  def generate_hard_association_session_key(model_instance)
    (generate_id(model_instance) +'_hard_association').to_sym
  end
  
  #Populate variables required to render the hard association controller
  def populate_variables(model_instance)
    hard_assoc_key = generate_hard_association_session_key(model_instance)
    model_id= session[hard_assoc_key][:frbr_instance]
    children_method= session[hard_assoc_key][:children_method]
    @frbr_instance = convert_id_to_model(model_id)
    
    #child entity type
    @child_entity_type = session[hard_assoc_key][:child_entity_type]
    
    #Just in case....
    @frbr_children = @frbr_instance.send(children_method) if children_method != 'destroy'
    
    # title
    @hard_association_title = 'None Specified'
    @hard_association_title = session[hard_assoc_key][:title] if session[hard_assoc_key][:title]
    
    @removal_mode = session[hard_assoc_key][:removal_mode].camelize
  end
  
  
  #Prime the hard association controller for viewing expressions of a work
  def prime_hard_association_for_work_expressions(model_instance)
    hard_assoc_key = generate_hard_association_session_key(model_instance)
    session[hard_assoc_key] = {}
    session[hard_assoc_key][:frbr_instance] = generate_id(model_instance)
    session[hard_assoc_key][:children_method] = "expressions"
    session[hard_assoc_key][:child_entity_type] = "expression"
    session[hard_assoc_key][:title] = "Related Expressions"
    session[hard_assoc_key][:relationship_type] = "is_realised_through"
    session[hard_assoc_key][:removal_mode] = "delete"
    populate_variables(model_instance)
  end
  
  
  #Prime the hard association controller for viewing expressions of a manifestation
  #(i.e. going up the tree), and is a many to many rel
  def prime_hard_association_for_manifestation_expressions(model_instance)
    hard_assoc_key = generate_hard_association_session_key(model_instance)
    session[hard_assoc_key] = {}
    session[hard_assoc_key][:frbr_instance] = generate_id(model_instance)
    session[hard_assoc_key][:children_method] = "expressions"
    session[hard_assoc_key][:child_entity_type] = "expression"
    session[hard_assoc_key][:title] = "Related Expressions"
    session[hard_assoc_key][:relationship_type] = "is_the_embodiment_of"
    session[hard_assoc_key][:removal_mode] = "delete"
    populate_variables(model_instance)
  end
  
  #Prime the hard association controller for viewing manifestations of an expression
  #(i.e. going down the tree), and is a many to many rel
  def prime_hard_association_for_expression_manifestations(model_instance)
    hard_assoc_key = generate_hard_association_session_key(model_instance)
    session[hard_assoc_key] = {}
    session[hard_assoc_key][:frbr_instance] = generate_id(model_instance)
    session[hard_assoc_key][:children_method] = "manifestations"
    session[hard_assoc_key][:child_entity_type] = "manifestation"
    session[hard_assoc_key][:title] = "Related Manifestations"
    session[hard_assoc_key][:relationship_type] = "is_embodied_in"
    session[hard_assoc_key][:removal_mode] = "detach"
    populate_variables(model_instance)
  end
end
