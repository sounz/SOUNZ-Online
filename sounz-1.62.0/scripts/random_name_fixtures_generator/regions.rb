#!/usr/bin/ruby
require 'list_reader.rb'
require 'csv_reader.rb'


regions_reader = CSV_Reader::new
regions_reader.loadfile('nz-regions.txt')

i = 0

for region in regions_reader.all_items
  i = i + 1
  puts "region#{i}:"
  puts "  region_id: #{i}"
  puts "  region_name: #{region[1]}"
  puts "  country_id: 158"
  puts
  
  
end
