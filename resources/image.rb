module Pages
  
  module Resources
    
    class Image < Default
      
      # special image handling to deal with image resizing
      on( :get, :get => [ 'images', { :asset => true } ]  ) do
        controller.get( query.asset * '/' )
      end
      
    end
    
  end

end
