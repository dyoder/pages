module Pages
  
  module Resources
    
    class Site
      
      include Waves::Resources::Mixin
      
      # admin access
      on( :get, :admin => [ 'admin' ] ) { response.content_type = 'text/html' ;  view.admin }
      
      # on( :put, :update => [ 'admin' ] ) { controller.update( captured.name ) ; redirect( paths.admin ) }
      # adding route missing - we could change /templates/site/editor.mab to do a put instead
      on( :post, :admin =>  [ 'admin' ] ) { controller.update( model_name ); redirect( paths.admin ) }
      
      # admin auth
      before( [ 'admin', { :rest => true } ] ) { authenticated? }
      before( [ 'admin' ] ) { authenticated? }
      
      private
      
      def authenticated?
        redirect( paths( :user ).login ) unless session[:user] && session[:role] == 'Admin'
      end

    end
    
  end

end
      