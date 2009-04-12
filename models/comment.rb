module Pages
	
	module Models 
		
		class Comment < Default
		  
		  def associate( domain )
  		  has_one :story, :class => Pages::Models::Story[ domain ]
  		end
  		
  		def attribution
        name.nil? || name.empty?  ? 'anonymous coward' : name
      end
							
		end
		
	end
	
end