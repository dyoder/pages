module Pages

  module Resources

    class Blog < Default

      # feed removed till we have a more understanding of extension matching      
      on( :get, { :feed => [ 'blog', :name ] }, :ext => [ :xml ] ) do
        view.feed( :blog => controller.find( basename( captured.name ) ) )
      end

    end

  end

end
