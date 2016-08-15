class Country < ActiveRecord::Base
    set_primary_key :country_id
    has_many :regions, :order => :region_name
    has_many :contacinfos, :order => :country_name
    
    
    validates_presence_of(:country_name, :message => "Country must exist")
    validates_presence_of(:country_abbrev, :message => "Please provide a country code")
   
    validates_uniqueness_of(:country_abbrev, :message => "Must be unique")
    
validates_format_of(:country_abbrev, :with => /^[A-Z][A-Z]$/, :message => "Must be 2 letters and uppercase")
    
    #For adding new regions in the HTML interface
    acts_as_dropdown
    
    
    NEW_ZEALAND = Country.find(:first, :conditions => ['country_name = ?', 'New Zealand'])
    UNITED_KINGDOM = Country.find(:first, :conditions => ['country_name = ?', 'United Kingdom'])
    CANADA = Country.find(:first, :conditions => ['country_name = ?', 'Canada'])
    AUSTRALIA = Country.find(:first, :conditions => ['country_name = ?', 'Australia'])
    UNITED_STATES = Country.find(:first, :conditions => ['country_name = ?', 'United States'])
    
    
    #UK, Canada, Australia, US and Other
    
  #---------------------------------------------------------
  #- Return country object based on country_name parameter,-
  #- default is set to 'New Zealand'                       -
  #---------------------------------------------------------
  def self.get_default_country(country_name='New Zealand')
    country = Country.find(:first, :conditions => ['LOWER(country_name) = ?', country_name.downcase])
    return country
  end
   
end

