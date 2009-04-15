module Pages
  module Resources
    class Map
      include Waves::Resources::Mixin
      
      # default to story if nothing else matches
      on( true ) { to( :story ) }
      
      # otherwise assume we are matching against a resource
      on( true, [ :resource, { :rest => true } ] ) { to( captured.resource ) }

      # another url for accessing admin page and updating site info
      on( [ :get, :post ], [ 'admin' ] ) { to( :site ) }

      # special URL just for login and authenticating
      on( [ :get, :post ], [ 'login' ] ) { to( :user ) }
      
      # logout
      on( :get, [ 'logout' ] ) { to( :user ) }
      
      # register
      on( :get, :register => [ 'user' ] ) { to( :user ) }
      
      # before anything else, check the accepts headers and route accordingly
      on( :get, [ 'images' , true ] ) { to( :image ) }
      
      # whatever as an extension comes from public or theme directory.
      #on( :get, true, :ext => [ :css, :js, :swf, :gif, :png, :htm ] ) { to( :media ) }
      on( :get, true, :ext => [ 'css', 'js', 'swf', 'gif', 'png', 'htm', 'jpg' ] ) { to( :media ) }
      #on( :get, true, :accept => :rss ) { to( :blog ) }
        
    end
  end
end
