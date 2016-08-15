#!/usr/bin/env ../sounz/script/runner

=begin
CAN_VIEW_PUBLIC
CAN_VIEW_PRIVATE
CAN_EDIT
CAN_ADV_SEARCH
CAN_SAVE_SEARCH
CAN_ACCESS_CRM
IS_AUTHENTICATED
CAN_ACCESS_LIBRARY
CAN_EDIT_CONTENT

Pending
Approved
Published
Withdrawn
Masked
=end
def add_restriction(controller, action, privilege_sym, http_verb, status_sym='')
  privilege = Privilege.find(:first, :conditions => ["privilege_name = ?",privilege_sym.to_s.upcase])
  status = Status.find(:first, :conditions => ["status_desc = ?",status_sym.to_s.camelize])
  
  #It was deemed preferable to use text instead of a wildcard char in case of parsing problems
  action = "ALL" if action == '*'
   
  if status.blank?
  puts "-- Restriction for /#{controller}/#{action}, for a privilege #{privilege.privilege_name}"
  puts "insert into controller_restrictions(controller_name, controller_action, http_verb, privilege_id) values"
  else
  puts "-- Restriction for /#{controller}/#{action}, for a status of #{status.status_desc} and privilege #{privilege.privilege_name}"
  puts "insert into controller_restrictions(controller_name, controller_action, http_verb, status_id, privilege_id) values"
  end
  puts "('#{controller}', '#{action}', '#{http_verb.to_s.downcase}',"
  puts "(select status_id from publishing_statuses where status_desc = '#{status.status_desc}')," unless status.blank?
  puts "		(select privilege_id from privileges where privilege_name = '#{privilege.privilege_name}')"
  puts ");\n\n"

end

puts "begin;"
  
#Delete the pervious ones
puts "-- Delete the existing permissions and regenerate"
puts "delete from controller_restrictions;\n\n"
#basic FRBR objects
add_restriction("contributors", "show_appropriate_for_role", :can_view_public, :get, :published)

# cm_content
add_restriction("cm_contents", "show_by_name", :can_view_public, :get, :published)
add_restriction("cm_contents", "show",         :can_view_public, :get, :published)

add_restriction("cm_contents", "ALL", :can_edit_content, :get,  :published)
add_restriction("cm_contents", "ALL", :can_edit_content, :post, :published)
add_restriction("cm_contents", "ALL", :can_edit_content, :get,  :pending)
add_restriction("cm_contents", "ALL", :can_edit_content, :post, :pending)

#Flash videos
add_restriction("media_items", "show_flash_music", :can_view_public, :get, :published)
add_restriction("media_items", "show_flash_video", :can_view_public, :get, :published)
add_restriction("media_items", "show_flash_music_for_sample", :can_view_public, :get, :published)
add_restriction("media_items", "show_flash_video_for_sample", :can_view_public, :get, :published)

# ERP
# cart
# FIXME at the moment there is no restriction for manipulations to items based on their status
add_restriction("cart", "show_cart_contents",  :is_authenticated,  :get,  :published)
add_restriction("cart", "show_cart_contents",  :is_authenticated,  :get,  :pending)
add_restriction("cart", "show_cart_contents",  :is_authenticated,  :get,  :withdrawn)
add_restriction("cart", "show_cart_contents",  :is_authenticated,  :get,  :masked)
add_restriction("cart", "show_cart_contents",  :is_authenticated,  :get,  :approved)
add_restriction("cart", "add_product_to_cart", :is_authenticated,  :get,  :published)
add_restriction("cart", "add_product_to_cart", :is_authenticated,  :get,  :pending)
add_restriction("cart", "add_product_to_cart", :is_authenticated,  :get,  :masked)
add_restriction("cart", "add_product_to_cart", :is_authenticated,  :get,  :withdrawn)
add_restriction("cart", "add_product_to_cart", :is_authenticated,  :get,  :approved)
add_restriction("cart", "add_product_to_cart", :is_authenticated,  :post,  :published)
add_restriction("cart", "add_product_to_cart", :is_authenticated,  :post,  :pending)
add_restriction("cart", "add_product_to_cart", :is_authenticated,  :post,  :masked)
add_restriction("cart", "add_product_to_cart", :is_authenticated,  :post,  :withdrawn)
add_restriction("cart", "add_product_to_cart", :is_authenticated,  :post,  :approved)
add_restriction("cart", "add_product_to_cart", :can_view_public,  :post )
add_restriction("cart", "show_memberships",    :is_authenticated,  :get)
add_restriction("cart", "show_donations",      :is_authenticated,  :get)
add_restriction("cart", "memberships_page",    :can_view_public,  :get)
add_restriction("cart", "hire_product",        :is_authenticated,  :get)
add_restriction("cart", "hire_product",        :is_authenticated,  :post)
add_restriction("cart", "memberships_page",    :can_view_public,  :get)
add_restriction("cart", "reserve_product",     :is_authenticated,  :get)
add_restriction("cart", "reserve_product",     :is_authenticated,  :post)


add_restriction("cart", "show_orders",         :can_edit_sales_history,  :get)
add_restriction("cart", "show_orders",         :can_edit_sales_history,  :post)
add_restriction("cart", "update_status",       :can_edit_sales_history,  :get)
add_restriction("cart", "update_status",       :can_edit_sales_history,  :post)

# borrowed_items
add_restriction("borrowed_items", "ALL", :can_edit_borrowed_item, :get)
add_restriction("borrowed_items", "ALL", :can_edit_borrowed_item, :post)

#Search resets
add_restriction("finder", "reset_event_search", :can_view_public, :get, :published)
add_restriction("finder", "reset_people_search", :can_view_public, :get, :published)
add_restriction("finder", "reset_work_search", :can_view_public, :get, :published)

#Related concepts
add_restriction("concepts", "related", :can_view_public, :get, :published)


#Finder
add_restriction("finder", "show", :can_view_public, :get, :published)
add_restriction("finder", "shows", :can_view_public, :get, :published)
add_restriction("finder", "toggle_facet_block", :can_view_public, :get, :published)
add_restriction("finder", "show", :can_view_public, :post, :published)
add_restriction("finder", "shows", :can_view_public, :post, :published)
add_restriction("finder", "toggle_facet_block", :can_view_public, :post, :published)

add_restriction("finder", "addToSelectedSession",      :can_view_public, :post, :published)
add_restriction("finder", "addToSelectedSession",      :can_view_public, :get,  :published)
add_restriction("finder", "removeFromSelectedSession", :can_view_public, :post, :published)
add_restriction("finder", "removeFromSelectedSession", :can_view_public, :get,  :published)
add_restriction("finder", "clearSelectedSession",      :can_view_public, :post, :published)
add_restriction("finder", "clearSelectedSession",      :can_view_public, :get,  :published)

add_restriction("finder", "addToSelected",             :can_save_search, :post, :published)
add_restriction("finder", "addToSelected",             :can_save_search, :get,  :published)
add_restriction("finder", "removeFromSelected",        :can_save_search, :post, :published)
add_restriction("finder", "removeFromSelected",        :can_save_search, :get,  :published)
add_restriction("finder", "clearSelected",             :can_save_search, :post, :published)
add_restriction("finder", "clearSelected",             :can_save_search, :get,  :published)

#home page
add_restriction("home", "index",                   :can_view_public,  :get)
add_restriction("home", "email_updates_requested", :can_view_public,  :get)
add_restriction("home", "email_updates_requested", :can_view_public,  :post)

#Auth page
add_restriction("authentication", "unauthorised", :can_view_public, :get)

#FRBR editors can see all the contributor images


#Allow public users to sign up
add_restriction("people", "new_web_user", :can_view_public, :get)
add_restriction("people", "create_web_user", :can_view_public, :post)
add_restriction("people", "login_from_checkout", :can_view_public, :get)
add_restriction("contactinfos", "countryChosen", :can_view_public, :get)
add_restriction("contactinfos", "countryChosen", :can_view_public, :post)

# news_articles for public
add_restriction("news_articles", "index",        :can_view_public, :get,  :published)
add_restriction("news_articles", "index",        :can_view_public, :post, :published)
add_restriction("news_articles", "list",         :can_view_public, :get,  :published)
add_restriction("news_articles", "show",         :can_view_public, :get,  :published)
add_restriction("news_articles", "search_news",  :can_view_public, :get,  :published)
add_restriction("news_articles", "search_news",  :can_view_public, :post, :published)

add_restriction("news_articles", "ALL", :can_edit_content, :get,  :published)
add_restriction("news_articles", "ALL", :can_edit_content, :post, :published)
add_restriction("news_articles", "ALL", :can_edit_content, :get,  :pending)
add_restriction("news_articles", "ALL", :can_edit_content, :post, :pending)

# allow to public to download media items in pdf formats
add_restriction("media_items", "download", :can_view_public, :get)

# advanced music search (sonline music) is available to public
add_restriction("advanced_finder", "sonline_music",           :can_view_public, :get)
add_restriction("advanced_finder", "search_works_resources",  :can_view_public, :get)
add_restriction("advanced_finder", "sonline_music",           :can_view_public, :post)
add_restriction("advanced_finder", "search_works_resources",  :can_view_public, :post)
add_restriction("advanced_finder", "work_subcategories",      :can_view_public, :get)
add_restriction("advanced_finder", "work_subcategories",      :can_view_public, :post)
add_restriction("advanced_finder", "concept_main_categories", :can_view_public, :get)
add_restriction("advanced_finder", "concept_main_categories", :can_view_public, :post)
add_restriction("advanced_finder", "reset_sonline_music",     :can_view_public, :get)
add_restriction("advanced_finder", "reset_sonline_music",     :can_view_public, :post)

add_restriction("advanced_finder", "work",              :can_view_tap, :get)
add_restriction("advanced_finder", "work",              :can_view_tap, :post)
add_restriction("advanced_finder", "search_works",      :can_view_tap, :get)
add_restriction("advanced_finder", "search_works",      :can_view_tap, :post)
add_restriction("advanced_finder", "reset_work",        :can_view_tap, :get)
add_restriction("advanced_finder", "reset_work",        :can_view_tap, :post)
add_restriction("advanced_finder", "findSubcategories", :can_view_tap, :get)
add_restriction("advanced_finder", "findSubcategories", :can_view_tap, :post)

add_restriction("advanced_finder", "event",          :can_view_tap, :get)
add_restriction("advanced_finder", "event",          :can_view_tap, :post)
add_restriction("advanced_finder", "search_events",  :can_view_tap, :get)
add_restriction("advanced_finder", "search_events",  :can_view_tap, :post)
add_restriction("advanced_finder", "reset_event",    :can_view_tap, :get)
add_restriction("advanced_finder", "reset_event",    :can_view_tap, :post)

add_restriction("advanced_finder", "contributor",          :can_view_tap, :get)
add_restriction("advanced_finder", "contributor",          :can_view_tap, :post)
add_restriction("advanced_finder", "search_contributors",  :can_view_tap, :get)
add_restriction("advanced_finder", "search_contributors",  :can_view_tap, :post)
add_restriction("advanced_finder", "reset_contributors",   :can_view_tap, :get)
add_restriction("advanced_finder", "reset_contributors",   :can_view_tap, :post)

add_restriction("advanced_finder", "manifestation_resource",          :can_view_tap, :get)
add_restriction("advanced_finder", "manifestation_resource",          :can_view_tap, :post)
add_restriction("advanced_finder", "search_manifestations_resources", :can_view_tap, :get)
add_restriction("advanced_finder", "search_manifestations_resources", :can_view_tap, :post)
add_restriction("advanced_finder", "reset_manifestation_resource",    :can_view_tap, :get)
add_restriction("advanced_finder", "reset_manifestation_resource",    :can_view_tap, :post)
add_restriction("advanced_finder", "type_formats",                    :can_view_tap, :get)
add_restriction("advanced_finder", "type_formats",                    :can_view_tap, :post)

add_restriction("advanced_finder", "expression",          :can_view_tap, :get)
add_restriction("advanced_finder", "expression",          :can_view_tap, :post)
add_restriction("advanced_finder", "search_expressions",  :can_view_tap, :get)
add_restriction("advanced_finder", "search_expressions",  :can_view_tap, :post)
add_restriction("advanced_finder", "reset_expressions",   :can_view_tap, :get)
add_restriction("advanced_finder", "reset_expressions",   :can_view_tap, :post)

