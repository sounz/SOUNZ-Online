#!/usr/bin/ruby
require 'list_reader.rb'
require 'paragraph_reader.rb'

class RandomSentenceGenerator
  
  SECS_IN_YEAR = 31536000 
  FORMAT ="%d %b %Y %H:%M"
  
  
  
  
  #----------------------
  #- Details about intialise
  #----------------------
  def initialise
    @nouns = ListReader::new
    @verbs_stems = ListReader::new
    @verbs_ed = ListReader::new
    @verbs_es = ListReader::new
    @verbs_ing = ListReader::new
    @prepositions = ListReader::new
    
    max = 100000
    @verbs_stems.loadfile('verb-stem.txt', max)
    @verbs_ed.loadfile('verb-ed.txt', max)
    @verbs_es.loadfile('verb-es.txt', max)
    @verbs_ing.loadfile('verb-ing.txt', max)
    @nouns.loadfile('nouns.txt', max)
    @prepositions.loadfile('prepositions.txt', max)
    
    
    
    @ctr = 1
    
  end
  
  
  def random_subject
    result = ""
    #TODO - add random formats of sentences
       result << random_noun
    result <<  random_verb_es
    result << random_preposition
    result << random_noun
    
    if rand(10)> 3
    result << random_preposition
    result << random_noun
    end
    result
  end
  
  
  def random_sentence
  
  end
  
  
  def random_article
    options =  ['the', 'a']
    options[rand(2)]+' '
  end
  
  
  def random_noun
    @nouns.random_item.to_s.capitalize+' '
  end
  
  def random_verb_ed
    @verbs_ed.random_item.to_s.capitalize+' '
  end
  
  
  def random_verb_es
    @verbs_es.random_item.to_s.capitalize+' '
  end
  
  def random_verb_ing
    @verbs_ing.random_item.to_s.capitalize+' '
  end
  
  
  def random_verb_imperative
    @verbs_stems.random_item.to_s.capitalize+' '
  end
  
  
  
  def random_preposition
    result = @prepositions.random_item.to_s.downcase+' '
  end
  
end

