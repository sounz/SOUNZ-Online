class RandomFrbrHelper


def self.random_data
  @@work_ids = Work.find(:all, :order => :work_id, :limit => 1000, :order => :work_id).map {|w| w.work_id}
  @@superwork_ids = Superwork.find(:all, :limit => 400).map {|w| w.superwork_id}
  @@contributor_ids = Contributor.find(:all, :order => :contributor_id, :limit => 100).map {|c| c.contributor_id}
  @@venue_ids = Venue.find(:all).map {|v| v.venue_id}
  @@expression_ids = Expression.find(:all).map {|e| e.expression_id}
  @@manifestation_ids = Manifestation.find(:all).map {|m| m.manifestation_id}
  @@event_ids = Event.find(:all).map {|e| e.event_id}
  @@resource_ids = Resource.find(:all).map {|r| r.resource_id}
  @@concept_ids = Concept.find(:all).map {|c| c.concept_id }
  
=begin
  random_composer_data
  random_venue_data
  random_conceived_superworks
  random_contributor_expression_data
  random_contributor_manifestation_data
  random_contributor_event_data
=end

=begin
#To be ran fully overnight I think
  random_work_expression_data
 # BROKEN random_thing1_to_thing2(:work, @@work_ids, :is_commissioned_for, :event, @@event_ids, 4 )
  random_thing1_to_thing2(:work, @@work_ids, :is_described_by, :resource, @@resource_ids, 2 )
  #TODO random_thing1_to_thing2(:work, @@work_ids, :receives, :distinction, @@distinction_ids, 2 )
  random_thing1_to_thing2(:work, @@work_ids, :is_influenced_by, :concept, @@concept_ids, 4 )
   random_thing1_to_thing2(:work, @@work_ids, :has_as_its_theme, :concept, @@concept_ids, 4 )
  random_thing1_to_thing2(:work, @@work_ids, :has_as_its_genre, :concept, @@concept_ids, 4 )
  
  #Superworks - NOT TESTED
  random_thing1_to_thing2(:superwork, @@superwork_ids, :is_influenced_by, :superwork, @@superwork_ids, 4 )
  random_thing1_to_thing2(:superwork, @@superwork_ids, :draws_source_material_from, :superwork, @@superwork_ids, 4 )
  random_thing1_to_thing2(:superwork, @@superwork_ids, :is_evidenced_as, :work, @@work_ids, 4 )
  random_thing1_to_thing2(:superwork, @@superwork_ids, :is_described_by, :resource, @@resource_ids, 2 )
  
  random_thing1_to_thing2(:superwork, @@superwork_ids, :is_influenced_by, :concept, @@concept_ids, 2 )
  random_thing1_to_thing2(:superwork, @@superwork_ids, :has_as_its_theme, :concept, @@concept_ids, 2 )
  random_thing1_to_thing2(:superwork, @@superwork_ids, :has_as_its_genre, :concept, @@concept_ids, 2 )
  
  
  random_thing1_to_thing2(:expression, @@expression_ids, :is_embodied_in, :manifestation, @@manifestation_ids, 4 )
  
  random_thing1_to_thing2(:expression, @@expression_ids, :is_described_by, :resource, @@resource_ids, 2 )
  
  random_thing1_to_thing2(:expression, @@expression_ids, :happens_at, :event, @@event_ids, 1 )
  random_thing1_to_thing2(:expression, @@expression_ids, :is_commissioned_for, :event, @@event_ids, 1 )
  random_thing1_to_thing2(:expression, @@expression_ids, :is_presented_at, :event, @@event_ids, 1 )
  
  random_thing1_to_thing2(:expression, @@expression_ids, :receives, :distinction, @@distinction_ids, 2 )
  
  random_thing1_to_thing2(:manifestation, @@manifestation_ids, :is_the_recording_of, :manifestation, @@manifestation_ids, 2 )
  random_thing1_to_thing2(:manifestation, @@manifestation_ids, :is_the_publication, :manifestation, @@manifestation_ids, 2 )
  random_thing1_to_thing2(:manifestation, @@manifestation_ids, :is_related_to, :manifestation, @@manifestation_ids, 2 )
 
 
  random_thing1_to_thing2(:manifestation, @@manifestation_ids, :is_related_to, :manifestation, @@manifestation_ids, 6 )
  random_thing1_to_thing2(:manifestation, @@manifestation_ids, :is_related_to, :manifestation, @@manifestation_ids, 6 )
 
  random_thing1_to_thing2(:manifestation, @@manifestation_ids, :is_described_by, :resource, @@resource_ids, 2 )
  random_thing1_to_thing2(:manifestation, @@manifestation_ids, :is_documented_by, :resource, @@resource_ids, 2 )
  
  random_thing1_to_thing2(:manifestation, @@manifestation_ids, :is_launched_at, :event, @@event_ids, 2 )
  
  random_thing1_to_thing2(:manifestation, @@manifestation_ids, :is_launched_at, :event, @@event_ids, 2 )
  random_thing1_to_thing2(:manifestation, @@manifestation_ids,:receives, :distinction, @@distinction_ids, 2 )
  
  
  random_thing1_to_thing2(:manifestation, @@manifestation_ids, :has_as_its_genre, :concept, @@concept_ids, 2 )
  random_thing1_to_thing2(:manifestation, @@manifestation_ids, :has_as_its_theme, :concept, @@concept_ids, 2 )
  random_thing1_to_thing2(:manifestation, @@manifestation_ids, :is_influenced_by, :concept, @@concept_ids, 2 )
  
  random_thing1_to_thing2(:resource, @@resource_ids, :has_as_its_genre, :concept, @@concept_ids, 2 )
  random_thing1_to_thing2(:resource, @@resource_ids, :has_as_its_theme, :concept, @@concept_ids, 2 )
  random_thing1_to_thing2(:resource, @@resource_ids, :is_influenced_by, :concept, @@concept_ids, 2 )
  
  random_thing1_to_thing2(:venue, @@mvenue_ids, :has_as_its_genre, :concept, @@concept_ids, 2 )
  random_thing1_to_thing2(:venue, @@mvenue_ids, :has_as_its_theme, :concept, @@concept_ids, 2 )
  random_thing1_to_thing2(:venue, @@mvenue_ids, :is_influenced_by, :concept, @@concept_ids, 2 )
  
  
   random_thing1_to_thing2(:events, @@event_ids, :launches, :resource, @@resource_ids, 2 )
   random_thing1_to_thing2(:events, @@event_ids, :is_related_to, :event, @@event_ids, 2 )
   
   random_thing1_to_thing2(:events, @@event_ids, :is_held_at, :venue, @@venue_ids, 4 )
   random_thing1_to_thing2(:events, @@event_ids, :is_presented_by, :venue, @@venue_ids, 4 )
   
   random_thing1_to_thing2(:event, @@event_ids,:receives, :distinction, @@distinction_ids, 2 )
  
  
  random_thing1_to_thing2(:venues, @@venue_ids, :is_related_to, :venues, @@venue_ids, 4)
  random_thing1_to_thing2(:concepts, @@concept_ids, :is_related_to, :concepts, @@concept_ids, 4 )


