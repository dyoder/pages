module Application
	
	module Controllers
		
		class Site

			include Waves::Controllers::Mixin
			include Application::ResponseMixin

			def assigns
				@assigns ||= Dynamo.new( params[model_name.singular.intern] )
			end

			def authenticate
				admin = site.administrators.find do |admin| 
					( admin['email'] == assigns.email )  && 
						( admin['password'] == assigns.password )
				end
				if admin
  				session[:user] = admin['email']
  				redirect '/admin'
  			end
			end
			
			def find
			  model.find( domain )
			end
			
			def update
			  find.assign( assigns.to_h ).save
			end

		end
	
	end

end