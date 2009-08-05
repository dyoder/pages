module Pages
  module Resources
    class Map
      include Waves::Resources::Mixin
      
      # default to story if nothing else matches
      on( true ) { to( :story ) }
      
      # otherwise assume we are matching against a resource
      on( true, [ :resource, { :rest => true } ] ) { to( captured.resource ) }

      on( :get, [ 'javascript', true ] ) { to( :media ) }
      on( :get, [ 'css', true ] ) { to( :media ) }
      on( :get, [ 'images', true ] ) { to( :image ) }

      # # for accessing admin page and updating site info -- requires authentication
      # on( [ :get, :post ], [ 'admin' ] ) { to( :site ) }
      # on( [ :get, :post ], [ 'admin', { :rest => true } ] ) { to( :site ) }
      # 
      # # special URL just for login and authenticating
      # on( [ :get, :post ], [ 'login' ] ) { to( :user ) }
      # 
      # # logout
      # on( :get, [ 'logout' ] ) { to( :user ) }
      # 
      # # register
      # on( :get, :register => [ 'user' ] ) { to( :user ) }
      # 
      # # images
      # on( :get, [ 'images' , true ] ) { to( :image ) }
      # 
      # # whatever as an extension comes from public or theme directory.
      # on( :get, [ %w( javascript css) ] ) { to( :media ) }
      # on( true, [ :resource, { :rest => true } ], :ext => [ :rss, :xml ] ) { to( captured.resource ) }
      # 
      # # before anything else, check the accepts headers and route accordingly
      # on( :get, true, :accept => [ :rss ] ) { to( :blog ) }
      # 
      # # updating status on social network
      # on( true, [ 'social' , :name ] ) { to( :social ) }
      # 
      # # # special URL just payment notification
      # # on( :post, [ 'donation' ] ) { to( :payment ) }
      # # on( [ :get, :post ], [ 'payment-notification' ] ) { to( :payment ) }
        
    end
  end
end