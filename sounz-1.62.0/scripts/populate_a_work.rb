#!/usr/bin/env ../sounz/script/runner

#RelationshipHelper.add_frbr_relationship(:work, 12447, :is_realised_by, :contributor, 1101)

require 'time'


class DataEntryHelper
  

  
  def self.link_work_to_expression_to_event_to_venue(work,expression,event,venue)
    
    puts "Adding #{work.work_title} #{generate_id(work)} is realised through #{expression.expression_title} #{generate_id(expression)}"+
    " happens at #{event.event_title} #{generate_id(event)} which is held at #{venue.venue_name} #{generate_id(venue)}"
    
    #A work is realised through an expression
    RelationshipHelper.add_frbr_relationship(:work, work.work_id, :is_realised_through, :expression, expression.expression_id, login=1)
    
    #An expression happens at an event
    RelationshipHelper.add_frbr_relationship(:expression, expression.expression_id, :happens_at, :event,event.event_id, login=1  )
    
    #An event is held at a venue
    RelationshipHelper.add_frbr_relationship(:event, event.event_id, :is_held_at, :venue, venue.venue_id, login=1  )
    
    puts "===="
  end
  
  #Convert a model to a string in the following way:
  # CommunicatiionPeople.find(49) => communication_people_49
  def self.generate_id(model)
    return "#{model.class.to_s.underscore}_#{model.id}"
  end
  
end

=begin
# old stuff
# Tweak 4089, give it a future expression
exp = Expression.find(4089)
exp.expression_title="Future performance of Music for Four"
exp.expression_start = Time.now + (86400*10)
exp.expression_finish = exp.expression_start + (86400*10)
exp.mode_id = 1
exp.save

# Tweak 4021, give it a past expression
exp = Expression.find(4021)
exp.expression_title="Past performance of Music for Four"
exp.expression_start = Time.now - (86400*10)
exp.expression_finish = exp.expression_start + (86400*2)
exp.mode_id = 1
exp.save


w = Work.find(12447)
w.dedication_note = "This work is dedicated to all the people in the world"
w.difficulty_note = "This is really hard to play"
w.commission_note = "This work was commissioned for NZ premiere"
w.save
RelationshipHelper.add_frbr_relationship(:work, 12447, :is_dedicated_to, :contributor, 1200, login=1)
RelationshipHelper.add_frbr_relationship(:work, 12447, :is_commissioned_by, :contributor, 1201, login=1)

#Fix dates for events
ev = Event.find(5)
exp = Expression.find(4021)
ev.event_start = exp.expression_start
ev.event_finish = exp.expression_finish
ev.save

#Fix dates for events
ev = Event.find(1)
exp = Expression.find(4089)
ev.event_start = exp.expression_start
ev.event_finish = exp.expression_finish
ev.save


RelationshipHelper.add_frbr_relationship(:work, 12447, :is_realised_through, :expression, 4021, login=1)
RelationshipHelper.add_frbr_relationship(:work, 12447, :is_realised_through, :expression, 4089, login=1)
RelationshipHelper.add_frbr_relationship(:work, 12447, :is_realised_through, :expression, 2585, login=1)



RelationshipHelper.add_frbr_relationship(:expression, 4021, :is_performed_by, :contributor, 1000, login=1)
RelationshipHelper.add_frbr_relationship(:expression, 4021, :is_exhibited_by, :contributor, 1001, login=1)
RelationshipHelper.add_frbr_relationship(:expression, 4021, :is_improvised_by, :contributor, 1002, login=1)
RelationshipHelper.add_frbr_relationship(:expression, 4021, :is_broadcasted_by, :contributor, 1003, login=1)

RelationshipHelper.add_frbr_relationship(:expression, 4089, :is_performed_by, :contributor, 1004, login=1)
RelationshipHelper.add_frbr_relationship(:expression, 4089, :is_exhibited_by, :contributor, 1005, login=1)
RelationshipHelper.add_frbr_relationship(:expression, 4089, :is_improvised_by, :contributor, 1006, login=1)
RelationshipHelper.add_frbr_relationship(:expression, 4089, :is_broadcasted_by, :contributor, 1007, login=1)

RelationshipHelper.add_frbr_relationship(:event, 1, :is_held_at, :venue, 1004, login=1)
RelationshipHelper.add_frbr_relationship(:event, 5, :is_held_at, :venue, 1007, login=1)



RelationshipHelper.add_frbr_relationship(:expression, 4021, :happens_at, :event, 1, login=1)
RelationshipHelper.add_frbr_relationship(:expression, 4089, :happens_at, :event, 5, login=1)


=end

