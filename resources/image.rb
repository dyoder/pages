module Pages
  
  module Resources
    
    class Image < Default
      
      # special image handling to deal with image resizing
      on( :get, :get => [ 'images', { :asset => true } ]  ) do
        # example of http freshness - images are valid for 24 hours - rack-cache will return the cached copy.
        response['Cache-Control'] = 'max-age=86400'
        controller.get( captured.asset * '/' )
      end
      
    end
    
  end

end
