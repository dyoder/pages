module Pages
	
	module Models 
		
		class Event < Default
		  
		  def self.[]( domain )
        Class.new( self ) do
          include( Filebase::Model[ :db / domain / superclass.basename.snake_case ] )
          associate( domain )
          
          # callback from filebase before deleting
          before_delete do |obj|
            g = Pages::Models[ 'calendar' ][ domain ].find( obj.calendar )
            if g
              g.save if g['events'].delete( obj.key )
            end
            obj
          end
          
        end
      end
		  
		  def associate( domain )
  		  has_one :calendar, :class => Pages::Models::Calendar[ domain ]
  		end
			
			FORMATS = [ 
			  ['Formatted Text','wysiwyg'],
        ['Plain Text','text'], 
        ['HTML','html'], 
        ['Textile','textile']
      ]
            
			def self.formats
			  FORMATS
			end
			
			def date
			  published
			end
							
		end
		
	end
	
end
