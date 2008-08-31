module Pages
  
  module Resources
    
    class Media < Default
      
      MEDIA = { :media => /^(javascript|flash|audio|css|video)$/ }
			
      on( :get, :get => [ MEDIA, { :asset => true } ] ) do
        controller.get( query.media, query.asset * '/')
      end
      
    end
    
  end

end
