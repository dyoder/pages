module Pages
	
	module Models 
		
		class Gallery < Default
		  
		  def self.[]( domain )
        Class.new( self ) do
          include( Filebase::Model[ :db / domain / superclass.basename.snake_case ] )
          associate( domain )

          # callback from filebase before deleting
          after_save do |obj|
            obj.images.each do |image|
              b = Pages::Models[ 'gallery' ][ domain ].find( image.gallery )
              if b and b.key != obj.key
                b['images'].delete( image.key )
                b.save
              end
              image.gallery = obj.key
              image.save
            end
            obj
          end

        end
      end
			
			def self.associate( domain )
  			has_many :images, :class => Pages::Models::Image[ domain ]
  		end
			
      DISPLAYS = [ ['Album', 'Album' ], ['Slideshow','Slideshow'] ]
      
			def self.displays; DISPLAYS; end
			
		end
		
	end
	
end
				
