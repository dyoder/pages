module Pages
	
	module Models 
		
		class Event < Default
		  
		  #alias_method :published, :date ;
		  
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
