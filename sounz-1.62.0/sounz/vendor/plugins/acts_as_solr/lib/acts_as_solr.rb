# Copyright (c) 2006 Erik Hatcher, Thiago Jackiw
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

require 'active_record'
require 'rexml/document'
require 'net/http'
require 'yaml'

require File.dirname(__FILE__) + '/acts_methods'
require File.dirname(__FILE__) + '/class_methods'
require File.dirname(__FILE__) + '/instance_methods'
require File.dirname(__FILE__) + '/background_methods'
require File.dirname(__FILE__) + '/common_methods'
require File.dirname(__FILE__) + '/deprecation'

module ActsAsSolr

  class Post
    def self.execute(body, mode = :search)
      begin
        if File.exists?(RAILS_ROOT+'/config/solr.yml')
          config = YAML::load_file(RAILS_ROOT+'/config/solr.yml')
          server = config[RAILS_ENV]['host']
          port = config[RAILS_ENV]['port']
          servlet_path = config[RAILS_ENV]['servlet_path']
        else
          server = 'localhost'
          port   = 8982
          servlet_path = 'solr'
        end
        url = URI.parse("http://#{server}:#{port}")
        post = Net::HTTP::Post.new(mode == :search ? "/#{servlet_path}/select" : "/#{servlet_path}/update?commit=true")
        post.body = body
        post.content_type = mode == :search ? 'application/x-www-form-urlencoded; charset=utf-8' : 'text/xml'

        response = Net::HTTP.start(url.host, url.port) do |http|
          http.request(post)
        end

        if response.class != Net::HTTPOK
          raise "An error occurred whilst posting to SOLR #{post.to_yaml} with response #{response.to_yaml}.  Please check also for a write.lock file if indexing"
        end

        #now check for write lock message in response - this is returned as an http 200 (duh!) by solr
        result =response.body

        if result.include?("java.io.IOException: Lock obtain timed out")
          raise "SOLR is not able to index this document due to a problem obtaining a write permission lock"
        end

        return result
      rescue
        raise "Couldn't connect to the Solr server on #{server}:#{port} located at /#{servlet_path}. #{$!}"
        false
      end
    end
  end

end

# reopen ActiveRecord and include the acts_as_solr method
ActiveRecord::Base.extend ActsAsSolr::ActsMethods
