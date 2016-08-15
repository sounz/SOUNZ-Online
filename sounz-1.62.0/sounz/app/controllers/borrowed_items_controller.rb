class BorrowedItemsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @borrowed_items = BorrowedItem.paginate(:page => params[:page], :per_page => 20, :conditions => ['active is true'], :order=>'date_borrowed desc')
  end
  
  def inactive_list
	@borrowed_items = BorrowedItem.paginate(:page => params[:page], :per_page => 20, :conditions => ['active is false'], :order=>'date_borrowed desc') 
  end  

  def show
    @borrowed_item = BorrowedItem.find(params[:id])
  end

  def new
    @borrowed_item = BorrowedItem.new
  end

  def create
    @borrowed_item = BorrowedItem.new(params[:borrowed_item])
    if @borrowed_item.save
      flash[:notice] = 'BorrowedItem was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    # currently we can edit borrowed items from borrowed items search
    # or from borrowed items listing, hence, adding new params - from
    # to redirect to appropriate controller after editing
    @from = (params[:from].blank? ? 'borrowed_items' : params[:from])
    @borrowed_item = BorrowedItem.find(params[:id])
    @backlink = params[:backlink]
  end

  def update
    # currently we can edit borrowed items from borrowed items search
    # or from borrowed items listing, hence, adding new params - from
    # to redirect to appropriate controller after editing
    from = (params[:from].blank? ? 'borrowed_items' : params[:from])
    @borrowed_item = BorrowedItem.find(params[:id])
    #item=@borrowed_item.item
    #has this borrowed item been returned?
    
    if @borrowed_item.update_attributes(params[:borrowed_item])
      flash[:notice] = 'BorrowedItem was successfully updated.'
      if !params[:back][:link].blank?
        redirect_to params[:back][:link]
      else
        redirect_to :controller => from, :action => :index
      end
    else
      render :action => 'edit'
    end
  end

  def destroy
    # currently we can edit borrowed items from borrowed items search
    # or from borrowed items listing, hence, adding new params - from
    # to redirect to appropriate controller after editing    
    from = (params[:from].blank? ? 'borrowed_items' : params[:from])
    
    bi=BorrowedItem.find(params[:id])
    
    # set appropriate item to be available for loan/hire
    bi.item.out_on_loan_or_hire=false
	  bi.item.save()
	
	  bi.active   = false
	  bi.reserved = false
    bi.date_returned = Time.now()
    bi.save()
    
    redirect_to :controller => from, :action => :index
  end
end
