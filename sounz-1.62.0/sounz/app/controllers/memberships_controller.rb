class MembershipsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @memberships = Membership.paginate( :page => params[:page], :per_page => 10)
  end

  def show
    @membership = Membership.find(params[:id])
  end

  def new
  	login = Login.find(params[:login])
    @membership = Membership.new
	@membership.login = login
  end

  def create
  	convert_datetime_to_db_format_in_params(params, 'membership', 'purchased_date')
	convert_datetime_to_db_format_in_params(params, 'membership', 'expiry_date')
    
	@membership = Membership.new(params[:membership])
	
	if @membership.valid_membership?

	  @membership.set_subscription_attributes(params[:membership])
      
	  if @membership.save
        flash[:notice] = 'Membership was successfully created.'
        redirect_to :action => 'show', :id => @membership
      else
        render :action => 'new'
      end
	  
	else
	  flash[:error] = 'Membership does not match Member Type. Please check the data you have entered'
	  render :action => 'new', :login => @membership.login
	end
  end

  #def edit
  #  @membership = Membership.find(params[:id])
  #end

  #def update
  #  @membership = Membership.find(params[:id])
	
  #  if @membership.update_attributes(params[:membership])
  #    flash[:notice] = 'Membership was successfully updated.'
  #    redirect_to :action => 'show', :id => @membership
  #  else
  #    render :action => 'edit'
  #  end
  #end

  def destroy
    Membership.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
