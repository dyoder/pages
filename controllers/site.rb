module Pages
  module Controllers
    class Site < Default
      
      include Waves::Controllers::Mixin
			include Pages::ResponseMixin
			
			def authenticate
				admin = site.administrators.find do |admin| 
					( admin['email'] == attributes[:email] )  && 
						( admin['password'] == attributes[:password] )
				end
				if admin
  				session[:user] = admin['email']
				redirect(paths.admin)
  			end
			end

  	end
  	
  end

end
