module Pages
	
	module Models 
		
		class Blog < Default
		  
		  include Functor::Method
		  
		  def self.associate( domain )
  		  has_many :entries, :class => Pages::Models::Story[ domain ]
  		end
		  
			functor( :entries=, String ) { set( :entries, rval.split(',').map{ |name| name.strip } ) }
			
		end
		
	end
	
end
				
