module Pages

  module Resources

    class Media

      include Waves::Resources::Mixin

      on( :get, :get => [ 'media', :mediatype, { :asset => true } ] ) do
        # example of http freshness - js and css are valid for 1 hour - rack-cache will return the cached copy of css and js.
        response['Cache-Control'] = 'max-age=3600'
        controller.get( captured.mediatype, (captured.asset  * '/') + (request.ext || ''))
      end

    end

  end

end
