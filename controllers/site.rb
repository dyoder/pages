module Pages
  module Controllers
    class Site < Default
      
			def authenticate
				admin = site.administrators.find do |admin| 
					( admin['email'] == assigns.email )  && 
						( admin['password'] == assigns.password )
				end
				if admin
  				session[:user] = admin['email']
  			end
			end

			def model ; _model[ :db / domain ] ; end

  	end
  	
  end

end