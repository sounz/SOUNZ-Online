#!/usr/bin/env ../../sounz/script/runner

Status.rebuild_solr_index

puts "Indexing resources"
Resource.rebuild_solr_index

puts "Indexing contributors"
Contributor.rebuild_solr_index

puts "Indexing Events"
Event.rebuild_solr_index

puts "Indexing news articles"
NewsArticle.rebuild_solr_index

puts "Indexing borrowed items"
BorrowedItem.rebuild_solr_index

puts "Indexing works"
Work.rebuild_solr_index

puts "Indexing superworks"
Superwork.rebuild_solr_index


puts "Indexing Manifestations"
Manifestation.rebuild_solr_index

puts "Indexing Expressions"
Expression.rebuild_solr_index

puts "Indexing contactinfos"
Contactinfo.rebuild_solr_index


puts "Indexing distinction instances"
DistinctionInstance.rebuild_solr_index

puts "Indexing people"
Person.rebuild_solr_index

puts "Indexing organisations"
Organisation.rebuild_solr_index

puts "Indexing logins"
Login.rebuild_solr_index

puts "Indexing comms"
Communication.rebuild_solr_index

puts "indexing roles"
Role.rebuild_solr_index

puts "Indexing role_contactinfos"
RoleContactinfo.rebuild_solr_index
