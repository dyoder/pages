module Pages
	
	module Models 
		
		class Story < Default
		  
		  def self.[]( domain )
        Class.new( self ) do
          include( Filebase::Model[ :db / domain / superclass.basename.snake_case ] )
          associate( domain )
          
          # callback from filebase before deleting
          before_delete do |obj|
            g = Pages::Models[ 'blog' ][ domain ].find( obj.blog )
            if g
              g.save if g['entries'].delete( obj.key )
            end
            obj
          end
          
        end
      end
		  
		  def associate( domain )
  		  has_one :blog, :class => Pages::Models::Blog[ domain ]
  		  has_many :comments, :class => Pages::Models::Comment[ domain ]
  		end
  		
  		def comment_number
        n = comments.size
        case n
        when 0
          "No Comments"
        when 1
          "1 Comment"
        else
          "#{n} Comments"
        end
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
							
		end
		
	end
	
end
