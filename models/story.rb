module Pages
	
	module Models 
		
		class Story < Default
		  
		  def associate( domain )
  		  has_one :blog, :class => Pages::Models::Blog[ domain ]
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
