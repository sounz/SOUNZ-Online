module ResourcesHelper
  
  def self.sounzmedia_only(resource_array)
      resource_array.reject{|r| !r.is_a_sounzmedia?}.sort_by{|r| r.publication_year_or_zero} 
    end
  
  def self.sounzmedia_audio_only(resource_array)
      resource_array.reject{|r| !r.is_a_sounzmedia_audio?}.sort_by{|r| r.publication_year_or_zero} 
  end

  def self.sounzmedia_video_only(resource_array)
      resource_array.reject{|r| !r.is_a_sounzmedia_video?}.sort_by{|r| r.publication_year_or_zero} 
  end


end
