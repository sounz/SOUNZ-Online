
require 'application_helper'
require 'net/http'

class LoanItemController < ApplicationController
  
  include ApplicationHelper

  def show
  @item=Item.find(params[:id])
  end

  def loan_item
    @item = Item.find(params[:id])
    if @item != nil
    
    login = Login.find(params[:user_login])
	
	# processing to find reserved borrowed item for that item manifestation or resource
	# if the one exist for that login, use it instead of creating a new borrowed item record 
	reserved_bi = nil
	conditions = "login_id =" + login.login_id.to_s + " AND reserved IS TRUE AND date_returned IS NULL"
	if ! @item.manifestation.blank?
	  conditions += " AND manifestation_id =" + @item.manifestation.manifestation_id.to_s
	  reserved_bi = BorrowedItem.find(:first, :joins => 'inner join items using (item_id)', :conditions => conditions)
	elsif ! @item.resource.blank?
	  conditions += " AND resource_id =" + @item.resource.resource_id.to_s
	  reserved_bi = BorrowedItem.find(:first, :joins => 'inner join items using (item_id)', :conditions => conditions)
	end
    
	if reserved_bi.blank?
	  #create a borrowed_item reference
      bi = BorrowedItem.new()
      bi.login_id = params[:user_login]
    else
      bi = BorrowedItem.find(reserved_bi.borrowed_item_id)
	  bi.reserved = false
	end	
	
	bi.item_id = @item.id
    db = params[:date_borrowed]
    dd = params[:date_due]
    bi.date_borrowed = "#{db[:year]}-#{db[:month]}-#{db[:day]}"
    bi.date_due = "#{dd[:year]}-#{dd[:month]}-#{dd[:day]}"
    bi.hired_out = false
    bi.borrowing_note = params[:borrowed_item][:borrowing_note]
    #bi.hire_cost=params[:hire_cost]
    if bi.save()
    #we need to mark our item as out on loan or hire
    @item.out_on_loan_or_hire = true;
    @item.save()
    
	# if login has subscription count membership (currently
    # only SOUNZ Standard Library Membership)
	# decrease the count on the manual issued loan
	if reserved_bi.blank?
	  membership = Membership.get_subscription_item_count_membership(login, 'library')
	  membership.decrease_loan_count(1) unless membership.blank?
	end
	
    else
    #error!
    logger.debug("Loan Error!")
    end
    
    
    else
    render :action => 'show'
    end    
    
    
    
  end

end


