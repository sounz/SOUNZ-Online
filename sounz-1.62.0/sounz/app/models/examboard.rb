class Examboard < ActiveRecord::Base
  set_primary_key "examboard_id" 
    
  # model relationships
  has_many :exam_set_works
  
  # model validation
  validates_presence_of :examboard_name,
            :message => "cannot be empty"

end
