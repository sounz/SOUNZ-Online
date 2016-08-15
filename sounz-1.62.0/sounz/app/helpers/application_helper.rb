require 'redcloth'
require 'yaml'

# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  UNTABBED_CONTROLLERS = [
    "authentication",
    "cm_contents",
    "prov_composer_bios",
    "prov_contact_updates",
    "prov_contributor_profiles",
    "prov_events",
    "prov_feedbacks",
    "prov_work_updates",
	"prov_products",
    "news_articles",
    "logins",
    "privileges",
    "cart",
	"people/new_web_user",
	"password",
	"rss_feeds"
    ]

  def get_zenid_cookie
     ecj = external_cookie_jar
     cookieString = ecj.cookies_for(URI.parse("http://"+ZENCART_SERVER.to_s+"/zencart")).to_s
     #extract our zencart id and attach to our cookie list
     cookieString = ~/zenid=(.*)/
     return cookieString
  end

  # - These methods are used as short cuts to render public/private views
  def start_of_content(object_in_context, main_title)
    render :partial => 'shared/public_pages/content_start',
                  :locals => {:object => object_in_context, :main_title => main_title}
  end


  def end_of_content(object_in_context)
    render :partial => 'shared/public_pages/content_end',:locals => {:object => object_in_context}
  end


  def main_tabs(selected = :works)
      render :partial => '/shared/tabs/public_site_tabs', :locals => {:selected_tab => selected}
  end


  def get_summary_for_text(text, length)
    result= ""
    result = summary_of(convert_to_html(text), length) if  !text.blank?
    result
  end


  #Show the note if its not blank, and convert it to HTML
  def show_note(note)
    result = ""
    result = convert_to_html(note) if !note.blank?
    result
  end


  def show_dt_dd_row(name, value, first=false)
    result = ""
    if !value.blank?
      cl_string = ""
      cl_string = ' class="first"' if first==true
      result << "<dt#{cl_string}>#{name}:</dt>"
      result << "<dd#{cl_string}>#{value}</dd>"
    end
    result
  end

  #Render a table row iff the value is not blank
  def show_value_for_table_row(name, value, login)
    return show_value_for_table_row_with_inline_contributors(name,value,[], login)
  end

  #Render a table row with an inline list of contributors, see for example resource
  def show_value_for_table_row_with_inline_contributors(name, value, contributor_roles, login)
    result = ""
    empty = ((value.blank?) && (contributor_roles.blank?))
    logger.debug "VALUE:#{value.blank?}"
	logger.debug "ROLES: #{contributor_roles.map{|cr| cr.role_name}}"
    logger.debug "CONT:#{contributor_roles.blank?}"
    logger.debug "EMPTY:#{empty}"




    if (!empty)
      if !value.blank?
        result << '<tr><th class="informationRowHeader">'
        result << name
        result << ":</th>"
        result << '<td>'
        result << value.to_s
      end

      if !contributor_roles.blank?
        result << "<br/>" if !value.blank?
        for contributor_role in contributor_roles
          result << "&nbsp;"
          result << ContributorsHelper.get_link_depending_on_role_type(contributor_role, login)
        end
      end
      result << "</td></tr>"

    end
    result
  end



  #Show the correct icon for a sampple attachment, namely score, video or recording
  #These are shown on the public site
  def sample_icon(manifestation, sample_attachment)
    result = ""
    result = "/icons/sample-recording.gif" if manifestation.is_a_recording?
    result = "/icons/sample-score.gif" if manifestation.is_a_score?
    result = "/icons/sample-vid.gif" if sample_attachment.is_video?

    if !result.blank?
        icon_message = result.gsub('/icons/sample-', '')
        icon_message.gsub!('.gif', '')
        icon_message.gsub!('vid', 'video')
        html ='<img src="'
        html << result
        html << " \" alt = \"#{icon_message}\""
        html << "title = \"#{icon_message}\""
        html << ' >'
        result = html
    end
    result
  end


  #Show the correct icon for a sampple attachment, namely score, video or recording
  #These are shown on the public site
  def public_sample_icon(sample_attachment)
    result = ""
    sample = sample_attachment.sample
    result = "/icons/samples/audio.png" if sample_attachment.is_audio?
    result = "/icons/samples/score.png" if sample_attachment.is_document?
    result = "/icons/samples/video.png" if sample_attachment.is_video?

    if !result.blank?
        icon_message = "#{sample_attachment.media_item.content_type}"
        icon_message << "," if !icon_message.blank?
        size = sample_attachment.media_item.size
        icon_message << bytes_to_size(size) if !size.blank?
        html ='<img src="'
        html << result
        html << " \" alt = \"#{icon_message}\""
        html << "title = \"#{icon_message}\""
        html << ' >'
        result = html
    end
    result
  end

  #Return a premiere icon for world or nz, or indeed nothing if n/a
  def premiere_icon(expression)

    p_string = expression.get_premiere_as_string
    icon_file = ""
    icon_file = "world-premiere.gif" if p_string == 'World Premiere'
    icon_file = "nz-premiere.gif" if p_string == 'NZ Premiere'
    html = ""
    icon_message = "#{p_string} for #{expression.expression_title}"
    if !icon_file.blank?
        html ='<img src="/icons/'
        html << icon_file
        html << " \" alt = \"#{icon_message}\""
        html << "title = \"#{icon_message}\""
        html << ' >'
    end

    html

  end


  #Show icon for an object, along with status if appropriate
  def icons_for(object, login)
    #Go with convention
   #The main icon
    icon_image = object.class.to_s.tableize.singularize+".gif"
    html = ""

    if PrivilegesHelper.has_permission?(@login, 'CAN_VIEW_TAP')
      #Special cases
      if object.class == Manifestation
        if object.is_a_score?
            icon_image = "manifestation-score.gif"
        elsif object.is_a_recording?
          icon_image = "manifestation-cd.gif"
        else
          icon_image = nil
        end
      elsif object.class == Expression
        if object.is_performance?
          icon_image = "expression-performance.gif"
        else
          icon_image = "expression.gif"
        end

      #Roles show the contributor icon
      elsif object.class == Role
        icon_image = "contributor.gif"
      end

      #Now form the HTML for the icon
      if !icon_image.blank?
        icon_message = icon_image.gsub('.gif', '')
        html ='<img src="/icons/'
        html << icon_image
        html << " \" alt = \"#{icon_message}\""
        html << "title = \"#{icon_message}\""
        html << ' >'
      end


      status = nil

      #Special case for role / contributor
      if object.class != Role
        status = object.status if object.respond_to?("status")
      else
        status = object.contributor.send("status") unless object.contributor.blank?
      end





      if !status.blank?
        status_message = "Icon for status #{status.status_desc}"
        icon_name = status.status_desc.tableize.singularize
        html << '<img src="/icons/'
        html << icon_name
        html << ".gif"
        html << " \" alt = \"#{status_message}\""
        html << "title = \"#{status_message}\""
        html << ' >'
      end
    end

    html
  end


  def show_status_icon(status)
    html = ""
    if !status.blank?
      status_message = "Icon for status #{status.status_desc}"
      icon_name = status.status_desc.tableize.singularize
      html << '<img src="/icons/'
      html << icon_name
      html << ".gif"
      html << " \" alt = \"#{status_message}\""
      html << "title = \"#{status_message}\""
      html << ' >'
    end
    html
  end

  # helper method for sounzmedia format
  def external_formats
    external_formats = Array.new
    external_formats.push(Format.find(:first, :conditions => ["format_desc = 'external - audio'"]).format_id)
    external_formats.push(Format.find(:first, :conditions => ["format_desc = 'external - video'"]).format_id)
    return external_formats
  end

  #Link back to either music, people or event search
  def back_to_search_link(object)
    result = "<a href='/finder/shows/TAB' class='back'>Return to THING Search</a>"

    if ["Event", "Distinction", "DistinctionInstance"].include?(object.class.to_s)
      result.gsub!("TAB", "events")
      result.gsub!("THING", "Events")
    elsif ["Contributor"].include?(object.class.to_s)
      result.gsub!("TAB", "people")
      result.gsub!("THING", "People")
    elsif ["Manifestation", "Resource"].include?(object.class.to_s)
      if object.is_a_sounzmedia?
        result.gsub!("TAB", "sounzmedia")
        result.gsub!("THING", "Media")
      else
        result.gsub!("TAB", "works")
        result.gsub!("THING", "Music")
      end
    else
      result.gsub!("TAB", "works")
      result.gsub!("THING", "Music")
    end


    result
  end


  def show_edit_links_if_permission(object, privilege='CAN_EDIT_TAP')
    result = ""
    if PrivilegesHelper.has_permission?(@login, privilege)
      result = '<div class="editLinks">'
      result << render(:partial => 'shared/last_updated_by', :locals => {:object => object})


      result <<  show_tap_edit_link_for(object, privilege, text='Edit', ignore_class=true)
      result << " | "
      if object.class == Manifestation
        result << link_to('Add Recent Expressions', :action => 'add_recent_expressions', :id => object)+" | "
      elsif object.class == Event
          result << link_to('Add Sub Events', :action => 'add_recent_events', :id => object)+" | "
      end


      result <<   link_to('List', :action => 'list')
        result << "</div>"
    end


    result
  end


  def show_relationships_if_permission(object)
    result = ""
     if PrivilegesHelper.has_permission?(@login,'CAN_VIEW_TAP')
       result = render(:partial => 'shared/frbr/relationships/view', :locals => { :object => object})
      end
      result
  end


  #--- HELPER METHODS FOR DISPLAYING EDIT LINKS ----
  def show_tap_edit_link_for(object, privilege='CAN_EDIT_TAP', text="Edit", ignore_class = false)

    object_to_link_to = object
    object_to_link_to = object_to_link_to.role if object.class == Contributor
    result = ""
    if PrivilegesHelper.has_permission?(@login, privilege)
      if !ignore_class
        result = '<span class="actionButton">'
      else
        result = "<span>"
      end

      #Deal with the contributor special case
      if object.class == Role
        if !object.person.blank?
          object_id    = object.person
          object_class = "people"
        elsif !object.organisation.blank?
          object_id    = object.organisation
          object_class = "organisations"
        end
      elsif object.class == Contributor
        if !object.role.person.blank?
          object_id    = object.role.person
          object_class = "people"
        elsif !object.role.organisation.blank?
          object_id    = object.role.organisation
          object_class = "organisations"
        end
      else
        #logger.debug result
        object_id    = object
        object_class = object.class.to_s.tableize
        #logger.debug result
      end

      result = result + (link_to text, :action => 'edit', :id => object_id, :controller => object_class)

      result = result + "</span>"

    end
    result
  end





  #--------


  def observe_field_delayed(field_id, options = {})
    if options[:frequency] && options[:frequency] > 0
      build_observer('Form.Element.DelayedObserver', field_id, options)
    else
      build_observer('Form.Element.DelayedEventObserver', field_id, options)
    end
  end





  def standard_edit_cols
    return 50
  end

  def standard_edit_rows
    return 4
  end

  #Standard edit size for tiny MCE
  def standard_edit_cols_mce
    return 60
  end

  def standard_edit_rows_mce
    return 40
  end

  #- Check to see if a user is logged in -
  def is_logged_in?(sesh)
    sesh[:login] != nil
  end

  #------------------------------------------------------
  #- Return a date in day/month/year format -
  #------------------------------------------------------
  def dmy_date(date)
    result = ""
    if date != nil
      result = date.strftime("%d/%m/%y")
    end
    result
  end

  #------------------------------------------------------
  #- Return a date in day mon year hour:minute format -
  #------------------------------------------------------
  def dby_date(date)
    result = ""
    if date != nil
      result = date.strftime("%d %b %Y %H:%M")
    end
    result
  end

  #-----------------------------------
  #- Return a date in day Month year -
  #-----------------------------------
  def eBY_date(date)
    result = ""
    if date != nil
      result = date.strftime("%e %B %Y")
    end
    result
  end

  #------------------------------------------------------
  #- Return a date in day/month/year hour:minute format -
  #------------------------------------------------------
  def dmyhm_date(date)
    result = ""
    if date != nil
      result = date.strftime("%d/%m/%y %H:%M")
    else
      result = "-"
    end
    result
  end

  #------------------
  #- Restrict a string to a given number of chars
  # FIXME: finish the text on a word break
  #------------------

  def summary_of(text, max_length)
    result = text
    if text.length > max_length
      result = text[0..max_length]
      #Try not to split words
      last_space_pos = result.rindex(' ')
      result = text[0..last_space_pos-1]
      result << "..."
    end

    result = close_html_tags(result)
	#logger.debug "DEBUG: summary_of: #{result}"
	return result

  end

  #------------------
  #- Convert some wikitext into text
  #------------------

  def convert_to_html(wikitext)
    result = ''
    if !wikitext.blank?
      r = RedCloth.new wikitext
      result = r.to_html
    end
  end

  #
  # - Close not closed html tags by appending the closing tags required to the end of the string
  #
  def close_html_tags(text, basic_tags = ['a', 'i','b','u','ul','li', 'em', 'strong', 'h1', 'h2', 'h3', 'h4', 'h5', 'td', 'tr', 'table']  )
    text = strip_paragraph_formatting(text)
	basic_tags.each do |bt|
	  if text.match('<' + bt +'>') && !text.match('</' + bt +'>')
	  	text += '</' + bt +'>'
      end
    end
	return '<p>' + text + '</p>'
  end

  #
  # - Remove paragraph formatting (only initial and final tags)
  #
  def strip_paragraph_formatting(text)
      text = text.gsub(/^(<p>)/, '')
	  text = text.gsub(/(<\/p>)$/, '')
	  return text
  end

  # -------------------------------------------------------------------
  # - Strip html tags, with an optional array of tags to be preserved -
  # -------------------------------------------------------------------
  def strip_html(str, allow = ['a','img','p','br','i','b','u','ul','li'])
		str = str.strip || ''
		allow_arr = allow.join('|') << '|\/'
		str.gsub(/<(\/|\s)*[^(#{allow_arr})][^>]*>/,'')
  end


  #Convert a model to a string in the following way:
  # CommunicatiionPeople.find(49) => communication_people_49
  def generate_id(model)
    return "#{model.class.to_s.underscore}_#{model.id}"
  end


  # Convert a string of the form communication_people_49 into the corresponding model
  def convert_id_to_model(model_id_string)
    bits = model_id_string.split("_")
    gid = bits.pop
    model_name = bits.join('_').camelize
    model = model_name.constantize.find(gid.to_i)
    return model

  end

  # Provides a button that can be used to take a user to a certain place, with
  # the word "Cancel" on it.
  # FIXME: Needs the URL to be json encoded
  def cancel_to(url)
    return '<input type="button" name="cancel" value="Cancel" class="formButton" title="Return to the previous screen" onclick="window.location = \'' + url_for(url) + '\'">'
  end

  # Take user back one step in history
  #FIXME: Add pop up to say 'are you really really sure!'
  def cancel_and_go_back_button
    return '<input type="button" name="cancel" value="Cancel" title="Return to the previous screen" onclick="javascript:history.go(-1)">'
  end


  #------------------------------------------------------------
  #- Cancel and close the current window - use this in popups -
  #------------------------------------------------------------
  def cancel_and_close
    return '<input type="button" name="cancel" value="Cancel" title="Return to the previous screen" onclick="javascript:window.close()">'
  end



  def go_back_link
    return '<a href="javascript:history.go(-1)" title="Go back">Back</a>'
  end

  # creates an html button
  def create_button(name, title)
    return '<input type="button" name="' + name + '" value="' + name + '" title="' + title + '">'
  end

  # Creates a button that, when clicked, takes the user to the given URL
  def link_button(name, url, title='')
     '<button type="button" title="' + h(title) + '" onclick="window.location.href=\'' + url_for(url) + '\'">' + h(name) + '</button>'
  end

  #--------------------------------------------------------------------
  # - Using the details from session storage, render a popup callback -
  # -------------------------------------------------------------------
  def link_to_popup_callback(text, id_of_thing)
    callback_details = session[:popup_callback]
    if callback_details
      div_to_update = callback_details[:source_div_to_update]
      target_controller = callback_details[:controller_name]
      target_action = callback_details[:action_name]
      result ="<a href=\"#\" onclick=\"update_from_popup('#{div_to_update}','#{target_controller}', '#{target_action}', #{id_of_thing})\">#{text}</a>"
    else
      result = "<span class='errorMessage'>No popup callback details are available</div>'"
    end

    return result

  end

  #-----------------------------------------
  #- Render a link to close a modal dialog -
  #-----------------------------------------
  def close_modal_box_link(text)
    return '<button onclick="window.parent.hidePopWin()">'+text+'</button>'
  end



  #------------------
  #- Description for method: link_to_new
  #------------------


  def link_to_new(name, width, height, options = {}, html_options = nil, *parameters_for_method_reference)
    #POPUP
    # new_html_options = options.merge({:popup => ['sounz_popup_window', 'height=400,width=600', 'scrollbars=1']})
    #MODAL

    #  modal_class_name = 'submodal-'+width.to_s+'-'+height.to_s #The css class
    #   new_html_options = options.merge(:class => modal_class_name)
    #    link_to(name, options, new_html_options, parameters_for_method_reference)
    address = url_for(options)
    load_address = '/modal/loading/'+name
    return '<span onclick="showPopWin(\''+address+'\', '+width.to_s+', '+height.to_s+', null);">'+name+'</span>'

  end

  # --------------------------------------------------------------------------------------------
  # - Helper method taken from http://woss.name/2006/11/25/multi-select-boxes-in-your-rails-view
  # --------------------------------------------------------------------------------------------
  def collection_select_multiple(object, method,
                                 collection, value_method, text_method, number_rows,
                                 options = {}, html_options = {})
    real_method = "#{method.to_s.singularize}_ids".to_sym
    collection_select(
                      object, real_method,
                      collection, value_method, text_method,
                      options,
                      html_options.merge({
      :multiple => true,
      :size => number_rows,
      :name => "#{object}[#{real_method}][]",
    })
    )
  end

  # -----------------------------------------
  # - Return multiple select drop-down list -
  # - with the selected values highlighted  -
  # -----------------------------------------
  def select_multiple_list(object, method, collection, selected_array, size, include_blank = nil)

    # prepare select drop-down name
    name = "#{object}[#{method}][]"

    # start compiling html view of multiple select drop-down
    html = '<select id="' + method + '" multiple="multiple" name="' + name + '" size="' + size.to_s + '"><br/>'

    html += "<option value=\"\">#{include_blank}</option>" unless include_blank.nil?
    collection.each do |c|
      key   = c[0]
      value = c[1]

      # pairs with the key included into selecte array
      # get 'selected' attribute
      if !selected_array.blank? && selected_array.include?(key.to_s)
        selected = 'selected'
      else
        selected = ''
      end

      html += '<option value="' + key.to_s + '"' + selected + '>' + value + '</option><br/>'

    end

    # close select drop-down tag
    html += '</select><br/>'

    return html

  end

  # ----------------------------------------------------------------
  # - Return a string of option tags surrounded by <optgroup> tags -
  # ----------------------------------------------------------------
  def option_groups_from_collection_for_multiple_select(collection, group_method, group_label_method, option_key_method, option_value_method, selected_keys, include_blank = nil)

    collection.inject("") do |options_for_select, group|
      options_for_select = "<option value=\"\">#{include_blank}</option>\n" if options_for_select.blank? && !include_blank.nil?

      group_label_string = eval("group.#{group_label_method}")

      options_for_select += "<optgroup label=\"#{html_escape(group_label_string)}\">\n"

      container = eval("group.#{group_method}").inject([]) { |options, object| options << [ object.send(option_value_method), object.send(option_key_method) ] }

      container = container.to_a if Hash === container

      select_options = container.inject([]) do |options, element|
        if !element.is_a?(String) and element.respond_to?(:first) and element.respond_to?(:last)
          is_selected = ( (selected_keys.respond_to?(:include?) && !selected_keys.is_a?(String) ? selected_keys.include?(element.last.to_s) : element.last == selected_keys) )

          if is_selected
             options << "<option value=\"#{html_escape(element.last.to_s)}\" selected=\"selected\">#{html_escape(element.first.to_s)}</option>"
          else
             options << "<option value=\"#{html_escape(element.last.to_s)}\">#{html_escape(element.first.to_s)}</option>"
          end
        else
          is_selected = ( (selected_keys.respond_to?(:include?) && !selected_keys.is_a?(String) ? selected_keys.include?(element.to_s) : element == selected_keys) )

          options << ((is_selected) ? "<option value=\"#{html_escape(element.to_s)}\" selected=\"selected\">#{html_escape(element.to_s)}</option>" : "<option value=\"#{html_escape(element.to_s)}\">#{html_escape(element.to_s)}</option>")
        end
      end

     options_for_select += select_options.join("\n") + "\n"

     options_for_select += "</optgroup>\n"
    end
  end

  # Renders a tab link to a given controller/action/id
  def render_tab(text, name, selected_name, url)
    #<li><a href="<%=url_for(:controller => 'search', :action => 'find_contacts_menu')%>">Search</a></li>
    result = "<li"

    #Render a selected CSS class if required
    if name == selected_name
      result << ' class="current"'
    end
    result << '>'
    #This is not a selected tab so render a link
    #if name != selected_name
      result << "<a href=\"#{url_for(url)}\">#{text}</a>"
    #else
      #Tab is selected so only show text
     # result << text
    #end
    result << "</li>"
    result
  end

  #---------------------------------------------------------------
  #- Convert a hashtable value to a camelized version of the key -
  #---------------------------------------------------------------
  # DEPRECATED - (this should be in status_helper.rb)

  def  generic_status_display(hashmap, value)
    key = hashmap.invert[value]
    result = "NOT FOUND"
    if key != nil
        result = key.to_s.camelize
    end
    result
  end

  #------------------
  #- Returns the user record identified by the login_id.
  #- If no login_id is specified, then the currently logged
  #- in user is returned.
  #------------------
  def get_user(login_id=nil)
    if login_id == nil
      login_id = session[:login]
    end
    if login_id != nil
    login = Login.find(login_id)
    return login
    end
    return nil
  end

  def check_user_is_valid(login_id)

    if login_id == nil
      return false
    end

    login = Login.find(login_id)
    if login != nil
      if login.person != nil
        #get all the roles for the person
        for role in login.person.roles
          rc_list=role.get_role_contactinfos
            for rc in rc_list
              if rc.contactinfo != nil
                #we have at least one contactinfo
              return true
              end
            end
        end #for role in login.person.roles
      end #if login.person...

	  if login.organisation != nil
	  for role in login.organisation.roles
	    rc_list=role.get_role_contactinfos
		for rc in rc_list
	      if rc.contactinfo != nil
		    #we have at least one contactinfo
			return true
		  end
		end
	   end #for role in login.organisation.roles
      end

      end

    return false

    end


  # --------------------------------------------------------
  # - Convert a time in seconds to hours and minute format -
  # --------------------------------------------------------
  def convert_seconds_to_hours_and_minutes(seconds)
    result = "ERROR:Seconds was nil"

    if !seconds.blank?

      hours = seconds / 3600
      seconds_remaining = seconds - 3600*hours
      minutes = seconds_remaining/60
      seconds = seconds_remaining - 60*minutes
      if hours > 0
        result = "#{hours}.#{minutes}'"
      else
        result = "#{minutes}'"
      end

      if seconds > 0
        result = result + ' '+seconds.to_s+'\"'
      end

    end
    result
  end

  # Returns a link that can be used to link to a facet
  def link_to_facet(name, count, field_name, field_value, action_to_link_to)
    url = link_to_facet_base_url(action_to_link_to)
    url[field_name.to_sym] = field_value if field_name
    logger.debug "NAME:#{name}"
    logger.debug "COUNT:#{count}"
    logger.debug "URL:#{url}"
    if count != 0
      link_to name + ' (' + count.to_s + ')', url
    else
      h name + ' (0)'
    end
  end

  # Returns a link that can be used for a facet block title. Such links do not
  # have a count associated with them, and have some parameters removed in
  # order for the "undrilling" to work
  def link_to_facet_title(name, action_to_link_to, to_remove=[])
    url = link_to_facet_base_url(action_to_link_to)
    to_remove = [to_remove] if !to_remove.is_a?(Array)
    to_remove.each do |field|
      url[field] = nil
    end

    link_to name, url
  end

  # Returns the base URL for faceted browsing
  # GBA: added parameter @mode, to be either people, works, or events, which changes the base URL
  def link_to_facet_base_url(id)
    url = {}

    #these are common
    url[:query] = @query
    url[:id] = id

    #fields for works
    if id == 'works'
      url[:action] = 'show'
      url[:year_group] = @year_group
      url[:year_subgroup] = @year_subgroup
      url[:duration] = @duration

      #GBA: why is the zero case important - is this isntead of a blank to represent 'the whole category'
      url[:category] = @category if @category.to_i > 0
      url[:subcategory] = @subcategory if @subcategory.to_i > 0
      url[:suitable_for] = @suitable_for if @suitable_for.to_i > 0

      url[:concept_type] = @concept_type if !@concept_type.blank?

      url[:concept] = @concept_id if !@concept_id.blank?

      url[:available_as] = @available_as if !@available_as.blank?
      url[:score_type] = @score_type if !@score_type.blank?
      url[:recording_format] = @recording_format if !@recording_format.blank?
      url[:sample_type] = @sample_type if !@sample_type.blank?
	  url[:resource_type] = @resource_type if ! @resource_type.blank?

      url[:popular_category] = @popular_category if !@popular_category.blank?
      url[:popular_subcategory] = @popular_subcategory if !@popular_subcategory.blank?

      url[:available_for] = @available_for if !@available_for.blank?

	  url[:quicklink] = @search_details.quicklink

	  url[:special_subcategory] = @search_details.special_subcategory

	  url[:sort_by] = @sort_by

    #fields for the people faceting case
    elsif id=='people'
      url[:born] = @born_key if !@born_key.blank?
      url[:where] = @where if !@where.blank?
      url[:region] = @region_facet_key if !@region_facet_key.blank?
      url[:country] = @country_facet_key if !@country_facet_key.blank?
      url[:role_group] = @role_group_key if !@role_group_key.blank?
      url[:last_name] = @last_name if !@last_name.blank?
      url[:role_type] = @role_type_id if !@role_type_id.blank?
      url[:status] = @status if !@status.blank?
      url[:distinction_type] = @distinction_type_id if ! @distinction_type_id.blank?

    #deal with events
    elsif id=='events'
      url[:year_group] = @year_group if !@year_group.blank?
      url[:country] = @country_id if !@country_id.blank?
      url[:region] = @region_id if !@region_id.blank?
      url[:event_type] = @event_type_id if !@event_type_id.blank?
      url[:month] = @month if !@month.blank?
      url[:day] = @day if !@day.blank?
      url[:prev_years_group] = @previous_year_groups if !@previous_year_groups.blank?
      url[:distinction_type] = @distinction_type_id if ! @distinction_type_id.blank?
      url[:quicklink] = @search_details.quicklink unless @search_details.quicklink.blank?

    elsif id=='sounzmedia'
	  url[:year_group] = @year_group
	  url[:year_subgroup] = @year_subgroup
	  url[:duration] = @duration
	
	  url[:category] = @category if @category.to_i > 0
	  url[:subcategory] = @subcategory if @subcategory.to_i > 0
	  url[:suitable_for] = @suitable_for if @suitable_for.to_i > 0
	
	  url[:concept_type] = @concept_type if !@concept_type.blank?
	
	  url[:concept] = @concept_id if !@concept_id.blank?
	
	  url[:available_as] = @available_as if !@available_as.blank?
	  url[:score_type] = @score_type if !@score_type.blank?
	  url[:recording_format] = @recording_format if !@recording_format.blank?
	  url[:sample_type] = @sample_type if !@sample_type.blank?
	  url[:resource_type] = @resource_type if ! @resource_type.blank?
	
	  url[:popular_category] = @popular_category if !@popular_category.blank?
	  url[:popular_subcategory] = @popular_subcategory if !@popular_subcategory.blank?
	
	  url[:available_for] = @available_for if !@available_for.blank?
	
	  url[:special_subcategory] = @search_details.special_subcategory
	
	  url[:sort_by] = @sort_by
    end
    url
  end

  #--------------------------------------------------------
  #- Provide a hidden field to update the last_updated_by -
  #--------------------------------------------------------
  def last_updated_by_field(instance_object_name)
    return hidden_field(instance_object_name, "updated_by", :value => @login.login_id)
  end


  #------------------
  #- Get the key for a given value in a hash: get_key_for_value
  # FIXME: make this more efficient by caching inverted hashes?
  #------------------

  def get_key_for_value(value, hash)
    result =  hash.invert[value.strip]

    if result == nil
      result = "Value #{value} not found in #{hash}"
    else
      result = result.to_s.capitalize
    end

    result
  end


  # Convert a list of symboled keys to pretty strings
  # FIXME - cache these?
  def hash_with_capitalised_keys(hash_in)
    hash_out = {}
    for key in hash_in.keys
      hash_out[key.to_s.capitalize] = hash_in[key]
    end
    return hash_out
  end

  #Return the URL of a sample, e.g. a pdf or mp3
  def sample_url(sample_attachment)
    begin
    if sample_attachment != nil
      if sample_attachment.media_item != nil
    return sample_attachment.media_item.public_filename
  end
    end
    rescue
    logger.debug("sample attachment filename error")
    end
    #default
    return "http://sounz.org.nz/home"

  end

  def bytes_to_size(bytes)
    return (bytes/1024).to_s+"k"
  end


  #Centralise the creation of action buttons
  def action_button(html)
    result = '<span class="actionButton">'
    result << html
    result << "</span>"
    result
  end

  def pagination_link_remotes(paginator, options={}, html_options={})
    name = options[:name] || ActionView::Helpers::PaginationHelper::DEFAULT_OPTIONS[:name]
    params = (options[:params] || ActionView::Helpers::PaginationHelper::DEFAULT_OPTIONS[:params]).clone

    pagination_links_each(paginator, options) do |n|
      params[:url][name] = n
      link_to_remote(n.to_s, params, html_options)
    end
  end

  #
  # Allows you to set a page title
  #
  def title(page_title)
    content_for(:title) { ' - ' + page_title }
  end


  #Show a music player at a sensible size
  def music_player(media_item)
     player({:file => media_item.public_filename},
              {:id => "player_#{generate_id(media_item)}", :width => 320, :height => 40})
  end


  #Show a flash video at 320x240
  def flash_video_player(media_item)
    player({:file => media_item.public_filename,   :autostart => true},
              {:id => "player_#{generate_id(media_item)}", :width => 320, :height => 240})
  end

  #-------------------------------------------------------------------------------------------
  #- Return role_contactinfo for a particular role with a particular contactinfo_type if any -
  #-------------------------------------------------------------------------------------------
  def get_role_contactinfo(role_id, contactinfo_type)
    role_contactinfo = RoleContactinfo.find(:first, :conditions => ['role_id =? and LOWER(contactinfo_type) =?',
                                                                     role_id, contactinfo_type])
    return role_contactinfo
  end


  #-------------------------------------------------
  #- Select All/None links taking a div name param -
  #-------------------------------------------------
  def selectAllNone(division)
    html = "<a href=\"#\" title=\"Select All\" onclick=\"$$('#" + division + " input.check').each(function(box){box.checked=true});return false\">All </a> " +
           "| <a href=\"#\" title=\"Select None\" onclick=\"$$('#" + division + " input.check').each(function(box){box.checked=false});return false\">None</a>"
    return html
  end

def getSelected(user_id)
  selectedHash=[]
  mySearches=[]
  mySearches=SavedSearch.find(:all,:conditions => ['search_type=? AND saved_by_login_id=?',"selected_results",user_id])
  mySearch=mySearches.first()
    if mySearch != nil
      #require all the frbr objects we will be attempting to deserialise
      mySearch.search_data.scan(/!ruby\/object:(.*) \n/).uniq.each { |c| require c[0].underscore
      #Work.logger.debug("REQUIRING #{c[0].underscore}")
      }
      selectedHash=YAML.load(mySearch.search_data)
      #Work.logger.debug("IN GET_SELECTED")
      #Work.logger.debug(selectedHash.to_yaml)
    end
  #Work.logger.debug("SELECTEDHASH TYPE: #{selectedHash.class}")
  #return []
  return selectedHash
  end

  # ---------------------
  #- TinyMCE invocation -
  #----------------------
  # js open tag
  def js_open
    '<script type="text/javascript">//<![CDATA[' + "\n"
  end

  # js close tag
  def js_close
    "\n" + '//]]>' + "</script>"
  end

  def uses_tinymce
    string = <<END_OF_STRING
    tinyMCE.init({
    	mode : "textareas",
    	editor_selector : "tiny_mce",
    	theme : "advanced",
    	plugins : "inlinepopups,ts_advimage,advlink,iespell,zoom,searchreplace,fullscreen,visualchars,preview,print,table",
    	theme_advanced_buttons1 : "undo,redo,removeformat,|,bold,italic,underline,strikethrough,sub,sup,|,forecolor,backcolor,|,preview,|,fullscreen",
    	theme_advanced_buttons2 : ",outdent,indent,bullist,numlist,hr,|,link,unlink,anchor,charmap,ts_image,|,cleanup,code,|,help",
    	theme_advanced_buttons3 : "tablecontrols,|,print",
    	theme_advanced_buttons4 : "formatselect,fontselect,fontsizeselect,",
    	theme_advanced_toolbar_location : "top",
    	theme_advanced_toolbar_align : "left",
    	theme_advanced_path_location : "bottom",
    	theme_advanced_blockformats : "p,h1,h2,h3,h4,blockquote",
    	gecko_spellcheck : true,
      convert_urls : false,
      remove_script_host : false,
      remove_linebreaks : false,
      relative_urls : false,
      extended_valid_elements : "input[type|value|name|class],a[name|href|target|title|onclick],img[class|src|style|border=0|alt|title|hspace|vspace|width|height|align|onmouseover|onmouseout|name|id],hr[class|width|size|noshade],span[class|align|style],object[height|width],iframe[src|width|frameborder|height],param[name|value],embed[allowscriptaccess|height|src|type|width|height|id|allowfullscreen|flashvars|overstretch|scale|menu|play|quality|name|style],font[face|size|color],link[rel|href|type],style[type|src],script[src|type],form[action|method|id|name|class|target],div[class|id|style]",
    	theme_advanced_resizing : true,
    	theme_advanced_resize_horizontal : false
    });
END_OF_STRING

    js_open + string + js_close
  end

  # ----------------------------------------------------
  # - Return an html link to the element with id="top" -
  # ----------------------------------------------------
  def go_to_top_link
    return "<div align=\"right\"><a href=\"#top\" title=\"Go to the top of the page\">Top</a></div>"
  end

  #def strip_html_image_tags(content)
  #  logger.debug "######### content #{content}###"
  #  #content = convert_to_html(content)
  #  stripped_content = content.gsub(/(<img src=).*(\/>)\1/, " ")
  #  logger.debug "######### stripped_content #{stripped_content}###"
  #  return stripped_content
  #end

  def login_to_zencart
    user=get_user
    username=user.username
    password=user.password
     external_fetch('POST',URI.parse('http://127.0.0.1/zencart/index.php?main_page=login&action=process'),"encrypted=true&email_address=#{username}&password=#{password}")

  end

  def format_link(link)
    if !link.match(/^(http:\/\/)/)
      link = 'http://' + link
    end
    return link
  end

  # Display the summary of the content requested with the 'more >>' link
  # to the object show page
  def description_teaser(desc, object, no_of_letters=230)
  	desc_teaser = nil
	if !desc.blank?
	  desc_teaser = summary_of(desc, no_of_letters).gsub('</p>', '')
	  desc_teaser << link_to(" more &raquo;", {:controller => object.class.to_s.tableize , :action => :show, :id => object.id}, {:class => 'more'})
	  desc_teaser << '</p>'
	end
	return desc_teaser
  end

  def get_dates_between(start, finish, format="%Y%m%d")
    dates = []
    unless start.blank? && finish.blank?
      day = start
      until day > finish
        dates.push(day.strftime(format))
        day += 1.day
      end
    end
    return dates
  end
  
  # WR208084 this is an ugly bug fix to circumvent the fact that the current
  # implementation is returning truncated resource names available_as_top_level_facet_for_solr_t.
  def readable_facet_name_camelized(name)
      name_camelized = ''
      case name
        when "score"
            name_camelized = "Scores"
        when "record"
            name_camelized = "Recordings"
        when "sampl"
            name_camelized = "Samples"
        when "resourc"
            name_camelized = "Resources"
        else
            name_camelized = name.camelize
        end
      return name_camelized
  end

  private
  #This is used to add an extra CSS class for the main content, in order to space out the history widget from
  #the main content in the scenario where we are lacking tabs
  def is_tabless?(controller_name)
    result = false
    #Blank is a check for the login pages
    logger.debug "CHECKING FOR #{controller_name} for UNTABBED"
    if controller_name.blank?
      result = true
    elsif  UNTABBED_CONTROLLERS.include?(controller_name)
      result = true
    end

    result

  end

  

end
