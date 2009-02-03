module Pages

	module Controllers
		
		class Story < Default
			
			def update( name )
			   #updating story entry
			   find( name ).assign( query[ model_name ].to_h ).save
			   #updating relation with blog 
			   sel_b = query[ model_name ].to_h['blog']
			   model_b = models('blog').find(sel_b)
			   model_b.entries.push(find(name))
			   model_b.save
			end
			
		end
		
	end

end