=end
  
  
  #Gillian whitehead
  @@contributor_ids = [1101]
  random_thing1_to_thing2(:contributor, @@contributor_ids, :arranges, :work, @@work_ids, 10 )
  random_thing1_to_thing2(:contributor, @@contributor_ids, :improvises, :work, @@work_ids, 10 )
  random_thing1_to_thing2(:contributor, @@contributor_ids, :writes, :work, @@work_ids, 10 )
  random_thing1_to_thing2(:contributor, @@contributor_ids, :creates, :work, @@work_ids, 10 )


  #Mr de Pledge
  @@contributor_ids = [1288]
  random_thing1_to_thing2(:contributor, @@contributor_ids, :performs, :expression, @@expression_ids, 40 )
  random_thing1_to_thing2(:contributor, @@contributor_ids, :commissions, :expression, @@expression_ids, 40 )
  random_thing1_to_thing2(:contributor, @@contributor_ids, :exhibits, :expression, @@expression_ids, 40 )
  random_thing1_to_thing2(:contributor, @@contributor_ids, :presents, :expression, @@expression_ids, 40 )
  random_thing1_to_thing2(:contributor, @@contributor_ids, :improvises, :expression, @@expression_ids, 40 )
  random_thing1_to_thing2(:contributor, @@contributor_ids, :broadcasts, :expression, @@expression_ids, 40 )
  random_thing1_to_thing2(:contributor, @@contributor_ids, :notates, :expression, @@expression_ids, 40 )
  
  

