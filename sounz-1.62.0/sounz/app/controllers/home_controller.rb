class HomeController < ApplicationController
  include ApplicationHelper
  def index
    @page_title = "Home"

    #Add one to the home key
    counter = Setting.increment_value_by_key(Setting::HOME_PAGE_CTR_KEY)

    front_page_ids = Setting.get_value(Setting::HOME_PAGE_CONTRIBUTORS_LIST).split(',')

    #Use the following in a Rails console to check what combination of composers / performers exist.
    #front_page_ids.map{|c| Contributor.find(c).known_as+':'+Contributor.find(c).role.role_type.facet_role_type}
    contributor_id = front_page_ids[counter % front_page_ids.length]
    @random_contributor = Contributor.find(contributor_id)

    front_page_manifestation_ids = Setting.get_value(Setting::HOME_PAGE_MANIFESTATIONS_LIST).split(',')
    logger.debug front_page_manifestation_ids
    logger.debug "MANIF ID SIZE #{front_page_manifestation_ids.length}"
    manifestation_id = front_page_manifestation_ids[counter % front_page_manifestation_ids.length]
    logger.debug "MANIF_ID:#{manifestation_id}"
    @random_manifestation = Manifestation.find(manifestation_id)

    front_page_event_ids = Setting.get_value(Setting::HOME_PAGE_EVENTS_LIST).split(',')
    event_pos = counter % front_page_event_ids.length
    logger.debug "EVENT POS:#{event_pos}"
    event_id = front_page_event_ids[event_pos]
    @random_event = Event.find(event_id)

    front_page_sounzmedia_ids = Setting.get_value(Setting::HOME_PAGE_SOUNZMEDIA_LIST).split(',')
    if(front_page_sounzmedia_ids.size > 0)
      sounzmedia_id = front_page_sounzmedia_ids[counter % front_page_sounzmedia_ids.length]
      @random_sounzmedia = Manifestation.find(sounzmedia_id)
    end

    @news_articles = NewsArticle.get_feature_articles(2)

    @homepage_content = CmContent.find(:first, :conditions => {:cm_content_name => 'homepage'})
    if @homepage_content.nil?
      @homepage_content = ''
    else
      @homepage_content = @homepage_content.cm_content
    end
  end


  def check_images
    @contributor_ids = ContributorAttachment.find(:all,
    :conditions => ["attachment_type_id = ?",
      AttachmentType::ICON_IMAGE.attachment_type_id]
      ).map{|ca|ca.contributor_id}
  end

  def check_manifestation_images
    @manifestation_ids = ManifestationAttachment.find(:all,
    :limit => 100,
    :conditions => ["attachment_type_id = ?",
      AttachmentType::ICON_IMAGE.attachment_type_id]
      ).map{|ca|ca.manifestation_id}
  end

  def email_updates_requested

	if ! @login.blank?
	  @login.add_to_saved_list("Requested Email Updates")
    end

  end

end
