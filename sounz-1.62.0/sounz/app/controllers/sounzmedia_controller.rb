class SounzmediaController < ApplicationController
  
  include SounzmediaHelper
  include ApplicationHelper
  
  def list
    @sounzmedia = get_sounzmedia()
    @results = paginate_collection(@sounzmedia, {:page => params[:page], :per_page => 20})
  end

end