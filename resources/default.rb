module Pages
  
  module Resources
    
    class Default < Waves::Resources::Base
      
			with( :visitor ) do
			  
			  on( :get, :show => [{ :name => :home }] ) do
          view.show( singular => controller.find( query.name ) )
        end
        
      end
      
      with( :author ) do
        
        before do
          redirect( paths( :site ).login ) unless session[:user]  
        end
        
        on( :post, :update =>  [ :name ] ) do
          controller.update( query.name ) and redirect( paths( :site ).admin )
        end

        on( :get, :edit => [ :name ] ) do
          view.edit( singular => controller.find( query.name ) )
        end
              
        on( :put, :add =>  [ :name ] ) do
          controller.create and redirect( paths.show )
        end
        
        on( :delete, :delete =>  [ :name ] ) do
          controller.delete( query.name ) and redirect( paths( :site ).main )
        end
      
      end
            
    end
    
  end
  
end