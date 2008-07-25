module Pages
	
	module Models 
		
		class Story < Application::Models::Default
			
			FORMATS = [ 
			  ['Formatted Text','wysiwyg'],
        ['Plain Text','text'], 
        ['HTML','html'], 
        ['Textile','textile']
      ]
      
			def self.formats
			  FORMATS
			end

			def blog=( name )
				unless name.nil? or name.empty?
				  x = self.class.find( domain, name )
					unless x.entries.include?( self.name )
						x.entries << self.name
						x.save
					end
					set( :blog, name )
				end
			end
			
				
		end
		
	end
	
end
