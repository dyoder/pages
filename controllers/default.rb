module Application

	module Controllers
		
		class Default
			
			include Waves::Controllers::Mixin
			include Application::ResponseMixin
			
			def assigns
				@assigns ||= Dynamo.new( params[model_name.singular.intern] )
			end
						
			def create
				model.create( domain, 
				  assigns.to_h.merge( :name => name_from_assigns, :published => Date.today ) )
			end
			
			def find( name )
			  model.find( domain, name ) or not_found
			end
			
			def update( name )
			  p assigns.to_h
        find( name ).assign( assigns.to_h ).save
			end
			
			def delete( name )
				find( name ).delete
			end
			
			private
			
			def name_from_assigns
        ( assigns.name.nil? || assigns.name.empty? ) ? 
			    assigns.title.downcase.gsub(/\s+/,'-').gsub(/[^\w\-]/,'') : assigns.name
			end
			
		end
		
	end

end
			
			
