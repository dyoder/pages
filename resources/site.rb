module Pages
  
  module Resources
    
    class Site < Default
      
      with( :author ) do
        before { redirect( paths( :site ).login ) unless session[:user]  }
        on( :get, :login => [ 'login' ] ) { view.login }
        on( :get, :admin => [] ) { view.admin }
        on( :post, :authenticate =>  [ 'login' ] ) { controller.authenticate }
        on( :put, :update =>  [ 'admin' ] ) { controller.update ; view.admin }
      end
      
    end
    
  end

end
      