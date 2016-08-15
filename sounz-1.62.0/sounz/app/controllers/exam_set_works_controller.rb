class ExamSetWorksController < ApplicationController
  include ModelAsStringHelper
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @exam_set_works = ExamSetWork.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @exam_set_work = ExamSetWork.find(params[:id])
  end

  def new
    @exam_set_work = ExamSetWork.new
  end

  def create
    @exam_set_work = ExamSetWork.new(params[:exam_set_work])
    if @exam_set_work.save
      flash[:notice] = 'ExamSetWork was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @exam_set_work = ExamSetWork.find(params[:id])
  end

  def update
    @exam_set_work = ExamSetWork.find(params[:id])
    if @exam_set_work.update_attributes(params[:exam_set_work])
      flash[:notice] = 'ExamSetWork was successfully updated.'
      redirect_to :action => 'show', :id => @exam_set_work
    else
      render :action => 'edit'
    end
  end

  def destroy
    ExamSetWork.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  
  # -------------------------------------
  # - Dynamically add new exam set work -
  # -------------------------------------
  def add_exam_set_work
    
    @exam_set_work = ExamSetWork.new(params[:exam_set_work])
    
    @manifestation = Manifestation.find(params[:exam_set_work][:manifestation_id])    
    @saved = @exam_set_work.save
    if @saved
      @dom_id = generate_id(@exam_set_work)
      @exam_set_work = ExamSetWork.new
    end
 
  end
  
  # ----------------------------------------
  # - Dynamically remove the exam set work -
  # ----------------------------------------
  def delete_exam_set_work
    @exam_set_work = ExamSetWork.find(params[:id])
    manifestation = @exam_set_work.manifestation
    @exam_set_work.destroy  
    
    @exam_set_work = ExamSetWork.new
    
    render :partial => 'new_exam_set_work', :locals => { :manifestation => manifestation }
  end
  
  #- Display edit exam set work
  def edit_exam_set_work
  	@exam_set_work = ExamSetWork.find(params[:exam_set_work_id])
	@manifestation = @exam_set_work.manifestation
	@dom_id = generate_id(@exam_set_work)
  end
  
  def update_exam_set_work
    
    @exam_set_work = ExamSetWork.find(params[:exam_set_work_id])
    
    @manifestation = Manifestation.find(params[:exam_set_work][:manifestation_id])    
    @saved = @exam_set_work.save
    if @exam_set_work.update_attributes(params[:exam_set_work])
      @dom_id = generate_id(@exam_set_work)
      @exam_set_work = ExamSetWork.new
    end
 
  end
  
  #----------------------------
  #- Cancel and hide the form -
  #----------------------------
  def cancel_exam_set_work_form
	@exam_set_work = ExamSetWork.find(params[:exam_set_work_id])
		  
	@manifestation = @exam_set_work.manifestation
    
	@dom_id = generate_id(@exam_set_work)
	@exam_set_work = ExamSetWork.new
  end  
  
end
