module Pages

  module Resources

    class Calendar < Default

      on( :get, { :feed => [ 'calendar', :name ] }, :ext => :xml ) do
        view.feed( :calendar => controller.find( basename( captured.name ) ) )
      end

    end

  end

end