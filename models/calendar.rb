module Pages
	
	module Models 
		
		class Calendar < Default
		  
		  def self.[]( domain )
        Class.new( self ) do
          include( Filebase::Model[ :db / domain / superclass.basename.snake_case ] )
          associate( domain )

          # callback from filebase before deleting
          after_save do |obj|
            obj.events.each do |event|
              b = Pages::Models[ 'calendar' ][ domain ].find( event.calendar )
              if b and b.key != obj.key
                b['events'].delete( event.key )
                b.save
              end
              event.calendar = obj.key
              event.save
            end
            obj
          end

        end
      end
		  
		  def self.associate( domain )
  		  has_many :events, :class => Pages::Models::Event[ domain ]
  		end
		  
		end
		
	end
	
end