#This is the start of scillas stuff
r_chi = Resource::create(:resource_type_id => 15, :format_id => 6, :status_id => 1, 
:resource_title => "Lyell Cresswell: Chiaroscuro",
:resource_title_alt => "",
:publication_year => 2005,
:series_title => "programme note",
:contents_note => "Chiaroscuro is a method used in the visual arts applying light and shadow to create the"+
" illusion of three-dimensional objects. If light comes from only one source, and therefore from one direction,"+
" then all light and shadow will be determined by the rules that this implies.\n'Chiaroscuro' was commissioned by Stephen De Pledge in 2005."
)

r_chi.save

r_ara = Resource::create(:resource_type_id => 15, :format_id => 6, :status_id => 1, 
:resource_title => "Gillian Whitehead: Arapatiki",
:resource_title_alt => "",
:publication_year => 2004,
:series_title => "programme note",
:contents_note => "'Arapatiki' was commissioned by Stephen de Pledge as one of a series of Landscape preludes, and received its first performance in the Wigmore Hall, London, in January, 2004. Arapatiki translates (from the Maori language) as 'the way of the flounder', and is the ancient name †of the sand flats in front of my house at Harwood, near Dunedin. The piece has something to do with the advance and retreat of the tide across the flats, where many species of sea and water birds spend much of the day - an ever-varying water-scape. The opening idea is based on the song of the korimako or bellbird.")
r_ara.save

r_eve = Resource::create(:resource_type_id => 15, :format_id => 6, :status_id => 1, 
:resource_title => "Eve de Castro-Robinson: This liquid drift of light",
:resource_title_alt => "",
:series_title => "programme note",
:publication_year => 2004,
:contents_note => "The title is taken from the poem 'Spring Drift Kawhia' by New Zealand poet Denys Trussell and refers"+
" to the shallow tidal harbour of Kawhia on the western coast of the North Island:"+
"Now hills half-stripped\nof gods rim this liquid\ndrift of light, and\nthe sea eye flashes\nmosaic beneath a nest of cliffs"+
"startling the shag\nin its pine-black tower.\n"+
"The evocative phrase provided the inspiration for this 'landscape prelude', written with gratitude to its commissioner, the wonderfully poetic pianist Stephen De Pledge."+
"It was premiered by him in the Wigmore Hall, London, on 23rd January 2004")
r_eve.save


#--- THESE ARE TAKEN FROM SCILLA'S SPREADSHEET Landscape Preludes.xls ----

wellington_region = Region.find(58)

cnz_ci = Contactinfo::create(:region_id =>wellington_region,
:postcode => 'W1U 2BP', 
:street => 'Old Public Trust Building, 131-135 Lambton Quay', :locality => 'Wellington', 
:website_urls => 'http://www.creativenz.govt.nz',
:phone => '(04) 473 0880',
:phone_fax => '(04) 471 2865',
:email_1 => 'info@creativenz.govt.nz'
)


#Generate creative new zealand
cnz = Organisation::create(
:organisation_name => "Creative New Zealand",
:status_id => 3,
:organisation_abbrev => "CNZ",
:contactinfo_id => cnz_ci
)

cnz.save

cnz_contributor = Contributor::create(
 #:contactinfo_id => cnz_ci.contactinfo_id,
 :status_id => 3,
 :contributor_agent_class => 'P',
 :profile => 'Stub for profile of creative NZ'
)

cnz_contributor.save



join = ContributorOrganisation::create(
:organisation_id => cnz.organisation_id, :contributor_id => cnz_contributor.contributor_id
)

join.save

cnz_role = Role::create(
:organisation_id => cnz.organisation_id, :role_type_id => 23
)

cnz_role.save

cnz_role_ci = RoleContactinfo::create(
  :contactinfo_id => cnz_ci.contactinfo_id,
  :contactinfo_type => 'postal',
  :role_id => cnz_role.role_id
)


#Create a skeletal james wallace
jw_ci = Contactinfo::create(:region_id =>wellington_region
)


#Generate creative new zealand
jw_p = Person::create(
:first_names => "James",
:last_name => "Wallace",
:status_id => 3,
:gender => 'M',\
:updated_by => 1
)

jw_p.save

jw_contributor = Contributor::create(
 #:contactinfo_id => jw_ci.contactinfo_id,
 :status_id => 3,
 :contributor_agent_class => 'P',
 :profile => 'Stub for James Wallace'
)

jw_contributor.save

join2 = ContributorPeople::create(
:person_id => jw_p.person_id, :contributor_id => jw_contributor.contributor_id
)

join2.save

puts "James wallace join: "+join2.id.to_s








#Populate chiaroscuro
w_chi = Work.find(17195)
w_chi.difficulty_note = ""
w_chi.commissioned_note="Commissioned by Stephen De Pledge"
w_chi.contents_note = "Part of the New Zealand landscape prelude series"
w_chi.save

