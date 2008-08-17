module Pages
  module Controllers
    class Site < Waves::Controllers::Base
      
      include Pages::ResponseMixin
			
			def authenticate
				admin = site.administrators.find do |admin| 
					( admin['email'] == attributes[:email] )  && 
						( admin['password'] == attributes[:password] )
				end
				if admin
  				session[:user] = admin['email']
  			end
			end

			def model ; _model[ :db / domain ] ; end

  	end
  	
  end

end