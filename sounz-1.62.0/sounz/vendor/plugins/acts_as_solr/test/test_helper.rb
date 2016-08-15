require 'rubygems'
require 'test/unit'
require 'active_record'
require 'active_record/fixtures'
require File.dirname(__FILE__) + '/../lib/acts_as_solr'
require File.dirname(__FILE__) + '/../config/environment.rb'

# Load Models
models_dir = File.join(File.dirname( __FILE__ ), 'models')
Dir[ models_dir + '/*.rb'].each { |m| require m }

Test::Unit::TestCase.fixture_path = File.dirname(__FILE__) + "/fixtures/"

class Test::Unit::TestCase
  def self.fixtures(*table_names)
    if block_given?
      Fixtures.create_fixtures(Test::Unit::TestCase.fixture_path, table_names) { yield }
    else
      Fixtures.create_fixtures(Test::Unit::TestCase.fixture_path, table_names)
    end
    table_names.each do |table_name|
      clear_from_solr(table_name)
      klass = instance_eval table_name.to_s.capitalize.singularize
      klass.find(:all).each{|content| content.solr_save}
    end
  end
  
  private
  def self.clear_from_solr(table_name)
    query = "type_t:#{table_name.to_s.capitalize.singularize}"
    response = ActsAsSolr::Post.execute("wt=ruby&rows=100000&q=#{ERB::Util::url_encode(query)}")
    response = response ? eval(response) : []
    response['response']['docs'].each do |doc|
      ActsAsSolr::Post.execute("<delete><id>#{doc["id"]}</id></delete>", :update)
    end
  end
end

module ActsAsSolr
  class Post  
    def self.execute(body, mode = :search)
      begin
        url = URI.parse("http://localhost:#{SOLR_PORT}")
        post = Net::HTTP::Post.new(mode == :search ? "/solr/select" : "/solr/update")
        post.body = body
        post.content_type = 'application/x-www-form-urlencoded; charset=utf-8'
        response = Net::HTTP.start(url.host, url.port) do |http|
          http.request(post)
        end
        return response.body    
      rescue 
        raise "Couldn't connect to the Solr server on localhost:#{SOLR_PORT}"
        false
      end
    end
  end
end
