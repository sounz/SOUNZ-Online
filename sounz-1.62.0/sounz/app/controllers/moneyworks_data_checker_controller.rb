require 'application_helper'
require 'fastercsv'

class MoneyworksDataCheckerController < ApplicationController

	def index
	  flash[:error] = nil
	end
	
	# Checks the fields of the file uploaded to /tmp/
	# against the data in SOUNZ db
	# Fields in the file should correspond to the following (the same order):
	# - mw_code (moneyworks code)
	# - title
	# - freight_code
	# - item_cost
	# Streams the results of the check in csv format
	def run_check
	 	  
	  flash[:error] = nil
	  
	  file = params['file']
	    
	  if !file.blank?
	    
        begin
	  	  
		  file_lines = FasterCSV.parse(file)
	      
		  # reading moneyworks file output
	      #file_lines = file.read.split(/\r?\n|\r(?!\n)/)
		
	      # remove column headings if any
		  column_headings = params[:upload_file][:column_headings]
	      file_lines.shift if column_headings == "1"
	  
          # hash with the mw_code as a key
		  objectHash = Hash.new
	    
		  # hash with the object title as a key, needed when there is no mw_code in SOUNZ online data  
		  objectTitleHash = Hash.new
	  
          # query SOUNZ online data
		  manifestation_data = ActiveRecord::Base.connection.execute("SELECT mw_code, manifestation_id AS id, manifestation_title AS title, freight_code, item_cost FROM manifestations")
	      resource_data      = ActiveRecord::Base.connection.execute("SELECT mw_code, resource_id AS id, resource_title AS title, freight_code, item_cost FROM resources")	
	  
	      # manifestations
	      for m in manifestation_data
		    if ! m['mw_code'].blank?
		      # object type
			  m['type'] = 'MANIFESTATION'
		  
    		  objectHash[m['mw_code']] = m
		    end
		  
		    objectTitleHash[m['title'].downcase] = m

	      end
	  
	      # resources
	      for r in resource_data
		    if ! r['mw_code'].blank?
		      # object type
			  r['type'] = 'RESOURCE'
		  
              objectHash[r['mw_code']] = r
		     end
		 
		     objectTitleHash[r['title'].downcase] = r
		 
	      end

		  # array for file fields
          fields = Array.new
	
	      stream_csv do |csv|
	        csv << [
			  	"FLAG",
				"MATCHED",
				"OBJECT_TYPE",
 				"OBJECT_ID",			
				"MW_CODE_FILE",
				"MW_CODE_DB",
				"FREIGHT_CODE_FILE",
				"FREIGHT_CODE_DB",
				"ITEM_COST_FILE",
				"ITEM_COST_DB",
				"OBJECT_TITLE_FILE",
				"OBJECT_TITLE_DB"
			        ]	
	
		   # going through moneyworks file output
           file_lines.each {|columns|	
	     
             #fields = columns.split(/(?=(?:[^\"]*\"[^\"]*\")*(?![^\"]*\"))/m)
		     fields  = columns
		     flag               = "NONE"
		     matched            = "UNMATCHED"
		 
		     mw_code_file       = fields[0]
		     object_title_file  = fields[1]
		     freight_code_file  = fields[2]
		     item_cost_file     = fields[3]
		 
		     object_type        = nil
		     object_id          = nil
		     mw_code_db         = nil
		     object_title_db    = nil
		     freight_code_db    = nil
		     item_cost_db       = nil		  		  
		
             # matched by moneyworks code or title
		     if ! objectHash[mw_code_file].blank? || ! objectTitleHash[object_title_file].blank?
			  
			    if ! objectHash[mw_code_file].blank?
			  	
				  matched    = "MATCHED_BY_MW_CODE"
				  objectData = objectHash[mw_code_file]
			  
			    elsif ! objectTitleHash[object_title_file].blank?
			  	
			  	  matched    = "MATCHED_BY_TITLE"
				  objectData = objectTitleHash[object_title_file.downcase]
				
			    end		  	  
		  
			    object_type        = objectData['type']
			    object_id          = objectData['id']
			    mw_code_db         = objectData['mw_code']
			    object_title_db    = objectData['title']
			    freight_code_db    = objectData['freight_code']
			    item_cost_db       = objectData['item_cost']  
				
			    flag = "PRICE" if item_cost_file.to_f != item_cost_db.to_f
			  
			    if freight_code_file.to_i != freight_code_db.to_i
				
			  	  if flag != 'NONE'    
			        flag += " | FREIGHT"
				  else	
				    flag="FREIGHT"
				  end
			  
			    end
		  	  
		  	  end
			

			  csv << [
					flag,
					matched,
					object_type,
					object_id,			
					mw_code_file,
					mw_code_db,
					freight_code_file,
					freight_code_db,
					item_cost_file,
					item_cost_db,
					object_title_file,
					object_title_db
				     ]		  
				   
		  }

    	  end	# end stream_csv
        
		rescue FasterCSV::MalformedCSVError
			flash[:error] = "There was an error parsing your file. Please make sure it is in csv format"
		end
	  
	  else
	   	flash[:error] = "No file to check"
	  end

	end
	
	private
	
	# -----------------------------------------------------------
	# - Send csv formatted output directly to the HTTP response -
	# -----------------------------------------------------------
	def stream_csv
	   
	   now   = Time.now.strftime("%Y%m%d_%H:%M")
	   
	   filename = "moneyworks_data_check_results_" + now.to_s + ".csv"
  
	   #this is required if you want this to work with IE        
	   if request.env['HTTP_USER_AGENT'] =~ /msie/i
		 headers['Pragma'] = 'public'
		 headers["Content-type"] = "text/plain" 
		 headers['Cache-Control'] = 'no-cache, must-revalidate, post-check=0, pre-check=0'
		 headers['Content-Disposition'] = "attachment; filename=\"#{filename}\"" 
		 headers['Expires'] = "0" 
	   else
		 headers["Content-Type"] ||= 'text/csv'
		 headers["Content-Disposition"] = "attachment; filename=\"#{filename}\"" 
	   end
  
	  render :text => Proc.new { |response, output|
		csv = FasterCSV.new(output, :row_sep => "\r\n") 
		yield csv
	  }
	end
		
end	