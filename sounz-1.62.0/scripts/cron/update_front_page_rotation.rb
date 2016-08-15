#!/usr/bin/env ../../sounz/script/runner

role_types_ids_for_front_display = RoleType.find(:all, :conditions => ['role_type_desc in (?) or role_type_desc in (?)', RoleType::COMPOSER_ROLE_TYPE_NAMES, RoleType::PERFORMER_ROLE_TYPE_NAMES]).map{|rt| rt.role_type_id}

csv = ContributorAttachment.find(:all, :select => 'DISTINCT(contributor_id)', 
                                       :joins => "inner join contributors using (contributor_id) inner join roles using (role_id)",
                                       :conditions => ["attachment_type_id in (?) and contributors.status_id = ? and role_type_id in (?)", 
                                                        [AttachmentType::ICON_IMAGE.attachment_type_id,AttachmentType::MAIN_IMAGE.attachment_type_id],
                                                         Status::PUBLISHED, role_types_ids_for_front_display]
                                 ).map{|ca|ca.contributor_id}
								 
csv = csv.sort_by{rand}.join(',')
                               
Setting.set_and_possibly_create(Setting::HOME_PAGE_CONTRIBUTORS_LIST, csv)

puts "HOME_PAGE_CONTRIBUTORS_LIST: number: #{csv.split(',').length}   ids: #{csv}"


csv = ManifestationAttachment.find(:all, :joins => "inner join manifestations using (manifestation_id)",
                                         :conditions => ["attachment_type_id = ? and status_id = ?", 
                                         AttachmentType::MAIN_IMAGE.attachment_type_id, Status::PUBLISHED]
                                   ).map{|ma|ma.manifestation_id}.join(',')
                                   
Setting.set_and_possibly_create(Setting::HOME_PAGE_MANIFESTATIONS_LIST, csv)
puts "HOME_PAGE_MANIFESTATIONS_LIST: #{csv}"

#list of sounzmedia, restrict to Manifestations and internal format
sounzmedia_type = ManifestationType.find(:first, :conditions => ["manifestation_type_desc = 'Media on Demand'"])
internal_audio_format = Format.find(:first, :conditions => ["format_desc='internal - audio'"])
internal_video_format = Format.find(:first, :conditions => ["format_desc='internal - video'"])
external_audio_format = Format.find(:first, :conditions => ["format_desc='external - audio'"])
external_video_format = Format.find(:first, :conditions => ["format_desc='external - video'"])

csv = ManifestationAttachment.find(:all, :joins => "inner join manifestations m using (manifestation_id)",
                                         :conditions => ["attachment_type_id = ? and status_id = ? and m.manifestation_type_id = ? and (m.format_id = ? or m.format_id = ? or m.format_id = ? or m.format_id = ?)", 
                                         AttachmentType::MAIN_IMAGE.attachment_type_id, Status::PUBLISHED, sounzmedia_type, internal_audio_format, internal_video_format, external_audio_format, external_video_format]
                                   ).map{|ma|ma.manifestation_id}.join(',')
                                   
Setting.set_and_possibly_create(Setting::HOME_PAGE_SOUNZMEDIA_LIST, csv)
puts "HOME_PAGE_SOUNZMEDIA_LIST: #{csv}"


future_event_ids = Event.find(:all, :conditions => ["event_start > ? and status_id = ?", Time.now, Status::PUBLISHED]).map{|e| e.event_id}

puts "FUTURE EVENT IDS:#{future_event_ids.join(', ')}"
future_events_attachments = EventAttachment.find(:all,
                      :conditions => ["event_id in (?) and attachment_type_id = ?", future_event_ids,  
                        AttachmentType::MAIN_IMAGE.attachment_type_id])

puts "FUTURE EVENT ATTACHMENTS:#{future_events_attachments}"                    

csv =future_events_attachments.map{|ea|ea.event_id}.join(',')
Setting.set_and_possibly_create(Setting::HOME_PAGE_EVENTS_LIST, csv) 

puts "CSV FOR HOME PAGE EVENTS:#{csv}"                  
                      
=begin
               SAMPLE = AttachmentType.find(:first, :conditions => ["attachment_type_desc = ?", "Sample"])
                      CAMPAIGN_MAILOUT = AttachmentType.find(:first, :conditions => ["attachment_type_desc = ?", "Campaign mailout"])
                      MAIN_IMAGE = AttachmentType.find(:first, :conditions => ["attachment_type_desc = ?", "Main Image"])
                      ICON_IMAGE = AttachmentType.find(:first, :conditions => ["attachment_type_desc = ?", "Icon Image"])
                      LOGO = AttachmentType.find(:first, :conditions => ["attachment_type_desc = ?", "Logo"])
                      SUPPLEMENTARY_IMAGE = AttachmentType.find(:first, :conditions => ["attachment_type_desc = ?", "Supplementary Image"])
                      TINE_MCE = AttachmentType.find(:first, :conditions => ["attachment_type_desc = ?", "Tiny MCE"])
=end