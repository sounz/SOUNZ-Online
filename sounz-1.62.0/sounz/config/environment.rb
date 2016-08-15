# Be sure to restart your web server when you modify this file.

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

# regex for durations
DURATION_REGEX = /^(\d)*\d:[0-5]\d:[0-5]\d$/i

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here

  # Skip frameworks you're not going to use (only works if using vendor/rails)
  # config.frameworks -= [ :action_web_service, :action_mailer ]

  # Only load the plugins named here, by default all plugins in vendor/plugins are loaded
  # config.plugins = %W( exception_notification ssl_requirement )

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Force all environments to use the same logger level
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Use the database for sessions instead of the file system
  # (create the session table with 'rake db:sessions:create')
  # config.action_controller.session_store = :active_record_store

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector

  # Make Active Record use UTC-base instead of local time
  # config.active_record.default_timezone = :utc

  # See Rails::Configuration for more options
  config.active_record.observers = [ :frbr_observer ]
  config.action_controller.session_store = :p_store
end

# Add new inflection rules using the following format
# (all these examples are active by default):
Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
  inflect.uncountable %w( contributor_people )
end

# Add date formats
ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(
  :default => '%d %b %Y',
  :date_time => "%d/%m/%Y %H:%M%:%S"
)

# Time
ActiveSupport::CoreExtensions::Time::Calculations

# Global email settings
#ActionMailer::Base.delivery_method = :smtp
#ActionMailer::Base.raise_delivery_errors = true
#ActionMailer::Base.default_charset = "utf-8"
#ActionMailer::Base.smtp_settings = {
#  :address        => "smtp.catalyst.net.nz",
#  :port           => 25,
#  :domain         => 'catalyst.net.nz',
#  :user_name      => nil,
#  :password       => nil,
#  :authentication => nil
#}


# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
# Mime::Type.register "application/x-mobile", :mobile

# Include your application configuration below

#This is the listings within the composers/perfomers stuff
LISTING_PAGE_SIZE = 10

# The length of summaries
SUMMARY_LENGTH = 200

#Load these constants once only at server start time
rr_types = {}

rr_types = {}
rts = RelationshipType.find(:all, :order => :relationship_type_desc)
for rt in rts
    d = rt.relationship_type_desc
    d.downcase!
    d.gsub!(' ','_')
    d.gsub!('(', '')
    d.gsub!(')', '')
    d.strip!
   # puts d
    rr_types[d.to_sym] = rt
end

REL_TYPES_CACHED = rr_types

etypes = {}
rts = EntityType.find(:all, :order => :entity_type)
for rt in rts
    d = rt.entity_type
    d.downcase!
    d.gsub!(' ','_')
    d.gsub!('(', '')
    d.gsub!(')', '')
    d.strip!

    etypes[d.to_sym] = rt
end

ENTITY_TYPES_CACHED = etypes




YAML.add_domain_type("ActiveRecord,2007", "") do |type, val|
  klass = type.split(':').last.constantize
  YAML.object_maker(klass, val)
end

#YAML.add_domain_type("sounz.org,2007", "") do |type, val|
#  klass = type.split(':').last.constantize
#  YAML.object_maker(klass, val)
#end


class ActiveRecord::Base
  def to_yaml_type
    "!ActiveRecord,2007/#{self.class}"
  end


  def to_yaml_properties
    ['@attributes']
  end
end


class String
    def prefixes(delimiter='/')
        segments = split(delimiter)
        result=(1..segments.length).collect { |i| segments[0..-i].join(delimiter) }
        Work.logger.debug("PREFIXES RESULT: #{result}")
        result
        end
    def suffixes(delimiter='/')
        segments = split(delimiter)
        (1..segments.length).collect { |i| segments[(i-1)..-1].join(delimiter) }
        end
    end

class ExternalCookieJar
    def initialize
        @jar = {}
        end


    def parse_cookie_from(uri,s)
        Work.logger.debug("ZENCART PARSING COOKIES FROM:"+uri.to_s+" : "+s.to_s )
        return unless s.is_a? String and s.length > 2
        cookies = s.gsub(/, ([^\d])/,';;\1').split(';;')
        cookies.each { |cookie|
            name_value,*options = cookie.split(';')
            name,value = name_value.split('=')
            Work.logger.debug("ZENCART COOKIE NAME: #{name} VALUE: #{value}")
            acceptable_protocols,domain,path,expires = ['http','https'],uri.host,uri.path,nil
            options.each { |option| case option
                when /expires=.+?, (..-...-.. ..:..:..(..)? GMT)/
                    expires = DateTime.parse($1,:guess_year)
                when /path=(.*)/
                    path = $1
                when /domain=(.*)/
                    domain = $1
                when /secure/
                    acceptable_protocols = ['https']
                end}

            currentEntries=((@jar[domain] ||= {})[path] ||= [])
            currentEntries.delete_if{|key, val|
            Work.logger.debug("ZENCART ARRRGH #{key} #{value[0]}")
            key.to_s==name.to_s }
            Work.logger.debug("ZENCART DOUBLE ARRGH: #{name} #{value}")
            ((@jar[domain] ||= {})[path] ||= []) << [name,value,expires, acceptable_protocols]
            Work.logger.debug("ZENCART COOKIE SAVED: #{domain} #{path} #{@jar[domain][path]}")
            }
        end

    def cookies_for(uri)
        result = {}
        if uri.host.blank?
          uri.host='127.0.0.1'
        end
        uri.host.suffixes('.').each { |domain|
            Work.logger.debug("ZENCART PROCESSING DOMAIN: #{domain}")
            myPaths=uri.path.prefixes+["/"]
            myPaths.each { |path|
                Work.logger.debug("ZENCART PROCESSING PATH: #{path}")
                @jar[domain][path].each { |name,value,expires,acceptable_protocols|
                    Work.logger.debug("ZENCART PROCESSING COOKIE: #{name},#{value}")
                    (result[name] ||= []) << value if acceptable_protocols.include? uri.scheme
                    #cookies[result[name]]=value if acceptable_protocols.include? uri.scheme
                    } if @jar[domain].has_key? path
                } if @jar.has_key? domain
            }

    def result.to_s
            keys.collect { |name|
                self[name].collect { |value| "#{name}=#{value}" }
                }.flatten.join(';')
            end
        Work.logger.debug("ZENCART COOKIES_FOR URI:" +uri.to_s + "RESULT: "+result.to_s)
        result
        end
    end




