class PersonContactinfosController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @person_contactinfo_pages, @person_contactinfos = paginate :person_contactinfos, :per_page => 10
  end

  def show
    @person_contactinfo = PersonContactinfo.find(params[:id])
  end

  def new
    @person_contactinfo = PersonContactinfo.new
  end

  def create
    @person_contactinfo = PersonContactinfo.new(params[:person_contactinfo])
    if @person_contactinfo.save
      flash[:notice] = 'PersonContactinfo was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @person_contactinfo = PersonContactinfo.find(params[:id])
  end

  def update
    @person_contactinfo = PersonContactinfo.find(params[:id])
    if @person_contactinfo.update_attributes(params[:person_contactinfo])
      flash[:notice] = 'PersonContactinfo was successfully updated.'
      redirect_to :action => 'show', :id => @person_contactinfo
    else
      render :action => 'edit'
    end
  end

  def destroy
    PersonContactinfo.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
