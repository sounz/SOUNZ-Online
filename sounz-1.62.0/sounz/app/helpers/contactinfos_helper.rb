module ContactinfosHelper
  
  #Return a country code for facet purposes - get it either from the country or region.country
  #The issue here is that country can be nil in the database
  def self.get_country_from_country_or_region(contactinfo)
    result_country = contactinfo.country
    if result_country.blank? and !contactinfo.region.blank?
      result_country = contactinfo.region.country
    end
    result_country
  end
end
