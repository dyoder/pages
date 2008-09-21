module Pages
  
  module Resources
    
    class Site
      
      include Waves::Resources::Mixin

      on( :get, :admin => [ 'admin' ] ) { view.admin }

      on( :put, :update => [ 'admin' ] ) { controller.update ; redirect( paths.admin ) }
      
      on( :get, :login => [ 'login' ] ) { view.login }

      on( :post, :authenticate => [ 'login' ] ) { controller.authenticate }

    end
    
  end

end
      