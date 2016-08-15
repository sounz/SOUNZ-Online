#
# Some fields in the database may be one of a few values, which are chosen by a
# dropdown select box in the UI. This model assists by providing an easy way to
# make the dropdowns
#
class DropDown
  
  attr_reader :id, :name
  attr_writer :id, :name
  
  #
  # Person genders
  #
  def self.genders(advanced_form = false)
    unspecified = DropDown.new
    unspecified.id = 'U'
    unspecified.name = "Unspecified"
    male = DropDown.new
    male.id='M'
    male.name = "Male"
    female = DropDown.new
    female.id='F'
    female.name = "Female"

    [unspecified, male, female]
  end
  
  
  #
  # This is either publisher or composer
  #
  def self.access_right_sources
     composer = DropDown.new
     composer.id = 'composer'
     composer.name = "Composer"

     publisher = DropDown.new
     publisher.id = 'publisher'
     publisher.name = "Publisher"

     [composer, publisher]
   end
   
   
   def self.concepts
      genre = DropDown.new
      genre.id = 'genre'
      genre.name = "Genre"

      influence = DropDown.new
      influence.id = 'influence'
      influence.name = "Influence"
      
      theme = DropDown.new
      theme.id = 'theme'
      theme.name = "Theme"

      [genre, influence, theme]
    end

  #
  # Contributor composer tiers
  #
  def self.composer_tiers(advanced_form = false)
    
    ct1 = DropDown.new
    ct1.id = 1
    ct1.name = 'Composer Tier 1'
    
    ct2 = DropDown.new
    ct2.id = 2
    ct2.name = 'Composer Tier 2'
    
    [ct1, ct2]
  end
  
  
  #For the advanced forms, a does not matter / true / false dropdown is required
  def self.true_false_dont_care

    a1 = DropDown.new
    a1.id = 'true'
    a1.name = 'True'
    
    a2 = DropDown.new
    a2.id = 'no'
    a2.name = 'false'
    
    [a1, a2]
  end
  
  
  #Used in distinctions
  def self.true_false

    a1 = DropDown.new
    a1.id = 'true'
    a1.name = 'True'
    
    a2 = DropDown.new
    a2.id = 'false'
    a2.name = 'False'
    
    [a1, a2]
  end
  
  
  #
  # Person genders
  #
  def self.expression_availabilities
    available = DropDown.new
    available.id='available'
    available.name = "Available"
    unavail = DropDown.new
    unavail.id='unavailable'
    unavail.name = "Unavailable"

    [available, unavail]
  end
  
  #
  # Work difficulties
  #
  def self.work_difficulties
    advanced = DropDown.new
    advanced.id=3
    advanced.name = "Advanced"
    
    intermediate = DropDown.new
    intermediate.id=2
    intermediate.name = "Intermediate"
    
    beginnner = DropDown.new
    beginnner.id=1
    beginnner.name = "Beginner"
    
    unknown = DropDown.new
    unknown.id=0
    unknown.name = "Unknown"


    [unknown,advanced,intermediate,beginnner]
  end
  
  #
  # Work difficulties for search
  #
  def self.work_difficulties_for_search
    advanced = DropDown.new
    advanced.id=3
    advanced.name = "Advanced"
    
    intermediate = DropDown.new
    intermediate.id=2
    intermediate.name = "Intermediate"
    
    beginner = DropDown.new
    beginner.id=1
    beginner.name = "Beginner"
    
    [beginner, intermediate, advanced]
  end

  #
  # Communication priorities
  #
  def self.communication_priorities
    not_applicable      = DropDown.new
    not_applicable.id   = 0
    not_applicable.name = "Not applicable"
    
    highest    = DropDown.new
    highest.id = 1
    highest.name = "Same day"
    
    high    = DropDown.new
    high.id = 2
    high.name = "24 hrs"
    
    normal      = DropDown.new
    normal.id   = 3
    normal.name = "48 hrs"

    low      = DropDown.new
    low.id   = 4
    low.name = "Within a week"
    
    unimportant      = DropDown.new
    unimportant.id   = 5
    unimportant.name = "Longer than a week"
    
    [not_applicable, highest, high, normal, low, unimportant]
    
  end
  
  #
  # 'Greater than', 'Less than', 'Equal to'
  # drop-down for sonline music search
  def self.bool_type_search
    equal      = DropDown.new
    equal.id   = 'equal'
    equal.name = "equal to"
    
    greater      = DropDown.new
    greater.id   = 'greater'
    greater.name = "greater then"
    
    less      = DropDown.new
    less.id   = 'less'
    less.name = "less than"
    
    [equal, greater, less]
     
  end
  
  # Role contactinfos contactinfo types including 'preferred'
  def self.role_contactinfo_types
    preferred      = DropDown.new
    preferred.id   ='preferred'
    preferred.name = "Preferred"
    
    postal      = DropDown.new
    postal.id   = 'postal'
    postal.name = "Postal"
    
    physical      = DropDown.new
    physical.id   = 'physical'
    physical.name = "Physical"
    
    billing      = DropDown.new
    billing.id   = 'billing'
    billing.name = "Billing"


    [preferred,postal,physical,billing]
  end  

end
