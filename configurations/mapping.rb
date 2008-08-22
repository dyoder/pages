module Pages
  
  module Configurations
    
    module Mapping

      extend Waves::Mapping
      
      # Basic Patterns
			RESOURCE = /^(story|image|gallery|blog|feed|product|catalog)$/
			MEDIA = /^(javascript|flash|audio|css|video)$/
			
      #
      # Supported Media Types
      #
      before do
        on( :any => [ 'admin', true ] ) { authenticated? }
      end
      
      on( :get => [ 'favicon.ico' ], :resource => :image, :as => :fav_icon ) { get( 'favicon.ico' ) }
      
      # special image handling to deal with image resizing
      on( :get => [ 'images', { :asset => true } ], :as => :get ) { get( attributes.asset * '/' ) }
      
      # arbitrary media: video, audio, whichever
      on( :get => [ { :media => MEDIA }, { :asset => true } ], :resource => :media, :as => :get ) do
        get( attributes.media, attributes.asset * '/')
      end
      
      # blogs feeds
      on( :get => [ 'blog', :name ], :resource => :blog, :accepts => :rss, :as => :feed ) do
         view.feed( :blog => controller.find( attributes.name ) )
      end
      
      #
      # Administration
      #
      
      with :resource => :site do
        on( :get => [ 'login' ], :as => :login ) { view.login }
        on( :post => [ 'login' ], :as => :authenticate ) { controller.authenticate }
        on( :get => [ 'admin' ], :as => :admin ) { view.admin }
        on( :post => [ 'admin' ], :as => :update ) { controller.update ; view.admin }
      end
           
      on( :post => [ 'admin', { :resource => RESOURCE } ], :as => :add ) { add }
      on( :post => [ 'admin', { :resource => RESOURCE }, :name ], :as => :update ) { update }
      on( :delete => [ 'admin', { :resource => RESOURCE }, :name ], :as => :delete ) { delete }
      on( :edit, :get => [ 'admin', { :resource => RESOURCE }, :name ], :as => :edit ) { edit }
      on( :get => [ { :resource => RESOURCE }, :name ], :as => :show ) { show( attributes.name ) }

      # defaults to story
      with :resource => :story do
        on( :get => [ :name ], :as => :show ) { show( attributes.name ) }
        on( :get => [], :as => :home ) { show( 'home' ) }
      end

    end
  
  end

end