#!/usr/bin/env ../sounz/script/runner
require 'csv'
=begin
GENRE=1



csv = CSV::parse(File.open("genres.csv") {|f|f.read})
csv.each do |record|
 # puts "*****"
#  puts "***#{record}"
  record[0].gsub!("\342\200\223", '-')
  puts 'genre = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", GENRE,"'+record[0].strip+'"])'
 # puts record[1]
  record[1].each_line do |line|
      line.strip!
      line.gsub!("\342\200\223", '-')
     # puts line
      
      puts 'genre.children.create(:updated_by => 1000, :concept_name => "'+line+'", :concept_type_id => GENRE).save'
  end
  puts
end
=end


#==== GENRES ====
GENRE=1

genre = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", GENRE,"Jazz"])
genre.children.create(:updated_by => 1000, :concept_name => "Big band", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Free jazz", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Lounge music", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Blues", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Latin", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Bebop", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Fusion", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Improvisation", :concept_type_id => GENRE).save

genre = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", GENRE,"Popular"])
genre.children.create(:updated_by => 1000, :concept_name => "Rock", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Hiphop", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Rap", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Electronica", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Funk", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Popular Te Reo", :concept_type_id => GENRE).save

genre = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", GENRE,"Maori Music"])
genre.children.create(:updated_by => 1000, :concept_name => "Moteatea", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Waiata", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Kapa haka", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Whare tapere", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Haka", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Karanga", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Kaupapa (protest) music", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Popular cultural", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Popular Te Reo", :concept_type_id => GENRE).save

genre = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", GENRE,"20th Century Genres"])
genre.children.create(:updated_by => 1000, :concept_name => "Modernism", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Post-modernism", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Avant-garde", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Darmstadt School", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Serialism", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Aleatoric", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Minimalism", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Expressionism", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Neo-romanticism", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Neo-classicism", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Surrealism", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Musique concrète", :concept_type_id => GENRE).save

genre = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", GENRE,"19th Century Genres"])
genre.children.create(:updated_by => 1000, :concept_name => "Impressionism", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Romanticism", :concept_type_id => GENRE).save

genre = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", GENRE,"Pre-19th Century Genres"])
genre.children.create(:updated_by => 1000, :concept_name => "Classical", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Baroque", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Renaissance", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Mediaeval", :concept_type_id => GENRE).save

genre = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", GENRE,"Nationalism"])
genre.children.create(:updated_by => 1000, :concept_name => "Nationalism", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Folk", :concept_type_id => GENRE).save

genre = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", GENRE,"Eclecticism"])
genre.children.create(:updated_by => 1000, :concept_name => "Eclecticism", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Transcriptions", :concept_type_id => GENRE).save

genre = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", GENRE,"Improvisation"])
genre.children.create(:updated_by => 1000, :concept_name => "Improvisation", :concept_type_id => GENRE).save

genre = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", GENRE,"Sonic Art"])
genre.children.create(:updated_by => 1000, :concept_name => "Noise", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Intermedia", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Sound design", :concept_type_id => GENRE).save
genre.children.create(:updated_by => 1000, :concept_name => "Ars Electronica", :concept_type_id => GENRE).save




#=== INFLUENCES ===

INFLUENCE=2

influence = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", INFLUENCE,"Maori Culture"])
influence.children.create(:updated_by => 1000, :concept_name => "Maori - culture", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Purakau - legends", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Iwi - people", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Kaupapa - protest", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Moteatea - song poetry", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Haka - dance", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Waiata - song", :concept_type_id => INFLUENCE).save

influence = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", INFLUENCE,"Landscape - other"])
influence.children.create(:updated_by => 1000, :concept_name => "Landscape - other", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Conservation", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Urban", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Flora and Fauna - other", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Sea and water - other", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Travel", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Antarctica", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Natural History", :concept_type_id => INFLUENCE).save

influence = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", INFLUENCE,"Landscape - NZ"])
influence.children.create(:updated_by => 1000, :concept_name => "Landscape - NZ", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Flora and fauna - NZ", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Birds - NZ", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Sea and water - NZ", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Urban - NZ", :concept_type_id => INFLUENCE).save

influence = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", INFLUENCE,"Natural History"])
influence.children.create(:updated_by => 1000, :concept_name => "Flora and Fauna - other", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Natural History", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Flora and fauna - NZ", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Birds - NZ", :concept_type_id => INFLUENCE).save

influence = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", INFLUENCE,"Culture - NZ"])
influence.children.create(:updated_by => 1000, :concept_name => "Culture - NZ", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "History - NZ", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "People - NZ", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Art and literature - NZ", :concept_type_id => INFLUENCE).save

influence = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", INFLUENCE,"Culture - South Pacific"])
influence.children.create(:updated_by => 1000, :concept_name => "South Pacific - history and culture", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Samoa - history and culture", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Cook Islands - history and culture", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Fiji - history and culture", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Niue - history and culture", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Tonga - history and culture", :concept_type_id => INFLUENCE).save

influence = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", INFLUENCE,"Culture - other"])
influence.children.create(:updated_by => 1000, :concept_name => "African", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Australian", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Indonesian", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Chinese", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Japanese", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Asian - other", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Indian", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "French", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "British", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "German", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "French", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Italian", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Spanish", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Portuguese", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Greek", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Scandinavian", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Russian", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Baltic States", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Balkan States", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Eastern European - other", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Middle East", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Canadian", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "American - USA", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Latin American", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Jewish", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Ancient civilisations", :concept_type_id => INFLUENCE).save

influence = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", INFLUENCE,"The Elements"])
influence.children.create(:updated_by => 1000, :concept_name => "The elements", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Fire", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Sea and water - other", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Sea and water - NZ", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Space", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Air and Sky", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Weather", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Seasons", :concept_type_id => INFLUENCE).save

influence = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", INFLUENCE,"Religion / Spirituality"])
influence.children.create(:updated_by => 1000, :concept_name => "Wedding", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Easter", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Bible", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Religious", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Spiritual", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Christmas", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Heaven and hell", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Birth", :concept_type_id => INFLUENCE).save

influence = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", INFLUENCE,"Time"])
influence.children.create(:updated_by => 1000, :concept_name => "Time", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Seasons", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Historical Event", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Anniversary", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Night", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Day", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Travel", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Space", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Sleep", :concept_type_id => INFLUENCE).save

influence = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", INFLUENCE,"Age"])
influence.children.create(:updated_by => 1000, :concept_name => "Age", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Birth", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Children/youth", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Life", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Death", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Sleep", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Old Age", :concept_type_id => INFLUENCE).save

influence = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", INFLUENCE,"Humanity"])
influence.children.create(:updated_by => 1000, :concept_name => "Humanity", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Women", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Men", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Relationships", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Sexuality", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Change", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Mental wellbeing", :concept_type_id => INFLUENCE).save

influence = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", INFLUENCE,"Celebration"])
influence.children.create(:updated_by => 1000, :concept_name => "Celebration", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Historical Event", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Anniversary", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Wedding", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Christmas", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Ceremony", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Play / Games", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Commemoration", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Food", :concept_type_id => INFLUENCE).save

influence = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", INFLUENCE,"Love"])
influence.children.create(:updated_by => 1000, :concept_name => "Love", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Wedding", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Peace", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Good and Evil", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Beauty", :concept_type_id => INFLUENCE).save

influence = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", INFLUENCE,"Mythology"])
influence.children.create(:updated_by => 1000, :concept_name => "Purakau - legends", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Myth", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Good and Evil", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Heaven and hell", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Play / Games", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Fairytale / folktale", :concept_type_id => INFLUENCE).save

influence = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", INFLUENCE,"Language and Literature"])
influence.children.create(:updated_by => 1000, :concept_name => "Language and Literature", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Shakespeare", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Fairytale / folktale", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Art and literature - NZ", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Theatre", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Greek theatre", :concept_type_id => INFLUENCE).save

influence = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", INFLUENCE,"Performing / Visual Arts"])
influence.children.create(:updated_by => 1000, :concept_name => "Music", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Dance", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Theatre", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Shakespeare", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Greek theatre", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Sculpture/ painting", :concept_type_id => INFLUENCE).save

influence = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", INFLUENCE,"Politics"])
influence.children.create(:updated_by => 1000, :concept_name => "Politics", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Peace", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "War", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Conservation", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Race Relations", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Kaupapa - protest", :concept_type_id => INFLUENCE).save

influence = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", INFLUENCE,"History"])
influence.children.create(:updated_by => 1000, :concept_name => "Politics", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "War", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Historical Event", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Anniversary", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Ancient civilisations", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "History - NZ", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Commemoration", :concept_type_id => INFLUENCE).save

influence = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", INFLUENCE,"Travel / Migration"])
influence.children.create(:updated_by => 1000, :concept_name => "Travel", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Space", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Migration", :concept_type_id => INFLUENCE).save

influence = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", INFLUENCE,"Maths and Science"])
influence.children.create(:updated_by => 1000, :concept_name => "Mathematics", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Science", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Space", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Conservation", :concept_type_id => INFLUENCE).save

influence = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", INFLUENCE,"Jazz"])
influence.children.create(:updated_by => 1000, :concept_name => "Big band", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Free jazz", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Lounge music", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Blues", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Latin", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Bebop", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Fusion", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Improvisation", :concept_type_id => INFLUENCE).save

influence = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", INFLUENCE,"Popular"])
influence.children.create(:updated_by => 1000, :concept_name => "Rock", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Hiphop", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Rap", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Electronica", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Funk", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Popular Te Reo", :concept_type_id => INFLUENCE).save

influence = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", INFLUENCE,"Maori Music"])
influence.children.create(:updated_by => 1000, :concept_name => "Moteatea", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Waiata", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Kapa haka", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Whare tapere", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Haka", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Karanga", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Kaupapa (protest) music", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Popular cultural", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Popular Te Reo", :concept_type_id => INFLUENCE).save

influence = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", INFLUENCE,"20th Century Genres"])
influence.children.create(:updated_by => 1000, :concept_name => "Modernism", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Post-modernism", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Avant-garde", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Darmstadt School", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Serialism", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Aleatoric", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Minimalism", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Expressionism", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Neo-romanticism", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Neo-classicism", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Surrealism", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Musique concrète", :concept_type_id => INFLUENCE).save

influence = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", INFLUENCE,"19th Century Genres"])
influence.children.create(:updated_by => 1000, :concept_name => "Impressionism", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Romanticism", :concept_type_id => INFLUENCE).save

influence = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", INFLUENCE,"Pre-19th Century Genres"])
influence.children.create(:updated_by => 1000, :concept_name => "Classical", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Baroque", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Renaissance", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Mediaeval", :concept_type_id => INFLUENCE).save

influence = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", INFLUENCE,"Nationalism"])
influence.children.create(:updated_by => 1000, :concept_name => "Nationalism", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Folk", :concept_type_id => INFLUENCE).save

influence = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", INFLUENCE,"Eclecticism"])
influence.children.create(:updated_by => 1000, :concept_name => "Eclecticism", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Transcriptions", :concept_type_id => INFLUENCE).save

influence = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", INFLUENCE,"Improvisation"])
influence.children.create(:updated_by => 1000, :concept_name => "Improvisation", :concept_type_id => INFLUENCE).save

influence = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", INFLUENCE,"Sonic Art"])
influence.children.create(:updated_by => 1000, :concept_name => "Noise", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Intermedia", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Sound design", :concept_type_id => INFLUENCE).save
influence.children.create(:updated_by => 1000, :concept_name => "Ars Electronica", :concept_type_id => INFLUENCE).save



#=== THEMES ====
THEME=3

theme = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", THEME,"Maori Culture"])
theme.children.create(:updated_by => 1000, :concept_name => "Maori - culture", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Purakau - legends", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Iwi - people", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Kaupapa - protest", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Moteatea - song poetry", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Haka - dance", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Waiata - song", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Conservation FIXME", :concept_type_id => THEME).save

theme = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", THEME,"Landscape - other"])
theme.children.create(:updated_by => 1000, :concept_name => "Landscape - other", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Conservation", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Urban", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Flora and Fauna - other", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Sea and water - other", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Travel", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Antarctica", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Natural History", :concept_type_id => THEME).save

theme = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", THEME,"Landscape - NZ"])
theme.children.create(:updated_by => 1000, :concept_name => "Landscape - NZ", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Flora and fauna - NZ", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Birds - NZ", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Sea and water - NZ", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Urban - NZ", :concept_type_id => THEME).save

theme = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", THEME,"Natural History"])
theme.children.create(:updated_by => 1000, :concept_name => "Flora and Fauna - other", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Natural History", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Flora and fauna - NZ", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Birds - NZ", :concept_type_id => THEME).save

theme = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", THEME,"Culture - NZ"])
theme.children.create(:updated_by => 1000, :concept_name => "Culture - NZ", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "History - NZ", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "People - NZ", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Art and literature - NZ", :concept_type_id => THEME).save

theme = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", THEME,"Culture - South Pacific"])
theme.children.create(:updated_by => 1000, :concept_name => "South Pacific - history and culture", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Samoa - history and culture", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Cook Islands - history and culture", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Fiji - history and culture", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Niue - history and culture", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Tonga - history and culture", :concept_type_id => THEME).save

theme = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", THEME,"Culture - other"])
theme.children.create(:updated_by => 1000, :concept_name => "African", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Australian", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Indonesian", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Chinese", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Japanese", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Asian - other", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Indian", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "French", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "British", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "German", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "French", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Italian", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Spanish", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Portuguese", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Greek", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Scandinavian", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Russian", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Baltic States", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Balkan States", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Eastern European - other", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Middle East", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Canadian", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "American - USA", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Latin American", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Jewish", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Ancient civilisations", :concept_type_id => THEME).save

theme = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", THEME,"The Elements"])
theme.children.create(:updated_by => 1000, :concept_name => "The elements", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Fire", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Sea and water - other", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Sea and water - NZ", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Space", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Air and Sky", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Weather", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Seasons", :concept_type_id => THEME).save


theme = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", THEME,"Time"])
theme.children.create(:updated_by => 1000, :concept_name => "Time", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Seasons", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Historical Event", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Anniversary", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Night", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Day", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Travel", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Space", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Sleep", :concept_type_id => THEME).save

theme = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", THEME,"Age"])
theme.children.create(:updated_by => 1000, :concept_name => "Age", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Birth", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Children/youth", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Life", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Death", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Sleep", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Old Age", :concept_type_id => THEME).save

theme = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", THEME,"Humanity"])
theme.children.create(:updated_by => 1000, :concept_name => "Humanity", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Women", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Men", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Relationships", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Sexuality", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Change", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Mental wellbeing", :concept_type_id => THEME).save

theme = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", THEME,"Celebration"])
theme.children.create(:updated_by => 1000, :concept_name => "Celebration", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Historical Event", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Anniversary", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Wedding", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Christmas", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Ceremony", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Play / Games", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Commemoration", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Food", :concept_type_id => THEME).save

theme = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", THEME,"Love"])
theme.children.create(:updated_by => 1000, :concept_name => "Love", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Wedding", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Peace", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Good and Evil", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Beauty", :concept_type_id => THEME).save

theme = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", THEME,"Mythology"])
theme.children.create(:updated_by => 1000, :concept_name => "Purakau - legends", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Myth", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Good and Evil", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Heaven and hell", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Play / Games", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Fairytale / folktale", :concept_type_id => THEME).save

theme = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", THEME,"Language and Literature"])
theme.children.create(:updated_by => 1000, :concept_name => "Language and Literature", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Shakespeare", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Fairytale / folktale", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Art and literature - NZ", :concept_type_id => THEME).save

theme = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", THEME,"Performing / Visual Arts"])
theme.children.create(:updated_by => 1000, :concept_name => "Music", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Dance", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Theatre", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Shakespeare", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Greek theatre", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Sculpture/ painting", :concept_type_id => THEME).save

theme = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", THEME,"Politics"])
theme.children.create(:updated_by => 1000, :concept_name => "Politics", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Peace", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "War", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Conservation", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Race Relations", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Kaupapa - protest", :concept_type_id => THEME).save

theme = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", THEME,"History"])
theme.children.create(:updated_by => 1000, :concept_name => "Politics", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "War", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Historical Event", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Anniversary", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Ancient civilisations", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "History - NZ", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Commemoration", :concept_type_id => THEME).save

theme = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", THEME,"Travel / Migration"])
theme.children.create(:updated_by => 1000, :concept_name => "Travel", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Space", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Migration", :concept_type_id => THEME).save

theme = Concept.find(:first, :conditions => ["concept_type_id = ? and concept_name = ?", THEME,"Maths and Science"])
theme.children.create(:updated_by => 1000, :concept_name => "Mathematics", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Science", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Space", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Conservation", :concept_type_id => THEME).save

puts "ADDED CONCEPTS"




theme = Concept.create(:concept_type_id => THEME, :concept_name =>"Religion / Spirituality")
theme.save
theme.children.create(:updated_by => 1000, :concept_name => "Wedding", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Easter", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Bible", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Religious", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Spiritual", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Christmas", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Heaven and hell", :concept_type_id => THEME).save
theme.children.create(:updated_by => 1000, :concept_name => "Birth", :concept_type_id => THEME).save










