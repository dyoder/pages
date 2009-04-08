module Pages
  
  module Resources
    
    class User < Default

      # create a new user from the register page
      on( :post, :add =>  [ 'user' ] ) do
        controller.create['key']
        redirect(paths.login)
      end
      
      #on( :get, :edit => [ 'user', :name ] ) do
      #  view.editor( singular => controller.find( captured.name ) )
      #end
            
      #on( :post, :update =>  [ 'user', :name ] ) do
      #  controller.update( captured.name ) and redirect( paths( :site ).admin )
      #end
    
      #on( :delete, :delete =>  [ 'user', :name ] ) do
      #  controller.delete( captured.name ) and redirect( paths( :site ).admin )
      #end
      
      # login post
      on( :post, :authenticate => [ 'login' ] ) { controller.authenticate }
      
      # login page
      on( :get, :login => [ 'login' ] ) { view.login }
      
      # logout
      on( :get, [ 'logout' ] ) { controller.logout }
      
      # register page
      on( :get, :register => [ 'user' ] ) { view.register }
      
      # user accessing personal page
      on( :get, :role => [ 'user', :name ] ) { view.show( singular => controller.find( captured.name ) )} 

      # authentication, avoiding logged user to jump into another account
      before( [ 'user', :name ] ) { authenticated? captured.name }
      
      private
      
      def authenticated?(name)
        redirect( paths.login ) unless session[:user] == name
      end
    end
    
  end
  
end