end






#Loop through entity 1 ids adding random entity2 ids a max number of times.
def self.random_thing1_to_thing2(entity1_type, entity1_ids, relationship_sym, entity2_type, entity2_ids, max, login=1)
  for thing1_id in entity1_ids
    #only one relationship so inline it
     puts "Adding #{entity2_type} for #{entity1_type} #{thing1_id} from list of len #{entity2_ids.length}"
     
    for i in 0..(1+rand(max))
       
        random_id = entity2_ids[rand(entity2_ids.length)]
        RelationshipHelper.add_frbr_relationship(entity1_type, thing1_id, relationship_sym, entity2_type, random_id, login  )
    end
  end
end

def self.random_work_resource_data(login=1)
  for work_id in @@work_ids
    #only one relationship so inline it
     puts "Adding resource for work #{work_id} in list of len #{@@work_ids.length}"
     
    for i in 0..(1+rand(2))
       
        random_id = @@resource_ids[rand(@@resource_ids.length)]
        RelationshipHelper.add_frbr_relationship(:resource, random_id, :describes, :work,  work_id, login)
    end
  end
end

def self.random_work_expression_data(login=1)
  for work_id in @@work_ids
    #only one relationship so inline it
     puts "Adding expression for work #{work_id} in list of len #{@@work_ids.length}"
     
    for i in 0..(1+rand(3))
       
        random_id = @@expression_ids[rand(@@expression_ids.length)]
        RelationshipHelper.add_frbr_relationship(:expression, random_id, :is_realisation_of, :work, work_id, login)
    end
  end
end


def self.add_expressions_to_contributors_with_relationship(contributor_id, relationship_type_sym, login=1)
  for i in 0..(1+rand(10))
      random_exp_id = @@expression_ids[rand(@@expression_ids.length)]
      RelationshipHelper.add_frbr_relationship(:expression, random_exp_id,relationship_type_sym, :contributor, contributor_id, login)       
  end
end


def self.random_contributor_expression_data
  for contributor_id in @@contributor_ids
      puts "Assigning random expressions to #{contributor_id}"
      add_expressions_to_contributors_with_relationship(contributor_id, :is_performed_by)
      add_expressions_to_contributors_with_relationship(contributor_id, :is_exhibited_by)
      add_expressions_to_contributors_with_relationship(contributor_id, :is_improvised_by)
      add_expressions_to_contributors_with_relationship(contributor_id, :is_broadcasted_by)
      add_expressions_to_contributors_with_relationship(contributor_id, :is_notated_by)
      add_expressions_to_contributors_with_relationship(contributor_id, :is_compiled_by)
      add_expressions_to_contributors_with_relationship(contributor_id, :is_presented_by)
  end
end

def self.random_contributor_manifestation_data
  for contributor_id in @@contributor_ids
      puts "Assigning random manifestations to #{contributor_id}"
      add_manifestations_to_contributors_with_relationship(contributor_id, :is_recorded_by)
      add_manifestations_to_contributors_with_relationship(contributor_id, :is_published_by)
      add_manifestations_to_contributors_with_relationship(contributor_id, :is_released_by)
      add_manifestations_to_contributors_with_relationship(contributor_id, :is_sold_by)
      add_manifestations_to_contributors_with_relationship(contributor_id, :is_presented_by)
     
  end
end

