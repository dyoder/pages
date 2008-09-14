module Pages
  
  module Resources
    
    class Image
      
      
      include Waves::Resources::Mixin
      
      # special image handling to deal with image resizing
      on( :get, :get => [ 'images', { :asset => true } ]  ) do
        controller.get( captured.asset * '/' )
      end
      
    end
    
  end

end
