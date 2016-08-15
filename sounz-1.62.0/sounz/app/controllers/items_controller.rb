class ItemsController < ApplicationController

  include ApplicationHelper
  include ModelAsStringHelper
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @items = Item.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(params[:item])
    
    # updated by
    @item.updated_by = get_user.login_id
    
    if @item.save
      flash[:notice] = 'Item was successfully created.'
      redirect_to :action => 'edit', :id => @item.item_id
    else
      render :action => 'new'
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    
    # updated by
    @item.updated_by = get_user.login_id
    
    if @item.update_attributes(params[:item])
      flash[:notice] = 'Item was successfully updated.'
      redirect_to :action => 'edit', :id => @item
    else
      render :action => 'edit'
    end
  end

  def destroy
    Item.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  #--------------------------------------------------------
  #- Show item form for an update from appropriate entity -
  #--------------------------------------------------------
  def show_item_update_form
    # get entity which we are coming from
    @entity = convert_id_to_model(params[:id])
    @item = Item.find(params[:item_id])
    @dom_id = generate_id(@item)
               
    render :layout => false
  end
  
  #-------------------------------------------
  #- Show add item form for creating an item -
  #- from appropriate entity                 -
  #-------------------------------------------
  def show_add_item_form
    # get entity which we are coming from
    @entity = convert_id_to_model(params[:id])
    
    initialise_item
    
    logger.debug @item.to_yaml
    render :partial => "items/new_item_form", :locals => { :entity => @entity, :item => @item }
  end

  #---------------------------------------------
  #- Initialise item based on the entity which -
  #- we are coming from                        -
  #---------------------------------------------
  def initialise_item
    
    @item = Item.new
    
    # if coming from manifestations
    if !@entity.blank? && params[:id].match('manifestation_*')    
      @item.send('manifestation_id=', @entity.manifestation_id)
      @item.send('item_category=', 'M')
    end
    
    # if coming from resources
    if !@entity.blank? && params[:id].match('resource_*')  
      @item.send('resource_id=', @entity.resource_id)
      @item.send('item_category=', 'R')
    end
    
  end

  #---------------
  #- Update item -
  #---------------
  def update_item
    # get entity which we are coming from
    @entity = convert_id_to_model(params[:id])
    
    @item = Item.find(params[:item_id])
    @dom_id = generate_id(@item)
    @item.updated_by = @login.login_id
        
    @saved = @item.update_attributes(params[:item])
    if @saved
      @dom_id = generate_id(@item)
      flash[:notice] = 'Item was successfully updated.'
    end   
  end

  #---------------
  #- Create item -
  #---------------
  def create_item
    # how many items to create with the same details
    no_of_times_to_add = params[:items][:no_to_add] unless params[:items].blank?
    
	no_of_times_to_add = 1 if no_of_times_to_add.blank?
    
	no_of_times_to_add.to_i.times do
      # get entity which we are coming from
      @entity = convert_id_to_model(params[:id])
      @item = Item.new(params[:item])
      @dom_id = generate_id(@item)
      @item.updated_by = @login.login_id
       
      @saved = @item.save
      if @saved
        @dom_id = generate_id(@item)
        flash[:notice] = 'Item was successfully created.'
      else
          # get hidden values for form
          @item.item_category = params[:item][:item_category]
          @item.manifestation_id = params[:item][:manifestation_id]
          @item.resource_id = params[:item][:resource_id]       
      end
    end
    
  end

  #----------------------------
  #- Cancel and hide the form -
  #----------------------------
  def cancel_item_form
    # get entity which we are coming from
    @entity = convert_id_to_model(params[:id])
    if !params[:item_id].blank?
      @item = Item.find(params[:item_id])
      @dom_id = generate_id(@item)
    end
    render :layout => false
  end
  
  #-------------------
  #- Delete the item -
  #-------------------
  def delete_item
    # get entity which we are coming from
    @entity = convert_id_to_model(params[:id])
    @item = Item.find(params[:item_id])
    @dom_id = generate_id(@item)
    @item.destroy
  end
  
  
end
