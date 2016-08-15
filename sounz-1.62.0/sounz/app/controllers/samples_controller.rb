class SamplesController < ApplicationController
  
  include AttachmentHelper
  include StatusesHelper
  
  
  # GET /samples
  # GET /samples.xml
  def index
    @samples = Sample.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @samples.to_xml }
    end
  end

  # GET /samples/1
  # GET /samples/1.xml
  def show
    @sample = Sample.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @sample.to_xml }
    end
  end

  # GET /samples/new
  def new
    @sample = Sample.new
    get_statuses(@sample)
  end

  # GET /samples/1;edit
  def edit
    @sample = Sample.find(params[:id])
    get_statuses(@sample)
    @media_items = attachments(@sample)
  end

  # POST /samples
  # POST /samples.xml
  def create
    @sample = Sample.new(params[:sample])
    get_statuses(@sample)
    
    respond_to do |format|
      if @sample.save
        flash[:notice] = 'Sample was successfully created.'
        format.html { redirect_to sample_url(@sample) }
        format.xml  { head :created, :location => sample_url(@sample) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sample.errors.to_xml }
      end
    end
  end

  # PUT /samples/1
  # PUT /samples/1.xml
  def update
    @sample = Sample.find(params[:id])
    get_statuses(@sample)
    
    respond_to do |format|
      if @sample.update_attributes(params[:sample])
        flash[:notice] = 'Sample was successfully updated.'
        format.html { redirect_to sample_url(@sample) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sample.errors.to_xml }
      end
    end
  end

  # DELETE /samples/1
  # DELETE /samples/1.xml
  def destroy
    @sample = Sample.find(params[:id])
    @sample.destroy

    respond_to do |format|
      format.html { redirect_to samples_url }
      format.xml  { head :ok }
    end
  end
end