def self.random_contributor_event_data
  for contributor_id in @@contributor_ids
      puts "Assigning random events to #{contributor_id}"
      add_events_to_contributors_with_relationship(contributor_id, :is_presented_by)
      add_events_to_contributors_with_relationship(contributor_id, :is_performed_by)
      add_events_to_contributors_with_relationship(contributor_id, :is_funded_by)
      add_events_to_contributors_with_relationship(contributor_id, :is_broadcasted_by)
      add_events_to_contributors_with_relationship(contributor_id, :is_recorded_by)
      add_events_to_contributors_with_relationship(contributor_id, :is_sold_by)
      add_events_to_contributors_with_relationship(contributor_id, :is_managed_by)
      end
end


def self.add_events_to_contributors_with_relationship(contributor_id, relationship_type_sym, login=1)
  for i in 0..(1+rand(20))
      random_exp_id = @@event_ids[rand(@@event_ids.length)]
      begin
        RelationshipHelper.add_frbr_relationship(:event, random_exp_id,relationship_type_sym, :contributor, contributor_id, login)       
      rescue
        puts "Could not find relationship #{relationship_type_sym}"
      end
  end
end



def self.add_manifestations_to_contributors_with_relationship(contributor_id, relationship_type_sym, login=1)
  for i in 0..(1+rand(10))
      random_exp_id = @@manifestation_ids[rand(@@manifestation_ids.length)]
      RelationshipHelper.add_frbr_relationship(:manifestation, random_exp_id,relationship_type_sym, :contributor, contributor_id, login)       
  end
end


def self.random_conceived_superworks(login=1)
    for contributor_id in @@contributor_ids
        puts "Assigning random superworks to #{contributor_id}"
        for i in 0..(1+rand(10))
            random_sw_id = @@swork_ids[rand(@@swork_ids.length)]
            RelationshipHelper.add_frbr_relationship(:superwork, random_sw_id, :is_conceived_by, :contributor, contributor_id, login)       
        end
    end
end


def self.random_venue_data(login=1)
  for contributor_id in @@contributor_ids
    rng = rand(100)
    #Assume we have a funder
    if rng < 33
      for i in 0..(1+rand(10))
          random_venue_id = @@venue_ids[rand(@@venue_ids.length)]
          RelationshipHelper.add_frbr_relationship(:venue, random_venue_id, :is_managed_by, :contributor, contributor_id, login)       
          RelationshipHelper.add_frbr_relationship(:venue, random_venue_id, :is_owned_by, :contributor, contributor_id, login)       
          
      end
    else
        puts "Adding random venue data for performances to #{contributor_id}"
        for i in 0..(1+rand(40))
            random_venue_id = @@venue_ids[rand(@@venue_ids.length)]
            puts "Adding venue #{random_venue_id}"
              RelationshipHelper.add_frbr_relationship( :contributor, contributor_id, :performs_at, :venue, random_venue_id, login)       
        end
    end
  end
end

def self.random_composer_data(login=1)
  for contributor_id in @@contributor_ids
    puts "Adding works for composer #{contributor_id}"


    
    add_random_works_with_relationship(:is_composed_by, contributor_id,200)
    
    add_random_works_with_relationship(:is_created_by, contributor_id,10)
     add_random_works_with_relationship(:is_improvised_by, contributor_id,10)
   add_random_works_with_relationship(:is_arranged_by, contributor_id,10)
    
    #Take a subset of works
    works = Contributor.find(contributor_id).compositions.map {|w| w.work_id}
    #We wish a subset of this for selected works
    for i in 0..works.length-1
        work_id = works[i]
        if work_id != nil
        # 25% are selected works
          if rand(100) > 75
            puts "Adding selected work #{work_id}"
            RelationshipHelper.add_frbr_relationship(:work, work_id, :is_selected_by, :contributor, contributor_id, login)
          
          end
        end
    end
  end
end

#-----------------------------------------------
#-Add an arbitrary relationship to random works-
#-----------------------------------------------
def self.add_random_works_with_relationship(relationship_sym, contributor_id, max, login=1)
  works = get_random_works(max)
  for work_id in works
    RelationshipHelper.add_frbr_relationship(:work, work_id, relationship_sym, :contributor, contributor_id, login)
  end
end

#-------------------------
#- Get some random works -
#-------------------------
def self.get_random_works(max)
  rw= []
  for i in 1..rand(max)
    rw << @@work_ids[rand(@@work_ids.length)]
  end
  rw
end

end