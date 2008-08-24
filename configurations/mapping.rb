module Pages
  
  module Configurations
    
    module Mapping

      extend Waves::Mapping
      
      # Basic Patterns
			MEDIA = { :media => /^(javascript|flash|audio|css|video)$/ }
			RESOURCE = [{ :resource => /^(story|image|gallery|blog|feed|product|catalog)$/ }]
			NAMED_RESOURCE = RESOURCE << :name
			ADMIN = [ 'admin' ] ; LOGIN = [ 'login' ]
			
      #
      # Supported Media Types
      #
      
      on( :get => [ 'favicon.ico' ], :resource => :image, :as => :fav_icon ) { controller.get( 'favicon.ico' ) }
      
      # special image handling to deal with image resizing
      on( :get => [ 'images', { :asset => true } ], :as => :get ) { controller.get( query.asset * '/' ) }
      
      # arbitrary media: video, audio, whichever
      on( :get => [ MEDIA, { :asset => true } ], :resource => :media, :as => :get ) do
        controller.get( query.media, query.asset * '/')
      end
      
      # blog feeds
      on( :get => [ 'blog', :name ], :resource => :blog, :as => :feed ) do
         view.feed( :blog => controller.find( query.name ) )
      end
      
      #
      # Administration
      #

      with :resource => :site do
        before do
          on( :any => ADMIN << true ) { authenticated? }
        end
        on(  :get   => LOGIN,   :as => :login )          { view.login }
        on( :post   => LOGIN,   :as => :authenticate )   { controller.authenticate }
        on(  :get   => ADMIN,   :as => :admin )          { view.admin }
        on( :post   => ADMIN,   :as => :update )         { controller.update ; view.admin }
      end
      
      on(   :post   => ADMIN + RESOURCE,        :as => :add )
      on(   :post   => ADMIN + NAMED_RESOURCE,  :as => :update )
      on( :delete   => ADMIN + NAMED_RESOURCE,  :as => :delete )
      on(    :get   => ADMIN + NAMED_RESOURCE,  :as => :edit )
      on(    :get   => NAMED_RESOURCE,          :as => :show )

      # defaults to story
      with :resource => :story do
        on(   :get  => [ :name ],  :as => :show )
        on(   :get  => [],         :as => :home )
      end

    end
  
  end

end