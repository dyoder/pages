require 'lib/twitter_client'
module Pages
  
  module Resources
    
    class Social < Default

      on( :post, [ 'social' , 'twitter' ] ) { 
          resp = tweet
          tweet_result = (resp[:error]) ? 'Failed' : 'Completed'
          redirect('/home')
      }
                  
      #       on( :post, [ 'admin', 'social' , 'twitter' ] ) {
      #         resp = tweet
      #         tweet_result = (resp[:error]) ? 'Failed' : 'Completed'
      #         view.spread( :result => tweet_result )
      #       }
      
      on( :get, [ 'admin', 'social' , 'twitter' ] ) { 
        message = site.default_message || ''
        domain = site['domain'] || ''
        user = site.twitter_account || ''
        pwd = site.twitter_password || ''
        view.spread( :user => user, :pwd => pwd, :url => domain, :message => message )
      }
      
      on( :get, [ 'social' , 'twitter' ] ) { 
        message = params[:message] || ''
        url = params[:url] || ''
        view.spread( :message => message, :url => url )
      }
            
      private 
      
      def tweet
        user = params[:user]
        pwd = params[:password]
        status = params[:status]
        url = params[:url]
        client = Twitter::Client.new( :user => user, :password => pwd )
        begin
          return client.update_status( { :message => status, :url => url } )
        rescue Object => e
          return { :error => "#{e.message}" }
        end
      end
      
    end
    
  end
  
end