# superworks
add_restriction("superworks", "ALL", :can_edit_tap, :get, :published)
add_restriction("superworks", "ALL", :can_edit_tap, :post, :published)
add_restriction("superworks", "ALL", :can_edit_tap, :get, :pending)
add_restriction("superworks", "ALL", :can_edit_tap, :post, :pending)
add_restriction("superworks", "ALL", :can_edit_tap, :get, :approved)
add_restriction("superworks", "ALL", :can_edit_tap, :post, :approved)
add_restriction("superworks", "ALL", :can_edit_tap, :get, :masked)
add_restriction("superworks", "ALL", :can_edit_tap, :post, :masked)
add_restriction("superworks", "ALL", :can_edit_tap, :get, :withdrawn)
add_restriction("superworks", "ALL", :can_edit_tap, :post, :withdrawn)

add_restriction("superworks", "ALL", :can_publish_tap, :get, :published)
add_restriction("superworks", "ALL", :can_publish_tap, :post, :published)
add_restriction("superworks", "ALL", :can_publish_tap, :get, :pending)
add_restriction("superworks", "ALL", :can_publish_tap, :post, :pending)
add_restriction("superworks", "ALL", :can_publish_tap, :get, :approved)
add_restriction("superworks", "ALL", :can_publish_tap, :post, :approved)
add_restriction("superworks", "ALL", :can_publish_tap, :get, :masked)
add_restriction("superworks", "ALL", :can_publish_tap, :post, :masked)
add_restriction("superworks", "ALL", :can_publish_tap, :get, :withdrawn)
add_restriction("superworks", "ALL", :can_publish_tap, :post, :withdrawn)

add_restriction("superworks", "show", :can_view_tap, :get, :published)
add_restriction("superworks", "show", :can_view_tap, :get, :pending)
add_restriction("superworks", "show", :can_view_tap, :get, :approved)
add_restriction("superworks", "show", :can_view_tap, :get, :masked)
add_restriction("superworks", "show", :can_view_tap, :get, :withdrawn)

add_restriction("superworks", "list", :can_view_tap, :get, :published)
add_restriction("superworks", "list", :can_view_tap, :get, :pending)
add_restriction("superworks", "list", :can_view_tap, :get, :approved)
add_restriction("superworks", "list", :can_view_tap, :get, :masked)
add_restriction("superworks", "list", :can_view_tap, :get, :withdrawn)

add_restriction("superworks", "show", :can_view_public, :get, :published)

# works
add_restriction("works", "ALL", :can_edit_tap, :get, :published)
add_restriction("works", "ALL", :can_edit_tap, :post, :published)
add_restriction("works", "ALL", :can_edit_tap, :get, :pending)
add_restriction("works", "ALL", :can_edit_tap, :post, :pending)
add_restriction("works", "ALL", :can_edit_tap, :get, :approved)
add_restriction("works", "ALL", :can_edit_tap, :post, :approved)
add_restriction("works", "ALL", :can_edit_tap, :get, :masked)
add_restriction("works", "ALL", :can_edit_tap, :post, :masked)
add_restriction("works", "ALL", :can_edit_tap, :get, :withdrawn)
add_restriction("works", "ALL", :can_edit_tap, :post, :withdrawn)

add_restriction("works", "ALL", :can_publish_tap, :get, :published)
add_restriction("works", "ALL", :can_publish_tap, :post, :published)
add_restriction("works", "ALL", :can_publish_tap, :get, :pending)
add_restriction("works", "ALL", :can_publish_tap, :post, :pending)
add_restriction("works", "ALL", :can_publish_tap, :get, :approved)
add_restriction("works", "ALL", :can_publish_tap, :post, :approved)
add_restriction("works", "ALL", :can_publish_tap, :get, :masked)
add_restriction("works", "ALL", :can_publish_tap, :post, :masked)
add_restriction("works", "ALL", :can_publish_tap, :get, :withdrawn)
add_restriction("works", "ALL", :can_publish_tap, :post, :withdrawn)

add_restriction("works", "show", :can_view_tap, :get, :published)
add_restriction("works", "show", :can_view_tap, :get, :pending)
add_restriction("works", "show", :can_view_tap, :get, :approved)
add_restriction("works", "show", :can_view_tap, :get, :masked)
add_restriction("works", "show", :can_view_tap, :get, :withdrawn)

add_restriction("works", "list", :can_view_tap, :get, :published)
add_restriction("works", "list", :can_view_tap, :get, :pending)
add_restriction("works", "list", :can_view_tap, :get, :approved)
add_restriction("works", "list", :can_view_tap, :get, :masked)
add_restriction("works", "list", :can_view_tap, :get, :withdrawn)

add_restriction("works", "availability", :can_view_tap, :get, :published)
add_restriction("works", "availability", :can_view_tap, :get, :pending)
add_restriction("works", "availability", :can_view_tap, :get, :approved)
add_restriction("works", "availability", :can_view_tap, :get, :masked)
add_restriction("works", "availability", :can_view_tap, :get, :withdrawn)

add_restriction("works", "related", :can_view_tap, :get, :published)
add_restriction("works", "related", :can_view_tap, :get, :pending)
add_restriction("works", "related", :can_view_tap, :get, :approved)
add_restriction("works", "related", :can_view_tap, :get, :masked)
add_restriction("works", "related", :can_view_tap, :get, :withdrawn)

add_restriction("works", "show",         :can_view_public, :get, :published)
add_restriction("works", "availability", :can_view_public, :get, :published)
add_restriction("works", "related",      :can_view_public, :get, :published)

# expressions
add_restriction("expressions", "ALL", :can_edit_tap, :get, :published)
add_restriction("expressions", "ALL", :can_edit_tap, :post, :published)
add_restriction("expressions", "ALL", :can_edit_tap, :get, :pending)
add_restriction("expressions", "ALL", :can_edit_tap, :post, :pending)
add_restriction("expressions", "ALL", :can_edit_tap, :get, :approved)
add_restriction("expressions", "ALL", :can_edit_tap, :post, :approved)
add_restriction("expressions", "ALL", :can_edit_tap, :get, :masked)
add_restriction("expressions", "ALL", :can_edit_tap, :post, :masked)
add_restriction("expressions", "ALL", :can_edit_tap, :get, :withdrawn)
add_restriction("expressions", "ALL", :can_edit_tap, :post, :withdrawn)

add_restriction("expressions", "ALL", :can_publish_tap, :get, :published)
add_restriction("expressions", "ALL", :can_publish_tap, :post, :published)
add_restriction("expressions", "ALL", :can_publish_tap, :get, :pending)
add_restriction("expressions", "ALL", :can_publish_tap, :post, :pending)
add_restriction("expressions", "ALL", :can_publish_tap, :get, :approved)
add_restriction("expressions", "ALL", :can_publish_tap, :post, :approved)
add_restriction("expressions", "ALL", :can_publish_tap, :get, :masked)
add_restriction("expressions", "ALL", :can_publish_tap, :post, :masked)
add_restriction("expressions", "ALL", :can_publish_tap, :get, :withdrawn)
add_restriction("expressions", "ALL", :can_publish_tap, :post, :withdrawn)

add_restriction("expressions", "show", :can_view_tap, :get, :published)
add_restriction("expressions", "show", :can_view_tap, :get, :pending)
add_restriction("expressions", "show", :can_view_tap, :get, :approved)
add_restriction("expressions", "show", :can_view_tap, :get, :masked)
add_restriction("expressions", "show", :can_view_tap, :get, :withdrawn)

add_restriction("expressions", "list", :can_view_tap, :get, :published)
add_restriction("expressions", "list", :can_view_tap, :get, :pending)
add_restriction("expressions", "list", :can_view_tap, :get, :approved)
add_restriction("expressions", "list", :can_view_tap, :get, :masked)
add_restriction("expressions", "list", :can_view_tap, :get, :withdrawn)

add_restriction("expressions", "show", :can_view_public, :get, :published)

# manifestations
add_restriction("manifestations", "ALL", :can_edit_tap, :get, :published)
add_restriction("manifestations", "ALL", :can_edit_tap, :post, :published)
add_restriction("manifestations", "ALL", :can_edit_tap, :get, :pending)
add_restriction("manifestations", "ALL", :can_edit_tap, :post, :pending)
add_restriction("manifestations", "ALL", :can_edit_tap, :get, :approved)
add_restriction("manifestations", "ALL", :can_edit_tap, :post, :approved)
add_restriction("manifestations", "ALL", :can_edit_tap, :get, :masked)
add_restriction("manifestations", "ALL", :can_edit_tap, :post, :masked)
add_restriction("manifestations", "ALL", :can_edit_tap, :get, :withdrawn)
add_restriction("manifestations", "ALL", :can_edit_tap, :post, :withdrawn)

add_restriction("manifestations", "ALL", :can_publish_tap, :get, :published)
add_restriction("manifestations", "ALL", :can_publish_tap, :post, :published)
add_restriction("manifestations", "ALL", :can_publish_tap, :get, :pending)
add_restriction("manifestations", "ALL", :can_publish_tap, :post, :pending)
add_restriction("manifestations", "ALL", :can_publish_tap, :get, :approved)
add_restriction("manifestations", "ALL", :can_publish_tap, :post, :approved)
add_restriction("manifestations", "ALL", :can_publish_tap, :get, :masked)
add_restriction("manifestations", "ALL", :can_publish_tap, :post, :masked)
add_restriction("manifestations", "ALL", :can_publish_tap, :get, :withdrawn)
add_restriction("manifestations", "ALL", :can_publish_tap, :post, :withdrawn)

add_restriction("manifestations", "show", :can_view_tap, :get, :published)
add_restriction("manifestations", "show", :can_view_tap, :get, :pending)
add_restriction("manifestations", "show", :can_view_tap, :get, :approved)
add_restriction("manifestations", "show", :can_view_tap, :get, :masked)
add_restriction("manifestations", "show", :can_view_tap, :get, :withdrawn)

add_restriction("manifestations", "list", :can_view_tap, :get, :published)
add_restriction("manifestations", "list", :can_view_tap, :get, :pending)
add_restriction("manifestations", "list", :can_view_tap, :get, :approved)
add_restriction("manifestations", "list", :can_view_tap, :get, :masked)
add_restriction("manifestations", "list", :can_view_tap, :get, :withdrawn)

add_restriction("manifestations", "related", :can_view_tap, :get, :published)
add_restriction("manifestations", "related", :can_view_tap, :get, :pending)
add_restriction("manifestations", "related", :can_view_tap, :get, :approved)
add_restriction("manifestations", "related", :can_view_tap, :get, :masked)
add_restriction("manifestations", "related", :can_view_tap, :get, :withdrawn)

add_restriction("manifestations", "show",    :can_view_public, :get, :published)
add_restriction("manifestations", "related", :can_view_public, :get, :published)

# resources
add_restriction("resources", "ALL", :can_edit_tap, :get, :published)
add_restriction("resources", "ALL", :can_edit_tap, :post, :published)
add_restriction("resources", "ALL", :can_edit_tap, :get, :pending)
add_restriction("resources", "ALL", :can_edit_tap, :post, :pending)
add_restriction("resources", "ALL", :can_edit_tap, :get, :approved)
add_restriction("resources", "ALL", :can_edit_tap, :post, :approved)
add_restriction("resources", "ALL", :can_edit_tap, :get, :masked)
add_restriction("resources", "ALL", :can_edit_tap, :post, :masked)
add_restriction("resources", "ALL", :can_edit_tap, :get, :withdrawn)
add_restriction("resources", "ALL", :can_edit_tap, :post, :withdrawn)

add_restriction("resources", "ALL", :can_publish_tap, :get, :published)
add_restriction("resources", "ALL", :can_publish_tap, :post, :published)
add_restriction("resources", "ALL", :can_publish_tap, :get, :pending)
add_restriction("resources", "ALL", :can_publish_tap, :post, :pending)
add_restriction("resources", "ALL", :can_publish_tap, :get, :approved)
add_restriction("resources", "ALL", :can_publish_tap, :post, :approved)
add_restriction("resources", "ALL", :can_publish_tap, :get, :masked)
add_restriction("resources", "ALL", :can_publish_tap, :post, :masked)
add_restriction("resources", "ALL", :can_publish_tap, :get, :withdrawn)
add_restriction("resources", "ALL", :can_publish_tap, :post, :withdrawn)

