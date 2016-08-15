# This is taken from http://mail-archives.apache.org/mod_mbox/lucene-solr-user/200609.mbox/%3C3DAA5B2D-5737-4168-B919-03D11B76A235@mintsource.org%3E


require "#{File.dirname(__FILE__)}/../../../vendor/plugins/acts_as_solr/lib/acts_as_solr.rb"





		module ActsAsSolr #:nodoc:

			module InstanceMethods #:nodoc:

				def solr_save #:nodoc:
                 puts "SOLR SAVE MOCKED OUT"
				end
				
				def solr_destroy #:nodoc:
puts "SOLR DESTROY MOCKED OUT"
				end
				
				
			
				
			end
			


	end#module Acts

