class FindCommunicationsController < ApplicationController
  include FindCommunicatonsHelper
  
def index
@communication_types = CommunicationType.find(:all)
end


def search
   debug_message "Searching communications"
   organisation_query = params[:search][:organisation]
   person_query = params[:search][:person]
   freetext_query = params[:search][:freetext]
   type_ids = params[:search][:communication_type_id_ids]
   last_modified = params[:search][:modified_since]

   debug_message "Freetext query is #{freetext_query}"
   @communications = find_communications(person_query, organisation_query, freetext_query, type_ids, last_modified)
  # debug_message "Communications from search is nil?.... "+(@communications==nil).to_s
 #  for communication in @communications
  #  debug_message "Result comm is nil?... #{communication == nil}"
 #  end
    render :layout => false
end


end
