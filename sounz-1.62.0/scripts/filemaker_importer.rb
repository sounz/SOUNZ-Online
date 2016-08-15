#!/usr/bin/env ../sounz/script/runner

include FinderHelper


def sanitiseQuery (query)
	#strip leading whitespace if first_name is empty
	query.gsub!(/^\s+/,'')
	#strip trailing whitespace if surname is empty
	query.gsub!(/\s+$/,'')
	
	#escape oddball characters
	query.gsub!(/:/,'')
	query.gsub!(/!/,'')
	query.gsub!(/\s+-\s+/,' ')
	
	query.gsub!(/\s+/,' AND ')
	puts "SANITISED QUERY: #{query}"

	return query
end








#This script will open the filemaker export, and update person and organisation contactinfo records to reflect 
#the new details.
counter=0
solrcount=0
file = File.open("marketing_export.tab", "r")
while (line = file.gets)
  fields=line.split(/\t/)
  
  address_1,building_name,first_name,city,cname_nm,contactname_nm,created_at,cross_ref,description,dl_no,dnzmo,donor,email,entry_no,entry_source,fax_code,fax_no,foreign_country,individual,initials,join_date,launch_1,large_org,lucys,membership_contact,membership_expires,mobile,modification_date,newsletter,nomenclature,note,nzmc,oct_launch,unknown,organisation_name,phone_code,phone_no,phys_address_1,phys_city,phys_post_code,unknown2,position,post_code,press_release,province_state,role_sonl,small_org,unknown3,sub_category,suburb,surname,title,website = *fields
  

 # puts fields[0]+":"+fields[1]+":"+fields[2]+":"+fields[3]+"|"
 # puts "#{counter}:#{first_name}:#{surname}:#{address_1}|"
  
  #search for an existing contact with the same first name and surname
  
  

