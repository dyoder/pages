module Pages
	
	module Models 
		
		class Blog < Default
		  
		  def self.associate( domain )
  		  has_many :entries, :class => Pages::Models::Story[ domain ]
  		end
		  
		end
		
	end
	
end
				