RelationshipHelper.add_frbr_relationship(:work, w_chi.work_id, :is_described_by, :resource, r_chi.resource_id, login=1)
#FIXME RelationshipHelper.add_frbr_relationship(:resource, r_chi.resource_id, :is_written_by, :contributor, w_chi.composers[0].contributor_id, login=1 )

sdp_id = 1288 


RelationshipHelper.add_frbr_relationship(:work, w_chi.work_id, :is_commissioned_by, :contributor, sdp_id, login=1)
RelationshipHelper.add_frbr_relationship(:work, w_chi.work_id, :has_as_its_theme, :concept, 11, login=1) # Landscape other, theme

PIANO_SOLO = WorkSubcategory.find(10)
w_liquid_light = Work.find(16598)
w_liquid_light.work_description = 'This "landscape prelude" for piano reflects an aspect of New Zealand (the water at Kawhia harbour)'
w_liquid_light.difficulty_note = ''
w_liquid_light.general_note = 'Title from a poem by Denys Trussell'
w_liquid_light.commissioned_note = 'Commissioned by Stephen De Pledge with funding from Creative New Zealand'
w_liquid_light.contents_note = 'Part of the New Zealand landscape prelude series'

#FIXME - expressions
w_liquid_light.save

RelationshipHelper.add_frbr_relationship(:work, w_liquid_light.work_id, :is_described_by, :resource, r_eve.resource_id, login=1)
#FIXME RelationshipHelper.add_frbr_relationship(:resource, r_eve.resource_id, :is_written_by, :contributor, w_liquid_light.composers[0].contributor_id, login=1 )



#w_liquid_light.work_categorisations =[PAINO_SOLO]
RelationshipHelper.add_frbr_relationship(:work, w_liquid_light.work_id, 
:is_commissioned_by, :contributor, sdp_id, login=1)

RelationshipHelper.add_frbr_relationship(:work, w_liquid_light.work_id, 
:is_funded_by, :contributor, jw_contributor.contributor_id, login=1) 


RelationshipHelper.add_frbr_relationship(:work, w_liquid_light.work_id, :has_as_its_theme, :concept, 12, login=1) # Landscape other, theme
RelationshipHelper.add_frbr_relationship(:work, w_liquid_light.work_id, :has_as_its_theme, :concept, 70, login=1) # Landscape other, theme


w_ara = Work.find(16837)
w_ara.work_description = "a landscape prelude for piano"
w_ara.difficulty_note = ''
w_ara.difficulty=2 # Intermediate
w_ara.commissioned_note = 'Commissioned by Stephen De Pledge'
w_ara.contents_note = 'Part of the New Zealand landscape prelude series'


w_ara.save


RelationshipHelper.add_frbr_relationship(:work, w_ara.work_id, :is_described_by, :resource, r_ara.resource_id, login=1)
#FIXME RelationshipHelper.add_frbr_relationship(:resource, r_ara.resource_id, :is_written_by, :contributor, w_ara.composers[0].contributor_id, login=1 )



RelationshipHelper.add_frbr_relationship(:work, w_ara.work_id, 
:is_commissioned_by, :contributor, sdp_id, login=1)
RelationshipHelper.add_frbr_relationship(:work, w_ara.work_id, :has_as_its_theme, :concept, 12, login=1) # Landscape nz, theme
RelationshipHelper.add_frbr_relationship(:work, w_ara.work_id, :has_as_its_theme, :concept, 70, login=1) # Landscape other, theme
RelationshipHelper.add_frbr_relationship(:work, w_ara.work_id, :is_influenced_by, :concept, 71, login=1) # Landscape other, theme



w_gk = Work.find(16574)
w_gk.work_description = "a landscape prelude for piano"
w_gk.contents_note = 'Part of the New Zealand landscape prelude series'
w_gk.difficulty_note=''
w_gk.commissioned_note = 'Commissioned by Stephen De Pledge'
w_gk.save
RelationshipHelper.add_frbr_relationship(:work, w_gk.work_id, 
:is_commissioned_by, :contributor, sdp_id, login=1)
RelationshipHelper.add_frbr_relationship(:work, w_gk.work_id, :has_as_its_theme, :concept, 14, login=1) #Culture NZ




w_reign = Work.find(17196)
w_reign.work_description = "a landscape prelude for piano"
w_reign.contents_note = 'Part of the New Zealand landscape prelude series'
w_reign.difficulty_note=''
w_reign.commissioned_note = 'Commissioned by Stephen De Pledge with funding from James Wallace'
w_reign.save
RelationshipHelper.add_frbr_relationship(:work, w_reign.work_id, :is_commissioned_by, :contributor, sdp_id, login=1)
RelationshipHelper.add_frbr_relationship(:work, w_reign.work_id, :is_funded_by, :contributor, jw_contributor.contributor_id, login=1)
RelationshipHelper.add_frbr_relationship(:work, w_reign.work_id, :is_dedicated_to, :contributor, sdp_id, login=1)



