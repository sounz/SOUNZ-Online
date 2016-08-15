class ModalController < ApplicationController
  
  
  #This is used to set the modal dialog title
  def loading
      @title = params[:title]
      render :layout => false
  end
end
