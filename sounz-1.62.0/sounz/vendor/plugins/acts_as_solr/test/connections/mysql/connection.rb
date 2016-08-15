print "Using native MySQL\n"

require 'logger'
ActiveRecord::Base.logger = Logger.new("debug.log")

ActiveRecord::Base.establish_connection(
  :adapter  => "mysql",
  :username => "root",
  :encoding => "utf8",
  :database => "actsassolr_tests"
)

