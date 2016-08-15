#!/usr/bin/env ../sounz/script/runner
require 'net/http'
require 'uri'

result = "0"
@error_message="NONE"

#Firstly check database - use Time.now to guarantee forcing a new query
begin
  status = Status.find(:first, 
  :conditions => ["status_id < ?",Time.now.to_i])
rescue
  @error_message = "ActiveRecord db not responding"
    result = "2"
end

begin
  #Execute a query against SOLR
  n_penguin_works_solr = Status.count_by_solr("Published")
rescue
  @error_message = "SOLR not responding"
    result = "2"
end

begin
  
  for port in ARGV
  #  puts port
    res = Net::HTTP.start("localhost", port.to_s) {|http|
      http.get('/')
    }
    http_code = res['status']
 #   puts "HTTPCOD:#{http_code}"
    raise ArgumentException("Mongrel server returned non-200") if http_code != "200 OK" 
  end
  
rescue Exception => e
  #puts "#{e.class}: #{e.message}\n\t#{e.backtrace.join("\n\t")}"
  @error_message = "Mongrel servers not responding"
  result = "2"
end
puts "OK: SOUNZ Healthcheck good" if result.to_i == 0
puts "CRITICAL: "+@error_message if result.to_i == 2

#puts "RESULT:#{result}"
  


exit(result.to_i)