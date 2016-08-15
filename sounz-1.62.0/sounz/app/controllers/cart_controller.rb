
require 'application_helper'
require 'net/http'

class CartController < ApplicationController
  
  include ApplicationHelper

def show_cart_contents
@html=external_fetch('POST',URI.parse('http://'+ZENCART_SERVER+'/zencart/index.php?main_page=shopping_cart'),nil)  
logger.debug("ZENCART CART FETCH URL: http://"+ZENCART_SERVER+"/zencart/index.php?main_page=shopping_cart")
@html.gsub!(/<html.*?>.*<body.*?>/m,'')
@html.gsub!(/<head>.*<\/head>/m,'')
end


def hire_product
  
  #send out our hire notice.
  #find our object description
  if params[:type]=='resource'
    myResource=Resource.find(params[:id])
    #create a new borrowed item entry
    if myResource != nil
      logger.debug("DEBUG: HIRE: About to send email")
      
      if @login.username.to_s=~/\@/
      HireNotice.deliver_email_hire_notice(@login.username,@login.id,'resource',myResource.id,myResource.frbr_ui_desc,'')
      else
      HireNotice.deliver_email_hire_notice("#{@login.username}<info@sounz.org.nz>",@login.id,'resource',myResource.id,myResource.frbr_ui_desc,'')
      end
    else
      logger.debug("DEBUG: HIRE: failed to find resource id: #{params[:id]}")
    end
  elsif params[:type]=='manifestation'
    myManifestation=Manifestation.find(params[:id])
    if myManifestation != nil
      logger.debug("DEBUG: HIRE: About to send email")
      if @login.username.to_s=~/\@/
      HireNotice.deliver_email_hire_notice(@login.username,@login.id,'manifestation',myManifestation.id,myManifestation.frbr_ui_desc,'')
      else
      HireNotice.deliver_email_hire_notice("#{@login.username}<info@sounz.org.nz>",@login.id,'manifestation',myManifestation.id,myManifestation.frbr_ui_desc,'')
      end
    else
      logger.debug("DEBUG: HIRE: failed to find manifestation id: #{params[:id]}")
    end
  else
  logger.debug("DEBUG: HIRE: hire object type not recognised!")
  return false
  end
   
  #redirect to hire confirm page - just fall through to the partial
  
end

#
# Send Loan Request notification to SOUNZ administrator
#
def reserve_product
  
  method = params[:method]
  type   = params[:type]
  
  #send out our reserve product notice.
  #find our object description
  if type == 'resource'
    object = Resource.find(params[:id])
	
  elsif type =='manifestation'
    object = Manifestation.find(params[:id])
  else
    logger.debug("DEBUG: RESERVE: reserve object type not recognised!")
    return false
  end
  
  if !object.blank? && !method.blank? && !type.blank?
    logger.debug("DEBUG: RESERVE: About to send email")
    
	username = @login.username
	username = @login.username.to_s + "<info@sounz.org.nz>" unless username.to_s=~/\@/
	
	HireNotice.deliver_email_hire_notice(username, @login.id, type, object.id, object.frbr_ui_desc, '', method)
  else
	logger.debug("DEBUG: RESERVE: ERROR ")
  end
  
end


