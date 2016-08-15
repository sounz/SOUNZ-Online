module SavedContactListsHelper
  
  #- Convert a person or organisation to an object
  #- Possible values are of the form
  #<ul><li>person348 - person with id 348</li><li>organisation70 - organisation with id 70</li>
  def get_person_or_organisation(stringid)
    result = nil
    #Remove the person bit
    thing = stringid.gsub('person', '')
    
    # was it replaced, if so create a person
    if thing != stringid
      #we h ave a person id
      result = Person.find(thing)
    elsif
      thing.gsub!('organisation', '')
      if !(thing.index('organisation')==0)
        thing = Organisation.find(thing)
      end
    end
  end
  
end
