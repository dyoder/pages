module Pages

	module Controllers
		
		class Blog < Default
			
			def update( name )
			  # Hack for supporting single story added to the blog
			  query[model_name].entries = query[model_name].entries.to_a if query[model_name].entries
			  super
			end
			
		end
		
	end

end