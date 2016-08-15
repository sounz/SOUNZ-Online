class PrivilegesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @privileges = Privilege.paginate( :page => params[:page], :per_page => 10)
  end

  def show
    @privilege = Privilege.find(params[:id])
    @member_types=@privilege.member_types
    
  end

  def new
    @privilege = Privilege.new
  end

  def create
    @privilege = Privilege.new(params[:privilege])
    if @privilege.save
      flash[:notice] = 'Privilege was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @privilege = Privilege.find(params[:id])
     @member_types=@privilege.member_types
  end

  def update
    @privilege = Privilege.find(params[:id])
    @member_types=@privilege.member_types
    if @privilege.update_attributes(params[:privilege])
      flash[:notice] = 'Privilege was successfully updated.'
      redirect_to :action => 'show', :id => @privilege
    else
      render :action => 'edit'
    end
  end

  def destroy
    Privilege.find(params[:id]).destroy
    redirect_to :action => 'list'
  end


def addMemberType
    @privilege = Privilege.find(params[:id])
  myMemberTypeId=params[:member_type][:member_type_id]
  if ! myMemberTypeId.blank?
    #check to see we havent already assigned this
    myMemberType=MemberType.find(myMemberTypeId)
    if ! @privilege.member_types.include?(myMemberType)
      @privilege.member_types << myMemberType  
    end
  end
  
  redirect_to :action => 'edit', :id => @privilege
end

def removeMemberType
  @privilege = Privilege.find(params[:id])
  myMemberTypeId=params[:member_type_id]
  if !myMemberTypeId.blank?  
    @privilege.member_types.delete(MemberType.find(myMemberTypeId))
  end
  redirect_to :action => 'edit', :id => @privilege
end



end
