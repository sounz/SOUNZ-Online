#!/usr/bin/ruby
require 'list_reader.rb'
require 'csv_reader.rb'


languages_reader = CSV_Reader::new
languages_reader.loadfile('languages.txt')

i = 0

for language in languages_reader.all_items
  i = i + 1
  puts "language#{i}:"
  puts "  language_id: #{i}"
  puts "  language_name: #{language[1]}"
  puts "  char_encoding: "
  puts "  is_default: F"
  puts "  display_order: #{i}"
  puts
  
end