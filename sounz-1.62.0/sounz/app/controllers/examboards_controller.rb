class ExamboardsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @examboards = Examboard.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @examboard = Examboard.find(params[:id])
  end

  def new
    @examboard = Examboard.new
  end

  def create
    @examboard = Examboard.new(params[:examboard])
    if @examboard.save
      flash[:notice] = 'Examboard was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @examboard = Examboard.find(params[:id])
  end

  def update
    @examboard = Examboard.find(params[:id])
    if @examboard.update_attributes(params[:examboard])
      flash[:notice] = 'Examboard was successfully updated.'
      redirect_to :action => 'show', :id => @examboard
    else
      render :action => 'edit'
    end
  end

  def destroy
    Examboard.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