add_restriction("resources", "show", :can_view_tap, :get, :published)
add_restriction("resources", "show", :can_view_tap, :get, :pending)
add_restriction("resources", "show", :can_view_tap, :get, :approved)
add_restriction("resources", "show", :can_view_tap, :get, :masked)
add_restriction("resources", "show", :can_view_tap, :get, :withdrawn)

add_restriction("resources", "list", :can_view_tap, :get, :published)
add_restriction("resources", "list", :can_view_tap, :get, :pending)
add_restriction("resources", "list", :can_view_tap, :get, :approved)
add_restriction("resources", "list", :can_view_tap, :get, :masked)
add_restriction("resources", "list", :can_view_tap, :get, :withdrawn)

add_restriction("resources", "related", :can_view_tap, :get, :published)
add_restriction("resources", "related", :can_view_tap, :get, :pending)
add_restriction("resources", "related", :can_view_tap, :get, :approved)
add_restriction("resources", "related", :can_view_tap, :get, :masked)
add_restriction("resources", "related", :can_view_tap, :get, :withdrawn)

add_restriction("resources", "show", :can_view_public, :get, :published)
add_restriction("resources", "related", :can_view_public, :get, :published)

# distinctions
add_restriction("distinctions", "ALL", :can_edit_distinction, :get, :published)
add_restriction("distinctions", "ALL", :can_edit_distinction, :post, :published)
add_restriction("distinctions", "ALL", :can_edit_distinction, :get, :pending)
add_restriction("distinctions", "ALL", :can_edit_distinction, :post, :pending)
add_restriction("distinctions", "ALL", :can_edit_distinction, :get, :approved)
add_restriction("distinctions", "ALL", :can_edit_distinction, :post, :approved)
add_restriction("distinctions", "ALL", :can_edit_distinction, :get, :masked)
add_restriction("distinctions", "ALL", :can_edit_distinction, :post, :masked)
add_restriction("distinctions", "ALL", :can_edit_distinction, :get, :withdrawn)
add_restriction("distinctions", "ALL", :can_edit_distinction, :post, :withdrawn)

add_restriction("distinctions", "ALL", :can_publish_distinction, :get, :published)
add_restriction("distinctions", "ALL", :can_publish_distinction, :post, :published)
add_restriction("distinctions", "ALL", :can_publish_distinction, :get, :pending)
add_restriction("distinctions", "ALL", :can_publish_distinction, :post, :pending)
add_restriction("distinctions", "ALL", :can_publish_distinction, :get, :approved)
add_restriction("distinctions", "ALL", :can_publish_distinction, :post, :approved)
add_restriction("distinctions", "ALL", :can_publish_distinction, :get, :masked)
add_restriction("distinctions", "ALL", :can_publish_distinction, :post, :masked)
add_restriction("distinctions", "ALL", :can_publish_distinction, :get, :withdrawn)
add_restriction("distinctions", "ALL", :can_publish_distinction, :post, :withdrawn)

add_restriction("distinctions", "show",    :can_view_public, :get, :published)
add_restriction("distinctions", "related", :can_view_public, :get, :published)

# distinction_instances
add_restriction("distinction_instances", "ALL", :can_edit_tap, :get, :published)
add_restriction("distinction_instances", "ALL", :can_edit_tap, :post, :published)
add_restriction("distinction_instances", "ALL", :can_edit_tap, :get, :pending)
add_restriction("distinction_instances", "ALL", :can_edit_tap, :post, :pending)
add_restriction("distinction_instances", "ALL", :can_edit_tap, :get, :approved)
add_restriction("distinction_instances", "ALL", :can_edit_tap, :post, :approved)
add_restriction("distinction_instances", "ALL", :can_edit_tap, :get, :masked)
add_restriction("distinction_instances", "ALL", :can_edit_tap, :post, :masked)
add_restriction("distinction_instances", "ALL", :can_edit_tap, :get, :withdrawn)
add_restriction("distinction_instances", "ALL", :can_edit_tap, :post, :withdrawn)

add_restriction("distinction_instances", "ALL", :can_publish_tap, :get, :published)
add_restriction("distinction_instances", "ALL", :can_publish_tap, :post, :published)
add_restriction("distinction_instances", "ALL", :can_publish_tap, :get, :pending)
add_restriction("distinction_instances", "ALL", :can_publish_tap, :post, :pending)
add_restriction("distinction_instances", "ALL", :can_publish_tap, :get, :approved)
add_restriction("distinction_instances", "ALL", :can_publish_tap, :post, :approved)
add_restriction("distinction_instances", "ALL", :can_publish_tap, :get, :masked)
add_restriction("distinction_instances", "ALL", :can_publish_tap, :post, :masked)
add_restriction("distinction_instances", "ALL", :can_publish_tap, :get, :withdrawn)
add_restriction("distinction_instances", "ALL", :can_publish_tap, :post, :withdrawn)

add_restriction("distinction_instances", "show", :can_view_tap, :get, :published)
add_restriction("distinction_instances", "show", :can_view_tap, :get, :pending)
add_restriction("distinction_instances", "show", :can_view_tap, :get, :approved)
add_restriction("distinction_instances", "show", :can_view_tap, :get, :masked)
add_restriction("distinction_instances", "show", :can_view_tap, :get, :withdrawn)

add_restriction("distinction_instances", "search", :can_view_tap, :get, :published)
add_restriction("distinction_instances", "search", :can_view_tap, :get, :pending)
add_restriction("distinction_instances", "search", :can_view_tap, :get, :approved)
add_restriction("distinction_instances", "search", :can_view_tap, :get, :masked)
add_restriction("distinction_instances", "search", :can_view_tap, :get, :withdrawn)

add_restriction("distinction_instances", "find", :can_view_tap, :get, :published)
add_restriction("distinction_instances", "find", :can_view_tap, :get, :pending)
add_restriction("distinction_instances", "find", :can_view_tap, :get, :approved)
add_restriction("distinction_instances", "find", :can_view_tap, :get, :masked)
add_restriction("distinction_instances", "find", :can_view_tap, :get, :withdrawn)

add_restriction("distinction_instances", "list", :can_view_tap, :get, :published)
add_restriction("distinction_instances", "list", :can_view_tap, :get, :pending)
add_restriction("distinction_instances", "list", :can_view_tap, :get, :approved)
add_restriction("distinction_instances", "list", :can_view_tap, :get, :masked)
add_restriction("distinction_instances", "list", :can_view_tap, :get, :withdrawn)

add_restriction("distinction_instances", "related", :can_view_tap, :get, :published)
add_restriction("distinction_instances", "related", :can_view_tap, :get, :pending)
add_restriction("distinction_instances", "related", :can_view_tap, :get, :approved)
add_restriction("distinction_instances", "related", :can_view_tap, :get, :masked)
add_restriction("distinction_instances", "related", :can_view_tap, :get, :withdrawn)

add_restriction("distinction_instances", "show", :can_view_public, :get, :published)
add_restriction("distinction_instances", "related", :can_view_public, :get, :published)

# concepts
add_restriction("concepts", "ALL", :can_edit_tap, :get, :published)
add_restriction("concepts", "ALL", :can_edit_tap, :post, :published)
add_restriction("concepts", "ALL", :can_edit_tap, :get, :pending)
add_restriction("concepts", "ALL", :can_edit_tap, :post, :pending)
add_restriction("concepts", "ALL", :can_edit_tap, :get, :approved)
add_restriction("concepts", "ALL", :can_edit_tap, :post, :approved)
add_restriction("concepts", "ALL", :can_edit_tap, :get, :masked)
add_restriction("concepts", "ALL", :can_edit_tap, :post, :masked)
add_restriction("concepts", "ALL", :can_edit_tap, :get, :withdrawn)
add_restriction("concepts", "ALL", :can_edit_tap, :post, :withdrawn)

add_restriction("concepts", "ALL", :can_publish_tap, :get, :published)
add_restriction("concepts", "ALL", :can_publish_tap, :post, :published)
add_restriction("concepts", "ALL", :can_publish_tap, :get, :pending)
add_restriction("concepts", "ALL", :can_publish_tap, :post, :pending)
add_restriction("concepts", "ALL", :can_publish_tap, :get, :approved)
add_restriction("concepts", "ALL", :can_publish_tap, :post, :approved)
add_restriction("concepts", "ALL", :can_publish_tap, :get, :masked)
add_restriction("concepts", "ALL", :can_publish_tap, :post, :masked)
add_restriction("concepts", "ALL", :can_publish_tap, :get, :withdrawn)
add_restriction("concepts", "ALL", :can_publish_tap, :post, :withdrawn)

add_restriction("concepts", "show", :can_view_tap, :get, :published)
add_restriction("concepts", "show", :can_view_tap, :get, :pending)
add_restriction("concepts", "show", :can_view_tap, :get, :approved)
add_restriction("concepts", "show", :can_view_tap, :get, :masked)
add_restriction("concepts", "show", :can_view_tap, :get, :withdrawn)

add_restriction("concepts", "list", :can_view_tap, :get, :published)
add_restriction("concepts", "list", :can_view_tap, :get, :pending)
add_restriction("concepts", "list", :can_view_tap, :get, :approved)
add_restriction("concepts", "list", :can_view_tap, :get, :masked)
add_restriction("concepts", "list", :can_view_tap, :get, :withdrawn)

add_restriction("concepts", "related", :can_view_tap, :get, :published)
add_restriction("concepts", "related", :can_view_tap, :get, :pending)
add_restriction("concepts", "related", :can_view_tap, :get, :approved)
add_restriction("concepts", "related", :can_view_tap, :get, :masked)
add_restriction("concepts", "related", :can_view_tap, :get, :withdrawn)

add_restriction("concepts", "show", :can_view_public, :get, :published)
add_restriction("concepts", "related", :can_view_public, :get, :published)

# events
add_restriction("events", "ALL", :can_edit_event, :get, :published)
add_restriction("events", "ALL", :can_edit_event, :post, :published)
add_restriction("events", "ALL", :can_edit_event, :get, :pending)
add_restriction("events", "ALL", :can_edit_event, :post, :pending)
add_restriction("events", "ALL", :can_edit_event, :get, :approved)
add_restriction("events", "ALL", :can_edit_event, :post, :approved)
add_restriction("events", "ALL", :can_edit_event, :get, :masked)
add_restriction("events", "ALL", :can_edit_event, :post, :masked)
add_restriction("events", "ALL", :can_edit_event, :get, :withdrawn)
add_restriction("events", "ALL", :can_edit_event, :post, :withdrawn)

add_restriction("events", "ALL", :can_publish_event, :get, :published)
add_restriction("events", "ALL", :can_publish_event, :post, :published)
add_restriction("events", "ALL", :can_publish_event, :get, :pending)
add_restriction("events", "ALL", :can_publish_event, :post, :pending)
add_restriction("events", "ALL", :can_publish_event, :get, :approved)
add_restriction("events", "ALL", :can_publish_event, :post, :approved)
add_restriction("events", "ALL", :can_publish_event, :get, :masked)
add_restriction("events", "ALL", :can_publish_event, :post, :masked)
add_restriction("events", "ALL", :can_publish_event, :get, :withdrawn)
add_restriction("events", "ALL", :can_publish_event, :post, :withdrawn)

add_restriction("events", "show", :can_view_tap, :get, :published)
add_restriction("events", "show", :can_view_tap, :get, :pending)
add_restriction("events", "show", :can_view_tap, :get, :approved)
add_restriction("events", "show", :can_view_tap, :get, :masked)
add_restriction("events", "show", :can_view_tap, :get, :withdrawn)

add_restriction("events", "list", :can_view_tap, :get, :published)
add_restriction("events", "list", :can_view_tap, :get, :pending)
add_restriction("events", "list", :can_view_tap, :get, :approved)
add_restriction("events", "list", :can_view_tap, :get, :masked)
add_restriction("events", "list", :can_view_tap, :get, :withdrawn)

add_restriction("events", "related", :can_view_tap, :get, :published)
add_restriction("events", "related", :can_view_tap, :get, :pending)
add_restriction("events", "related", :can_view_tap, :get, :approved)
add_restriction("events", "related", :can_view_tap, :get, :masked)
add_restriction("events", "related", :can_view_tap, :get, :withdrawn)

add_restriction("events", "news", :can_view_tap, :get, :published)
add_restriction("events", "news", :can_view_tap, :get, :pending)
add_restriction("events", "news", :can_view_tap, :get, :approved)
add_restriction("events", "news", :can_view_tap, :get, :masked)
add_restriction("events", "news", :can_view_tap, :get, :withdrawn)

