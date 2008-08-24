module Pages
  
  module Resources
    
    class Site < Default
      
      def authenticated?
        redirect( paths.login ) unless session[:user]
      end
      
      def authenticate
        ( action( :authenticate ) and redirect( paths.main ) ) or 
          render( :login, :retry => true )
      end
      
      def update
        action( :update, :site ) and redirect( paths.main )
      end
      
    end
    
  end

end
      