class FrbrObject

	def initialize(objectType,objectData)
		@objectType=objectType
		@objectData=objectData
	end
    
    def objectType 
		@objectType 
	end

	def objectType=(newType) 
		@objectType = newType 
	end
  
  def objectData 
		@objectData 
	end

	def objectData=(newData) 
		@objectData = newData 
	end

  def objectTitle
    if @objectType == 'resource'
      @objectData.resource_title
    elsif @objectType == 'manifestation'
      @objectData.manifestation_title
    end
  end
end