def add_product_to_cart
  product_id=params[:id]
  product_type=params[:type]
  method=params[:method]
  count = (params[:count].blank? ? "1" : params[:count])
  logger.debug("ADDING ITEM FOR #{method} OF TYPE #{product_type} AND ID #{product_id} TO CART!")
  if product_id.blank?
    logger.debug('No product id specified!')
    return nil
  end
  
  if count.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil 
    logger.debug("Count #{count} is not a valid number, setting to 1.")
    count = 1
  end 
  
  if method=='loan'
    if product_type=='manifestation'
      myManifestation=Manifestation.find(product_id)
      
      #loan manifestation
      if myManifestation != nil
      zencart_product_id=myManifestation.loan_product_id
      logger.debug("ADDING PRODUCT_ID #{zencart_product_id} to CART!")
      external_fetch('POST',URI.parse('http://'+ZENCART_SERVER+'/zencart/index.php?action=add_product'),"main_page=product_info&cPath=2&products_id=#{zencart_product_id}&action=add_product&cart_quantity=1")
      end
      
    elsif product_type=='resource'
      myResource=Resource.find(product_id)
      
      #loan resource
      if myResource != nil
      zencart_product_id=myResource.loan_product_id
	  logger.debug("DEBUG: zencart_product_id  (#{zencart_product_id})")
      external_fetch('POST',URI.parse('http://'+ZENCART_SERVER+'/zencart/index.php?action=add_product'),"main_page=product_info&cPath=2&products_id=#{zencart_product_id}&action=add_product&cart_quantity=1")
      end
      
    else
      logger.debug("Unrecognised product type (#{product_type})")
    end
    
  elsif method == 'sale'
    if product_type=='manifestation'
      myManifestation=Manifestation.find(product_id)
      
      #sale manifestation
      if myManifestation != nil
        zencart_product_id=myManifestation.sale_product_id
        logger.debug("ADDING #{count} x PRODUCT_ID #{zencart_product_id} to CART!")
        if myManifestation.downloadable
          if myManifestation.format.format_desc=='digital sound file - MP3'
          #use attribute 1
          external_fetch('POST',URI.parse('http://'+ZENCART_SERVER+'/zencart/index.php?action=add_product'),"main_page=product_info&cPath=2&id[1]=1&products_id=#{zencart_product_id}&action=add_product&cart_quantity=#{count}")
          else
          # use attribute 2
          external_fetch('POST',URI.parse('http://'+ZENCART_SERVER+'/zencart/index.php?action=add_product'),"main_page=product_info&cPath=2&id[1]=2&products_id=#{zencart_product_id}&action=add_product&cart_quantity=#{count}")
          end
              
        else
          external_fetch('POST',URI.parse('http://'+ZENCART_SERVER+'/zencart/index.php?action=add_product'),"main_page=product_info&cPath=2&products_id=#{zencart_product_id}&action=add_product&cart_quantity=#{count}")
        end
      
      end
      
    elsif product_type=='resource'
      myResource=Resource.find(product_id)
      
      #sale resource
      if myResource != nil
      zencart_product_id=myResource.sale_product_id
        if myResource.downloadable
         if myResource.format.format_desc=='digital sound file - MP3'
         #use attribute 1
          external_fetch('POST',URI.parse('http://'+ZENCART_SERVER+'/zencart/index.php?action=add_product'),"main_page=product_info&cPath=2&id[1]=1&products_id=#{zencart_product_id}&action=add_product&cart_quantity=#{count}")
         
         else
         #use attribute 2
          external_fetch('POST',URI.parse('http://'+ZENCART_SERVER+'/zencart/index.php?action=add_product'),"main_page=product_info&cPath=2&id[1]=2&products_id=#{zencart_product_id}&action=add_product&cart_quantity=#{count}")
         
         end
          
        else
          external_fetch('POST',URI.parse('http://'+ZENCART_SERVER+'/zencart/index.php?action=add_product'),"main_page=product_info&cPath=2&products_id=#{zencart_product_id}&action=add_product&cart_quantity=#{count}")
        end
      end
      
    elsif product_type=='donation'
      myDonation=SounzDonation.find(product_id)
      if myDonation != nil
      zencart_product_id=myDonation.sounz_donation_id
      external_fetch('POST',URI.parse('http://'+ZENCART_SERVER+'/zencart/index.php?action=add_product'),"main_page=product_info&cPath=2&products_id=#{zencart_product_id}&action=add_product&cart_quantity=1")
        
      end
    elsif product_type=='service'
      myService=SounzService.find(product_id)
      if myService != nil
      zencart_product_id=myService.sounz_service_id
      external_fetch('POST',URI.parse('http://'+ZENCART_SERVER+'/zencart/index.php?action=add_product'),"main_page=product_info&cPath=2&products_id=#{zencart_product_id}&action=add_product&cart_quantity=1")
        
      end
    else
    logger.debug("Unrecognised product type (#{product_type})")
    end
  
  
    
  else
  logger.debug("Unrecognised method (#{method})")
  end
  
  render :partial => 'show_cart'
