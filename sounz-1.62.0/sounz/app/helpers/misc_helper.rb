module MiscHelper
  #In order to stop some of the menus going jump crazy, pad strings out to maintain a sensible width
  def self.pad_string(source_string, required_length)
=begin
    result = source_string
    if source_string.length > required_length
      result = source_string.first(required_length)
    elsif source_string.length < required_length
      n_spaces = required_length - source_string.length - 1
      for i in 0..n_spaces
        result << '*'
      end
    end
    result
=end
    source_string
  end
  
  
end
