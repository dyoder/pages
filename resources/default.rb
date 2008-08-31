module Pages
  
  module Resources
    
    class Default
      
      include Waves::Resources::Mixin
      
      RESOURCE = [{ :resource => { /^(story|image|gallery|blog|feed|product|catalog)$/ => :story } }]
			NAMED_RESOURCE = RESOURCE + [ :name => :home ]
			ADMIN = [ 'admin' ] ; LOGIN = [ 'login' ]
			
      on( :get, :show => NAMED_RESOURCE ) do
        view.show( singular => controller.find( query.name || 'home' ) )
      end  

      on( :get, :edit => ADMIN + NAMED_RESOURCE ) do
        view.edit( singular => controller.find( query.name ) )
      end
              
      on( :put, :add => ADMIN + RESOURCE ) do
        controller.create and redirect( paths.show )
      end
        
      on( :post, :update => ADMIN + NAMED_RESOURCE ) do
        controller.update( attributes.name ) and rediect( paths( :site ).admin )
      end
      
      on( :delete, :delete => ADMIN + NAMED_RESOURCE ) do
        controller.delete( attributes.name ) and redirect( paths( :site ).main )
      end
      
            
    end
    
  end
  
end