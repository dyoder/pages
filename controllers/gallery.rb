module Pages

	module Controllers
		
		class Gallery < Default
			
			def update( name )
			  # Hack for supporting single image added to the gallery
			  query[model_name].images = query[model_name].images.to_a if query[model_name].images
			  find( name ).assign( query[ model_name ].to_h ).save
			end
			
		end
		
	end

end