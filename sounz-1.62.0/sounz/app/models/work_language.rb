class WorkLanguage < ActiveRecord::Base
  belongs_to :work
  belongs_to :language
  
end