end



def show_memberships
  serviceList=SounzService.find(:all,:order => 'sounz_service_price')
  @services=[]
  for service in serviceList
    @services << service
  end  
  #do nothing - just defer to the rhtml
end


def show_donations
  #find our ids and put them in our id array
  donationList=SounzDonation.find(:all)
  @donations=Hash.new()
  for donation in donationList
    @donations["#{donation.sounz_donation_price.to_i}"]=donation.sounz_donation_id
  end
  
  #do nothing - just defer to the rhtml
end


def show_orders
  zc_statuses=ActiveRecord::Base.connection.execute("SELECT orders_status_name,orders_status_id from zencartorders_status")
  @statuses=[]
  for zc_status in zc_statuses
  status=[zc_status['orders_status_name'],zc_status['orders_status_id'].to_i]
  @statuses << status
  
  end
  
  @results=[]
  @orders={}
  @results=ActiveRecord::Base.connection.execute("SELECT * from sounz_orders order by date_purchased DESC")
  for result in @results
    orders=ActiveRecord::Base.connection.execute("SELECT * from zencartorders_products where orders_id=#{result['orders_id']}")
    @orders[result['orders_id']]=orders
  end
  
  # do nothing - defer to the rhtml
  
end

def update_status
  #ensure this is an integer
  order_id = params[:order_id].to_i

  status = params[:status_id]

  email = params[:send_confirmation]

  sql = "SELECT orders_status, customers_id FROM sounz_orders where orders_id=#{order_id} limit 1"

  orders = ActiveRecord::Base.connection.execute(sql)

  for order in orders
    order = order
  end
  
  logger.debug order.to_yaml

  if order['orders_status'] != status
    old_status = order['orders_status']
    logger.debug("STATUS_ID: #{order['orders_status']} CUSTOMER_ID: #{order['customers_id']}")
    ActiveRecord::Base.connection.execute("UPDATE zencartorders set orders_status=#{status} where orders_id=#{order_id}")
    
	  notified = 1
    if email.blank?
      notified = 0
    end
	
    ActiveRecord::Base.connection.execute("INSERT INTO zencartorders_status_history (orders_id,orders_status_id,date_added,customer_notified) VALUES (#{order_id},#{status},now(),#{notified})")
    #retrieve our status texts
    statusrecs=ActiveRecord::Base.connection.execute("SELECT orders_status_name from zencartorders_status where orders_status_id=#{status}")
    for statusrec in statusrecs
      statusrec = statusrec
    end

    status_text=statusrec['orders_status_name']
    statusrec=ActiveRecord::Base.connection.execute("SELECT orders_status_name from zencartorders_status where orders_status_id=#{old_status}")
    for statusrec in statusrecs
      statusrec = statusrec
    end
    
    old_status_text=statusrec['orders_status_name']
    
    if ! email.blank?
      #send our status update email.
      #look up our users email address
      sql = "SELECT customers_email_address, customers_firstname FROM sounz_zencart_customers where customers_id=#{order['customers_id']} limit 1"
      recipient_details = ActiveRecord::Base.connection.execute(sql)  
      for recipient_detail in recipient_details
        recipient_detail = recipient_detail
      end
      recipient = recipient_detail['customers_email_address']
      name = recipient_detail['customers_firstname']
      note = nil
	    #note="Previous order Status: #{old_status_text}.\n\nNew order status: #{status_text}\n\n"  
      
	    if ! recipient.blank?
        StatusNotice.deliver_email_status(recipient, name, note, order_id, status_text, old_status_text) 
      end   
      
    end
  end
  redirect_to :action => 'show_orders'
end



end