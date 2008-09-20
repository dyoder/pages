module Pages
  
  module Resources
    
    class Blog < Default

      on( :get, { :feed => [ 'blog', :name ] }, { :accept => :rss }) do
        view.feed( :blog => controller.find( captured.name ) )
      end
      
    end
    
  end

end
