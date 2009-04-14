module Pages
  module Controllers
    class User < Default
      	
			def authenticate
			  
			  email_key = attributes[ :email ].gsub(/\s+/,'-').gsub(/[^\w\-]/,'-')
			  user = find( email_key )
			  auth = false
			  if(user && ( user['email'] == attributes[:email] )  && 
					( user['password'] == attributes[:password] ))
			    auth = true
			  end
				if auth #user is present and authenticated
  				session[:user] = email_key
  				session[:role] = user.role
  				redirect(paths( :site ).admin) if user.role == 'Admin'
  				redirect(paths.role + email_key) if user.role == 'Member'
  			else
  			  # do something here.... in case authentication failed
  			  # redirect(paths.login)
  			end
			end
			
			def logout
			  session.clear
			  redirect('/')
		  end
      
    end
  end
end
