class FrbrRelationship

	def initialize(relatedObject,relType,objectType)
		@relatedObject=relatedObject
		@relType=relType
    @objectType=objectType
  	end
    
    def relatedObject 
		@relatedObject 
	end

	def relatedObject=(newObject) 
		@relatedObject = newObject 
	end

    def relType 
		@relType 
	end

	def relType=(newType) 
		@relType = newType 
	end
    
    def objectType 
		@objectType 
	end

	def objectType=(newType) 
		@objectType = newType 
	end

end