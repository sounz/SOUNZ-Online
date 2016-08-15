class ShopController < ApplicationController
  
  #Stub for buying a manifestation
  
  #FIXME - this needs to use items eventually
  def purchase
    @manifestation = Manifestation.find(params[:id])
    @page_title = "Purchase #{@manifestation.manifestation_title}"
  end
end
