class NewsArticle < ActiveRecord::Base
  
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::SanitizeHelper
    
  set_primary_key :news_article_id
  
  # model relationships
  has_many :news_article_attachments, :order => 'news_article_attachment_id', :dependent => :destroy
  has_many :media_items, :through => :news_article_attachments
  
  belongs_to :status
  
  belongs_to :login_updated_by, 
             :class_name => 'Login',
             :foreign_key => :updated_by

  # model validation
  validates_presence_of :headline,
            :message => "cannot be empty"
            
  # updated by relationship 
  validates_presence_of :login_updated_by
  #validates_associated  :login_updated_by
  
  validates_inclusion_of :feature,      :in => [true, false]
  validates_inclusion_of :archived,     :in => [true, false]
  
  # article_type can be 'n' - 'Normal' or 'p' - 'PDF'
  validates_inclusion_of :article_type, :in => ['n', 'p']

  # Solr searching. All fields to be indexed must be listed here in :fields.
  acts_as_solr :fields => [
  	  :headline_for_solr, 
	  :content_for_solr,
	  :precis_for_solr,
	  :archived_for_solr,
	  {:article_timestamp_for_solr => :string}
	  ]

  # solr fields - as per WR#51726 - only archived articles are searched
  def headline_for_solr
  	return FinderHelper.strip(headline) if archived == true
  end
  
  def content_for_solr
  	return FinderHelper.strip(strip_tags(content)) if archived == true
  end  
  
  def precis_for_solr
  	return FinderHelper.strip(precis) if archived == true
  end
  
  def archived_for_solr
  	archived ? 1 : 0
  end
    
  def article_timestamp_for_solr
  	return FinderHelper.date_for_solr_ymd(article_timestamp)
  end
  
  # ----------------------------------------------------
  # - Return news articles based on category requested -
  # - Categories:                                      -
  # - 'current'                                        -
  # - 'archived'                                       -
  # - 'magazine'                                       -
  # - default to 'current'                             -
  # ----------------------------------------------------
  def self.get_news_articles_by_category(category='current', limit=nil)
        
    if category.match('current')
      archived_articles = 'f'
    elsif category.match('archived')
      archived_articles = 't'
    end
    
	conditions = nil   
    conditions = "archived ='" + archived_articles + "' AND article_type='n'" if !archived_articles.blank?
    
    if category.match('magazine')
      conditions = "article_type='p'"
    end
    
	status_id = Status::PUBLISHED.status_id
	# current time
	now = Time.now.strftime("%Y-%m-%d %H:%M:%S")	
	
	if category.match('pending')
	  status_id = Status::PENDING.status_id
	  now = nil
	end
	    
    conditions = conditions.to_s + " AND status_id=" + status_id.to_s 
	
	# display only the articles that are dated before(/equal)
	conditions += " AND article_timestamp <='" + now.to_s + "'" unless now.blank?
    
    return NewsArticle.find(:all, :conditions => conditions, :order => 'article_timestamp DESC', :limit => limit)
  
  end
  
  # ---------------------------------------------
  # - Return the most recent 'feature' articles 
  # - NOTE: this concerns only 'Published' news 
  # - articles of 'story' ('n') type
  # ---------------------------------------------
  def self.get_feature_articles(limit_number=1)
    feature_articles = NewsArticle.find(:all, :conditions => ["feature = 't' AND article_type='n' AND archived = 'f' AND status_id=?",
                                                              Status::PUBLISHED.status_id], 
    	                                :order => 'article_timestamp DESC', :limit => limit_number)
      
    #feature_articles = NewsArticle.find(:all, :conditions => ["article_type='n'"], :order => 'article_timestamp DESC', :limit => limit_number) if feature_articles.blank?
  
    return feature_articles
  end
  
  # ---------------------------------------------------------
  # - Return archived news articles based on year requested -
  # ---------------------------------------------------------
  def self.get_archived_articles_by_year(year)
    year_from = '1 Jan ' + year + ' 00:00'
    year_to   = '31 Dec ' + year + ' 23:59'
          
    timestamp_from = DateTime::strptime(year_from, '%d %b %Y %H:%M').to_time
    #logger.debug "****** timestamp_from #{timestamp_from} ***"
    timestamp_to = DateTime::strptime(year_to, '%d %b %Y %H:%M').to_time
    #logger.debug "****** timestamp_from #{timestamp_to} ***"
    
    # case for current year
    # we do not display archived articles
    # with the date in the future on public site
    if year.to_i == Time.now.year.to_i
      timestamp_to = Time.now.strftime("%Y-%m-%d %H:%M")
    end
    
    NewsArticle.find(:all, :conditions => ["article_type='n' AND archived='t' AND article_timestamp >= ? AND article_timestamp <= ? AND status_id=?", 
                                            timestamp_from, timestamp_to, Status::PUBLISHED.status_id], :order => 'article_timestamp DESC')
  end
  
  # ------------------------------
  # - Return article categories, -
  # - used in UI                 -
  # ------------------------------
  def self.article_categories
    categories = Array.new
    
    categories.push(
                    {'current'  => 'Current News'}, 
                    {'archived' => 'Archived News'}, 
                    {'magazine' => 'SOUNZnews'}
                    )
    
    return categories
    
  end
  
  # -----------------------------------------------------
  # - Set previously featured article to non-feature       
  # - if new, more recent feature article has been selected
  # - NOTE: this concerns only 'Published' articles
  # - News articles of 'Story' ('n') type and 'Published'
  # - status can have only two 'feature' article
  # - There is no such limit for 'Pending' story news articles
  # -----------------------------------------------------
  def self.update_features
    
    latest_featured_articles = NewsArticle.get_feature_articles(limit_number=2)
	#logger.debug "DEBUG: update_features: latest_featured_articles #{latest_featured_articles}"
	
	latest_featured_articles_ids = latest_featured_articles.map{|a| a.news_article_id}
	#logger.debug "DEBUG: update_features: latest_featured_articles #{latest_featured_articles_ids.join(', ')}"
    
	current_featured_articles_to_set_to_false = NewsArticle.find(:all, 
    	                                         :conditions => ['feature =? AND news_article_id NOT IN (?) AND status_id=?', 
    	                                                         't', latest_featured_articles_ids, Status::PUBLISHED.status_id])
	#logger.debug "DEBUG: update_features: current_featured_articles_to_set_to_false #{current_featured_articles_to_set_to_false}"										  
    
    current_featured_articles_to_set_to_false.each do |cf|
      cf.update_attribute('feature', 'f')
    end
    
  end
  
  # ---------------------------
  # - Return article category -
  # ---------------------------
  def get_article_category
    category = ''
    
    if self.archived
      category = 'archived'
    elsif self.article_type == 'p'
      category = 'magazine'
    elsif !self.archived && self.article_type == 'n'
      category = 'current'
    else
      logger.debug "*** get_article_category: ERROR: Could not define the category ***"
    end
    
  end
  
  
  # -----------------------------------------------------
  # - Return pending articles based on the article_type -
  # - requested                                         -
  # - 'pending' includes articles with status 'Pending' -
  # - and articles with the date in the future          -
  # -----------------------------------------------------
  def self.pending_articles(article_type)
    # current time
    now = Time.now.strftime("%Y-%m-%d %H:%M:%S")

    NewsArticle.find(:all, :conditions => ["(article_type=? and status_id=?) or (article_timestamp > ? and article_type=?)", 
                                            article_type, Status::PENDING.status_id, now, article_type], :order => 'article_timestamp DESC')
  end
  
  # --------------------------------------
  # - Return pending article categories, -
  # - used in UI                         -
  # --------------------------------------
  def self.pending_article_categories
    categories = Array.new
    
    categories.push(
                    {'pending_news'      => 'Pending News'} 
                    #{'pending_sounznews' => 'Pending SounzNews'}
                    )
    
    return categories
    
  end
  
end
