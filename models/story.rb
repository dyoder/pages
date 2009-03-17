module Pages
	
	module Models 
		
		class Story < Default
		  
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
