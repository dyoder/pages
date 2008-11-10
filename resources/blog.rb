module Pages
  
  module Resources
    
    class Blog < Default

      on( :get, { :feed => [ 'blog', :name ] }, :accept => :xml ) do
        view.feed( :blog => controller.find( basename( captured.name ) ) )
      end
      
    end
    
  end

end
