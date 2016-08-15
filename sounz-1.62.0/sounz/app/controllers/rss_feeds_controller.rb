class RssFeedsController < ApplicationController

	def index
	  list
	  render :action => 'list'	  
	end
	
	# GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
	verify :method => :post, :only => [ :destroy, :create, :update ],
	       :redirect_to => { :action => :list }	
	
	def list
	  @rss_feeds = ['New Products', 'Latest News']
	end
    
	# WR#50297
    def latest_news
	  @news_articles = NewsArticle.find(:all, :conditions => ["status_id =? AND article_type = 'n' AND archived = 'f'", Status::PUBLISHED.status_id], :order => "article_timestamp DESC")
	  render :layout => false
    end
	
	# WR#50297
	def new_products
	  @products = ActiveRecord::Base.connection.execute("SELECT product_class, product_id, product_title, product_desc " +
	  	                                                "  FROM sounz_manifestations_resources_for_sale " +
														"    WHERE product_status =#{Status::PUBLISHED.status_id} " +
														"     AND product_price IS NOT NULL " +
														" ORDER BY product_date_added DESC LIMIT 10")
	  render :layout => false
	end
		
end
