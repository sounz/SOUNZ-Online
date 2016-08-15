require 'fileutils'

def install(file)
  puts "Installing: #{file}"
  target = File.join(File.dirname(__FILE__), '..', '..', '..', file)
  FileUtils.cp File.join(File.dirname(__FILE__), file), target
  FileUtils.mv File.dirname(__FILE__) + '/../trunk', File.dirname(__FILE__) + '/../acts_as_solr'
end

install File.join( 'config', 'solr.yml' )