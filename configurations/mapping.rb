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
        action( :favicon, :get => [ 'favicon.ico' ] ) { action( :get, 'favicon.ico' ) }
        action( :get, :get => [ 'images', 'get', :pathname ] ) { action( :get, pathname ) }
      end
      
      with :resource => :media do
        action( :get, :get => [ :media => /#{media}/, :path => /#{path}/ ] ) { action( :get, media, path ) }
      end
      
      # special rule to handle rss blog feed
      action( :feed, :resource => :blog, :get => [ 'blog', { :name => /#{name}/ } ], :accepts => :rss ) do
        action( :find, name ) and render( :feed )
      end
      
      #
      # Administration
      #
            
      with :resource => :site do
        # make the user is logged in before doing any admin functions
        before :authenticated, :any => [ 'admin', true ]
        # show the login page / process the login info
        action( :login, :get => [ 'login' ] ) { render( :login ) }
        action :authenticate, :post => [ 'login' ]
        # main site administration page
        action( :main, :get => [ 'admin' ] ) { render( :main ) }
        action :update, :post => [ 'admin' ]
      end
      
      action :add, :post => [ 'admin', { :resource => /#{resource}/ } ]
      action :update, :post => [ 'admin', { :resource => /#{resource}/ }, :name ]
      action :delete, :delete => [ 'admin', { :resource => /#{resource}/ }, :name ]
      action :edit, :get => [ 'admin', { :resource => /#{resource}/ }, :name ]
      action :show, :get => [ :resource, :name ]

      # defaults to story
      with :resource => :story do
        action :show, :get => [ :name ]
        action :home, :get => []
      end

    end
  
  end

end