module Pages

  module Resources

    class Media

      include Waves::Resources::Mixin

      on( :get, :get => [ :mediatype, { :asset => true } ], :ext => true ) do
        controller.get( captured.mediatype, (captured.asset  * '/') + (request.ext || ''))
      end

    end

  end

end
