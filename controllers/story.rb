module Pages

	module Controllers
		
		class Story < Default
			
			def update( name )
			   str = find( name )
			   #updating relation with blog 
 			   sel_b = query[ model_name ].to_h['blog']
 			   model_b = models('blog').find(sel_b)
 			   unless model_b.nil?
 			     model_b.entries.push( str )
 			     model_b.save
 			   end
			   #updating story entry
			   str.assign( query[ model_name ].to_h ).save
			end
			
		end
		
	end

end