add_restriction("events", "homepage_news", :can_view_tap, :get, :published)
add_restriction("events", "homepage_news", :can_view_tap, :get, :pending)
add_restriction("events", "homepage_news", :can_view_tap, :get, :approved)
add_restriction("events", "homepage_news", :can_view_tap, :get, :masked)
add_restriction("events", "homepage_news", :can_view_tap, :get, :withdrawn)

add_restriction("events", "show", :can_view_public, :get, :published)
add_restriction("events", "related", :can_view_public, :get, :published)
add_restriction("events", "homepage_news", :can_view_public, :get, :published)
add_restriction("events", "news", :can_view_public, :get, :published)

# contributors
add_restriction("contributors", "ALL", :can_edit_contributor_profile, :get, :published)
add_restriction("contributors", "ALL", :can_edit_contributor_profile, :post, :published)
add_restriction("contributors", "ALL", :can_edit_contributor_profile, :get, :pending)
add_restriction("contributors", "ALL", :can_edit_contributor_profile, :post, :pending)
add_restriction("contributors", "ALL", :can_edit_contributor_profile, :get, :approved)
add_restriction("contributors", "ALL", :can_edit_contributor_profile, :post, :approved)
add_restriction("contributors", "ALL", :can_edit_contributor_profile, :get, :masked)
add_restriction("contributors", "ALL", :can_edit_contributor_profile, :post, :masked)
add_restriction("contributors", "ALL", :can_edit_contributor_profile, :get, :withdrawn)
add_restriction("contributors", "ALL", :can_edit_contributor_profile, :post, :withdrawn)

add_restriction("contributors", "ALL", :can_publish_contributor_profile, :get, :published)
add_restriction("contributors", "ALL", :can_publish_contributor_profile, :post, :published)
add_restriction("contributors", "ALL", :can_publish_contributor_profile, :get, :pending)
add_restriction("contributors", "ALL", :can_publish_contributor_profile, :post, :pending)
add_restriction("contributors", "ALL", :can_publish_contributor_profile, :get, :approved)
add_restriction("contributors", "ALL", :can_publish_contributor_profile, :post, :approved)
add_restriction("contributors", "ALL", :can_publish_contributor_profile, :get, :masked)
add_restriction("contributors", "ALL", :can_publish_contributor_profile, :post, :masked)
add_restriction("contributors", "ALL", :can_publish_contributor_profile, :get, :withdrawn)
add_restriction("contributors", "ALL", :can_publish_contributor_profile, :post, :withdrawn)

add_restriction("contributors", "show_appropriate_for_role", :can_view_public, :get, :published)
#add_restriction("contributors", "composer_intro", :can_view_public, :get, :published)
#add_restriction("contributors", "performer_intro", :can_view_public, :get, :published)
#add_restriction("contributors", "venue", :can_view_public, :get, :published)
#add_restriction("contributors", "presenter", :can_view_public, :get, :published)
#add_restriction("contributors", "general_intro", :can_view_public, :get, :published)

# items
add_restriction("items", "ALL", :can_edit_tap, :get, :published)
add_restriction("items", "ALL", :can_edit_tap, :post, :published)
add_restriction("items", "ALL", :can_edit_tap, :get, :pending)
add_restriction("items", "ALL", :can_edit_tap, :post, :pending)
add_restriction("items", "ALL", :can_edit_tap, :get, :approved)
add_restriction("items", "ALL", :can_edit_tap, :post, :approved)
add_restriction("items", "ALL", :can_edit_tap, :get, :masked)
add_restriction("items", "ALL", :can_edit_tap, :post, :masked)
add_restriction("items", "ALL", :can_edit_tap, :get, :withdrawn)
add_restriction("items", "ALL", :can_edit_tap, :post, :withdrawn)

add_restriction("items", "ALL", :can_publish_tap, :get, :published)
add_restriction("items", "ALL", :can_publish_tap, :post, :published)
add_restriction("items", "ALL", :can_publish_tap, :get, :pending)
add_restriction("items", "ALL", :can_publish_tap, :post, :pending)
add_restriction("items", "ALL", :can_publish_tap, :get, :approved)
add_restriction("items", "ALL", :can_publish_tap, :post, :approved)
add_restriction("items", "ALL", :can_publish_tap, :get, :masked)
add_restriction("items", "ALL", :can_publish_tap, :post, :masked)
add_restriction("items", "ALL", :can_publish_tap, :get, :withdrawn)
add_restriction("items", "ALL", :can_publish_tap, :post, :withdrawn)

add_restriction("items", "show", :can_view_tap, :get, :published)
add_restriction("items", "show", :can_view_tap, :get, :pending)
add_restriction("items", "show", :can_view_tap, :get, :approved)
add_restriction("items", "show", :can_view_tap, :get, :masked)
add_restriction("items", "show", :can_view_tap, :get, :withdrawn)

add_restriction("items", "list", :can_view_tap, :get, :published)
add_restriction("items", "list", :can_view_tap, :get, :pending)
add_restriction("items", "list", :can_view_tap, :get, :approved)
add_restriction("items", "list", :can_view_tap, :get, :masked)
add_restriction("items", "list", :can_view_tap, :get, :withdrawn)

# people
add_restriction("people", "new", :can_edit_crm, :get, :pending)
add_restriction("people", "new", :can_edit_crm, :post, :pending)
add_restriction("people", "new", :can_edit_crm, :get, :approved)
add_restriction("people", "new", :can_edit_crm, :post, :approved)
add_restriction("people", "new", :can_edit_crm, :get, :masked)
add_restriction("people", "new", :can_edit_crm, :post, :masked)
add_restriction("people", "new", :can_edit_crm, :get, :withdrawn)
add_restriction("people", "new", :can_edit_crm, :post, :withdrawn)

add_restriction("people", "new", :can_publish_crm, :get, :pending)
add_restriction("people", "new", :can_publish_crm, :post, :pending)
add_restriction("people", "new", :can_publish_crm, :get, :approved)
add_restriction("people", "new", :can_publish_crm, :post, :approved)
add_restriction("people", "new", :can_publish_crm, :get, :masked)
add_restriction("people", "new", :can_publish_crm, :post, :masked)
add_restriction("people", "new", :can_publish_crm, :get, :withdrawn)
add_restriction("people", "new", :can_publish_crm, :post, :withdrawn)

add_restriction("people", "create", :can_edit_crm, :get, :pending)
add_restriction("people", "create", :can_edit_crm, :post, :pending)
add_restriction("people", "create", :can_edit_crm, :get, :approved)
add_restriction("people", "create", :can_edit_crm, :post, :approved)
add_restriction("people", "create", :can_edit_crm, :get, :masked)
add_restriction("people", "create", :can_edit_crm, :post, :masked)
add_restriction("people", "create", :can_edit_crm, :get, :withdrawn)
add_restriction("people", "create", :can_edit_crm, :post, :withdrawn)

add_restriction("people", "create", :can_publish_crm, :get, :pending)
add_restriction("people", "create", :can_publish_crm, :post, :pending)
add_restriction("people", "create", :can_publish_crm, :get, :approved)
add_restriction("people", "create", :can_publish_crm, :post, :approved)
add_restriction("people", "create", :can_publish_crm, :get, :masked)
add_restriction("people", "create", :can_publish_crm, :post, :masked)
add_restriction("people", "create", :can_publish_crm, :get, :withdrawn)
add_restriction("people", "create", :can_publish_crm, :post, :withdrawn)

add_restriction("people", "edit", :can_edit_crm, :get, :pending)
add_restriction("people", "edit", :can_edit_crm, :post, :pending)
add_restriction("people", "edit", :can_edit_crm, :get, :approved)
add_restriction("people", "edit", :can_edit_crm, :post, :approved)
add_restriction("people", "edit", :can_edit_crm, :get, :masked)
add_restriction("people", "edit", :can_edit_crm, :post, :masked)
add_restriction("people", "edit", :can_edit_crm, :get, :withdrawn)
add_restriction("people", "edit", :can_edit_crm, :post, :withdrawn)

add_restriction("people", "edit", :can_publish_crm, :get, :pending)
add_restriction("people", "edit", :can_publish_crm, :post, :pending)
add_restriction("people", "edit", :can_publish_crm, :get, :approved)
add_restriction("people", "edit", :can_publish_crm, :post, :approved)
add_restriction("people", "edit", :can_publish_crm, :get, :masked)
add_restriction("people", "edit", :can_publish_crm, :post, :masked)
add_restriction("people", "edit", :can_publish_crm, :get, :withdrawn)
add_restriction("people", "edit", :can_publish_crm, :post, :withdrawn)

add_restriction("people", "update", :can_edit_crm, :get, :pending)
add_restriction("people", "update", :can_edit_crm, :post, :pending)
add_restriction("people", "update", :can_edit_crm, :get, :approved)
add_restriction("people", "update", :can_edit_crm, :post, :approved)
add_restriction("people", "update", :can_edit_crm, :get, :masked)
add_restriction("people", "update", :can_edit_crm, :post, :masked)
add_restriction("people", "update", :can_edit_crm, :get, :withdrawn)
add_restriction("people", "update", :can_edit_crm, :post, :withdrawn)

add_restriction("people", "update", :can_publish_crm, :get, :pending)
add_restriction("people", "update", :can_publish_crm, :post, :pending)
add_restriction("people", "update", :can_publish_crm, :get, :approved)
add_restriction("people", "update", :can_publish_crm, :post, :approved)
add_restriction("people", "update", :can_publish_crm, :get, :masked)
add_restriction("people", "update", :can_publish_crm, :post, :masked)
add_restriction("people", "update", :can_publish_crm, :get, :withdrawn)
add_restriction("people", "update", :can_publish_crm, :post, :withdrawn)

add_restriction("people", "roles", :can_edit_crm, :get, :pending)
add_restriction("people", "roles", :can_edit_crm, :post, :pending)
add_restriction("people", "roles", :can_edit_crm, :get, :approved)
add_restriction("people", "roles", :can_edit_crm, :post, :approved)
add_restriction("people", "roles", :can_edit_crm, :get, :masked)
add_restriction("people", "roles", :can_edit_crm, :post, :masked)
add_restriction("people", "roles", :can_edit_crm, :get, :withdrawn)
add_restriction("people", "roles", :can_edit_crm, :post, :withdrawn)

add_restriction("people", "roles", :can_publish_crm, :get, :pending)
add_restriction("people", "roles", :can_publish_crm, :post, :pending)
add_restriction("people", "roles", :can_publish_crm, :get, :approved)
add_restriction("people", "roles", :can_publish_crm, :post, :approved)
add_restriction("people", "roles", :can_publish_crm, :get, :masked)
add_restriction("people", "roles", :can_publish_crm, :post, :masked)
add_restriction("people", "roles", :can_publish_crm, :get, :withdrawn)
add_restriction("people", "roles", :can_publish_crm, :post, :withdrawn)

add_restriction("people", "privileges_list", :can_edit_login, :get, :pending)
add_restriction("people", "privileges_list", :can_edit_login, :post, :pending)
add_restriction("people", "privileges_list", :can_edit_login, :get, :approved)
add_restriction("people", "privileges_list", :can_edit_login, :post, :approved)
add_restriction("people", "privileges_list", :can_edit_login, :get, :masked)
add_restriction("people", "privileges_list", :can_edit_login, :post, :masked)
add_restriction("people", "privileges_list", :can_edit_login, :get, :withdrawn)
add_restriction("people", "privileges_list", :can_edit_login, :post, :withdrawn)

add_restriction("people", "privileges_list", :can_edit_borrowed_item, :get, :pending)
add_restriction("people", "privileges_list", :can_edit_borrowed_item, :post, :pending)
add_restriction("people", "privileges_list", :can_edit_borrowed_item, :get, :approved)
add_restriction("people", "privileges_list", :can_edit_borrowed_item, :post, :approved)
add_restriction("people", "privileges_list", :can_edit_borrowed_item, :get, :masked)
add_restriction("people", "privileges_list", :can_edit_borrowed_item, :post, :masked)
add_restriction("people", "privileges_list", :can_edit_borrowed_item, :get, :withdrawn)
add_restriction("people", "privileges_list", :can_edit_borrowed_item, :post, :withdrawn)