w_machine_noise = Work.find(16070)
w_machine_noise.work_description = "a landscape prelude for piano"
w_machine_noise.contents_note = 'Part of the New Zealand landscape prelude series'
w_machine_noise.difficulty_note=''
w_machine_noise.difficulty=2
w_machine_noise.commissioned_note = 'Commissioned by Stephen De Pledge'
RelationshipHelper.add_frbr_relationship(:work, w_machine_noise.work_id, :is_commissioned_by, :contributor, sdp_id, login=1)
w_machine_noise.save

w_street = Work.find(11764)
w_street.work_description = "a landscape prelude for piano"
w_street.contents_note = 'Part of the New Zealand landscape prelude series'
w_street.difficulty_note=''
w_street.commissioned_note = 'Commissioned by Stephen De Pledge'
w_street.save

RelationshipHelper.add_frbr_relationship(:work, w_street.work_id, :is_commissioned_by, :contributor, sdp_id, login=1)

RelationshipHelper.add_frbr_relationship(:work, w_street.work_id, :has_as_its_theme, :concept, 72, login=1) #Culture NZ



#EXPRESSION TIME......
chi_comp_set = Expression.find(5140)
chi_comp_set.mode_id=2
chi_comp_set.players_count = 1
chi_comp_set.save
#FIXME - create contributor...cont_sdp = Contributor::create()


#Create event
sussex_region = Region::new(:region_name => 'Sussex', :country_id => 230)
sussex_region.save

sussex_ci = Contactinfo::create(:region_id => sussex_region.region_id)
sussex_ci.save

aimf= Event::create(:event_title => 'Arundel Music Festival', 
:status_id => 3, :contactinfo_id => sussex_ci.contactinfo_id, :event_type_id => 5)
aimf.event_start = Time.parse('23-08-2005')
aimf.event_finish = Time.parse('27-08-2005')
aimf.save



=begin
exp1 = Expression::new
exp1.general_note='Premiered by Stephen De Pledge, Arundel International Festival, Sussex, England.  24 August 2005.'
exp1.mode_id = 1
exp1.expression_title = 'Chiaroscuro, De Pledge, Arundel'
exp1.premiere = Expression.premiere_statuses[:world_wide]
exp1.status_id = 3
exp1.work_id = w_chi.id
exp1.players_count = 1
exp1.expression_start = Time.parse('24-08-2005')
exp1.expression_finish = Time.parse('24-08-2005')
exp1.save
london_region = Region::new(:region_name => 'Greater London', :country_id => 230)
london_region.save
=end






wigmore_hall_venue = Venue.find(5)

aimf_venue = Venue::new
aimf_venue.contactinfo_id = sussex_ci.contactinfo_id
aimf_venue.status_id = 3
aimf_venue.venue_name = 'Arundel'
aimf_venue.save


wig_ev= Event::create(:event_title => 'Wigmore Hall Concert', 
:status_id => 3, 
:contactinfo_id => wigmore_hall_venue.contactinfo_id,
 :event_type_id => 1)
wig_ev.event_start = Time.parse('28-01-2004 19:00')
wig_ev.event_finish = Time.parse('28-01-2004 21:00')
wig_ev.save


# Stephen de pledge at wigmore, liquid drift of light
sdp_wig_liq_exp = Expression::new
sdp_wig_liq_exp.general_note='Premiered by pianist Stephen De Pledge, Wigmore Hall, London, United Kingdom. 28 January 2004'
sdp_wig_liq_exp.mode_id = 1
sdp_wig_liq_exp.expression_title = 'Liquid Drift of Light'
sdp_wig_liq_exp.premiere = Expression.premiere_statuses[:world_wide]
sdp_wig_liq_exp.status_id = 3
sdp_wig_liq_exp.work_id = w_liquid_light.id
sdp_wig_liq_exp.players_count = 1

sdp_wig_liq_exp.expression_start = Time.parse('28-01-2004')
sdp_wig_liq_exp.expression_finish = Time.parse('28-01-2004')

sdp_wig_liq_exp.save
DataEntryHelper.link_work_to_expression_to_event_to_venue(w_liquid_light, sdp_wig_liq_exp, wig_ev, wigmore_hall_venue)

# Stephen de pledge at wigmore, arapatiki
sdp_wig_ara_exp = Expression::new
sdp_wig_ara_exp.general_note='Premiered by pianist Stephen De Pledge, Wigmore Hall, London, United Kingdom. 28 January 2004'
sdp_wig_ara_exp.mode_id = 1
sdp_wig_ara_exp.expression_title = 'Arapatiki'
sdp_wig_ara_exp.premiere = Expression.premiere_statuses[:world_wide]
sdp_wig_ara_exp.status_id = 3
sdp_wig_ara_exp.work_id = w_ara.id
sdp_wig_ara_exp.players_count = 1
sdp_wig_ara_exp.expression_start = Time.parse('28-01-2004')
sdp_wig_ara_exp.expression_finish = Time.parse('28-01-2004')
sdp_wig_ara_exp.save

