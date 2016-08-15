class SounzDonationsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @sounz_donations = SounzDonation.paginate( :page => params[:page], :per_page => 10)
  end

  def show
    @sounz_donation = SounzDonation.find(params[:id])
  end

  def new
    @sounz_donation = SounzDonation.new
  end

  def create
    @sounz_donation = SounzDonation.new(params[:sounz_donation])
    if @sounz_donation.save
      flash[:notice] = 'SounzDonation was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @sounz_donation = SounzDonation.find(params[:id])
  end

  def update
    @sounz_donation = SounzDonation.find(params[:id])
    if @sounz_donation.update_attributes(params[:sounz_donation])
      flash[:notice] = 'SounzDonation was successfully updated.'
      redirect_to :action => 'show', :id => @sounz_donation
    else
      render :action => 'edit'
    end
  end

  def destroy
    SounzDonation.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
