module FrbrLinksHelper
   include ActionController::Pagination
   
  #Used in frbr controllers
  def retrieve_frbr_objects_using_mode(object, mode)
     @contains_frbr = false
     if mode.starts_with?("frbr_")
        mode = mode.gsub("frbr_","")
        #Now check method name is in valid entity entity relationship table - dont want
        #someone passing a mode of frbr_destroy!
        if !mode.starts_with?("composite_")
          veer = ValidEntityEntityRelationship.find(:first, :conditions => ["ruby_method_name=?", mode])
          raise ArgumentError, "Frbr method, #{@ode}, is not valid" if veer.blank?
           @frbr_title = veer.page_title
        else
          @frbr_title = mode[10..mode.length].split('_').map{|w| w.camelize}.join(' ')
        end
       
        @related_frbr_objects = object.send(mode)
        @page = params['page']
        @page = "1" if @page.blank?
        @paginator = Paginator.new(self, @related_frbr_objects.length , LISTING_PAGE_SIZE, @page)
        @contains_frbr = true
    end
    
    
    
  end
end