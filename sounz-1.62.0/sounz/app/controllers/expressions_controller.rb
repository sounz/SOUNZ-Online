class ExpressionsController < ApplicationController
  
  include FinderHelper
  include StatusesHelper
  include HardAssociationHelper
  include AccessRightHelper
  include DurationAsIntervalHelper
  include ApplicationHelper
  
  before_filter :show_works_widget
  
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @expressions = Expression.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @expression = Expression.find(params[:id])
    @page_title = "Expression - #{@expression.expression_title}"
  end

  #This is creating a new expression stand alone
  def new
    #FIXME - this loses the work if you enter bad data on the new expression screen
    logger.debug "** expression new **"
    @expression = Expression.new
	prepare_new
    save_expression_instance_in_session
  end
  
  
  #This occurs when a new experssion is created with errors
  def new_with_errors
    render :layout => 'new'
  end
  
  #Obtain variables necessary to render the new form
  def prepare_new
    @modes=Mode.find(:all)
    set_default_status(@expression)
    get_statuses(@expression)
    #Defaults as per expression notes/7
    @expression.premiere = 'NA'
    @expression.edition = 'ORG'
    @expression.mode = Mode::PERFORMANCE
    @expression.login_updated_by = @login
	
	prepare_duration_new
	
  end
  
  #This is creating an expression in the context of a work
  def new_from_work
    @expression = Expression.new
    @expression.login_updated_by = @login
    set_default_status(@expression)
    save_expression_instance_in_session
	@interval_duration = IntervalDuration.create_from_string(nil)
    
    #Sounz have requested that if you create an expression from a work then you cant change the work
    @show_works_widget = false
    
    begin
      @work = Work.find(params[:work_id])
      @expression.work = @work
      @expression.expression_title = @work.work_title
      @page_title = "New expression for work '#{@work.work_title}'"
      @assignedWork=FrbrObject.new("work",Work.find(@work.work_id))
    rescue
      logger.debug "****** Invalid ID for work: #{params[:work_id]}"
      @page_title = "New Expression"
    end
  
    prepare_new
    render :action => :new
  end
  
  #Edit an existing work
  def edit
    @expression = Expression.find(params[:id])
    save_expression_instance_in_session
    prepare_edit
  end
  
  def prepare_edit
    
	prepare_duration_edit(@expression.duration)
	
	@assignedWork=FrbrObject.new("work",Work.find(@expression.work_id))
    @modes=Mode.find(:all, :order => :mode_desc)
        
	get_statuses(@expression)
    @assoc_types=RelationshipType.find(:all, :order => :relationship_type_desc)
    @entity_types=EntityType.find(:all, :order => :entity_type)
    prime_hard_association_for_expression_manifestations(@expression)
    populate_access_right_variables(@expression)
  end
  
  
  def fix_start_time
    start_date_ok = false
    begin
      convert_datetime_to_db_format_in_params(params, 'communication','created_at')
      start_date_ok = true
    rescue TimeParseException
      @communication.errors.add("Start time")
    end
  end


  
  def create
    logger.debug "**EXPRESSION CREATE**"
    
    #Check if we have a date enabled flag, this also indicates existence of the date widget
    #and whether we need to parse it
    date_param = params[:date]
    
    if !date_param.blank?
      dates_enabled_string = params[:date][:enabled]
      dates_enabled = false
      dates_enabled = true if dates_enabled_string=="yes"
    
      #The enabled case
      if dates_enabled
        logger.debug "DATES ENABLED:"+dates_enabled.to_s
      
        #The start date is optional
        start_date_ok = true
        if params[:expression][:expression_start_time]
          begin
            convert_datetime_to_db_format_in_params(params, 'expression','expression_start')
          rescue TimeParseException
            start_date_ok = false
          end
        end
    
        #Ditto the end date
         finish_date_ok = true
          if params[:expression][:expression_finish_time]
            begin
              convert_datetime_to_db_format_in_params(params, 'expression','expression_finish')
            rescue TimeParseException
              finish_date_ok = false
            end
          end
       end
    end
   

      
          
    logger.debug "==about to create expression from params=="
    @expression = Expression.new(params[:expression])
    @work = @expression.work
    #nil out the dates for non performancy modes
    if date_param.blank?
      @expression.expression_start = nil
      @expression.expression_finish = nil
    end
    @expression.updated_by = @login.login_id
    
	@expression.duration = nil if params[:expression][:duration].blank?
		
    if @expression.save_with_frbr
      flash[:notice] = 'Expression was successfully created.'
      redirect_to :action => 'show', :id => @expression
    else
      #Without this, you will lose your assigned work
      flash[:notice] = "Some problems were found with your expression.  The errors are displayed below"
      @assignedWork=FrbrObject.new("work",@expression.work) if !@expression.work.blank?
      @interval_duration = IntervalDuration.create_from_string_no_validation(@expression.duration)
	  logger.debug "==== expression work id is <%=@expression.work_id%>"
      logger.debug "creating a new expression, did not save it due to validation errors"
      prepare_new
      render :action => 'new'
    end
  end



  def findWorks
    @results=Array.new
    @search_terms = params[:query]
    if @search_terms.length < 3 then
      render :partial => 'frbr_objects/query_too_short'
    else
      #@matchingWorks=Work.find(:all,:conditions => ["work_title like ? or work_description like ?", '%'+params[:query]+'%', '%'+params[:query]+'%'] )
      
      fields = [
        {:name => 'work_title_for_solr_t', :boost => 4},
        {:name => 'composers_csv_for_solr_t', :boost => 2.5},
        {:name => 'work_description_for_solr_t'},
      ]
      @matches, @paginator = solr_query(FinderHelper.build_query(Work, @search_terms, fields),{})
      logger.debug "Matching works:#{@matchingWorks}"
      for work in @matches[:docs]
        @results.push(work)
      end
    render :partial => 'result', :collection => @results
    end
  
  end
  
  def assignWork
    type=Inflector.camelize(params[:type])
    work=eval(type+".find("+params["object_id"]+")")
    assignedWork=FrbrObject.new("work",work)
    render :partial => 'work', :locals => {:object => assignedWork}
  end



  def update
    logger.debug "**** UPDATING EXPRESSION"
    show_params(params)
    logger.debug "EXPRESSION IS CURRENTLY:#{@expression.to_yaml}"
    #FIXME - this wont work due to ajax...@expression = Expression.find(params[:id])
    
    @expression_from_id = Expression.find(params[:id])
    #The expression is saved in the session prior to editing.  Its tweaked by the AJAX date widget,
    #so needs to be reloaded from session
    @expression = load_expression_instance_from_session #this is the one in session
    
    logger.debug "FROM DB ID of expression is #{@expression_from_id.expression_id}"
    logger.debug "FROM Session ID of expression is #{@expression.expression_id}"
    
  
    
    if @expression_from_id.expression_id != @expression.expression_id
      raise "Unable to save expression due to changing expression in session issue (WR42723), form submission id is "+
      " #{params[:id]}, expression id in session is #{@expression.expression_id}"
    end
    
    #Do we have a dates enabled flag - this will indicate where dates were required, ie
    #the dates widget was showing
    date_param = params[:date]
    
    #if no date param assume the mode is indicate of no dates and nil them out
    if date_param.blank?
      @expression.expression_start = nil
      @expression.expression_finish = nil
    else
    
      dates_enabled_string = params[:date][:enabled]
      dates_enabled = false
      dates_enabled = true if dates_enabled_string=="yes"
    
    
      logger.debug "DATES ENABLED: #{dates_enabled.to_s}"
    
      if dates_enabled    
        logger.debug "TRACE1"
        #The start date is optional
        start_date_ok = true
        if params[:expression][:expression_start_time]
          logger.debug "TRACE2"
          begin
            convert_datetime_to_db_format_in_params(params, 'expression','expression_start')
          rescue TimeParseException
            start_date_ok = false
          end
        end

        #Ditto the end date
        finish_date_ok = true
        if params[:expression][:expression_finish_time]
          logger.debug "TRACE3"
          begin
            convert_datetime_to_db_format_in_params(params, 'expression','expression_finish')
          rescue TimeParseException
            finish_date_ok = false
          end
        end
      
      else
        logger.debug "TRACE4"
        @expression.expression_start = nil
        @expression.expression_finish = nil
        #Remove the params data
      end
    end
      
    @expression.login_updated_by = @login
    @page_title = "Editing #{@expression.expression_title}"
    show_params(params)
    
	@expression.duration = nil if params[:expression][:duration].blank?
	
	if @expression.update_attributes_with_frbr(params[:expression], @login.login_id)
      flash[:notice] = 'Expression was successfully updated.'
      redirect_to :action => 'show', :id => @expression
    else
      flash[:notice] = 'Please fix any errors'
      logger.debug "**** EXPRESSION DID NOT UPDATE FROM FORM ****"
      logger.debug "EXP status is #{@expression.status_id}"
      logger.debug "EXP updated_by_id is #{@expression.updated_by}"
      logger.debug "EXP login_updated_by is #{@expression.login_updated_by}"
      @work = @expression.work
    # logger.debug "Expression is #{@expression.to_yaml}"
      prepare_edit
      render :action => 'edit'
    end
  end
  
  

  def destroy
    Expression.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  
  #When the start time is changed, make the end time the start time for parent work duration 
  #(if parent work set).  Do not execute however if the end date is turned off
  def set_end_time_from_start_time
    @expression = load_expression_instance_from_session
    @execute_update = false
    if !@expression.expression_finish.blank?
      @execute_update = true      
      @start_date = params[:start_date]
      @start_hms = params[:start_hms]
      
      #Only update the time if the start date is parseable.  This can happen if the date is edited
      #directly as opposed to using the widget
      begin
        start_time = Time.parse(@start_date << ' ' << @start_hms)
    
        #Use a dummy expression for rendering purposes
        @dummy_expression = Expression.new
        @dummy_expression.expression_finish = start_time
      rescue
        @execute_update = false
      end
    end
    
    #if the time has changed tweak the minutes supression flag
    logger.debug "Prior to supress, start hms is #{@start_hms}"
    if @start_hms != "00:00"
      logger.debug "Setting supress times to false"
      @expression.supress_times  = false
      save_expression_instance_in_session
    end
  end
  
  
  #- needed to keep the ajax happy -
  def disable_dates
    @expression = load_expression_instance_from_session
    @expression.expression_start = nil
    @expression.expression_finish = nil
    save_expression_instance_in_session
  end
  
  
  #- needed to keep the ajax happy -
  def enable_dates
    @expression = load_expression_instance_from_session
    @expression.expression_start = Time.now
    @expression.expression_finish = Time.now
    save_expression_instance_in_session
  end
  
  # Hide the widget for end date
  def set_no_finish_time
    @expression = load_expression_instance_from_session
    @expression.expression_finish = nil
    save_expression_instance_in_session
  end
  
  # Show the widget for end date
  def set_has_finish_time
    @expression = load_expression_instance_from_session
    @expression.expression_finish = Time.now
    save_expression_instance_in_session
  end
  
  #When date minutes are zeroed, set the  supress_times  flag
  def disable_date_minutes
    @expression = load_expression_instance_from_session
    logger.debug "Setting supress times when disabling date minutes"
    @expression.supress_times  = true
    save_expression_instance_in_session
  end
  
  
  
  
  #This is called by the before filter - it is only overriden for a new expression from a work
  def show_works_widget
    @show_works_widget = true
  end
  

  #When the mode drop down is changed the following happens
  #If mode is
  # Hide date and edition box
  #otherwise show them
  def mode_changed
    @new_mode = Mode.find(params[:expression_mode_id])
   #FIXME : does not appear to make sense @expression_mode_id = load_expression_instance_from_session # Not possible to pass id if not saved
    
    @expression = load_expression_instance_from_session
    @expression.mode = @new_mode
    save_expression_instance_in_session
  end
  
  
  # ---- Session storage of expressions ----
  
  #In order for the ajax to repopulate correctly the dates when a mode is changed, the expression being edited
  #needs to be stored in the session
  def save_expression_instance_in_session
    session[:expression_being_edited] = @expression
  end
  
  #Load the instance variable @expression with whats saved
  def load_expression_instance_from_session
    @expression = session[:expression_being_edited]
  end
  
  
  def  partial_expression_status_changed
    logger.debug "** DEBUG: PARTIAL EXP CHANGED **"
    @expression = load_expression_instance_from_session
    partial_status_param = params[:status]
    logger.debug "DEBUG: STATUS:#{partial_status_param}"
    
    if partial_status_param == "1"
      @expression.partial_expression = true
	  @partial_status = "true"
    else
      @expression.partial_expression = false
	  @expression.partial_expression_note = nil
      @partial_status = "false"
    end
    save_expression_instance_in_session
    show_params(params)
  end
  
  # ----------------------------
  # - Dynamically add language -
  # ----------------------------
  def add_language
    language = Language.find(params[:language_id]) unless params[:language_id].blank?
    @expression = Expression.find(params[:expression_id]) unless params[:expression_id].blank?
    
    if !language.blank? && !@expression.blank?
      expression_language = ExpressionLanguage.new
      expression_language.language = language
      expression_language.expression = @expression        
      
      # save
      if expression_language.save
        # save related work for solr indexing
        work = @expression.work
        work.save
      end
    end
        
    render :partial => 'languages_form', :locals => { :expression => @expression }
    
  end
  
  # ------------------------------------------
  # - Dynamically remove expression language -
  # ------------------------------------------
  def remove_language
    expression_language = ExpressionLanguage.find(params[:expression_language_id]) unless params[:expression_language_id].blank?
    @expression = expression_language.expression
    
    if !expression_language.blank?
      if expression_language.destroy
        # update related work for solr indexing
        work = @expression.work
        work.save
      end
    end
    
    render :partial => 'languages_form', :locals => { :expression => @expression }
  end
  
  # - WR#50282 - Create a copy of an expression with its associations/relationships
  def copy
    expression_to_clone = Expression.find(params[:id])
			  
	@expression = expression_to_clone.clone
	
	@expression.expression_title = "Copy of '#{expression_to_clone.expression_title}'"
  
  if @expression.expression_title.length > 100
    flash[:error] = "The new title '#{@expression.expression_title}' is too long."
    redirect_to :action => 'edit', :id => expression_to_clone.id
    return
  end
	
	@expression.status = Status::PENDING # default to 'pending'
	
	# delete created_at assigned from expression_to_clone created_at value
	# as we need created_at be actual time of creating the copy
	@expression.created_at = nil	
		
	# updated by
	@expression.updated_by = get_user.login_id
	
	# languages
	expression_to_clone.languages.each do |l|
	  @expression.languages << Language.find(l.language_id)
	end
		
	if @expression.save_with_frbr
	  
	  # copying relationships
	  success = true
	  
	  # FIXME do we need to clone access rights???
	  # it seems that currently there is no UI for entering them???
	  #expression_to_clone.expression_access_rights.each do |ar|
	  #  expression_access_right = ExpressionAccessRight.new
	  #  expression_access_right = ar.clone
	  #  expression_access_right.expression_id = @expression.id
	  #  
	  #  success = false if !expression_access_right.save
	  #end
	  	  
	  # manifestations - it is requested to do not copy relationships with manifestations
	  #expression_to_clone.manifestations.each do |m|
	  #	success = false if !m.add_expression(@expression)
	  #end
	  
	  # other relationships
	  expression_to_clone.expression_relationships.each do |ex_relationship|
	  	success = false if !RelationshipHelper.copy_frbr_relationships(@expression, ex_relationship, @login)
	  end
	  
	  notice = 'Expression clone was successfully created.'
	  notice += ' But some of the relationships failed to be copied.' if !success
	  
	  flash[:notice] = notice
	  
	  redirect_to :action => 'edit', :id => @expression
	else
	  flash[:error] = 'Expression cloning has failed.'
	  redirect_to :action => 'edit', :id => expression_to_clone.id
	end			
  end
  
end
