module Pages
	
	module Models 
		
		class Gallery < Default
			
			include Functor::Method
			
			def self.associate( domain )
  			has_many :images, :class => Pages::Models::Image[ domain ]
  		end
			
      DISPLAYS = [ ['Album', 'Album' ], ['Slideshow','Slideshow'] ]
      
			def self.displays; DISPLAYS; end
					
		end
		
	end
	
end
				
