require 'rubygems'
require 'test/unit'
require 'active_record/fixtures'
require File.dirname(__FILE__) + '/../lib/acts_as_solr'
require File.join(File.dirname(__FILE__), 'connections', "mysql", 'connection.rb')

# Load Models
models_dir = File.join(File.dirname( __FILE__ ), 'models')
Dir[ models_dir + '/*.rb'].each { |m| require m }

Test::Unit::TestCase.fixture_path = File.dirname(__FILE__) + "/fixtures/"
$LOAD_PATH.unshift(Test::Unit::TestCase.fixture_path)

class Test::Unit::TestCase #:nodoc:
  def self.fixtures(*table_names)
    if block_given?
      Fixtures.create_fixtures(Test::Unit::TestCase.fixture_path, table_names) { yield }
    else
      Fixtures.create_fixtures(Test::Unit::TestCase.fixture_path, table_names)
    end
    table_names.each do |t|
      klass = instance_eval t.capitalize.singularize
      klass.find(:all).each{|content| content.solr_save}
    end    
  end
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures = false  
end

module ActsAsSolr
  class Post  
    def execute_post
      begin
        url = URI.parse("http://localhost:8989")
        post = Net::HTTP::Post.new(@mode == :search ? "/solr/select" : "/solr/update")
        post.body = @body
        post.content_type = 'application/x-www-form-urlencoded'
        response = Net::HTTP.start(url.host, url.port) do |http|
          http.request(post)
        end
        return response.body    
      rescue 
        raise "Couldn't connect to the Solr server on localhost:8989"
        false
      end
    end
  end
end