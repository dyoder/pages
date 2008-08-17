module Pages
	
	module Models 
		
		class Gallery < Default
			
			include Functor::Method
			
			def associate( domain )
  			has_many :images, :class => Pages::Models::Image[ domain ]
  		end
			
      DISPLAYS = [ ['Album', 'Album' ], ['Slideshow','Slideshow'] ]
      
			def self.displays; DISPLAYS; end
		
			functor( :images=, String ) { set( :images, rval.split(',').map{ |name| name.strip } ) }
			
		end
		
	end
	
end
				
