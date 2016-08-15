#!/usr/bin/env ../sounz/script/runner

# IMPORTANT: be careful when using this script
# check carefully if it suits your situation!!!
# ex. this script works for Work -> Superwork
# 'Is evidence of' relationship as work can have
# only one superwork

# USAGE: ruby delete_duplicated_relationships.rb > tmp.txt

def delete_duplicated_relationship(entity_sym, relationship_type_desc)
  
  entity = entity_sym.to_s
  
  puts "---- Deleting duplicated " + entity + " relationships: " + relationship_type_desc
    
  # get an entity _relantionship model
  relationship_model_s   = entity.capitalize + "Relationship"
  relationship_model = relationship_model_s.constantize
  
  conditions = entity + "_id IN (SELECT r." + entity + "_id FROM (SELECT " + entity + "_id, relationship_type_id, count(*) AS count " +
               "FROM " + entity + "_relationships WHERE relationship_type_id=(SELECT relationship_type_id FROM relationship_types WHERE " +
			   " relationship_type_desc='" + relationship_type_desc +"') GROUP BY " + entity + "_id, relationship_type_id) r WHERE r.count > 1) " +
			   " AND relationship_type_id=(SELECT relationship_type_id FROM relationship_types WHERE relationship_type_desc='" + relationship_type_desc +"')"
  
  puts conditions
  
  objects = relationship_model.find(:all, :conditions => conditions, :order => entity + '_id, '+ entity + '_relationship_id')
  
  puts "Objects length:" + objects.length.to_s
  
  objects_hash = Hash.new
  objects.each do |o|
  	#puts o.id.to_s + " -> " + o.send(entity + "_id").to_s
  	objects_hash.store(o.id, o.send(entity + "_id"))
  end
  
  puts "---- Objects Hash (with dupes)"
  puts "Format: entity _relationship_id: entity _id"
  puts objects_hash.to_yaml 
  
  # by using invert method of Hash class
  # we make values to be keys, hence we get
  # uniq entity _id
  objects_hash_inverted = objects_hash.invert
  #objects_hash = objects_hash_inverted.invert
    
  #puts "---- Objects Hash (uniq)"  
  #puts objects_hash.to_yaml 
  
  puts "---- Objects Hash Inverted (uniq)"  
  puts objects_hash_inverted.to_yaml  
  
  puts "Objects Hash Inverted (uniq) length:" + objects_hash_inverted.length.to_s
  
  entities_affected = Array.new
  
  objects_hash_inverted.each_pair {|key, value| 
  	# get entities relationships of which are
  	# affected for recording purposes
  	entities_affected.push(key)
	
  	# an entity _relationships record
	object_to_delete = relationship_model.find(value)
	
	# the associated relationships record
	relationship = object_to_delete.relationship
	
	# delete entity _relationships record
	object_to_delete.destroy
	
	# delete relationships record
	relationship.destroy
  }
  
  puts "---- Duplicate relationships of type '" + relationship_type_desc + "' deleted for the following " + entity.capitalize + "s"
  puts entities_affected.to_yaml
  
end


puts "-- start"

delete_duplicated_relationship(:work, 'Is evidence of')

puts "-- end"