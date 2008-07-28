module Pages
  
  module Configurations
    
    module Mapping

      extend Waves::Mapping
      
      # Basic Patterns
      name = '([\w\-\_\.\+\@]+)' ; path = '([\w\-\_\.\+\@\/]+)'
			resource = '(story|image|gallery|blog|feed|product|catalog)'
			media = '(javascript|flash|audio|css|video)'
			
      #
      # Supported Media Types
      # We could probably consolidate these into a single rule or 3 ...
      #
      
      with :resource => :image do
        response( :favicon, :get => [ 'favicon.ico' ] ) { action( :get, 'favicon.ico' ) }
        response( :get, :get => [ 'images', 'get', :pathname ] ) { action( :get, pathname ) }
      end
      
      with :resource => :media do
        response( :get, :get => [ :media => /#{media}/, :path => /#{path}/ ] ) { action( :get, media, path ) }
      end
      
      # special rule to handle rss blog feed
      response( :feed, :resource => :blog, :get => [ 'blog', { :name => /#{name}/ } ], :accepts => :rss ) do
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
        response( :main, :get => [ 'admin' ] ) { render( :main ) }
        response :update, :post => [ 'admin' ]
      end
      
      response :add, :post => [ 'admin', { :resource => /#{resource}/ } ]
      response :update, :post => [ 'admin', { :resource => /#{resource}/ }, :name ]
      response :delete, :delete => [ 'admin', { :resource => /#{resource}/ }, :name ]
      response :edit, :get => [ 'admin', { :resource => /#{resource}/ }, :name ]
      response :show, :get => [ :resource, :name ]

      # defaults to story
      with :resource => :story do
        response :show, :get => [ :name ]
        response :home, :get => []
      end

    end
  
  end

end