add_restriction("people", "assignLogin", :can_edit_login, :get, :pending)
add_restriction("people", "assignLogin", :can_edit_login, :post, :pending)
add_restriction("people", "assignLogin", :can_edit_login, :get, :approved)
add_restriction("people", "assignLogin", :can_edit_login, :post, :approved)
add_restriction("people", "assignLogin", :can_edit_login, :get, :masked)
add_restriction("people", "assignLogin", :can_edit_login, :post, :masked)
add_restriction("people", "assignLogin", :can_edit_login, :get, :withdrawn)
add_restriction("people", "assignLogin", :can_edit_login, :post, :withdrawn)

add_restriction("people", "removeLogin", :can_edit_login, :get, :pending)
add_restriction("people", "removeLogin", :can_edit_login, :post, :pending)
add_restriction("people", "removeLogin", :can_edit_login, :get, :approved)
add_restriction("people", "removeLogin", :can_edit_login, :post, :approved)
add_restriction("people", "removeLogin", :can_edit_login, :get, :masked)
add_restriction("people", "removeLogin", :can_edit_login, :post, :masked)
add_restriction("people", "removeLogin", :can_edit_login, :get, :withdrawn)
add_restriction("people", "removeLogin", :can_edit_login, :post, :withdrawn)

add_restriction("people", "createLogin", :can_edit_login, :get, :pending)
add_restriction("people", "createLogin", :can_edit_login, :post, :pending)
add_restriction("people", "createLogin", :can_edit_login, :get, :approved)
add_restriction("people", "createLogin", :can_edit_login, :post, :approved)
add_restriction("people", "createLogin", :can_edit_login, :get, :masked)
add_restriction("people", "createLogin", :can_edit_login, :post, :masked)
add_restriction("people", "createLogin", :can_edit_login, :get, :withdrawn)
add_restriction("people", "createLogin", :can_edit_login, :post, :withdrawn)

#add_restriction("people", "web_user_address_details", :can_view_public, :get)
#add_restriction("people", "web_user_address_details", :can_view_public, :post)

#add_restriction("people", "update_web_user_address_details", :can_view_public, :get)
#add_restriction("people", "update_web_user_address_details", :can_view_public, :post)

# organisations
add_restriction("organisations", "new", :can_edit_crm, :get, :pending)
add_restriction("organisations", "new", :can_edit_crm, :post, :pending)
add_restriction("organisations", "new", :can_edit_crm, :get, :approved)
add_restriction("organisations", "new", :can_edit_crm, :post, :approved)
add_restriction("organisations", "new", :can_edit_crm, :get, :masked)
add_restriction("organisations", "new", :can_edit_crm, :post, :masked)
add_restriction("organisations", "new", :can_edit_crm, :get, :withdrawn)
add_restriction("organisations", "new", :can_edit_crm, :post, :withdrawn)

add_restriction("organisations", "new", :can_publish_crm, :get, :pending)
add_restriction("organisations", "new", :can_publish_crm, :post, :pending)
add_restriction("organisations", "new", :can_publish_crm, :get, :approved)
add_restriction("organisations", "new", :can_publish_crm, :post, :approved)
add_restriction("organisations", "new", :can_publish_crm, :get, :masked)
add_restriction("organisations", "new", :can_publish_crm, :post, :masked)
add_restriction("organisations", "new", :can_publish_crm, :get, :withdrawn)
add_restriction("organisations", "new", :can_publish_crm, :post, :withdrawn)

add_restriction("organisations", "create", :can_edit_crm, :get, :pending)
add_restriction("organisations", "create", :can_edit_crm, :post, :pending)
add_restriction("organisations", "create", :can_edit_crm, :get, :approved)
add_restriction("organisations", "create", :can_edit_crm, :post, :approved)
add_restriction("organisations", "create", :can_edit_crm, :get, :masked)
add_restriction("organisations", "create", :can_edit_crm, :post, :masked)
add_restriction("organisations", "create", :can_edit_crm, :get, :withdrawn)
add_restriction("organisations", "create", :can_edit_crm, :post, :withdrawn)

add_restriction("organisations", "create", :can_publish_crm, :get, :pending)
add_restriction("organisations", "create", :can_publish_crm, :post, :pending)
add_restriction("organisations", "create", :can_publish_crm, :get, :approved)
add_restriction("organisations", "create", :can_publish_crm, :post, :approved)
add_restriction("organisations", "create", :can_publish_crm, :get, :masked)
add_restriction("organisations", "create", :can_publish_crm, :post, :masked)
add_restriction("organisations", "create", :can_publish_crm, :get, :withdrawn)
add_restriction("organisations", "create", :can_publish_crm, :post, :withdrawn)

add_restriction("organisations", "edit", :can_edit_crm, :get, :pending)
add_restriction("organisations", "edit", :can_edit_crm, :post, :pending)
add_restriction("organisations", "edit", :can_edit_crm, :get, :approved)
add_restriction("organisations", "edit", :can_edit_crm, :post, :approved)
add_restriction("organisations", "edit", :can_edit_crm, :get, :masked)
add_restriction("organisations", "edit", :can_edit_crm, :post, :masked)
add_restriction("organisations", "edit", :can_edit_crm, :get, :withdrawn)
add_restriction("organisations", "edit", :can_edit_crm, :post, :withdrawn)

add_restriction("organisations", "edit", :can_publish_crm, :get, :pending)
add_restriction("organisations", "edit", :can_publish_crm, :post, :pending)
add_restriction("organisations", "edit", :can_publish_crm, :get, :approved)
add_restriction("organisations", "edit", :can_publish_crm, :post, :approved)
add_restriction("organisations", "edit", :can_publish_crm, :get, :masked)
add_restriction("organisations", "edit", :can_publish_crm, :post, :masked)
add_restriction("organisations", "edit", :can_publish_crm, :get, :withdrawn)
add_restriction("organisations", "edit", :can_publish_crm, :post, :withdrawn)

add_restriction("organisations", "update", :can_edit_crm, :get, :pending)
add_restriction("organisations", "update", :can_edit_crm, :post, :pending)
add_restriction("organisations", "update", :can_edit_crm, :get, :approved)
add_restriction("organisations", "update", :can_edit_crm, :post, :approved)
add_restriction("organisations", "update", :can_edit_crm, :get, :masked)
add_restriction("organisations", "update", :can_edit_crm, :post, :masked)
add_restriction("organisations", "update", :can_edit_crm, :get, :withdrawn)
add_restriction("organisations", "update", :can_edit_crm, :post, :withdrawn)

add_restriction("organisations", "update", :can_publish_crm, :get, :pending)
add_restriction("organisations", "update", :can_publish_crm, :post, :pending)
add_restriction("organisations", "update", :can_publish_crm, :get, :approved)
add_restriction("organisations", "update", :can_publish_crm, :post, :approved)
add_restriction("organisations", "update", :can_publish_crm, :get, :masked)
add_restriction("organisations", "update", :can_publish_crm, :post, :masked)
add_restriction("organisations", "update", :can_publish_crm, :get, :withdrawn)
add_restriction("organisations", "update", :can_publish_crm, :post, :withdrawn)

add_restriction("organisations", "related", :can_edit_crm, :get, :pending)
add_restriction("organisations", "related", :can_edit_crm, :post, :pending)
add_restriction("organisations", "related", :can_edit_crm, :get, :approved)
add_restriction("organisations", "related", :can_edit_crm, :post, :approved)
add_restriction("organisations", "related", :can_edit_crm, :get, :masked)
add_restriction("organisations", "related", :can_edit_crm, :post, :masked)
add_restriction("organisations", "related", :can_edit_crm, :get, :withdrawn)
add_restriction("organisations", "related", :can_edit_crm, :post, :withdrawn)

add_restriction("organisations", "related", :can_publish_crm, :get, :pending)
add_restriction("organisations", "related", :can_publish_crm, :post, :pending)
add_restriction("organisations", "related", :can_publish_crm, :get, :approved)
add_restriction("organisations", "related", :can_publish_crm, :post, :approved)
add_restriction("organisations", "related", :can_publish_crm, :get, :masked)
add_restriction("organisations", "related", :can_publish_crm, :post, :masked)
add_restriction("organisations", "related", :can_publish_crm, :get, :withdrawn)
add_restriction("organisations", "related", :can_publish_crm, :post, :withdrawn)

add_restriction("organisations", "add_relationship", :can_edit_crm, :get, :pending)
add_restriction("organisations", "add_relationship", :can_edit_crm, :post, :pending)
add_restriction("organisations", "add_relationship", :can_edit_crm, :get, :approved)
add_restriction("organisations", "add_relationship", :can_edit_crm, :post, :approved)
add_restriction("organisations", "add_relationship", :can_edit_crm, :get, :masked)
add_restriction("organisations", "add_relationship", :can_edit_crm, :post, :masked)
add_restriction("organisations", "add_relationship", :can_edit_crm, :get, :withdrawn)
add_restriction("organisations", "add_relationship", :can_edit_crm, :post, :withdrawn)

add_restriction("organisations", "add_relationship", :can_publish_crm, :get, :pending)
add_restriction("organisations", "add_relationship", :can_publish_crm, :post, :pending)
add_restriction("organisations", "add_relationship", :can_publish_crm, :get, :approved)
add_restriction("organisations", "add_relationship", :can_publish_crm, :post, :approved)
add_restriction("organisations", "add_relationship", :can_publish_crm, :get, :masked)
add_restriction("organisations", "add_relationship", :can_publish_crm, :post, :masked)
add_restriction("organisations", "add_relationship", :can_publish_crm, :get, :withdrawn)
add_restriction("organisations", "add_relationship", :can_publish_crm, :post, :withdrawn)

add_restriction("organisations", "delete_relationship", :can_edit_crm, :get, :pending)
add_restriction("organisations", "delete_relationship", :can_edit_crm, :post, :pending)
add_restriction("organisations", "delete_relationship", :can_edit_crm, :get, :approved)
add_restriction("organisations", "delete_relationship", :can_edit_crm, :post, :approved)
add_restriction("organisations", "delete_relationship", :can_edit_crm, :get, :masked)
add_restriction("organisations", "delete_relationship", :can_edit_crm, :post, :masked)
add_restriction("organisations", "delete_relationship", :can_edit_crm, :get, :withdrawn)
add_restriction("organisations", "delete_relationship", :can_edit_crm, :post, :withdrawn)

add_restriction("organisations", "delete_relationship", :can_publish_crm, :get, :pending)
add_restriction("organisations", "delete_relationship", :can_publish_crm, :post, :pending)
add_restriction("organisations", "delete_relationship", :can_publish_crm, :get, :approved)
add_restriction("organisations", "delete_relationship", :can_publish_crm, :post, :approved)
add_restriction("organisations", "delete_relationship", :can_publish_crm, :get, :masked)
add_restriction("organisations", "delete_relationship", :can_publish_crm, :post, :masked)
add_restriction("organisations", "delete_relationship", :can_publish_crm, :get, :withdrawn)
add_restriction("organisations", "delete_relationship", :can_publish_crm, :post, :withdrawn)

add_restriction("organisations", "roles", :can_edit_crm, :get, :pending)
add_restriction("organisations", "roles", :can_edit_crm, :post, :pending)
add_restriction("organisations", "roles", :can_edit_crm, :get, :approved)
add_restriction("organisations", "roles", :can_edit_crm, :post, :approved)
add_restriction("organisations", "roles", :can_edit_crm, :get, :masked)
add_restriction("organisations", "roles", :can_edit_crm, :post, :masked)
add_restriction("organisations", "roles", :can_edit_crm, :get, :withdrawn)
add_restriction("organisations", "roles", :can_edit_crm, :post, :withdrawn)

add_restriction("organisations", "roles", :can_publish_crm, :get, :pending)
add_restriction("organisations", "roles", :can_publish_crm, :post, :pending)
add_restriction("organisations", "roles", :can_publish_crm, :get, :approved)
add_restriction("organisations", "roles", :can_publish_crm, :post, :approved)
add_restriction("organisations", "roles", :can_publish_crm, :get, :masked)
add_restriction("organisations", "roles", :can_publish_crm, :post, :masked)
add_restriction("organisations", "roles", :can_publish_crm, :get, :withdrawn)
add_restriction("organisations", "roles", :can_publish_crm, :post, :withdrawn)

