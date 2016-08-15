class Mode < ActiveRecord::Base
    set_primary_key "mode_id" 
    set_sequence_name "modes_mode_id_seq" 
    
    has_many :expressions
    
    acts_as_dropdown :text => "mode_desc"
    
    
    PERFORMANCE = Mode.find(:first, :conditions => ['mode_desc=?', 'performance'])
    MUSIC_NOTATION = Mode.find(:first, :conditions => ['mode_desc=?', 'music notation'])
    COMPILED_COMPUTER_CODE = Mode.find(:first, :conditions => ['mode_desc=?', 'compiled computer code'])
    INSTALLATION = Mode.find(:first, :conditions => ['mode_desc=?', 'installation'])
    ALPHA_NUMERIC_NOTATION = Mode.find(:first, :conditions => ['mode_desc=?', 'alpha numeric notation'])
  
    DATE_MODES = [PERFORMANCE.mode_desc, COMPILED_COMPUTER_CODE.mode_desc, INSTALLATION.mode_desc]
    
    
    #Helper for acts as dropdown
    def name
      return mode_desc
    end
    
    
    #Not all expression modes require a start and end time.  This method return true
    # if they do and false if they dont
    def requires_date_and_premiere?
      result = DATE_MODES.include?(mode_desc)
    end
end
