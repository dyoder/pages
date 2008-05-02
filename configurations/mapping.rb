module Application
  
  module Configurations
    
    module Mapping
      
      extend Waves::Mapping
      
      # Basic Patterns
      name = '([\w\-\_\.\+\@]+)'
      pathname = '([\w\-\_\.\+\@\/]+)'
			model = '(story|image|gallery|blog|feed|product|catalog)'
			media = '(javascript|flash|audio|css|video)'

      #
      # Supported Media Types
      # We could probably consolidate these into a single rule or 3 ...
      #
      
      path %r{^/favicon.ico/?$} do
        use( :image ) | controller { get('favicon.ico') }
      end
      
      path %r{^/images/(?:get/)?#{pathname}/?$} do | pathname |
        use( :image ) | controller { get( pathname ) }
      end
      
      path %r{^/#{media}/#{pathname}/?$} do | media, pathname |
        use( :media ) | controller { resource( media, pathname ) }
      end
      
      # special rule to handle rss blog feed
      path %r{^/blog/#{name}.rss$} do | name |
        use( :blog ) | controller { find( name ) } | view { |blog| feed( :blog => blog ) }
      end     
      
      #
      # Administration
      #
      
      # This before filter locks down any access to /admin/...
      # we still allow for stories beginning with 'admin', like
      # 'admin-console' or 'administrative-assignments'
      before %r{^/admin(?:/|$)} do
        redirect( '/login/' ) unless session[:user]
      end

      # login verification
      path %r{^/login/?$}, :method => :post do
        use( :site ) | controller{ authenticate } | view{ login( :retry => true ) }
      end
      
      # login page
      path %r{^/login/?$} do
        use( :site ) | view{ login }
      end
            
      # add a new content object
      path %r{^/admin/#{model}/?$}, :method => :post do | model |
        use( model ) | instance = controller { create }
        redirect( "/admin/#{model}/#{instance.name}" )
      end

      # update a new content object
      path %r{^/admin/#{model}/#{name}/?$}, :method => :post do | model, name |
        use( model ) | controller { update( name ) }
        redirect( "/admin" )
      end

      # delete a content object
      path %r{^/admin/#{model}/#{name}/?$}, :method => :delete do | model, name |
        use( model ) | controller { delete( name ) }; redirect( "/admin/" )
      end

      # edit a content object
      path %r{^/admin/#{model}/#{name}/?$} do | model, name |
        use( model ) | controller { find( name ) } | 
          view { |instance| editor( model => instance ) }
      end

      # main site administration page
      path %r{^/admin/?$}, :method => :post do
        use( :site ) | controller{ update }; redirect( "/admin/" )
      end

      path %r{^/admin/?$} do
        use( :site ) | view { admin }
      end
    
      # generic content-delivery
      path %r{^/#{model}/#{name}/?$} do | model, name |
        use( model ) | controller { find( name ) } | 
          view { |instance| show( model => instance ) }
      end
      
      # defaults to story
      path %r{^/#{name}/?$} do | name |
        use( :story ) | controller{ find( name ) } |
          view { |story| show( :story => story ) }
      end

      # defaults to home
      path %r{^/$} do 
        use( :story ) | controller { find( :home ) } | 
          view { | story | show( :story => story ) }
      end

    end
  
  end

end