#add a recording to arapatiki for attachment of mp3 sample

ara_recording_man=Manifestation.new()
ara_recording_man.format_id=2
ara_recording_man.manifestation_type_id=3
ara_recording_man.status_id=1
ara_recording_man.manifestation_title="Recording of Araptiki"
ara_recording_man.series_title="No series title"
ara_recording_man.duration='3:00'
ara_recording_man.cost=5.50
ara_recording_man.publication_year='2007'
ara_recording_man.save

ara_exp_man=ExpressionManifestation.new()
ara_exp_man.expression_id=sdp_wig_ara_exp.id
ara_exp_man.manifestation_id=ara_recording_man.id
ara_exp_man.save

ara_sample=Sample.new()
ara_sample.manifestation_id=ara_recording_man.id
ara_sample.status_id=1
ara_sample.sample_description="Sample of Arapatiki recording"
ara_sample.save

ara_media_item=MediaItem.new()
ara_media_item.mime_type_id=2
ara_media_item.media_item_path="/samples/audio samples - mp3s/6793_108087_smp.mp3"
ara_media_item.save

ara_sample_att=SampleAttachment.new()
ara_sample_att.media_item_id=ara_media_item.id
ara_sample_att.sample_id=ara_sample.id
ara_sample_att.save

RelationshipHelper.add_frbr_relationship(:expression,sdp_wig_ara_exp.id, :is_embodied_in,:manifestation, ara_recording_man.id, login=1 )


DataEntryHelper.link_work_to_expression_to_event_to_venue(w_ara, sdp_wig_ara_exp, wig_ev, wigmore_hall_venue)

# Stephen de pledge at wigmore, liquid drift of light
sdp_wig_gk_exp = Expression::new
sdp_wig_gk_exp.general_note='Premiered by pianist Stephen De Pledge, Wigmore Hall, London, United Kingdom. 28 January 2004'
sdp_wig_gk_exp.mode_id = 1
sdp_wig_gk_exp.expression_title = 'Goodnight Kiwi'
sdp_wig_gk_exp.premiere = Expression.premiere_statuses[:world_wide]
sdp_wig_gk_exp.status_id = 3
sdp_wig_gk_exp.work_id = w_gk.id
sdp_wig_gk_exp.players_count = 1

sdp_wig_gk_exp.expression_start = Time.parse('28-01-2004')
sdp_wig_gk_exp.expression_finish = Time.parse('28-01-2004')


sdp_wig_gk_exp.save
DataEntryHelper.link_work_to_expression_to_event_to_venue(w_gk, sdp_wig_gk_exp, wig_ev, wigmore_hall_venue)


#Stephen de Plege, Reign, Arundel
sdp_aru_reign_exp = Expression::new
sdp_aru_reign_exp.general_note='Premiered by Stephen De Pledge, Arundel International Festival, Sussex, England on 24 August 2005.'
sdp_aru_reign_exp.mode_id = 1
sdp_aru_reign_exp.expression_title = 'Reign, Stephen de Plege, Arundel International Festival'
sdp_aru_reign_exp.premiere = Expression.premiere_statuses[:world_wide]
sdp_aru_reign_exp.status_id = 3
sdp_aru_reign_exp.work_id = w_reign.id
sdp_aru_reign_exp.players_count = 1
sdp_aru_reign_exp.expression_start = Time.parse('24-08-2005')
sdp_aru_reign_exp.expression_finish = Time.parse('24-08-2005')
sdp_aru_reign_exp.save
DataEntryHelper.link_work_to_expression_to_event_to_venue(w_reign, sdp_aru_reign_exp, aimf, aimf_venue)



#Stephen de Plege, Chiaroscoro, Arundel
sdp_aru_chi_exp = Expression::new
sdp_aru_chi_exp.general_note='Premiered by Stephen De Pledge, Arundel International Festival, Sussex, England on 24 August 2005.'
sdp_aru_chi_exp.mode_id = 1
sdp_aru_chi_exp.expression_title = 'Chiaroscuro'
sdp_aru_chi_exp.premiere = Expression.premiere_statuses[:world_wide]
sdp_aru_chi_exp.status_id = 3
sdp_aru_chi_exp.work_id = w_chi.id
sdp_aru_chi_exp.players_count = 1
sdp_aru_chi_exp.expression_start = Time.parse('24-08-2005')
sdp_aru_chi_exp.expression_finish = Time.parse('24-08-2005')
sdp_aru_chi_exp.save
DataEntryHelper.link_work_to_expression_to_event_to_venue(w_chi, sdp_aru_chi_exp, aimf, aimf_venue)




