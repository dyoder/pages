module Pages
	
	module Models 
		
		class Calendar < Default
		  
		  def self.associate( domain )
  		  has_many :events, :class => Pages::Models::Event[ domain ]
  		end
		  
		end
		
	end
	
end