module Pages
  
  module Resources
    
    class Default
      
      include Waves::Resources::Mixin
      
		  on( :get, [ :resource, { :name => 'home' }] ) { show }		  

		  on( :get, :show => [{ :name => 'home' }] ) { show }

      on( :post, :add =>  [ 'admin', :resource ] ) do
        controller.create and redirect( paths.show )
      end
      
      on( :get, :edit => [ 'admin', :resource, :name ] ) do
        view.editor( singular => controller.find( captured.name ) )
      end
            
      on( :post, :update =>  [ 'admin', :resource, :name ] ) do
        controller.update( captured.name ) and redirect( paths( :site ).admin )
      end
    
      on( :delete, :delete =>  [ 'admin', :resource, :name ] ) do
        controller.delete( captured.name ) and redirect( paths( :site ).main )
      end
                
      private
      
      def show
		    view.show( singular => controller.find( captured.name ) )
      end

    end
    
  end
  
end