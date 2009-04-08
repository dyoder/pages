module Pages
	
	module Models 
		
		class Listing < Default
		  
		  def associate( domain )
  		  # TODO associate listing with announcements
  		end
  		
  		PHONE_TYPE = [ 
  		  'Phone',
  		  'Fax',
  		  'Messages'
  		]
			
			def self.phone_types
			  PHONE_TYPE
			end
							
		end
		
	end
	
end
