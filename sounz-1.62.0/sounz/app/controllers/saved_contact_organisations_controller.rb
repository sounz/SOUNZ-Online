class SavedContactOrganisationsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @saved_contact_organisation_pages, @saved_contact_organisations = paginate :saved_contact_organisations, :per_page => 10
  end

  def show
    @saved_contact_organisation = SavedContactOrganisation.find(params[:id])
  end

  def new
    @saved_contact_organisation = SavedContactOrganisation.new
  end

  def create
    @saved_contact_organisation = SavedContactOrganisation.new(params[:saved_contact_organisation])
    if @saved_contact_organisation.save
      flash[:notice] = 'SavedContactOrganisation was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @saved_contact_organisation = SavedContactOrganisation.find(params[:id])
  end

  def update
    @saved_contact_organisation = SavedContactOrganisation.find(params[:id])
    if @saved_contact_organisation.update_attributes(params[:saved_contact_organisation])
      flash[:notice] = 'SavedContactOrganisation was successfully updated.'
      redirect_to :action => 'show', :id => @saved_contact_organisation
    else
      render :action => 'edit'
    end
  end

  def destroy
    SavedContactOrganisation.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