# -- CREATE THE ADAM CONCERT ROOM ---

=begin
ach_ci = Contactinfo::create(:region_id => wellington_region,
:postcode => '6021', :street => 'Wallace St', :suburb => 'Mt Cook', :locality => 'Wellington', 
:website_urls => 'http://www.nzsm.ac.nz',
:phone => '+64 4 801 5799',
:email_1 => 'info@nzsm.ac.nz'
)
ach_ci.save



ach_venue = Venue::new
ach_venue.contactinfo_id = ach_ci.contactinfo_id
ach_venue.status_id = 3
ach_venue.venue_name = 'Adam Concert Room'
ach_venue.save
=end
ach_venue = Venue.find(1000)


#Now create an event for that night at the ACR

ach_ev= Event::create(:event_title => 'Stephen de Pledge at the Adam Concert Room', 
:status_id => 3, 
:contactinfo_id => ach_venue.contactinfo_id,
 :event_type_id => 1)
ach_ev.event_start = Time.parse('25-05-2007')
ach_ev.event_finish = Time.parse('25-05-2007')
ach_ev.save

puts "TRACE1"

#Now create the experssion
#Stephen de Plege, Machine Noise, Adam Concert Room
sdp_mn_acr_exp = Expression::new
sdp_mn_acr_exp.general_note='Premiered by Stephen De Pledge at the Adam Concert Room, New Zealand School of Music on May 25, 2007\n'+
'Performance Note: Square noteheads indicate a cluster is to be performed containing all the notes occurring between the outer two '+
'notes (inclusive). For instance, if a chord of D-natural and F-natural is given square noteheads, the performer should play a cluster'+
' containing the notes D-natural, E-flat, E-natural and F-natural.\n\n'+
'The whole piece should be played almost mechanistically, greatly emphasising the dynamic contrast, preferably underpinning the dynamic markings with a contrast in physical gesture as well.'
sdp_mn_acr_exp.mode_id = 1
sdp_mn_acr_exp.expression_title = 'Machine Noise, Stephen de Plege, Adam Concert Room'
sdp_mn_acr_exp.premiere = Expression.premiere_statuses[:world_wide]
sdp_mn_acr_exp.status_id = 3
sdp_mn_acr_exp.work_id = w_machine_noise.id
sdp_mn_acr_exp.players_count = 1
sdp_mn_acr_exp.expression_start = Time.parse('25-05-2007')
sdp_mn_acr_exp.expression_finish = Time.parse('25-05-2007')
sdp_mn_acr_exp.save
puts "TRACE 1.5"
DataEntryHelper.link_work_to_expression_to_event_to_venue(w_machine_noise, sdp_mn_acr_exp, ach_ev, ach_venue)

puts "TRACE2"
# The street where I live expression, stephen de p
sdp_acr_street_exp = Expression::new
sdp_acr_street_exp.general_note='Premiered by Stephen De Pledge at the Adam Concert Room, New Zealand School of Music on May 25, 2007'
sdp_acr_street_exp.mode_id = 1
sdp_acr_street_exp.expression_title = 'The Street Where I Live, Stephen de Plege, Adam Concert Room'
sdp_acr_street_exp.premiere = Expression.premiere_statuses[:world_wide]
sdp_acr_street_exp.status_id = 3
sdp_acr_street_exp.work_id = w_street.id
sdp_acr_street_exp.players_count = 1
sdp_acr_street_exp.expression_start = Time.parse('25-05-2007')
sdp_acr_street_exp.expression_finish = Time.parse('25-05-2007')
sdp_acr_street_exp.save

DataEntryHelper.link_work_to_expression_to_event_to_venue(w_street, sdp_acr_street_exp, ach_ev, ach_venue)



puts "TRACE3"



#Stephen Pledge performs
RelationshipHelper.add_frbr_relationship(:contributor, sdp_id, :performs, :expression, sdp_acr_street_exp.expression_id, login=1)
RelationshipHelper.add_frbr_relationship(:contributor, sdp_id, :performs, :expression, sdp_mn_acr_exp.expression_id, login=1)
RelationshipHelper.add_frbr_relationship(:contributor, sdp_id, :performs, :expression, sdp_aru_reign_exp.expression_id, login=1)
RelationshipHelper.add_frbr_relationship(:contributor, sdp_id, :performs, :expression, sdp_wig_liq_exp.expression_id, login=1)
RelationshipHelper.add_frbr_relationship(:contributor, sdp_id, :performs, :expression, sdp_wig_ara_exp.expression_id, login=1)
RelationshipHelper.add_frbr_relationship(:contributor, sdp_id, :performs, :expression, sdp_wig_gk_exp.expression_id, login=1)


