module StatusesHelper
  
  PENDING   =  Status.find_by_symbol(:pending)
  PUBLISHED = Status.find_by_symbol(:published)
  APPROVED  = Status.find_by_symbol(:approved)
  WITHDRAWN = Status.find_by_symbol(:withdrawn)
  MASKED    = Status.find_by_symbol(:masked)
  

  # Get an ordered list of all the publishing statuses
  # As this is a module we have access the status instance variable
  def get_statuses(object)
      @statuses = Status.find(:all, :order => :status_desc)
      
      class_as_string = object.class.to_s
      #Filter out published for CRM
      if ['Person', 'Organisation', 'Role'].include? class_as_string
        @statuses.delete(PUBLISHED)
      end
      
      #Filter out approved for FRBR
      if  FrbrHelper::FRBR_CLASS_NAMES.include? class_as_string
        @statuses.delete(APPROVED)
      end
      
      #Check distinctions
      case class_as_string
        when 'Distinction' then @statuses.delete(APPROVED)
        when 'Item' then @statuses.delete(APPROVED)
        when 'DistinctionInstance' then @statuses.delete(APPROVED)
        when 'Sample' then @statuses.delete(APPROVED)
      end
      
      if ['CmContent', 'NewsArticle'].include? class_as_string
        @statuses.delete(APPROVED)
        @statuses.delete(WITHDRAWN)
        @statuses.delete(MASKED)
      end
      
	  if ['ProvComposerBios', 
	  	  'ProvContactUpdates', 
		  'ProvContributorProfiles', 
		  'ProvEvents', 
		  'ProvFeedbacks',
		  'ProvWorkUpdates',
		  'ProvProducts'
		  ].include? class_as_string
	    @statuses.delete(PUBLISHED)
      end

  end
  
  #This sets the default to pending if the status is blank
  def set_default_status(object)
    if object.status.blank?
      object.status = PENDING
    end
  end
  
  
end
