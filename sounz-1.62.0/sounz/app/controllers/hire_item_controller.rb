
require 'application_helper'
require 'net/http'

class HireItemController < ApplicationController
  
  include ApplicationHelper

  def show
  @item=Item.find(params[:id])
  end

  def hire_item
    show_params(params)
    @item=Item.find(params[:id])
    if @item != nil
    #create a borrowed_item reference
    
    bi=BorrowedItem.new()
    bi.item_id=@item.id
    bi.login_id=params[:user_login]
    db=params[:date_hired]
    dd=params[:date_due]
    bi.date_borrowed="#{db[:year]}-#{db[:month]}-#{db[:day]}"
    bi.date_due="#{dd[:year]}-#{dd[:month]}-#{dd[:day]}"
    bi.hired_out=true
    bi.hire_cost=params[:hire_cost]
    if bi.save()
    #we need to mark our item as out on loan or hire
    @item.out_on_loan_or_hire=true;
    @item.save()
    
    #do nothing
    
    else
    #error!
    logger.debug("Hiring Error!")
    end
    
    
    else
    render :action => 'show'
    end    
    
    
    
  end

end


