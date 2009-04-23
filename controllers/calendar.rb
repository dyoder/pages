module Pages

	module Controllers
		
		class Calendar < Default
			
			def update( name )
			  # Hack for supporting single event added to the calendar
			  query[model_name].events = query[model_name].events.to_a if query[model_name].events
			  super
			end
			
		end
		
	end

end