add_restriction("organisations", "privileges_list", :can_edit_login, :get, :pending)
add_restriction("organisations", "privileges_list", :can_edit_login, :post, :pending)
add_restriction("organisations", "privileges_list", :can_edit_login, :get, :approved)
add_restriction("organisations", "privileges_list", :can_edit_login, :post, :approved)
add_restriction("organisations", "privileges_list", :can_edit_login, :get, :masked)
add_restriction("organisations", "privileges_list", :can_edit_login, :post, :masked)
add_restriction("organisations", "privileges_list", :can_edit_login, :get, :withdrawn)
add_restriction("organisations", "privileges_list", :can_edit_login, :post, :withdrawn)

add_restriction("organisations", "privileges_list", :can_edit_borrowed_item, :get, :pending)
add_restriction("organisations", "privileges_list", :can_edit_borrowed_item, :post, :pending)
add_restriction("organisations", "privileges_list", :can_edit_borrowed_item, :get, :approved)
add_restriction("organisations", "privileges_list", :can_edit_borrowed_item, :post, :approved)
add_restriction("organisations", "privileges_list", :can_edit_borrowed_item, :get, :masked)
add_restriction("organisations", "privileges_list", :can_edit_borrowed_item, :post, :masked)
add_restriction("organisations", "privileges_list", :can_edit_borrowed_item, :get, :withdrawn)
add_restriction("organisations", "privileges_list", :can_edit_borrowed_item, :post, :withdrawn)

add_restriction("organisations", "assignLogin", :can_edit_login, :get, :pending)
add_restriction("organisations", "assignLogin", :can_edit_login, :post, :pending)
add_restriction("organisations", "assignLogin", :can_edit_login, :get, :approved)
add_restriction("organisations", "assignLogin", :can_edit_login, :post, :approved)
add_restriction("organisations", "assignLogin", :can_edit_login, :get, :masked)
add_restriction("organisations", "assignLogin", :can_edit_login, :post, :masked)
add_restriction("organisations", "assignLogin", :can_edit_login, :get, :withdrawn)
add_restriction("organisations", "assignLogin", :can_edit_login, :post, :withdrawn)

add_restriction("organisations", "removeLogin", :can_edit_login, :get, :pending)
add_restriction("organisations", "removeLogin", :can_edit_login, :post, :pending)
add_restriction("organisations", "removeLogin", :can_edit_login, :get, :approved)
add_restriction("organisations", "removeLogin", :can_edit_login, :post, :approved)
add_restriction("organisations", "removeLogin", :can_edit_login, :get, :masked)
add_restriction("organisations", "removeLogin", :can_edit_login, :post, :masked)
add_restriction("organisations", "removeLogin", :can_edit_login, :get, :withdrawn)
add_restriction("organisations", "removeLogin", :can_edit_login, :post, :withdrawn)

add_restriction("organisations", "createLogin", :can_edit_login, :get, :pending)
add_restriction("organisations", "createLogin", :can_edit_login, :post, :pending)
add_restriction("organisations", "createLogin", :can_edit_login, :get, :approved)
add_restriction("organisations", "createLogin", :can_edit_login, :post, :approved)
add_restriction("organisations", "createLogin", :can_edit_login, :get, :masked)
add_restriction("organisations", "createLogin", :can_edit_login, :post, :masked)
add_restriction("organisations", "createLogin", :can_edit_login, :get, :withdrawn)
add_restriction("organisations", "createLogin", :can_edit_login, :post, :withdrawn)

# roles
add_restriction("roles", "new",         :can_edit_crm, :get,  :pending)
add_restriction("roles", "new",         :can_edit_crm, :post, :pending)
add_restriction("roles", "new",         :can_edit_crm, :get,  :approved)
add_restriction("roles", "new",         :can_edit_crm, :post, :approved)
add_restriction("roles", "new",         :can_edit_crm, :get,  :masked)
add_restriction("roles", "new",         :can_edit_crm, :post, :masked)
add_restriction("roles", "new",         :can_edit_crm, :get,  :withdrawn)
add_restriction("roles", "new",         :can_edit_crm, :post, :withdrawn)

add_restriction("roles", "create",      :can_edit_crm, :get,  :pending)
add_restriction("roles", "create",      :can_edit_crm, :post, :pending)
add_restriction("roles", "create",      :can_edit_crm, :get,  :approved)
add_restriction("roles", "create",      :can_edit_crm, :post, :approved)
add_restriction("roles", "create",      :can_edit_crm, :get,  :masked)
add_restriction("roles", "create",      :can_edit_crm, :post, :masked)
add_restriction("roles", "create",      :can_edit_crm, :get,  :withdrawn)
add_restriction("roles", "create",      :can_edit_crm, :post, :withdrawn)

add_restriction("roles", "edit",        :can_edit_crm, :get,  :pending)
add_restriction("roles", "edit",        :can_edit_crm, :post, :pending)
add_restriction("roles", "edit",        :can_edit_crm, :get,  :approved)
add_restriction("roles", "edit",        :can_edit_crm, :post, :approved)
add_restriction("roles", "edit",        :can_edit_crm, :get,  :masked)
add_restriction("roles", "edit",        :can_edit_crm, :post, :masked)
add_restriction("roles", "edit",        :can_edit_crm, :get,  :withdrawn)
add_restriction("roles", "edit",        :can_edit_crm, :post, :withdrawn)

add_restriction("roles", "update_role", :can_edit_crm, :get,  :pending)
add_restriction("roles", "update_role", :can_edit_crm, :post, :pending)
add_restriction("roles", "update_role", :can_edit_crm, :get,  :approved)
add_restriction("roles", "update_role", :can_edit_crm, :post, :approved)
add_restriction("roles", "update_role", :can_edit_crm, :get,  :masked)
add_restriction("roles", "update_role", :can_edit_crm, :post, :masked)
add_restriction("roles", "update_role", :can_edit_crm, :get,  :withdrawn)
add_restriction("roles", "update_role", :can_edit_crm, :post, :withdrawn)

add_restriction("roles", "show",        :can_edit_crm, :get,  :pending)
add_restriction("roles", "show",        :can_edit_crm, :post, :pending)
add_restriction("roles", "show",        :can_edit_crm, :get,  :approved)
add_restriction("roles", "show",        :can_edit_crm, :post, :approved)
add_restriction("roles", "show",        :can_edit_crm, :get,  :masked)
add_restriction("roles", "show",        :can_edit_crm, :post, :masked)
add_restriction("roles", "show",        :can_edit_crm, :get,  :withdrawn)
add_restriction("roles", "show",        :can_edit_crm, :post, :withdrawn)

add_restriction("roles", "contributor_role_type_check",        :can_edit_crm, :get,  :pending)
add_restriction("roles", "contributor_role_type_check",        :can_edit_crm, :post, :pending)
add_restriction("roles", "contributor_role_type_check",        :can_edit_crm, :get,  :approved)
add_restriction("roles", "contributor_role_type_check",        :can_edit_crm, :post, :approved)
add_restriction("roles", "contributor_role_type_check",        :can_edit_crm, :get,  :masked)
add_restriction("roles", "contributor_role_type_check",        :can_edit_crm, :post, :masked)
add_restriction("roles", "contributor_role_type_check",        :can_edit_crm, :get,  :withdrawn)
add_restriction("roles", "contributor_role_type_check",        :can_edit_crm, :post, :withdrawn)

add_restriction("roles", "contributor_details",        :can_edit_contributor_profile, :get,  :pending)
add_restriction("roles", "contributor_details",        :can_edit_contributor_profile, :post, :pending)
add_restriction("roles", "contributor_details",        :can_edit_contributor_profile, :get,  :published)
add_restriction("roles", "contributor_details",        :can_edit_contributor_profile, :post, :published)
add_restriction("roles", "contributor_details",        :can_edit_contributor_profile, :get,  :masked)
add_restriction("roles", "contributor_details",        :can_edit_contributor_profile, :post, :masked)
add_restriction("roles", "contributor_details",        :can_edit_contributor_profile, :get,  :withdrawn)
add_restriction("roles", "contributor_details",        :can_edit_contributor_profile, :post, :withdrawn)
add_restriction("roles", "contributor_details",        :can_edit_contributor_profile, :get,  :approved)
add_restriction("roles", "contributor_details",        :can_edit_contributor_profile, :post, :approved)

add_restriction("roles", "contributor_details_update", :can_edit_contributor_profile, :get,  :pending)
add_restriction("roles", "contributor_details_update", :can_edit_contributor_profile, :post, :pending)
add_restriction("roles", "contributor_details_update", :can_edit_contributor_profile, :get,  :published)
add_restriction("roles", "contributor_details_update", :can_edit_contributor_profile, :post, :published)
add_restriction("roles", "contributor_details_update", :can_edit_contributor_profile, :get,  :masked)
add_restriction("roles", "contributor_details_update", :can_edit_contributor_profile, :post, :masked)
add_restriction("roles", "contributor_details_update", :can_edit_contributor_profile, :get,  :withdrawn)
add_restriction("roles", "contributor_details_update", :can_edit_contributor_profile, :post, :withdrawn)
add_restriction("roles", "contributor_details_update", :can_edit_contributor_profile, :get,  :approved)
add_restriction("roles", "contributor_details_update", :can_edit_contributor_profile, :post, :approved)

add_restriction("roles", "contributor_details",        :can_publish_contributor_profile, :get,  :pending)
add_restriction("roles", "contributor_details",        :can_publish_contributor_profile, :post, :pending)
add_restriction("roles", "contributor_details",        :can_publish_contributor_profile, :get,  :published)
add_restriction("roles", "contributor_details",        :can_publish_contributor_profile, :post, :published)
add_restriction("roles", "contributor_details",        :can_publish_contributor_profile, :get,  :masked)
add_restriction("roles", "contributor_details",        :can_publish_contributor_profile, :post, :masked)
add_restriction("roles", "contributor_details",        :can_publish_contributor_profile, :get,  :withdrawn)
add_restriction("roles", "contributor_details",        :can_publish_contributor_profile, :post, :withdrawn)
add_restriction("roles", "contributor_details",        :can_publish_contributor_profile, :get,  :approved)
add_restriction("roles", "contributor_details",        :can_publish_contributor_profile, :post, :approved)

add_restriction("roles", "contributor_details_update", :can_publish_contributor_profile, :get,  :pending)
add_restriction("roles", "contributor_details_update", :can_publish_contributor_profile, :post, :pending)
add_restriction("roles", "contributor_details_update", :can_publish_contributor_profile, :get,  :published)
add_restriction("roles", "contributor_details_update", :can_publish_contributor_profile, :post, :published)
add_restriction("roles", "contributor_details_update", :can_publish_contributor_profile, :get,  :masked)
add_restriction("roles", "contributor_details_update", :can_publish_contributor_profile, :post, :masked)
add_restriction("roles", "contributor_details_update", :can_publish_contributor_profile, :get,  :withdrawn)
add_restriction("roles", "contributor_details_update", :can_publish_contributor_profile, :post, :withdrawn)
add_restriction("roles", "contributor_details_update", :can_publish_contributor_profile, :get,  :approved)
add_restriction("roles", "contributor_details_update", :can_publish_contributor_profile, :post, :approved)

add_restriction("roles", "show", :can_view_public, :get, :approved)

# role_contactinfos
add_restriction("role_contactinfos", "ALL", :can_edit_crm, :get)
add_restriction("role_contactinfos", "ALL", :can_edit_crm, :post)
add_restriction("role_contactinfos", "ALL", :can_publish_crm, :get)
add_restriction("role_contactinfos", "ALL", :can_publish_crm, :post)

# contactinfos
add_restriction("contactinfos", "ALL", :can_edit_crm, :get)
add_restriction("contactinfos", "ALL", :can_edit_crm, :post)
add_restriction("contactinfos", "ALL", :can_publish_crm, :get)
add_restriction("contactinfos", "ALL", :can_publish_crm, :post)

# communications
add_restriction("communications", "ALL", :can_edit_crm, :get)
add_restriction("communications", "ALL", :can_edit_crm, :post)
add_restriction("communications", "ALL", :can_publish_crm, :get)
add_restriction("communications", "ALL", :can_publish_crm, :post)

# search_contacts (crm contacts searches)
add_restriction("search_contacts", "ALL", :can_edit_crm, :get)
add_restriction("search_contacts", "ALL", :can_edit_crm, :post)
add_restriction("search_contacts", "ALL", :can_publish_crm, :get)
add_restriction("search_contacts", "ALL", :can_publish_crm, :post)

