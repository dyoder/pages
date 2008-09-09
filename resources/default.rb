module Pages
  
  module Resources
    
    class Default
      include Waves::Resources::Mixin
      
      with( :authenticated? => true ) do
        
        before do
          redirect( paths( :site ).login ) unless session[:user]  
        end
        
        on( :post, :update =>  [ :name ] ) do
          controller.update( query.name ) and redirect( paths( :site ).admin )
        end

        on( :get, :edit => [ :name ] ) do
          view.editor( singular => controller.find( query.name ) )
        end
              
        on( :put, :add =>  [ :name ] ) do
          controller.create and redirect( paths.show )
        end
        
        on( :delete, :delete =>  [ :name ] ) do
          controller.delete( query.name ) and redirect( paths( :site ).main )
        end
      
      end
            
		  on( :get, :show => [{ :name => 'home' }] ) do
        view.show( singular => controller.find( query.name ) )
      end
              
    end
    
  end
  
end