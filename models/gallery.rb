module Pages
	
	module Models 
		
		class Gallery < Default
			
      DISPLAYS = [ ['Album', 'Album' ], ['Slideshow','Slideshow'] ]
      
			def self.displays; DISPLAYS; end
			
			def images=( rval )
				case rval
				when String then set( :images, rval.split(/\s*,\s*/) )
				else set( :images, rval )
				end
			end
			
		end
		
	end
	
end
				
