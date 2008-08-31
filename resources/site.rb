module Pages
  
  module Resources
    
    class Site < Default
      
      before { redirect( paths.login ) unless session[:user] }
      on( :get, :login => LOGIN ) { view.login }
      on( :get, :admin => ADMIN ) { view.admin }
      on( :post, :authenticate => LOGIN ) { controller.authenticate }
      on( :post, :update => ADMIN ) { controller.update ; view.admin }
      
    end
    
  end

end
      