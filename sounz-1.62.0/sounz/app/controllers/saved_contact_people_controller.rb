class SavedContactPeopleController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @saved_contact_person_pages, @saved_contact_people = paginate :saved_contact_people, :per_page => 10
  end

  def show
    @saved_contact_person = SavedContactPerson.find(params[:id])
  end

  def new
    @saved_contact_person = SavedContactPerson.new
  end

  def create
    @saved_contact_person = SavedContactPerson.new(params[:saved_contact_person])
    if @saved_contact_person.save
      flash[:notice] = 'SavedContactPerson was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @saved_contact_person = SavedContactPerson.find(params[:id])
  end

  def update
    @saved_contact_person = SavedContactPerson.find(params[:id])
    if @saved_contact_person.update_attributes(params[:saved_contact_person])
      flash[:notice] = 'SavedContactPerson was successfully updated.'
      redirect_to :action => 'show', :id => @saved_contact_person
    else
      render :action => 'edit'
    end
  end

  def destroy
    SavedContactPerson.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
