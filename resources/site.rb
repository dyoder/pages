module Pages
  
  module Resources
    
    class Site
      
      include Waves::Resources::Mixin

      with( :traits => { :authenticated => true } ) do
        on( :get, :admin => [ 'admin' ] ) { view.admin }
        on( :put, :update => [ 'admin' ] ) { controller.update ; redirect( paths.admin ) }
      end
      
      on( :get, :login => [ 'login' ] ) { view.login }
      on( :post, :authenticate => [ 'login' ] ) { controller.authenticate }

    end
    
  end

end
      