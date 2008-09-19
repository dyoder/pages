module Pages
	
	module Models 
		
		class Blog < Default
		  
		  include Functor::Method
		  
		  def self.associate( domain )
  		  has_many :entries, :class => Pages::Models::Story[ domain ]
  		end
		  
		end
		
	end
	
end
				
