module Pages
  
  module Configurations
    
    module Mapping

      extend Waves::Mapping
      
      # Basic Patterns
			RESOURCE = /^(story|image|gallery|blog|feed|product|catalog)$/
			MEDIA = /^(javascript|flash|audio|css|video)$/
			
      #
      # Supported Media Types
      # We could probably consolidate these into a single rule or 3 ...
      #
      
      with :resource => :image do
        response( :favicon, :get => [ 'favicon.ico' ] ) { action( :get, 'favicon.ico' ) }
        response( :get, :get => [ 'images', { :asset => true } ] ) { action( :get, asset * '/' ) }
      end
      
      with :resource => :media do
        response( :get, :get => [ { :media => MEDIA }, { :asset => true } ] ) { action( :get, media, asset * '/' ) }
      end
      
      # special rule to handle rss blog feed
      response( :feed, :get => [ 'blog', :name ], :resource => :blog, :accepts => :rss ) do
        action( :find, name ) and render( :feed )
      end
      
      #
      # Administration
      #
            
      with :resource => :site do
        # make the user is logged in before doing any admin functions
        before :authenticated, :path => [ 'admin', true ]
        # show the login page / process the login info
        response( :login, :get => [ 'login' ] ) { render( :login ) }
        response :authenticate, :post => [ 'login' ]
        # main site administration page
        response( :main, :get => [ 'admin' ] ) { render( :admin ) }
        response :update, :post => [ 'admin' ]
      end
      
      response :add, :post => [ 'admin', { :resource => RESOURCE } ]
      response :update, :post => [ 'admin', { :resource => RESOURCE }, :name ]
      response :delete, :delete => [ 'admin', { :resource => RESOURCE }, :name ]
      response :edit, :get => [ 'admin', { :resource => RESOURCE }, :name ]
      response :show, :get => [ { :resource => RESOURCE }, :name ]

      # defaults to story
      with :resource => :story do
        response :show, :get => [ :name ]
        response :home, :get => []
      end

    end
  
  end

end