#Lyle cresswell, meet the composer
cresswell = Contributor.find(1024)

#Expression
exp_cress_meet_the_composer = Expression::new
exp_cress_meet_the_composer.general_note=nil
exp_cress_meet_the_composer.mode_id = 1
exp_cress_meet_the_composer.expression_title = 'Meet the Composer; Lyell Cresswell'
exp_cress_meet_the_composer.premiere = nil
exp_cress_meet_the_composer.status_id = 3
exp_cress_meet_the_composer.work_id = w_chi.work_id
exp_cress_meet_the_composer.players_count = 1
exp_cress_meet_the_composer.expression_start = Time.parse('24-05-2007 19:00')
exp_cress_meet_the_composer.expression_finish = Time.parse('24-05-2007 21:00')
exp_cress_meet_the_composer.save



RelationshipHelper.add_frbr_relationship(:work, w_chi.work_id, :is_realised_through, :expression, exp_cress_meet_the_composer.expression_id, login=1)


# Gillian whitehead pull quote
gwc = Contributor.find(1101)
gwc.pull_quote = "My perceptions of European traditions (medieval to modernist) and the"+
" soundscapes, instruments and stories of Aotearoa are my materials. My pieces "+
"are in turn abstract, narrative, mediative and dramatic; a number draw on my "+
"Maori heritage; I love working with collaborative and improvisational "+
"elements. Music should always be a journey of exploration that moves, "+
"delights and challenges composer, performer and audience alike."
gwc.save


edc = Contributor.find(1001)
edc.pull_quote = "Get out of whatever cage you're in - John Cage"
edc.save


#Add future expression
tuho = Organisation.find(:first, :conditions => ["organisation_name like ?","Tuhono%"])
tuho_cont = ContributorOrganisations.find(:first, :conditions => ["organisation_id = ?",tuho.organisation_id])
auck_town_hall = Venue.find(:first, :conditions => ["venue_name like ?","Auckland Town Hall"])


cmz  = Organisation.find(:first, :conditions => ["organisation_name like ?","Chamber Music New Zealand%"])
cmz_cont = ContributorOrganisations.find(:first, :conditions => ["organisation_id = ?",cmz.organisation_id])


exp_tuo_auck = Expression::new
exp_tuo_auck.general_note=nil
exp_tuo_auck.mode_id = 1
exp_tuo_auck.expression_title = 'Arapatiki'
exp_tuo_auck.premiere = nil
exp_tuo_auck.status_id = 3
exp_tuo_auck.work_id = w_ara.work_id
exp_tuo_auck.players_count = 7
exp_tuo_auck.expression_start = Time.parse('19-06-2007 20:00')
exp_tuo_auck.expression_finish = Time.parse('19-06-2007 22:00')
exp_tuo_auck.save


exp_tuo_auck_ev= Event::create(:event_title => 'Tuhonohono', 
:status_id => 3, 
:contactinfo_id => auck_town_hall.contactinfo_id,
 :event_type_id => 1)
 exp_tuo_auck_ev.event_start = Time.parse('19-06-2007 20:00')
 exp_tuo_auck_ev.event_finish = Time.parse('19-06-2007 22:00')
exp_tuo_auck_ev.save


DataEntryHelper.link_work_to_expression_to_event_to_venue(w_ara, exp_tuo_auck, exp_tuo_auck_ev, auck_town_hall)
RelationshipHelper.add_frbr_relationship(:contributor, tuho_cont.contributor_id, :performs, :expression, exp_tuo_auck.expression_id, login=1)
RelationshipHelper.add_frbr_relationship(:contributor, cmz_cont.contributor_id, :presents, :expression, exp_tuo_auck.expression_id, login=1)




soundings_theatre_venue = Venue.find(:first, :conditions => ["venue_name like ? ","Soundings Theat%"])

tuo_soundings_exp = Expression::new
tuo_soundings_exp.general_note=nil
tuo_soundings_exp.mode_id = 1
tuo_soundings_exp.expression_title = 'Arapatiki'
tuo_soundings_exp.premiere = nil
tuo_soundings_exp.status_id = 3
tuo_soundings_exp.work_id = w_ara.work_id
tuo_soundings_exp.players_count = 7
tuo_soundings_exp.expression_start = Time.parse('21-06-2007 20:00')
tuo_soundings_exp.expression_finish = Time.parse('21-06-2007 22:00')
tuo_soundings_exp.save

tuo_soundings_ev = Event::create(:event_title => 'Tuhonohono', 
:status_id => 3, 
:contactinfo_id => soundings_theatre_venue.contactinfo_id,
 :event_type_id => 1)
 tuo_soundings_ev.event_start = Time.parse('21-06-2007 20:00')
 tuo_soundings_ev.event_finish = Time.parse('23-06-2007 22:00')
