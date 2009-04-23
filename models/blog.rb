module Pages
	
	module Models 
		
		class Blog < Default
		  
		  def self.[]( domain )
        Class.new( self ) do
          include( Filebase::Model[ :db / domain / superclass.basename.snake_case ] )
          associate( domain )

          # callback from filebase before deleting
          after_save do |obj|
            obj.entries.each do |story|
              b = Pages::Models[ 'blog' ][ domain ].find( story.blog )
              if b and b.key != obj.key
                b['entries'].delete( story.key )
                b.save
              end
              story.blog = obj.key
              story.save
            end
            obj
          end

        end
      end
		  
		  def self.associate( domain )
  		  has_many :entries, :class => Pages::Models::Story[ domain ]
  		end
		  
		end
		
	end
	
end
				
