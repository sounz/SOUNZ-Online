module ManifestationsHelper
  
  #Pass in an array of manifestations and return only those that are of category score
  def self.scores_only(manifestation_array)
      manifestation_array.reject{|m| !m.is_a_score?}.sort_by{|m| m.publication_year_or_zero}
  end
  
  #Pass in an array of manifestations and return only those that are of category sounzmedia
  def self.sounzmedia_only(manifestation_array)
      manifestation_array.reject{|m| !m.is_a_sounzmedia?}.sort_by{|m| m.publication_year_or_zero} 
  end

  def self.sounzmedia_audio_only(manifestation_array)
      manifestation_array.reject{|m| !m.is_a_sounzmedia_audio?}.sort_by{|m| m.publication_year_or_zero} 
  end

  def self.sounzmedia_video_only(manifestation_array)
      manifestation_array.reject{|m| !m.is_a_sounzmedia_video?}.sort_by{|m| m.publication_year_or_zero} 
  end
  
  #Pass in an array of manifestations and return only those that are recordings
  def self.recordings_only(manifestation_array)
      manifestation_array.reject{|m| !m.is_a_recording?}.sort_by{|m| m.publication_year_or_zero}
  end
  
  #Pass in an array of manifestations and return only those that are "others" - to be defined
  def self.others_only(manifestation_array)
      manifestation_array.reject{|m| !m.is_an_other?}.sort_by{|m| m.publication_year_or_zero}
  end
  

  #Get the samples from an array of manifestations
  def self.samples(manifestation_array)
    samples = []
    for manifestation in manifestation_array
      man_samps = manifestation.samples
      if !man_samps.blank?
        samples = samples + man_samps # FIXME is this the most efficient way?
      end
    end
    return samples
  end
end
