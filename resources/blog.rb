module Pages
  
  module Resources
    
    class Blog < Default
      
      on( :get, :feed => [ 'blog', :name ] ) do
         view.feed( :blog => controller.find( query.name ) )
      end
      
    end
    
  end

end