# search_communications
add_restriction("search_communications", "ALL", :can_edit_crm, :get)
add_restriction("search_communications", "ALL", :can_edit_crm, :post)
add_restriction("search_communications", "ALL", :can_publish_crm, :get)
add_restriction("search_communications", "ALL", :can_publish_crm, :post)

# search_borrowed_items
add_restriction("search_borrowed_items", "ALL", :can_edit_crm, :get)
add_restriction("search_borrowed_items", "ALL", :can_edit_crm, :post)
add_restriction("search_borrowed_items", "ALL", :can_publish_crm, :get)
add_restriction("search_borrowed_items", "ALL", :can_publish_crm, :post)

# saved_contact_lists
add_restriction("saved_contact_lists", "ALL", :can_edit_crm, :get)
add_restriction("saved_contact_lists", "ALL", :can_edit_crm, :post)
add_restriction("saved_contact_lists", "ALL", :can_publish_crm, :get)
add_restriction("saved_contact_lists", "ALL", :can_publish_crm, :post)

# projects
add_restriction("projects", "ALL", :can_edit_project, :get)
add_restriction("projects", "ALL", :can_edit_project, :post)

# marketing_campaigns
add_restriction("marketing_campaigns", "ALL", :can_edit_project, :get)
add_restriction("marketing_campaigns", "ALL", :can_edit_project, :post)

# campaign_mailouts
add_restriction("campaign_mailouts", "ALL", :can_edit_project, :get)
add_restriction("campaign_mailouts", "ALL", :can_edit_project, :post)

# mailout_contacts
add_restriction("mailout_contacts", "ALL", :can_edit_project, :get)
add_restriction("mailout_contacts", "ALL", :can_edit_project, :post)

# prov_composer_bios
add_restriction("prov_composer_bios", "ALL", :can_edit_composer_bio_prov_form, :get,    :pending)
add_restriction("prov_composer_bios", "ALL", :can_edit_composer_bio_prov_form, :put,    :pending)
add_restriction("prov_composer_bios", "ALL", :can_edit_composer_bio_prov_form, :delete, :pending)
add_restriction("prov_composer_bios", "ALL", :can_edit_composer_bio_prov_form, :get,    :approved)
add_restriction("prov_composer_bios", "ALL", :can_edit_composer_bio_prov_form, :put,    :approved)
add_restriction("prov_composer_bios", "ALL", :can_edit_composer_bio_prov_form, :delete, :approved)
add_restriction("prov_composer_bios", "ALL", :can_edit_composer_bio_prov_form, :get,    :masked)
add_restriction("prov_composer_bios", "ALL", :can_edit_composer_bio_prov_form, :put,    :masked)
add_restriction("prov_composer_bios", "ALL", :can_edit_composer_bio_prov_form, :delete, :masked)
add_restriction("prov_composer_bios", "ALL", :can_edit_composer_bio_prov_form, :get,    :withdrawn)
add_restriction("prov_composer_bios", "ALL", :can_edit_composer_bio_prov_form, :put,    :withdrawn)
add_restriction("prov_composer_bios", "ALL", :can_edit_composer_bio_prov_form, :delete, :withdrawn)
add_restriction("prov_composer_bios", "ALL", :can_edit_composer_bio_prov_form, :get,    :published)
add_restriction("prov_composer_bios", "ALL", :can_edit_composer_bio_prov_form, :put,    :published)
add_restriction("prov_composer_bios", "ALL", :can_edit_composer_bio_prov_form, :delete, :published)

add_restriction("prov_composer_bios", "new",               :is_authenticated, :get,  :pending)
add_restriction("prov_composer_bios", "new",               :is_authenticated, :post, :pending)
add_restriction("prov_composer_bios", "create",            :is_authenticated, :get,  :pending)
add_restriction("prov_composer_bios", "create",            :is_authenticated, :post, :pending)
add_restriction("prov_composer_bios", "show_confirmation", :is_authenticated, :get,  :pending)

# prov_contact_updates
add_restriction("prov_contact_updates", "ALL", :can_edit_contact_update_prov_form, :get,    :pending)
add_restriction("prov_contact_updates", "ALL", :can_edit_contact_update_prov_form, :put,    :pending)
add_restriction("prov_contact_updates", "ALL", :can_edit_contact_update_prov_form, :delete, :pending)
add_restriction("prov_contact_updates", "ALL", :can_edit_contact_update_prov_form, :get,    :approved)
add_restriction("prov_contact_updates", "ALL", :can_edit_contact_update_prov_form, :put,    :approved)
add_restriction("prov_contact_updates", "ALL", :can_edit_contact_update_prov_form, :delete, :approved)
add_restriction("prov_contact_updates", "ALL", :can_edit_contact_update_prov_form, :get,    :masked)
add_restriction("prov_contact_updates", "ALL", :can_edit_contact_update_prov_form, :put,    :masked)
add_restriction("prov_contact_updates", "ALL", :can_edit_contact_update_prov_form, :delete, :masked)
add_restriction("prov_contact_updates", "ALL", :can_edit_contact_update_prov_form, :get,    :withdrawn)
add_restriction("prov_contact_updates", "ALL", :can_edit_contact_update_prov_form, :put,    :withdrawn)
add_restriction("prov_contact_updates", "ALL", :can_edit_contact_update_prov_form, :delete, :withdrawn)
add_restriction("prov_contact_updates", "ALL", :can_edit_contact_update_prov_form, :get,    :published)
add_restriction("prov_contact_updates", "ALL", :can_edit_contact_update_prov_form, :put,    :published)
add_restriction("prov_contact_updates", "ALL", :can_edit_contact_update_prov_form, :delete, :published)

add_restriction("prov_contact_updates", "new",               :is_authenticated, :get,  :pending)
add_restriction("prov_contact_updates", "new",               :is_authenticated, :post, :pending)
add_restriction("prov_contact_updates", "create",            :is_authenticated, :get,  :pending)
add_restriction("prov_contact_updates", "create",            :is_authenticated, :post, :pending)
add_restriction("prov_contact_updates", "show_confirmation", :is_authenticated, :get,  :pending)

# prov_contributor_profiles
add_restriction("prov_contributor_profiles", "ALL", :can_edit_contributor_profile_prov_form, :get,    :pending)
add_restriction("prov_contributor_profiles", "ALL", :can_edit_contributor_profile_prov_form, :put,    :pending)
add_restriction("prov_contributor_profiles", "ALL", :can_edit_contributor_profile_prov_form, :delete, :pending)
add_restriction("prov_contributor_profiles", "ALL", :can_edit_contributor_profile_prov_form, :get,    :approved)
add_restriction("prov_contributor_profiles", "ALL", :can_edit_contributor_profile_prov_form, :put,    :approved)
add_restriction("prov_contributor_profiles", "ALL", :can_edit_contributor_profile_prov_form, :delete, :approved)
add_restriction("prov_contributor_profiles", "ALL", :can_edit_contributor_profile_prov_form, :get,    :masked)
add_restriction("prov_contributor_profiles", "ALL", :can_edit_contributor_profile_prov_form, :put,    :masked)
add_restriction("prov_contributor_profiles", "ALL", :can_edit_contributor_profile_prov_form, :delete, :masked)
add_restriction("prov_contributor_profiles", "ALL", :can_edit_contributor_profile_prov_form, :get,    :withdrawn)
add_restriction("prov_contributor_profiles", "ALL", :can_edit_contributor_profile_prov_form, :put,    :withdrawn)
add_restriction("prov_contributor_profiles", "ALL", :can_edit_contributor_profile_prov_form, :delete, :withdrawn)
add_restriction("prov_contributor_profiles", "ALL", :can_edit_contributor_profile_prov_form, :get,    :published)
add_restriction("prov_contributor_profiles", "ALL", :can_edit_contributor_profile_prov_form, :put,    :published)
add_restriction("prov_contributor_profiles", "ALL", :can_edit_contributor_profile_prov_form, :delete, :published)

add_restriction("prov_contributor_profiles", "new",               :is_authenticated, :get,  :pending)
add_restriction("prov_contributor_profiles", "new",               :is_authenticated, :post, :pending)
add_restriction("prov_contributor_profiles", "create",            :is_authenticated, :get,  :pending)
add_restriction("prov_contributor_profiles", "create",            :is_authenticated, :post, :pending)
add_restriction("prov_contributor_profiles", "show_confirmation", :is_authenticated, :get,  :pending)

# prov_events
add_restriction("prov_events", "ALL", :can_edit_event_prov_form, :get,    :pending)
add_restriction("prov_events", "ALL", :can_edit_event_prov_form, :put,    :pending)
add_restriction("prov_events", "ALL", :can_edit_event_prov_form, :delete, :pending)
add_restriction("prov_events", "ALL", :can_edit_event_prov_form, :get,    :approved)
add_restriction("prov_events", "ALL", :can_edit_event_prov_form, :put,    :approved)
add_restriction("prov_events", "ALL", :can_edit_event_prov_form, :delete, :approved)
add_restriction("prov_events", "ALL", :can_edit_event_prov_form, :get,    :masked)
add_restriction("prov_events", "ALL", :can_edit_event_prov_form, :put,    :masked)
add_restriction("prov_events", "ALL", :can_edit_event_prov_form, :delete, :masked)
add_restriction("prov_events", "ALL", :can_edit_event_prov_form, :get,    :withdrawn)
add_restriction("prov_events", "ALL", :can_edit_event_prov_form, :put,    :withdrawn)
add_restriction("prov_events", "ALL", :can_edit_event_prov_form, :delete, :withdrawn)
add_restriction("prov_events", "ALL", :can_edit_event_prov_form, :get,    :published)
add_restriction("prov_events", "ALL", :can_edit_event_prov_form, :put,    :published)
add_restriction("prov_events", "ALL", :can_edit_event_prov_form, :delete, :published)

add_restriction("prov_events", "new",                  :is_authenticated, :get,  :pending)
add_restriction("prov_events", "new",                  :is_authenticated, :post, :pending)
add_restriction("prov_events", "create",               :is_authenticated, :get,  :pending)
add_restriction("prov_events", "create",               :is_authenticated, :post, :pending)
add_restriction("prov_events", "show_confirmation",    :is_authenticated, :get,  :pending)

# prov_feedbacks
add_restriction("prov_feedbacks", "ALL", :can_edit_feedback_prov_form, :get,    :pending)
add_restriction("prov_feedbacks", "ALL", :can_edit_feedback_prov_form, :put,    :pending)
add_restriction("prov_feedbacks", "ALL", :can_edit_feedback_prov_form, :delete, :pending)
add_restriction("prov_feedbacks", "ALL", :can_edit_feedback_prov_form, :get,    :approved)
add_restriction("prov_feedbacks", "ALL", :can_edit_feedback_prov_form, :put,    :approved)
add_restriction("prov_feedbacks", "ALL", :can_edit_feedback_prov_form, :delete, :approved)
add_restriction("prov_feedbacks", "ALL", :can_edit_feedback_prov_form, :get,    :masked)
add_restriction("prov_feedbacks", "ALL", :can_edit_feedback_prov_form, :put,    :masked)
add_restriction("prov_feedbacks", "ALL", :can_edit_feedback_prov_form, :delete, :masked)
add_restriction("prov_feedbacks", "ALL", :can_edit_feedback_prov_form, :get,    :withdrawn)
add_restriction("prov_feedbacks", "ALL", :can_edit_feedback_prov_form, :put,    :withdrawn)
add_restriction("prov_feedbacks", "ALL", :can_edit_feedback_prov_form, :delete, :withdrawn)
add_restriction("prov_feedbacks", "ALL", :can_edit_feedback_prov_form, :get,    :published)
add_restriction("prov_feedbacks", "ALL", :can_edit_feedback_prov_form, :put,    :published)
add_restriction("prov_feedbacks", "ALL", :can_edit_feedback_prov_form, :delete, :published)

add_restriction("prov_feedbacks", "new",               :can_view_public, :get,  :pending)
add_restriction("prov_feedbacks", "new",               :can_view_public, :post, :pending)
add_restriction("prov_feedbacks", "create",            :can_view_public, :get,  :pending)
add_restriction("prov_feedbacks", "create",            :can_view_public, :post, :pending)
add_restriction("prov_feedbacks", "show_confirmation", :can_view_public, :get,  :pending)

