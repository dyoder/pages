module Pages
  
  module Resources
    
    class Site
      
      include Waves::Resources::Mixin
      include Pages::ResponseMixin
      
      on( true, [ 'admin', :resource ] ) { to( captured.resource ) }

      on( true, [ 'admin', :resource, { :rest => true } ] ) { to( captured.resource ) }
      
      # admin access
      on( :get, :admin => [ 'admin' ] ) { response.content_type = 'text/html' ;  view.admin }
      
      # updating admin properties
      on( :post, :admin =>  [ 'admin' ] ) { controller.update( model_name ); redirect( paths.admin ) }
      
      
      on( :get, [ 'admin', 'twitter' ] ) { 
          message = site.default_message || ''
          domain = site['domain'] || ''
          user = site.twitter_account || ''
          pwd = site.twitter_password || ''
          view(:social).configure( :user => user, :pwd => pwd, :url => domain )
      }
      
      # admin auth
      before( [ 'admin', { :rest => true } ] ) { authenticated? }
      before( [ 'admin' ] ) { authenticated? }
      
      private
      
      def authenticated?
        redirect( paths( :user ).login ) unless session[:user] && session[:role] == 'Admin'
      end
      
    end
    
  end
  
end