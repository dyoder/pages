module Pages
  
  module Resources
    
    class Admin
      
      include Waves::Resources::Mixin
      
      before( [ 'admin', { :rest => true } ] ) { authenticated? }
      
      on( true, [ 'admin' ] ) { to( :site ) }

      on( true, [ 'admin', :resource, { :rest => true } ] ) { to( captured.resource ) }

      private
      
      def authenticated?
        redirect( paths( :site ).login ) unless session[:user]
      end
      
    end
    
  end
  
end