
class FrbrCoreWizardController < ApplicationController
  
def index
@frbr_core=Hash.new()
@frbr_core["completed_steps"]=Array.new()
@frbr_core["steps_to_go"]=["Collect manifestation","Collect expressions","Assign works","Assign superworks","Categorise works","Assign contributors","Create relationships"]
@frbr_core["step"]="find_manifestation"
session[:frbr_core_wizard]=@frbr_core
@frbr_core["manifestation"]=Manifestation.new()
@frbr_core["currentExpression"]=0
@frbr_core["expressionContainer"]=Array.new()
render :action => :show
end

def show
  #create a new manifestation, expression, work and superwork object, marked temporary in the db
  #show step 1 - find manifestation
  # if manifestation not found, show create manifestation
  #with manifestation
  #show step 2 - find expression
  # if expression not found, show create expression
  #show step 3 - find work
  # if work not found, show create work
  #show step 4 - find superwork
  # if superwork not found, show create superwork
  #step 5 - link objects together
  #step 6 - save objects
  @frbr_core=session[:frbr_core_wizard]
  if @frbr_core == nil
  logger.info("NONEXISTANT session object! badness!")
  end
  if (params["step"] != nil)
    step=params["step"]
  else
   step=@frbr_core["step"]
  end
  
  logger.info("STEP PARAM: "+params["step"].to_s)
  
  if step == "create_manifestation"
    @frbr_core["step"]=  "create_manifestation"
    @manifestation=@frbr_core["manifestation"]
    @statuses=Status.find(:all)
    @formats=Format.find(:all)
  
  elsif step == "find_expression"
    @manifestation=@frbr_core["manifestation"]
    @expressionContainer=@frbr_core["expressionContainer"]
    @frbr_core["step"]=  "find_expression"
  
  elsif step == "create_expression"
    @frbr_core["step"]="create_expression"
    @manifestation=@frbr_core["manifestation"]
    @expressionContainer=@frbr_core["expressionContainer"]
    @statuses=Status.find(:all)
    @modes=Mode.find(:all)
  
  elsif step == "assign_works"
    @frbr_core["step"]=  "assign_works"
    @frbr_core["completed_steps"] << "Collect expressions"
    @frbr_core["steps_to_go"].delete("Collect expressions")
    @manifestation=@frbr_core["manifestation"]
    @expressionContainer=@frbr_core["expressionContainer"]
    @currentExpressionId=@frbr_core["currentExpression"]
    @statuses=Status.find(:all)
  
  
  elsif step == "find_work"
    @frbr_core["step"]=  "find_work"
    @manifestation=@frbr_core["manifestation"]
    @expressionContainer=@frbr_core["expressionContainer"]
    @work=@frbr_core["work"]
    @statuses=Status.find(:all)
  
  elsif step == "create_work"
    @frbr_core["step"]=  "create_work"
    @manifestation=@frbr_core["manifestation"]
    @expressionContainer=@frbr_core["expressionContainer"]
    @work=@frbr_core["work"]
    @statuses=Status.find(:all)
    
  
  elsif step == "find_superwork"
    @frbr_core["step"]= "find_expression"
  
  elsif step == "create_superwork"
    @frbr_core["step"]="create_superwork"
    @superwork=@frbr_core["superwork"]
    @statuses=Status.find(:all)
  
  end
  

end


def find_manifestation
  
end

def find_expression
  
end

def find_work
  
end

def find_superwork
  
end

def add_manifestation
#update our session-based manifestation
#with the data from our form.
@frbr_core=session[:frbr_core_wizard]
    @frbr_core["manifestation"]=Manifestation.new(params[:manifestation])
      if @frbr_core["manifestation"] != nil
      flash[:notice] = 'Manifestation was successfully collected.'
      @frbr_core["step"]= "find_expression"
      @frbr_core["completed_steps"] << "Collect manifestation"
      @frbr_core["steps_to_go"].delete("Collect manifestation")
      session[:frbr_core_wizard]=@frbr_core   
      redirect_to :action => 'show'
    else
      logger.info("There was a problem collecting Manifestation")
      flash[:notice] = 'There was a problem collecting Manifestation!'
      render :action => 'show'
    end
end


def add_expression
#update our session-based expression
#with the data from our form.
    hashContainer=Hash.new()
    hashContainer["expression"]=Expression.new(params[:expression])
    hashContainer["work"]=Work.new()
    hashContainer["superwork"]=Superwork.new()
    session[:frbr_core_wizard]["expressionContainer"] << hashContainer
    flash[:notice] = 'Expression was successfully collected.'
    session[:frbr_core_wizard]["step"]= "find_expression"
    redirect_to :action => 'show'
    
end

def add_work
#update our session-based work
#with the data from our form.
@frbr_core=session[:frbr_core_wizard]
    session[:frbr_core_wizard]["work"]=Work.new(params[:work])
      if @frbr_core["work"] != nil
      flash[:notice] = 'Work was successfully collected.'
      @frbr_core["step"]= "find_superwork"
      @frbr_core["completed_steps"] << "Collect work"
      @frbr_core["steps_to_go"].delete("Collect work")
      session[:frbr_core_wizard]=@frbr_core   
      redirect_to :action => 'show'
    else
      logger.info("There was a problem collecting Work")
      flash[:notice] = 'There was a problem collecting Work!'
      render :action => 'show'
    end
end

def add_superwork
#update our session-based work
#with the data from our form.
@frbr_core=session[:frbr_core_wizard]
    @frbr_core["superwork"]=Superwork.new(params[:superwork])
      if @frbr_core["superwork"] != nil
      flash[:notice] = 'Superwork was successfully collected.'
      @frbr_core["step"]= "assign_contributors"
      @frbr_core["completed_steps"] << "Collect Superwork"
      @frbr_core["steps_to_go"].delete("Collect Superwork")
      session[:frbr_core_wizard]=@frbr_core   
      redirect_to :action => 'show'
    else
      logger.info("There was a problem collecting Superwork")
      flash[:notice] = 'There was a problem collecting Superwork!'
      render :action => 'show'
    end  
end

def categorise_work
  
end

def assign_contributors

end

def create_relationships

end

def link_and_save_objects

end  

end