# prov_work_updates
add_restriction("prov_work_updates", "ALL", :can_edit_work_update_prov_form, :get,    :pending)
add_restriction("prov_work_updates", "ALL", :can_edit_work_update_prov_form, :put,    :pending)
add_restriction("prov_work_updates", "ALL", :can_edit_work_update_prov_form, :delete, :pending)
add_restriction("prov_work_updates", "ALL", :can_edit_work_update_prov_form, :get,    :approved)
add_restriction("prov_work_updates", "ALL", :can_edit_work_update_prov_form, :put,    :approved)
add_restriction("prov_work_updates", "ALL", :can_edit_work_update_prov_form, :delete, :approved)
add_restriction("prov_work_updates", "ALL", :can_edit_work_update_prov_form, :get,    :masked)
add_restriction("prov_work_updates", "ALL", :can_edit_work_update_prov_form, :put,    :masked)
add_restriction("prov_work_updates", "ALL", :can_edit_work_update_prov_form, :delete, :masked)
add_restriction("prov_work_updates", "ALL", :can_edit_work_update_prov_form, :get,    :withdrawn)
add_restriction("prov_work_updates", "ALL", :can_edit_work_update_prov_form, :put,    :withdrawn)
add_restriction("prov_work_updates", "ALL", :can_edit_work_update_prov_form, :delete, :withdrawn)
add_restriction("prov_work_updates", "ALL", :can_edit_work_update_prov_form, :get,    :published)
add_restriction("prov_work_updates", "ALL", :can_edit_work_update_prov_form, :put,    :published)
add_restriction("prov_work_updates", "ALL", :can_edit_work_update_prov_form, :delete, :published)

add_restriction("prov_work_updates", "new",               :is_authenticated, :get,  :pending)
add_restriction("prov_work_updates", "new",               :is_authenticated, :post, :pending)
add_restriction("prov_work_updates", "create",            :is_authenticated, :get,  :pending)
add_restriction("prov_work_updates", "create",            :is_authenticated, :post, :pending)
add_restriction("prov_work_updates", "show_confirmation", :is_authenticated, :get,  :pending)

# prov_products
add_restriction("prov_products", "ALL", :can_edit_product_prov_form, :get,    :pending)
add_restriction("prov_products", "ALL", :can_edit_product_prov_form, :put,    :pending)
add_restriction("prov_products", "ALL", :can_edit_product_prov_form, :delete, :pending)
add_restriction("prov_products", "ALL", :can_edit_product_prov_form, :get,    :approved)
add_restriction("prov_products", "ALL", :can_edit_product_prov_form, :put,    :approved)
add_restriction("prov_products", "ALL", :can_edit_product_prov_form, :delete, :approved)
add_restriction("prov_products", "ALL", :can_edit_product_prov_form, :get,    :masked)
add_restriction("prov_products", "ALL", :can_edit_product_prov_form, :put,    :masked)
add_restriction("prov_products", "ALL", :can_edit_product_prov_form, :delete, :masked)
add_restriction("prov_products", "ALL", :can_edit_product_prov_form, :get,    :withdrawn)
add_restriction("prov_products", "ALL", :can_edit_product_prov_form, :put,    :withdrawn)
add_restriction("prov_products", "ALL", :can_edit_product_prov_form, :delete, :withdrawn)
add_restriction("prov_products", "ALL", :can_edit_product_prov_form, :get,    :published)
add_restriction("prov_products", "ALL", :can_edit_product_prov_form, :put,    :published)
add_restriction("prov_products", "ALL", :can_edit_product_prov_form, :delete, :published)

add_restriction("prov_products", "new",                  :is_authenticated, :get,  :pending)
add_restriction("prov_products", "new",                  :is_authenticated, :post, :pending)
add_restriction("prov_products", "create",               :is_authenticated, :get,  :pending)
add_restriction("prov_products", "create",               :is_authenticated, :post, :pending)
add_restriction("prov_products", "show_confirmation",    :is_authenticated, :get,  :pending)

# prov_bids
add_restriction("prov_bids", "ALL", :can_edit_bid_prov_form, :get,    :pending)
add_restriction("prov_bids", "ALL", :can_edit_bid_prov_form, :put,    :pending)
add_restriction("prov_bids", "ALL", :can_edit_bid_prov_form, :delete, :pending)
add_restriction("prov_bids", "ALL", :can_edit_bid_prov_form, :get,    :approved)
add_restriction("prov_bids", "ALL", :can_edit_bid_prov_form, :put,    :approved)
add_restriction("prov_bids", "ALL", :can_edit_bid_prov_form, :delete, :approved)
add_restriction("prov_bids", "ALL", :can_edit_bid_prov_form, :get,    :masked)
add_restriction("prov_bids", "ALL", :can_edit_bid_prov_form, :put,    :masked)
add_restriction("prov_bids", "ALL", :can_edit_bid_prov_form, :delete, :masked)
add_restriction("prov_bids", "ALL", :can_edit_bid_prov_form, :get,    :withdrawn)
add_restriction("prov_bids", "ALL", :can_edit_bid_prov_form, :put,    :withdrawn)
add_restriction("prov_bids", "ALL", :can_edit_bid_prov_form, :delete, :withdrawn)
add_restriction("prov_bids", "ALL", :can_edit_bid_prov_form, :get,    :published)
add_restriction("prov_bids", "ALL", :can_edit_bid_prov_form, :put,    :published)
add_restriction("prov_bids", "ALL", :can_edit_bid_prov_form, :delete, :published)

add_restriction("prov_bids", "new",               :can_view_public, :get,  :pending)
add_restriction("prov_bids", "new",               :can_view_public, :post, :pending)
add_restriction("prov_bids", "create",            :can_view_public, :get,  :pending)
add_restriction("prov_bids", "create",            :can_view_public, :post, :pending)
add_restriction("prov_bids", "show_confirmation", :can_view_public, :get,  :pending)

# logins
add_restriction("logins", "newest_first", :can_edit_login, :get)
add_restriction("logins", "newest_first", :can_edit_login, :post)

add_restriction("logins", "show", :can_edit_login, :get)
add_restriction("logins", "show", :can_edit_login, :post)

add_restriction("logins", "find", :can_edit_login, :get)
add_restriction("logins", "find", :can_edit_login, :post)

add_restriction("logins", "new", :can_edit_login, :get)
add_restriction("logins", "new", :can_edit_login, :post)

add_restriction("logins", "create", :can_edit_login, :get)
add_restriction("logins", "create", :can_edit_login, :post)

add_restriction("logins", "edit", :can_edit_login, :get)
add_restriction("logins", "edit", :can_edit_login, :post)

add_restriction("logins", "prepare_edit", :can_edit_login, :get)
add_restriction("logins", "prepare_edit", :can_edit_login, :post)

add_restriction("logins", "update", :can_edit_login, :get)
add_restriction("logins", "update", :can_edit_login, :post)

add_restriction("logins", "addMemberType", :can_edit_login, :get)
add_restriction("logins", "addMemberType", :can_edit_login, :post)

add_restriction("logins", "removeMemberType", :can_edit_login, :get)
add_restriction("logins", "removeMemberType", :can_edit_login, :post)

add_restriction("logins", "membershipPaid", :can_edit_login, :get)
add_restriction("logins", "membershipPaid", :can_edit_login, :post)

add_restriction("logins", "removeMembership", :can_edit_login, :get)
add_restriction("logins", "removeMembership", :can_edit_login, :post)

add_restriction("logins", "extendLoan", :can_edit_borrowed_item, :get)
add_restriction("logins", "extendLoan", :can_edit_borrowed_item, :post)

add_restriction("logins", "markDue", :can_edit_borrowed_item, :get)
add_restriction("logins", "markDue", :can_edit_borrowed_item, :post)

add_restriction("logins", "markReturned", :can_edit_borrowed_item, :get)
add_restriction("logins", "markReturned", :can_edit_borrowed_item, :post)

add_restriction("logins", "sendReminder", :can_edit_borrowed_item, :get)
add_restriction("logins", "sendReminder", :can_edit_borrowed_item, :post)

add_restriction("logins", "web_user_address_details", :is_authenticated, :get)
add_restriction("logins", "web_user_address_details", :is_authenticated, :post)

add_restriction("logins", "update_web_user_address_details", :is_authenticated, :get)
add_restriction("logins", "update_web_user_address_details", :is_authenticated, :post)

# memberships
add_restriction("memberships", "ALL", :can_edit_login, :get)
add_restriction("memberships", "ALL", :can_edit_login, :post)

# saved_searches
add_restriction("saved_searches", "save_search_from_form", :can_save_search, :post)
add_restriction("saved_searches", "save_search_from_form", :can_save_search, :get)

add_restriction("saved_searches", "do_search", :can_save_search, :post)
add_restriction("saved_searches", "do_search", :can_save_search, :get)

add_restriction("saved_searches", "delete_search_ajax", :can_save_search, :post)
add_restriction("saved_searches", "delete_search_ajax", :can_save_search, :get)

# attachment
add_restriction("attachment", "ALL", :can_edit_tap, :post)
add_restriction("attachment", "ALL", :can_edit_tap, :get)

add_restriction("attachment", "ALL", :can_edit_crm, :post)
add_restriction("attachment", "ALL", :can_edit_crm, :get)

add_restriction("attachment", "ALL", :can_edit_content, :post)
add_restriction("attachment", "ALL", :can_edit_content, :get)

add_restriction("attachment", "ALL", :can_edit_project, :post)
add_restriction("attachment", "ALL", :can_edit_project, :get)

# image_mce_attachments
add_restriction("image_mce_attachments", "ALL", :can_edit_content, :post)
add_restriction("image_mce_attachments", "ALL", :can_edit_content, :get)

add_restriction("image_mce_attachments", "ALL", :can_edit_project, :post)
add_restriction("image_mce_attachments", "ALL", :can_edit_project, :get)

# association
add_restriction("association", "ALL", :can_edit_tap, :post)
add_restriction("association", "ALL", :can_edit_tap, :get)

add_restriction("association", "ALL", :can_edit_event, :post)
add_restriction("association", "ALL", :can_edit_event, :get)

# duration_as_interval
add_restriction("duration_as_interval", "ALL", :can_edit_tap, :get)
add_restriction("duration_as_interval", "ALL", :can_edit_tap, :post)

add_restriction("duration_as_interval", "ALL", :can_publish_tap, :get)
add_restriction("duration_as_interval", "ALL", :can_publish_tap, :post)

# role_categorizations
add_restriction("role_categorizations", "add_categorization", :can_edit_crm, :post)
add_restriction("role_categorizations", "add_categorization", :can_edit_crm, :get)

add_restriction("role_categorizations", "marketing_category_change", :can_edit_crm, :post)
add_restriction("role_categorizations", "marketing_category_change", :can_edit_crm, :get)

add_restriction("role_categorizations", "destroy_categorization_for_role", :can_edit_crm, :post)
add_restriction("role_categorizations", "destroy_categorization_for_role", :can_edit_crm, :get)

# hard_association
add_restriction("hard_association", "ALL", :can_edit_tap, :get)
add_restriction("hard_association", "ALL", :can_edit_tap, :post)

# password
add_restriction("password", "ALL",            :can_view_public, :get)
add_restriction("password", "request_change", :can_view_public, :post)
add_restriction("password", "update",         :can_view_public, :post)

# loan_item
add_restriction("loan_item", "ALL", :can_edit_borrowed_item, :get)
add_restriction("loan_item", "ALL", :can_edit_borrowed_item, :post)

# hire_item
add_restriction("hire_item", "ALL", :can_edit_borrowed_item, :get)
add_restriction("hire_item", "ALL", :can_edit_borrowed_item, :post)

# rss_feeds
add_restriction("rss_feeds", "ALL", :can_view_public, :get)
add_restriction("rss_feeds", "ALL", :can_view_public, :post)
#add_restriction("contributors", "show", :can_view_public, :get, :published)
#add_restriction("works", "show", :can_view_public, :get, :published)
#add_restriction("works", "show", :can_view_public, :get, :published)

# moneyworks_data_checker
add_restriction("moneyworks_data_checker", "ALL", :can_edit_tap, :get)
add_restriction("moneyworks_data_checker", "ALL", :can_edit_tap, :post)

add_restriction("moneyworks_data_checker", "ALL", :can_publish_tap, :get)
add_restriction("moneyworks_data_checker", "ALL", :can_publish_tap, :post)

# failed_orders_controller
add_restriction("failed_orders_controller", "ALL", :can_edit_sales_history, :get)
add_restriction("failed_orders_controller", "ALL", :can_edit_sales_history, :post)

puts "commit;"