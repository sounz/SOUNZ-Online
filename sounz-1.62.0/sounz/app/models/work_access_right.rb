class WorkAccessRight < ActiveRecord::Base
  set_primary_key :work_access_right_id
  
  belongs_to :access_right
  belongs_to :work
  
  validates_presence_of :access_right_source, :work, :access_right
  
  validates_inclusion_of :access_right_source, :in => ["publisher", "composer"]
  
  #Check for non duplicates
=begin
  def validate
    #test a new record
    if self.work_access_right_id.blank?
      ars = WorkAccessRight.count( 
      :conditions => ["access_right_id=? and and work_id=? and access_right_source ?"],
        access_right_id, work_id, access_right_id
      )
    else
    ars = WorkAccessRight.find(:first, 
                :conditions => ["work",?])
    end
  end
=end
end
