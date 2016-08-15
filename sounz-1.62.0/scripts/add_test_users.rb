#!/usr/bin/env ../sounz/script/runner

BATCH_USER = Login.find(1000)

def add_person_user(username, first_name, last_name, known_as, email, membership_type)

  begin 
      Login.transaction do
        puts "START WITH CONTACTINFO, #{email}"
        @contactinfo=Contactinfo::new
        @contactinfo.email_1 = email
        @contactinfo.updated_by=BATCH_USER.login_id    
        @contactinfo.save!
        
        @user_login=Login::new
        @user_login.username=username
        
        @user_login.login_agent_class='P'
        @user_login.password='NOT_SET_YET'
        @user_login.salt='NOT_SET_YET'

        

        
        @user_login.new_password = ":wibblywobbly"
        @user_login.save!
        
        @user_login.member_types << MemberType.find_by_member_type_desc(membership_type)
        
        @user_login.save!


        
  
        puts "SAVING PERSON"
        @person = Person::new
        @person.first_names = first_name
        @person.last_name = last_name
        @person.known_as = known_as
        @person.login_updated_by = BATCH_USER
        
        puts "SETTING PERSON ID TO #{Status::PUBLISHED.status_id}"
        @person.status_id = Status::PUBLISHED.status_id
        
        
        puts "PERSON STATUS ID:#{@person.status_id}"
        @person.save!
        
        @person.logins = [@user_login]
        @person.updated_by=BATCH_USER.login_id
        @person.status_id= Status::PUBLISHED.status_id
        
        @person.save!
        myRole=Role.new()
		myRole.status_id = Status::APPROVED.status_id
        myRole.person=@person
        myRole.role_type_id=RoleType.roleTypeToId('Person').id
        myRole.updated_by=BATCH_USER.login_id

        myRole.save!
        

        rc=RoleContactinfo.new()
        rc.role=myRole
        rc.contactinfo=@contactinfo
        rc.contactinfo_type='postal'
        rc.preferred=true
        rc.save!
          
        
      end
      
      rescue Exception => e
        puts "ROLLBACK 1"
        puts "Exception: #{e.class}: #{e.message}\n\t#{e.backtrace.join("\n\t")}"
        raise ArgumentError "Member creation failed for some reason"
      end
      
      return @user_login
  end
  
  
  
  def add_contributor_user(username, first_name, last_name, known_as, email, membership_type, role_type)
    begin
      Login.transaction do
        puts "CREATING LOGIN"
        
        login = add_person_user(username, first_name, last_name, known_as, email, membership_type)
        
        
        puts "LOGIN:#{login}"
        
        contributor_role = Role::new
		contributor_role.status_id = Status::APPROVED.status_id
        contributor_role.person = login.person
        contributor_role.updated_by = BATCH_USER.login_id
        contributor_role.general_note = "Created for testing"
        contributor_role.role_type = role_type
        
        puts contributor_role.to_yaml
    
        contributor_metadata = Contributor::new
        contributor_metadata.role = contributor_role
        contributor_metadata.updated_by = BATCH_USER.login_id
        contributor_metadata.status_id = Status::PUBLISHED
        
        contributor_metadata.profile = "Test user called #{username}'s profile"
        contributor_metadata.profile_other = "Test user called #{username}'s profile"
        contributor_metadata.known_as = "TEST USER:#{known_as}"
        
         contributor_role.save!
         
        contributor_metadata.save!
       
      end
      rescue Exception => e
         puts "ROLLBACK 2"
          puts "Exception: #{e.class}: #{e.message}\n\t#{e.backtrace.join("\n\t")}"
      end
  end





add_person_user('barry_crm_administrator', 'Barry', 'CRM Administrator', 'Barry the CRM Administrator','barry@crm.administrator.com', 'CRM Administrator')
    
    
    
    
    
add_person_user('barry_administrator', 'Barry', 'Administrator', 'Barry the Administrator','barry@administrator.com', 'Administrator')
    
add_person_user('barry_superuser', 'Barry', 'Superuser', 'Barry the Superuser','barry@superuser.com', 'Superuser')
    
add_person_user('barry_tap_administrator', 'Barry', 'TAP Administrator', 'Barry the TAP Administrator','barry@tap.administrator.com', 'TAP Administrator')
    
add_person_user('barry_online_member', 'Barry', 'Online Member', 'Barry the Online Member','barry@online.member.com', 'Online Member')
    
add_person_user('barry_contributor_member', 'Barry', 'Contributor Member', 'Barry the Contributor Member','barry@contributor.member.com', 'Contributor Member')
    
add_person_user('barry_library_member', 'Barry', 'Library Member', 'Barry the Library Member','barry@library.member.com', 'Library Member')
    
add_person_user('barry_guest', 'Barry', 'Guest', 'Barry the Guest','barry@guest.com', 'Guest')



add_contributor_user('barry_composer', 'Barry', 'Contributor Member', 'Barry the Composer Member',
'barry@contributor.member.com', 'Contributor Member', RoleType.find_by_role_type_desc('Composer (c)'))

add_contributor_user('barry_performer', 'Barry', 'Contributor Member', 'Barry the Performer Member',
'barry@contributor.member.com', 'Contributor Member', RoleType.find_by_role_type_desc('Performer - Music (c)'))

add_contributor_user('barry_commissioner', 'Barry', 'Contributor Member', 'Barry the Commissioner Member',
'barry@contributor.member.com', 'Contributor Member', RoleType.find_by_role_type_desc('Commissioner (c)'))

add_contributor_user('barry_publisher', 'Barry', 'Contributor Member', 'Barry the Publisher Member',
'barry@contributor.member.com', 'Contributor Member', RoleType.find_by_role_type_desc('Publisher (c)'))

add_contributor_user('barry_presenter', 'Barry', 'Contributor Member', 'Barry the Presenter Member',
'barry@contributor.member.com', 'Contributor Member', RoleType.find_by_role_type_desc('Broadcaster (c)'))



