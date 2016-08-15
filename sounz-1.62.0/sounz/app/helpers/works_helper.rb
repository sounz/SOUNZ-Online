module WorksHelper
  def self.plural_string(word, n_of_word)
    result = ""
    if n_of_word == 1
      result = word.singularize
    else
      result = word.pluralize
    end
    
    number = n_of_word.to_s
    number = 'a' if n_of_word == 1
    result = number +' '+result
    result
  end
  
  
  def self.join_text_with_and(word_array)
    word_array.map{| w | word_array.delete(w) if w.blank?}
  
    last_word = word_array.pop
    result = last_word
    if word_array.length > 0
      result = word_array.join(', ')
      result << ' and '
      result << last_word
    end 
    result
  end
  

end
