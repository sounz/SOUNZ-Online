class MailoutContactsController < ApplicationController
  include ApplicationHelper
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @mailout_contacts = MailoutContact.paginate( :page => params[:page], :per_page => 10)
  end
  
  def edit
    @mailout_contact = MailoutContact.find(params[:id])
  end

  def update
    @mailout_contact = MailoutContact.find(params[:id])
        
    # updated by
    @mailout_contact.updated_by = get_user.login_id
       
    if @mailout_contact.update_self(params[:mailout_contact])
      flash[:notice] = 'Mailout Contact was successfully updated.'
      redirect_to :action => 'edit', :id => @mailout_contact
    else
      render :action => 'edit'
    end
  end

  def destroy
    MailoutContact.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