tuo_soundings_ev.save

DataEntryHelper.link_work_to_expression_to_event_to_venue(w_ara, tuo_soundings_exp, tuo_soundings_ev, soundings_theatre_venue)
RelationshipHelper.add_frbr_relationship(:contributor, tuho_cont.contributor_id, :performs, :expression, tuo_soundings_exp.expression_id, login=1)
RelationshipHelper.add_frbr_relationship(:contributor, cmz_cont.contributor_id, :presents, :expression, tuo_soundings_exp.expression_id, login=1)


#Recording for goodnight kiwi
gk_recording_man=Manifestation.new()
gk_recording_man.format_id=2
gk_recording_man.manifestation_type_id=3
gk_recording_man.status_id=1
gk_recording_man.manifestation_title="Recording of Goodnight Kiwi"
gk_recording_man.series_title="No series title"
gk_recording_man.duration='3:00' #FIXME
gk_recording_man.cost=0
gk_recording_man.publication_year='2007'
gk_recording_man.save

gk_exp_man=ExpressionManifestation.new()
gk_exp_man.expression_id=sdp_wig_gk_exp.id
gk_exp_man.manifestation_id=gk_recording_man.id
gk_exp_man.save

gk_sample=Sample.new()
gk_sample.manifestation_id=gk_recording_man.id
gk_sample.status_id=1
gk_sample.sample_description="Sample of Arapatiki recording"
gk_sample.save

gk_media_item=MediaItem.new()
gk_media_item.mime_type_id=2
gk_media_item.media_item_path="/samples/audio samples - mp3s/6816_330028_smp.mp3"
gk_media_item.save

gk_sample_att=SampleAttachment.new()
gk_sample_att.media_item_id=gk_media_item.id
gk_sample_att.sample_id=gk_sample.id
gk_sample_att.save

RelationshipHelper.add_frbr_relationship(:expression,sdp_wig_gk_exp.id, :is_embodied_in,:manifestation, gk_recording_man.id, login=1 )



#Recording liquid drift of light
ld_recording_man=Manifestation.new()
ld_recording_man.format_id=2
ld_recording_man.manifestation_type_id=3
ld_recording_man.status_id=1
ld_recording_man.manifestation_title="Recording of this liquid drift of light"
ld_recording_man.series_title="No series title"
ld_recording_man.duration='5:00' #FIXME
ld_recording_man.cost=0
ld_recording_man.publication_year='2007'
ld_recording_man.save

ld_exp_man=ExpressionManifestation.new()
ld_exp_man.expression_id=sdp_wig_liq_exp.id
ld_exp_man.manifestation_id=ld_recording_man.id
ld_exp_man.save

ld_sample=Sample.new()
ld_sample.manifestation_id=ld_recording_man.id
ld_sample.status_id=1
ld_sample.sample_description="Sample of this liquid drift of light recording"
ld_sample.save

ld_media_item=MediaItem.new()
ld_media_item.mime_type_id=2
ld_media_item.media_item_path="/samples/audio samples - mp3s/6816_003044_smp.mp3"
ld_media_item.save

ld_sample_att=SampleAttachment.new()
ld_sample_att.media_item_id=ld_media_item.id
ld_sample_att.sample_id=ld_sample.id
ld_sample_att.save

RelationshipHelper.add_frbr_relationship(:expression,sdp_wig_liq_exp.id, :is_embodied_in,:manifestation, ld_recording_man.id, login=1 )



=begin
media_item_10001:
  media_item_id: 10001
  mime_type_id: 3
  media_item_path: "/composers/thumbs/B002.jpg"
  media_item_desc: "thumbnail for Christopher Blake"
  caption: "Christopher Blake (Christopher Blake)"
  
  contributor_attachment_10003:
    attachment_type_id: 2
    contributor_id: 1001
    media_item_id: 10003
    
    
    
     attachment_type_id |  attachment_type_desc   | display_order 
    --------------------+-------------------------+---------------
                      4 | Manifestation thumbnail |             1
                      1 | Contributor photo       |             0
                      2 | Contributor thumbnail   |             1
                      3 | Manifestation image     |             1
                      
                      
=end

#Image for steve de pledge
mi = MediaItem::create(
  :mime_type_id => 3,
  :media_item_path => "/composers/thumbs/sdp.jpg"
)
mi.save

ca = ContributorAttachment::create(
  :attachment_type_id => 2,
  :contributor_id => sdp_id,
  :media_item_id => mi.media_item_id
)
ca.save

mi = MediaItem::create(
  :mime_type_id => 3,
  :media_item_path => "/composers/sdp.jpg"
)
mi.save

ca = ContributorAttachment::create(
  :attachment_type_id => 1,
  :contributor_id => sdp_id,
  :media_item_id => mi.media_item_id
)
ca.save





