class ConceptTypesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @concept_types = ConceptType.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @concept_type = ConceptType.find(params[:id])
  end

  def new
    @concept_type = ConceptType.new
  end

  def create
    @concept_type = ConceptType.new(params[:concept_type])
    if @concept_type.save
      flash[:notice] = 'ConceptType was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @concept_type = ConceptType.find(params[:id])
  end

  def update
    @concept_type = ConceptType.find(params[:id])
    if @concept_type.update_attributes(params[:concept_type])
      flash[:notice] = 'ConceptType was successfully updated.'
      redirect_to :action => 'show', :id => @concept_type
    else
      render :action => 'edit'
    end
  end

  def destroy
    ConceptType.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
