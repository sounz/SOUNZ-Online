require 'application_helper'
class NewsArticlesController < ApplicationController
  include ApplicationHelper
  include ImageMceAttachmentsHelper
  include StatusesHelper
  include FinderHelper
  
  def index
    list
    render :action => 'list', :category => params[:category]
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  # ------------------------------------------------
  # - Display the list of articles with the layout -
  # - depending on category parameter passed       -
  # ------------------------------------------------ 
  def list
    
    @category = params[:category]
     
    if !@category.blank?    
      
      @title   = @category.capitalize + ' News'

      @news_articles = NewsArticle.get_news_articles_by_category(@category)
      
      case @category
        when 'current'
          # feature article or the most recent one
          #@news_article = NewsArticle.get_feature_articles
        when 'archived'
          year_s = params[:date][:year_created] unless params[:date].blank?
          # display by default the archived articles of the current year
          year_s = Time.now.year.to_s if year_s.blank?
          @news_articles = NewsArticle.get_archived_articles_by_year(year_s)
          @year = year_s.to_i
        when 'magazine'
          @title = 'SOUNZnews'
      end
      
    
    end

	@page_title = "NZ music and composer news"
  end

  def show
    @news_article = NewsArticle.find(params[:id])
    @category = params[:category]
    @category = 'current' if @category.blank?
  end

  # ---------------
  # - New article -
  # ---------------
  def new
    @news_article = NewsArticle.new
    @news_article_timestamp = separate_date_time(Time.now)
    get_statuses(@news_article)
  end

  # ----------------------
  # - Create new article -
  # ----------------------
  def create
    @news_article = NewsArticle.new(params[:news_article])
    
    @news_article.article_timestamp = date_time_to_db_format(params[:news_article_timestamp][:date],
                                                             params[:news_article_timestamp][:time]
                                                             )
    # updated by
    @news_article.updated_by = get_user.login_id
    
    # sets feature article to false for archived article
	archived_article_check
    
    if @news_article.save
      #logger.debug "DEBUG: create: @news_article.feature #{@news_article.feature}"
	  
      # change feature article if needed
	  if params[:news_article][:feature] != "0"
		NewsArticle.update_features
	  end      
      
	  # save new media items
      ImageMceAttachmentsHelper.update_object_attachments(@news_article.content, generate_id(@news_article))
	  
	  flash[:notice] = 'News story - ' + @news_article.headline + ' was successfully created.'
      redirect_to :action => 'edit', :id => @news_article.news_article_id
    else
      get_statuses(@news_article)
      @news_article.content = params[:news_article][:content]
      @news_article_timestamp = separate_date_time(@news_article.article_timestamp)
      render :action => 'new'
    end
  end

  # ----------------
  # - Edit article -
  # ----------------
  def edit
    @news_article = NewsArticle.find(params[:id])
    get_statuses(@news_article)
    @news_article_timestamp = separate_date_time(@news_article.article_timestamp)
  end

  # ------------------
  # - Update article -
  # ------------------
  def update
    @news_article = NewsArticle.find(params[:id])
    
    @news_article.article_timestamp = date_time_to_db_format(params[:news_article_timestamp][:date],
                                                             params[:news_article_timestamp][:time]
                                                             )
    # updated by
    @news_article.updated_by = get_user.login_id
    
	# sets feature article to false for archived article
	archived_article_check	

	if @news_article.update_attributes(params[:news_article])
      #logger.debug "DEBUG: update: @news_article.feature #{@news_article.feature}"
	  
	  # update feature articles if needed
	  if params[:news_article][:feature] != "0"
	    NewsArticle.update_features
	  end
	       	
      # save new media items
      ImageMceAttachmentsHelper.update_object_attachments(@news_article.content, generate_id(@news_article))
      
      flash[:notice] = 'News story - ' + @news_article.headline + ' was successfully updated.'
      redirect_to :action => 'edit', :id => @news_article
    else
      get_statuses(@news_article)
      @news_article.content = params[:news_article][:content]
      @news_article_timestamp = separate_date_time(@news_article.article_timestamp)
      render :action => 'edit'
    end
  end

  # -------------------------
  # - Show selected article -
  # -------------------------
  def show_article
    if !params[:id].blank? && !params[:category].blank?
    
      @news_article = NewsArticle.find(params[:id])
            
      @category = params[:category]
      
      if !params[:year_created].blank?
        @news_articles = NewsArticle.get_archived_articles_by_year(params[:year_created])
      else
        @news_articles = NewsArticle.get_news_articles_by_category(@category)
      end
               
      render :layout => false
    end
    
  end
  
  # ----------------------------
  # - Ajax set of article type -
  # ----------------------------
  def article_type
    if !params[:article_type].blank?
      @news_article = NewsArticle.new
      @news_article.send('article_type=', params[:article_type])
      @news_article_timestamp = separate_date_time(Time.now)
      get_statuses(@news_article)
      render :partial => 'form'
    end 
  end

  # -------------------------
  # - Show selected article -
  # -------------------------
  def display_by_year
    if !params[:category].blank? && params[:category].match('archive') && !params[:year_created].blank?
                 
      @category = params[:category]
       
      @news_articles = NewsArticle.get_archived_articles_by_year(params[:year_created])
      
      @news_article = nil
            
      render :layout => false
    end
    
  end
  
  # -----------------------
  # - Delete news article -
  # -----------------------
  def destroy
    news_article = NewsArticle.find(params[:id])
    @category = news_article.get_article_category
    NewsArticle.find(params[:id]).destroy
    redirect_to :action => 'list', :category => @category
  end
  
  # ----------------------------
  # - List of pending articles -
  # ----------------------------
  def pending_articles
    @category = params[:category]
    
    case @category
      when "pending_news"
        @title   = 'Pending News'
        article_type = 'n'
      when "pending_sounznews"
        @title   = 'Pending News'
        article_type = 'p'
    end
        
    @news_articles = NewsArticle.pending_articles(article_type)
    
  end
  
  # - Set feature parameter to false for archived article
  def archived_article_check
  	#logger.debug "DEBUG: archived_article_check: ---------"
  	
	if params[:news_article][:archived] != "0"
  	  #logger.debug "DEBUG: archived_article_check: params[:news_article][:archived] #{params[:news_article][:archived]}"
  	  params[:news_article][:feature] = "0"
	  @news_article.send('feature=', 'f')
	  #logger.debug "DEBUG: archived_article_check: @news_article.feature #{@news_article.feature}"
  	end
	
  end
  
  def search_news
  	#show_params(params)
	@category = params[:category]
	@category = params[:search][:category] if !params[:search].blank?
	@title = nil   
	if ! @category.blank?    
	  @title   = "Searching #{@category.capitalize} News"
	end
	@data = nil
	
	@data = find_news(params[:search], params[:page].to_i)
  end
  
  def find_news(search_params, page)
	@results  = []
	@paginator = nil	
	
	page = 1 if page < 1
	
	if !search_params.blank?
	@category = search_params[:category]
	
	
	@title = nil   
	if ! @category.blank?    
	  @title   = "Searching #{@category.capitalize} News"
	end
	
	@search_term   =  search_params[:search_term]
	
	archived = 0
	if @category == 'archived'
	  archived = 1
	end
	
	options = {:q => []}
	
		
	unless @search_term.blank?
	  search_term = FinderHelper.process_search_field(@search_term)

	  options[:q] << 'AND ((precis_for_solr_t:' + search_term + ')^10000'
	  options[:q] << ' OR (headline_for_solr_t:' + search_term + ')^1000'
	  options[:q] << ' OR (content_for_solr_t:' + search_term + ')^100)'
	  options[:q] << 'AND (archived_for_solr_t:' + archived.to_s + ')'
	  
	  query  = FinderHelper.build_query([NewsArticle], "", [], query_param_boolean='AND', [], defined_models_only=true)
	end
	
	options[:rows] = 10
	options[:page] = page
	options[:sort] = 'article_timestamp_for_solr_s desc'
				
	@results, @paginator = solr_query(query, options)
	# Convert each contact back to its raw type
	@results[:docs].map! {|c| c.objectData }	

	
  end

  {
	:results   => @results,
	:paginator => @paginator
  }      	
  end
    
end
