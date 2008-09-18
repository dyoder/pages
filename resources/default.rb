module Pages
  
  module Resources
    
    class Default
      
      include Waves::Resources::Mixin
      
      with( :traits => { :authenticated => true }) do
        
        on( :post, :update =>  [ :name ] ) do
          controller.update( captured.name ) and redirect( paths( :site ).admin )
        end
      
        on( :get, :edit => [ :name ] ) do
          view.editor( singular => controller.find( captured.name ) )
        end
              
        on( :put, :add =>  [ :name ] ) do
          controller.create( captured.to_h ) and redirect( paths.show )
        end
        
        on( :delete, :delete =>  [ :name ] ) do
          controller.delete( captured.name ) and redirect( paths( :site ).main )
        end
      
      end
            
		  on( :get, :show => [{ :name => 'home' }] ) do
        view.show( singular => controller.find( captured.name ) )
      end
              
    end
    
  end
  
end