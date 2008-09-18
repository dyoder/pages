module Pages
  
  module Resources
    
    class Site
      
      include Waves::Resources::Mixin
      
      class Paths < Waves::Resources::Paths
        def self.login ; "/login" ; end
      end
      
      on( :get, :login => [ 'login' ] ) { view.login }
      on( :post, :authenticate =>  [ 'login' ] ) { controller.authenticate }

      with( :traits => { :authenticated => true } ) do
        on( :get, :admin => [] ) { view.admin }
        on( :put, :update =>  [ 'admin' ] ) { controller.update ; view.admin }
      end
      
    end
    
  end

end
      