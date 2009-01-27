module Pages
  
  module Resources
    
    class Site
      
      include Waves::Resources::Mixin

      on( :get, :admin => [ 'admin' ] ) { view.admin }

      # on( :put, :update => [ 'admin' ] ) { controller.update( captured.name ) ; redirect( paths.admin ) }
      # adding route missing - we could change /templates/site/editor.mab to do a put instead
      on( :post, :admin =>  [ 'admin' ] ) { controller.update( model_name ); redirect( paths.admin ) }
      
      on( :get, :login => [ 'login' ] ) { view.login }

      on( :post, :authenticate => [ 'login' ] ) { controller.authenticate }

    end
    
  end

end
      