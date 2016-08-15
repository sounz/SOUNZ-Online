class AssociationController < ApplicationController

  include ModelAsStringHelper

  def index
  show
  render :action => 'show'
  end



  def ajax_types
   id=params[:type]

   type=Inflector.camelize(EntityType.entityIdToType(id))
   @results = eval(type+".find_all")

  render :partial => 'items'
  end

  def show
    @assoc_types=RelationshipType.find(:all, :order => :relationship_type_desc )
    @entity_types=EntityType.find(:all)
    @superworks=Superwork.find(:all)
    @relationships=Relationship.find(:all)
  end


  #When text is searched for in the search box,
  def findObjects
    logger.debug "***** FIND OBJECTS ****"

    association_type_id = params["association_type_id"].to_i
    association_type_desc = RelationshipType.find(association_type_id).relationship_type_desc.downcase

#    logger.debug "ASSOC TYPE:#{association_type_id}"
#    logger.debug "DESC:#{association_type_desc}"

    show_params(params)
    @results=Array.new
    search_term=params[:searchText].strip
    logger.debug "**** SEARCH TERM #{search_term}"
    entity_type=Inflector.camelize(EntityType.find(params[:association_entity_b_type]).entity_type)

    if search_term.length < 3
      render :text => '<p>Please type in at least 3 chars</p>'
    else
    if entity_type == "Superwork"
      @matchingSuperworks=Superwork.find(:all,:conditions => ["superwork_title ilike ? or superwork_title_alt ilike ?", '%'+search_term+'%','%'+search_term+'%'] )
      for superwork in @matchingSuperworks
        @results.push((FrbrObject.new("superwork",superwork)))
      end

      elsif entity_type == "Work"
        @matchingWorks=Work.find(:all,:conditions => ["work_title ilike ? or work_description ilike ?", '%'+search_term+'%','%'+search_term+'%'] )
        for work in @matchingWorks
          @results.push((FrbrObject.new("work",work)))
        end

      #As per WR 42530, allow searches to filter for MN: and P:
      elsif entity_type == "Expression"
        @matchingExpressions = []

        if search_term.downcase.starts_with?('p:')
            search_term = search_term[2,search_term.length]
            search_term.strip!
          @matchingExpressions=Expression.find(:all,
          :limit => 40,
          :conditions => ["expression_title ilike 'p:%' and expression_title ilike ?", '%'+search_term+'%'] )

        elsif search_term.downcase.starts_with?('mn:%')
          search_term = search_term[3,search_term.length]
          search_term.strip!
          @matchingExpressions=Expression.find(:all,
          :limit => 40,
          :conditions => ["expression_title ilike 'mn:' and expression_title ilike ?", '%'+search_term+'%'] )
        else
          @matchingExpressions=Expression.find(:all, :conditions => ["expression_title ilike ?", '%'+search_term+'%'] )
        end

          for expression in @matchingExpressions
            @results.push((FrbrObject.new("expression",expression)))
          end
      elsif entity_type == "Manifestation"
        @matchingManifestations=Manifestation.find(:all, :conditions => ["manifestation_title ilike ?", '%'+search_term+'%'] )
          for manifestation in @matchingManifestations
            @results.push((FrbrObject.new("manifestation",manifestation)))
          end
      elsif entity_type == "Concept"
       dealing_with_genre = association_type_desc.include?("genre")
       dealing_with_influence = association_type_desc.include?("influence")
       dealing_with_theme = association_type_desc.include?("theme")
       @matchingConcepts=Concept.find(:all, :conditions => ["concept_name ilike ? and parent_concept_id is not null", '%'+search_term+'%'] )

       case
        when dealing_with_genre == true
          @matchingConcepts=Concept.find(:all, :conditions =>
           ["concept_name ilike ? and parent_concept_id is not null and concept_type_id = #{ConceptType::GENRE.concept_type_id}", '%'+search_term+'%'] )
        when dealing_with_influence == true
          @matchingConcepts=Concept.find(:all, :conditions =>
           ["concept_name ilike ? and parent_concept_id is not null and concept_type_id = #{ConceptType::INFLUENCE.concept_type_id}", '%'+search_term+'%'] )

        when dealing_with_theme == true
          @matchingConcepts=Concept.find(:all, :conditions =>
            ["concept_name ilike ? and parent_concept_id is not null and concept_type_id = #{ConceptType::THEME.concept_type_id}", '%'+search_term+'%'] )

        else
          @matchingConcepts=Concept.find(:all, :conditions => ["concept_name ilike ? and parent_concept_id is not null", '%'+search_term+'%'] )

       end

          for concept in @matchingConcepts
            @results.push((FrbrObject.new("concept",concept)))
          end
      elsif entity_type == "Event"
        @matchingEvents=Event.find(:all, :conditions => ["event_title ilike ?", '%'+search_term+'%'] )
          for event in @matchingEvents
            @results.push((FrbrObject.new("event",event)))
          end


        #Resources
        elsif entity_type == "Resource"
            @matchingResources=Resource.find(:all, :conditions => ["resource_title ilike ?", '%'+search_term+'%'] )
              for resource in @matchingResources
                @results.push((FrbrObject.new("resource",resource)))
              end

        elsif entity_type == "DistinctionInstance"
          #Get the distinctions and all all instances
          @matchingDistinctions=Distinction.find(:all, :conditions => ["award_name ilike ?", '%'+search_term+'%'] )
          for distinction in @matchingDistinctions
            for distinction_instance in distinction.distinction_instances
              @results.push((FrbrObject.new("distinction_instance",distinction_instance)))
            end
          end
        elsif entity_type == "Distinction"
              @matchingDistinctions=Distinction.find(:all, :conditions => ["award_name ilike ?", '%'+search_term+'%'] )
                for distinction in @matchingDistinctions
                  @results.push((FrbrObject.new("distinction",distinction)))
                end

    #  elsif  entity_type == "Contributor"
    #    @matchingContributors=Contributor.find(:all, :include => :person, :conditions => ["last_name ilike ? or first_names ilike ?",'%'+search_term+'%','%'+search_term+'%'] )
    #      for contributor in @matchingContributors
    #        @results.push((FrbrObject.new("contributor",contributor)))
    #      end
    #    @matchingContributors=Contributor.find(:all, :include => [:organisation], :conditions => ["organisation_name ilike ?",'%'+search_term+'%'] )
    #      for contributor in @matchingContributors
    #        @results.push((FrbrObject.new("contributor",contributor)))
    #      end

      elsif  entity_type == "Role"
        #st = '%'+search_term+'%'

		#@matchingRoles = Role.find(:all, :include => [:person], :joins => "inner join contributors c using (role_id)",
        #        :conditions => ["last_name ilike ? or first_names ilike ? or c.known_as ilike ?",st,st,st] )

        #@matchingRoles += Role.find(:all, :include => [:organisation], :joins => "inner join contributors using (role_id)",
        #:conditions => ["organisation_name ilike ?",st] )

        #@matchingRoles = @matchingRoles.uniq

        search_term = FinderHelper.strip_query(search_term)
        @matchingRoles = Role.find_by_solr("contributor_known_as_for_solr:#{search_term}")

        for role in @matchingRoles
          @results.push(FrbrObject.new("role",role)) unless role.contributor.blank?
        end
      end

        render :partial =>'association/result',:collection=>@results
    end
    #render :text => entity_type

  end

  #--------------------
  #- Assign an object -
  #--------------------
  def assignObject
    type=Inflector.camelize(params[:type])
    object=eval(type+".find("+params["object_id"]+")")
    @assignedObject=FrbrObject.new(type,object)
    @type = params[:type]
    @source_object = object
    #render :partial => "shared/frbr/objects/brief/"+params[:type], :locals => {:object => @assignedObject.objectData}
  end



  def delete
    @relationship=Relationship.find(params[:id])
    @relationship.destroy_inter_relationships(@relationship.id,@relationship.entity_type_id)
    @relationship.destroy_inter_relationships(@relationship.id,@relationship.ent_entity_type_id)
    @relationship.destroy
    redirect_to :action => 'show'
  end

  #This is called when the remove button is clicked on the existing relationships at the foot of the screen
  def delete_ajax
    object=eval(Inflector.camelize(params[:object_type])+".find("+params[:object_id]+")")
    @relationship=Relationship.find(params[:relationship_id])
   # @relationship.destroy_inter_relationships(@relationship.id,@relationship.entity_type_id)
  #  @relationship.destroy_inter_relationships(@relationship.id,@relationship.ent_entity_type_id)
  #  @relationship.destroy

    RelationshipHelper.destroy_relationship_and_update_solr(@relationship)
    #get our object back - note due to the surrounding div, and not going all recursive, it calls the form
    #previously called from inside the edit partial
    render :partial => '/shared/frbr/relationships/form', :locals => {:object => object}
  end


  def create_ajax
    logger.debug "*** CREATING AN ASSOCIATION AJAX***"
    #association => entity_b_type=2, entity_a_type=4, entity_b_id=10915, entity_a_id=7897type_id29
    @relationship = Relationship.new()
    @relationship.updated_by=@login.login_id
    show_params(params)

    #Create the association manually (not sure how to pass name param from JS)
    @association=Hash.new
    @association["entity_a_type"] = params[:association_entity_a_type]
    @association["entity_b_type"] = params[:association_entity_b_type]
    @association["entity_a_id"] = params[:association_entity_a_id]
    @association["entity_b_id"] = params[:association_entity_b_id]
    @association["type_id"] = params[:association_type_id]

    logger.debug "Association to yaml is #{@association.to_yaml}"

    #FIXME: This may not work after primary key change
    @type_a=EntityType.find(@association["entity_a_type"])
    @type_b=EntityType.find(@association["entity_b_type"])

    logger.debug "Type A is #{@type_a.entity_type}"
    logger.debug "Type B is #{@type_b.entity_type}"

    model_a_string = "#{@type_a.entity_type}_#{@association["entity_a_id"]}"
    model_b_string = "#{@type_b.entity_type}_#{@association["entity_b_id"]}"

    logger.debug "MODEL A STRING: #{model_a_string}"
    logger.debug "MODEL B STRING: #{model_b_string}"

    model_a = convert_id_to_model(model_a_string)
    model_b = convert_id_to_model(model_b_string)

    logger.debug "MODEL A:#{model_a}"
    logger.debug "MODEL B:#{model_b}"


    @relationship.entity_type_id=EntityType.entityTypeToId(@type_a.entity_type)
    @relationship.ent_entity_type_id=EntityType.entityTypeToId(@type_b.entity_type)


    if @relationship.save
        invreltype=RelationshipType.find(@association["type_id"]).inverse
        logger.debug "Inverse relationship is #{invreltype}"
        @relationship.make_inter_relationship(@relationship.id,@association["entity_a_type"],@association["entity_a_id"],@association["type_id"])
        @relationship.make_inter_relationship(@relationship.id,@association["entity_b_type"],@association["entity_b_id"],invreltype)
        object=eval(Inflector.camelize(@type_a.entity_type)+".find("+@association['entity_a_id']+")")
        related_object=eval(Inflector.camelize(@type_b.entity_type)+".find("+@association['entity_b_id']+")")
        @dom_id = @type_b.entity_type+'_'+@association['entity_b_id']
        @chosen_object = object #Pass to template
       # render :partial => '/shared/frbr/relationships/edit', :locals => {:object => object}
       #Keep SOLR up to date

       if model_a.respond_to?('solr_save')
           model_a.send('solr_save')
       end

       if model_b.respond_to?('solr_save')
           model_b.send('solr_save')
       end


      else
        #FIXME: do something useful instead of this!?
        render :action => 'show'
      end
      logger.debug "/*** DONE CREATING AN ASSOCIATION ***"
  end



  def create
    @relationship = Relationship.new()
    @relationship.updated_by= @login.login_id
    @association=params[:association]
    @type_a=EntityType.find(@association["entity_a_type"])
    @type_b=EntityType.find(@association["entity_b_type"])
    @relationship.entity_type_id=EntityType.entityTypeToId(@type_a.entity_type)
    @relationship.ent_entity_type_id=EntityType.entityTypeToId(@type_b.entity_type)

    if @relationship.save
      invreltype=RelationshipType.find(@association["type_id"]).inverse
      @relationship.make_inter_relationship(@relationship.id,@association["entity_a_type"],@association["entity_a_id"],@association["type_id"])
      @relationship.make_inter_relationship(@relationship.id,@association["entity_b_type"],@association["entity_b_id"],invreltype)
      flash[:notice] = 'Relationship was successfully created.'
      redirect_to :action => 'show'
    else
      render :action => 'show'
    end
  end


  def restrict_target_object_type
    logger.debug "** RESTRICTING TARGET OBJECT TYPE **"
    show_params(params)
    association_type_id = params["association_type_id"].to_i
    model_sym_a = params["model_id"].split('_')
	model_sym_a.pop

	model_sym = model_sym_a.join('_').to_sym
    logger.debug "Association type is #{association_type_id}"

    valid_target_entity_ids = RelationshipTypesHelper.show_valid_target_entity_types_for(model_sym, association_type_id)
    @valid_target_entities = EntityType.find(:all,
                :conditions => ["entity_type_id in (?)", valid_target_entity_ids],
                :order => 'entity_type'
                )
    #valid_target_entity_ids.map{|e_id| EntityType.find(e_id)}

  end




end



