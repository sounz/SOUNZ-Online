class EventTypesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @event_types = EventType.paginate( :page => params[:page], :per_page => 10)
  end

  def show
    @event_type = EventType.find(params[:id])
  end

  def new
    @event_type = EventType.new
  end

  def create
    @event_type = EventType.new(params[:event_type])
    if @event_type.save
      flash[:notice] = 'EventType was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @event_type = EventType.find(params[:id])
  end

  def update
    @event_type = EventType.find(params[:id])
    if @event_type.update_attributes(params[:event_type])
      flash[:notice] = 'EventType was successfully updated.'
      redirect_to :action => 'show', :id => @event_type
    else
      render :action => 'edit'
    end
  end

  def destroy
    EventType.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
