class ExamSetWork < ActiveRecord::Base
  set_primary_key "exam_set_work_id" 
    
  # model relationships
  belongs_to :examboard
  belongs_to :manifestation
  
  # model validation
  validates_presence_of :examboard_id,
                        :manifestation_id,
            :message => "cannot be empty"
end