#puts "#{first_name}:#{surname}|"
			#strip whitespace at end
			first_name.gsub!(/\s*$/,'')
			surname.gsub!(/\s*$/,'')
			#strip whitespace at start
			first_name.gsub!(/^\s+/,'')
			surname.gsub!(/^\s+/,'')
			
			
			puts "STRIPPED WHITESPACE: |#{title}|#{first_name}|#{surname}| ORGNAME: #{organisation_name} |LO: #{large_org} SO: #{small_org}"
	findQuery=sanitiseQuery(first_name+" "+surname)
	
	foundOrg=nil
	newOrg=nil
    foundPerson=nil
	people=nil
	
	if findQuery.blank?
		puts "PROBLEM: nothing in firstname or surname fields - record #{counter}"
	else
		people=solr_query("type_t:Person "+findQuery, {})
		puts "QUERY: #{findQuery}"		
		puts "RESULT_COUNT: #{people[0][:docs].length}"
		
		if people[0][:docs].length > 1
			puts "PROBLEM: ambiguous name - record #{counter} (#{findQuery})"
			foundPerson=people[0][:docs].first
		elsif people[0][:docs].length == 1
		foundPerson=people[0][:docs].first
		else
		#do nothing			
		end
		

		if foundPerson != nil
        	puts "FOUND IN SOLR: #{foundPerson.objectData.full_name}"
		
			#now we can update our info
		
		
			#find our physical contactinfo
		
			
			#find our contributor record 
		
			solrcount+=1
		else
			
			#Check if we are an organisation
			puts "ORG NAME: #{organisation_name}"
			if ! organisation_name.blank?
			
				#search solr to see if our org record isn't already in the db
				query=organisation_name.clone
				findQuery=sanitiseQuery(query)
				orgs=solr_query("type_t:Organisation "+findQuery, {})
				puts "QUERY: #{findQuery}"		
				puts "RESULT_COUNT: #{orgs[0][:docs].length}"
		
				if orgs[0][:docs].length > 1
					puts "PROBLEM: ambiguous org name - record #{counter} (#{findQuery})"
					foundOrg=orgs[0][:docs].first
				elsif orgs[0][:docs].length == 1
					foundOrg=orgs[0][:docs].first
				else
					
					#do nothing			
				end
			
				if foundOrg == nil
					#create our organisation record
					puts("CREATING NEW ORGANISATION RECORD")
					newOrg=Organisation.new()
					newOrg.organisation_name=organisation_name
					newOrg.updated_by=1000
					newOrg.status_id=3
					newOrg.updated_at='2007-08-01'
					newOrg.created_at=created_at
					newOrg.save
					#our new organisation needs a role and some contactinfos.

					newRole=Role.new()
					newRole.role_type_id=24 #organisation
			    	newRole.organisation=newOrg
					newRole.updated_by=1000		
					newRole.updated_at='2007-08-01'
					newRole.created_at=created_at
				
					if  newRole.save
						puts "ROLE: #{newOrg.id}"
					else
						puts "ERROR: couldnt save role"
						puts newRole.errors.to_xml
					end	
					
					newOrg.roles << newRole
					
					if foreign_country.blank?
						myCountryId=158
					else
						myCountryId=158
					#TODO: lookup the country id
					end
				
			    
					#physical contactinfo	
					newContactinfo=Contactinfo.new
					newContactinfo.updated_by=1000		
					newContactinfo.updated_at='2007-08-01'
					newContactinfo.created_at=created_at
					newContactinfo.street=phys_address_1
					newContactinfo.locality=phys_city
					newContactinfo.postcode=phys_post_code
					newContactinfo.building=building_name
					newContactinfo.country_id=myCountryId				

					if newContactinfo.save()
						puts "CONTACTINFO: #{newContactinfo.id}"
					else
						puts "ERROR: couldn't save physical contactinfo"
						puts newContactinfo.errors.to_xml
					end
				
					#Create physical address role-link record
					newRoleContactinfo=RoleContactinfo.new()
					newRoleContactinfo.role_id=newRole.id
					newRoleContactinfo.contactinfo_id=newContactinfo.id
					newRoleContactinfo.contactinfo_type='physical'  
					 newRoleContactinfo.preferred=FALSE 
					newRoleContactinfo.save()

				
			

					#figure out region from province_state field?

					#postal contactinfo	
					newContactinfo=Contactinfo.new
					newContactinfo.updated_by=1000		
					newContactinfo.updated_at='2007-08-01'
					newContactinfo.created_at=created_at
					newContactinfo.street=address_1
					newContactinfo.locality=city
					newContactinfo.postcode=post_code
					newContactinfo.suburb=suburb
					newContactinfo.email_1=email
          newContactinfo.country_id=myCountryId
					newContactinfo.phone_prefix=phone_code
					newContactinfo.phone=phone_no	
				  newContactinfo.phone_mobile=mobile
					newContactinfo.phone_fax_prefix=fax_code
					newContactinfo.phone_fax=fax_no
	
					if newContactinfo.save()
						puts "CONTACTINFO: #{newContactinfo.id}"
					else
						puts "ERROR: couldn't save postal contactinfo"
						puts newContactinfo.errors.to_xml
					end
			
					#Create postal address role-link record
					newRoleContactinfo=RoleContactinfo.new()
					newRoleContactinfo.role_id=newRole.id
					newRoleContactinfo.contactinfo_id=newContactinfo.id
					newRoleContactinfo.contactinfo_type='postal' 
					newRoleContactinfo.preferred=TRUE 
          newRoleContactinfo.save()

				
					#billing contactinfo	
					newContactinfo=Contactinfo.new
					newContactinfo.updated_by=1000		
					newContactinfo.updated_at='2007-08-01'
					newContactinfo.created_at=created_at
					newContactinfo.country_id=myCountryId
								

					if newContactinfo.save()
					puts "CONTACTINFO: #{newContactinfo.id}"
					else
					puts "ERROR: couldn't save billing contactinfo"
					puts newContactinfo.errors.to_xml
					end
			
					#create billing address role-link record
					newRoleContactinfo=RoleContactinfo.new()
					newRoleContactinfo.role_id=newRole.id
					newRoleContactinfo.contactinfo_id=newContactinfo.id
					newRoleContactinfo.contactinfo_type='billing'
          newRoleContactinfo.preferred=FALSE 
					newRoleContactinfo.save()
			
					
			
				else
				
				end
			
			else
			# Do nothing

			end	
				#We are a standalone person			
	
				#we can create a new Person, along with some contactinfos 
				#make sure our name matches a reasonable pattern - one word first name, one word second name
			
				puts("CREATING NEW PERSON RECORD")
				#strip known prefixes/suffixes and flag as such
				first_name.gsub!(/Dr.\s+/,'')
				first_name.gsub!(/\./,'')
				surname.gsub!(/, M\.P\./,'')			

				myName="#{first_name} #{surname}"
				if (first_name=~/^\w*$/ or first_name=~/^\w*-\w*$/ ) and surname !~ /,/
					if first_name.length < 2
					first_name+="(abbr.)"
					end
					if surname.length < 2
					surname+="(abbr.)"
					end

					puts "NAME IS FORMED OK: #{myName}"
				
					newPerson=Person::new()
					newPerson.first_names=first_name
					newPerson.last_name=surname
					newPerson.updated_by=1000
					newPerson.status_id=3
				
					#try and figure out gender from the title field
					if title=~/s/
						newPerson.gender="F"
					else
						newPerson.gender="M"
					end
				
					#strip any dots
					nomenString=title.gsub(/\./,'')
					#try and select a nomenation based on the title field. if the nomenation is not present, 
					myNoms=Nomen.find(:all, :conditions => ['nomen = ? or nomen = ?',nomenString,nomenString+"."])
					if myNoms.length < 1
						#we didnt find a suitable nomen. doh.
				
						if newPerson.gender="M"
						#if male, assign Mr.
							newPerson.nomen_id=1
						elsif newPerson.gender="F"
						#if female, assign 'Ms.
							newPerson.nomen_id=5
						else
						#do nothing
						end
				
			
					else
						newPerson.nomen=myNoms.first
					end

				
					newPerson.internal_note="#{cross_ref}\n\n#{description}\n\n#{launch_1}\n\n#{nzmc}\n\n#{sub_category}"
				
					newPerson.updated_at='2007-08-01'
					newPerson.created_at=created_at
				
					if newPerson.save
						puts "PERSON: #{newPerson.id}"
					else
						puts "ERROR: couldnt save person"
						puts newPerson.errors.to_xml
					end
				
					if foundOrg != nil || newOrg != nil
						#
					
						orgRole=Role.new()
						orgRole.role_type_id=25 #default
			    		orgRole.person=newPerson
						if foundOrg != nil
							orgRole.organisation=foundOrg.objectData
						else
							orgRole.organisation=newOrg
						end
						orgRole.updated_by=1000		
						orgRole.updated_at='2007-08-01'
						orgRole.created_at=created_at
				
						if  orgRole.save
							puts "ORGANISATION ROLE: #{orgRole.id}"
						else
							puts "ERROR: couldnt save role"
							puts orgRole.errors.to_xml
						end

						newPerson.roles << orgRole
						
						#create contactinfos for our organisational roles.

						
						#physical contactinfo	
					newContactinfo=Contactinfo.new
					newContactinfo.updated_by=1000		
					newContactinfo.updated_at='2007-08-01'
					newContactinfo.created_at=created_at	

					if newContactinfo.save()
						puts "CONTACTINFO: #{newContactinfo.id}"
					else
						puts "ERROR: couldn't save physical contactinfo"
						puts newContactinfo.errors.to_xml
					end
				
					#Create physical address role-link record
					newRoleContactinfo=RoleContactinfo.new()
					newRoleContactinfo.role_id=orgRole.id
					newRoleContactinfo.contactinfo_id=newContactinfo.id
					newRoleContactinfo.contactinfo_type='physical'  
					newRoleContactinfo.preferred=FALSE  
					newRoleContactinfo.save()

				    #postal contactinfo	
					newContactinfo=Contactinfo.new
					newContactinfo.updated_by=1000		
					newContactinfo.updated_at='2007-08-01'
					newContactinfo.created_at=created_at	

					if newContactinfo.save()
						puts "CONTACTINFO: #{newContactinfo.id}"
					else
						puts "ERROR: couldn't save physical contactinfo"
						puts newContactinfo.errors.to_xml
					end
				
					#Create postal address role-link record
					newRoleContactinfo=RoleContactinfo.new()
					newRoleContactinfo.role_id=orgRole.id
					newRoleContactinfo.contactinfo_id=newContactinfo.id
					newRoleContactinfo.contactinfo_type='postal'  
					newRoleContactinfo.preferred=TRUE 
					newRoleContactinfo.save()

	                #billing contactinfo	
					newContactinfo=Contactinfo.new
					newContactinfo.updated_by=1000		
					newContactinfo.updated_at='2007-08-01'
					newContactinfo.created_at=created_at	

					if newContactinfo.save()
						puts "CONTACTINFO: #{newContactinfo.id}"
					else
						puts "ERROR: couldn't save physical contactinfo"
						puts newContactinfo.errors.to_xml
					end
				
					#Create billing address role-link record
					newRoleContactinfo=RoleContactinfo.new()
					newRoleContactinfo.role_id=orgRole.id
					newRoleContactinfo.contactinfo_id=newContactinfo.id
					newRoleContactinfo.contactinfo_type='billing'  
					newRoleContactinfo.preferred=FALSE  
					newRoleContactinfo.save()



					

					end					

					newRole=Role.new()
					newRole.role_type_id=25 #default
			    	newRole.person=newPerson
					newRole.updated_by=1000		
					newRole.updated_at='2007-08-01'
					newRole.created_at=created_at
				
					if  newRole.save
						puts " PERSON ROLE: #{newRole.id}"
					else
						puts "ERROR: couldnt save role"
						puts newRole.errors.to_xml
					end

					newPerson.roles << newRole
				
					
				
					if foreign_country.blank?
						myCountryId=158
					else
						myCountryId=158
					#TODO: lookup the country id
					end
				
			    	
					
					#physical contactinfo	
					newContactinfo=Contactinfo.new
					newContactinfo.updated_by=1000		
					newContactinfo.updated_at='2007-08-01'
					newContactinfo.created_at=created_at
					
					#if foundOrg != nil || newOrg != nil
						newContactinfo.street=phys_address_1
						newContactinfo.locality=phys_city
						newContactinfo.postcode=phys_post_code
						newContactinfo.building=building_name
						newContactinfo.country_id=myCountryId				
					#end

					if newContactinfo.save()
						puts "CONTACTINFO: #{newContactinfo.id}"
					else
						puts "ERROR: couldn't save physical contactinfo"
						puts newContactinfo.errors.to_xml
					end
				
					#Create physical address role-link record
					newRoleContactinfo=RoleContactinfo.new()
					newRoleContactinfo.role_id=newRole.id
					newRoleContactinfo.contactinfo_id=newContactinfo.id
					newRoleContactinfo.contactinfo_type='physical'  
					newRoleContactinfo.preferred=TRUE  
					newRoleContactinfo.save()

				
			

					#figure out region from province_state field?

					#postal contactinfo	
					newContactinfo=Contactinfo.new
					newContactinfo.updated_by=1000		
					newContactinfo.updated_at='2007-08-01'
					newContactinfo.created_at=created_at
					#if foundOrg != nil || newOrg != nil
					newContactinfo.street=address_1
					newContactinfo.locality=city
					newContactinfo.postcode=post_code
					newContactinfo.suburb=suburb
					newContactinfo.email_1=email
          newContactinfo.country_id=myCountryId
					newContactinfo.phone_prefix=phone_code
					newContactinfo.phone=phone_no	
				  newContactinfo.phone_mobile=mobile
					newContactinfo.phone_fax_prefix=fax_code
					newContactinfo.phone_fax=fax_no
					#end
					if newContactinfo.save()
						puts "CONTACTINFO: #{newContactinfo.id}"
					else
						puts "ERROR: couldn't save postal contactinfo"
						puts newContactinfo.errors.to_xml
					end
			
					#Create postal address role-link record
					newRoleContactinfo=RoleContactinfo.new()
					newRoleContactinfo.role_id=newRole.id
					newRoleContactinfo.contactinfo_id=newContactinfo.id
					newRoleContactinfo.contactinfo_type='postal' 
					newRoleContactinfo.save()

				
					#billing contactinfo	
					newContactinfo=Contactinfo.new
					newContactinfo.updated_by=1000		
					newContactinfo.updated_at='2007-08-01'
					newContactinfo.created_at=created_at
					newContactinfo.country_id=myCountryId
								

					if newContactinfo.save()
					puts "CONTACTINFO: #{newContactinfo.id}"
					else
					puts "ERROR: couldn't save billing contactinfo"
					puts newContactinfo.errors.to_xml
					end
			
					#create billing address role-link record
					newRoleContactinfo=RoleContactinfo.new()
					newRoleContactinfo.role_id=newRole.id
					newRoleContactinfo.contactinfo_id=newContactinfo.id
					newRoleContactinfo.contactinfo_type='billing' 
					newRoleContactinfo.save()
			
				
				#newContactinfo.destroy()
				#newRole.destroy()
				#newPerson.destroy()
				

				else
					puts "FAILED NAME WELL-FORMED CHECK: #{myName} (#{first_name}:#{surname})"
				end
			end
		
	end
  counter = counter + 1
end

puts "FOUND IN SOLR: #{solrcount} of #{counter} records"



