module Pages

	module Controllers
		
		class Payment < Default
			
			def store( transaction )
			  model.create( transaction )
			end
			
			def notification( transaction )
			  model.find( transaction['key'] ).assign( info ).save
		  end
			
		end
		
	end
	
end