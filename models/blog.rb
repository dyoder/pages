module Pages
	
	module Models 
		
		class Blog < Default
		  
			def entries=( rval )
				case rval
				when String then set( :entries, rval.split(/\s*,\s*/) )
				else set( :entries, rval )
				end
			end
			
		end
		
	end
	
end
				
