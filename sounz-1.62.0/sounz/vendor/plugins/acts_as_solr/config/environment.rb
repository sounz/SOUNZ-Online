ENV['RAILS_ENV'] = "development" if ENV['RAILS_ENV'].nil?
DB = (ENV['DB'] ? ENV['DB'] : 'mysql') unless defined? DB
MYSQL_USER = (ENV['MYSQL_USER'].nil? ? 'root' : ENV['MYSQL_USER']) unless defined? MYSQL_USER
#%x(mysql -u#{MYSQL_USER} < #{File.dirname(__FILE__) + "/../test/fixtures/db_definitions/mysql.sql"}) if DB == 'mysql'

require File.join(File.dirname(File.expand_path(__FILE__)), '..', 'test', 'db', 'connections', DB, 'connection.rb')
SOLR_PATH = "#{File.dirname(File.expand_path(__FILE__))}/../test/solr" unless defined? SOLR_PATH

unless defined? SOLR_PORT
  SOLR_PORT = case ENV['RAILS_ENV']
              when 'test' then 8981
              when 'production' then 8983
              else 8982
              end
end
