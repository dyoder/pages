module Pages
	
	module Models 
		
		class Image < Default
		  
		  def associate( domain )
  		  has_one :gallery, :class => Pages::Models::Gallery[ domain ]
  		end
			
		end
		
	end
	
end
