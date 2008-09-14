module Pages
  
  module Resources
    
    class Media
      
      include Waves::Resources::Mixin
      
      on( :get, :get => [ :media, { :asset => true } ] ) do
        controller.get( captured.media, captured.asset * '/')
      end
      
    end
    
  end

end
