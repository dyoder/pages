module Pages
  
  module Resources
    
    class Site
      
      include Waves::Resources::Mixin

      with( :traits => { :authenticated => true } ) do
        on( :get, :admin => [] ) { view.admin }
        on( :put, :update => [ 'admin' ] ) { controller.update ; view.admin }
      end
      
      on( :get, [] ) { view.login }
      on( :post, [] ) { controller.authenticate }

    end
    
  end

end
      