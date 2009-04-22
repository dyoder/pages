require 'net/http'
require 'json'
require 'logger'
  
module Twitter
  class Client
  
    def initialize( auth )
      @auth = auth
    end
    
    # public method for updating twitter status
    def update_status( message )
      call( 'statuses/update', {:status => message} , :post )
    end
    
    # public method for getting public timelines
    def public_timeline
      call( 'statuses/public_timeline.json' )
    end
    
    private
    
    def call( path, params = {}, method = :get )
      if method == :get
 	      logger.info "Calling #{get_url( path, params ) } ..."
	      request = Net::HTTP::Get.new( get_url( path, params ) )
      else
	      logger.info "Calling #{post_url( path) } ..."
	      request = Net::HTTP::Post.new( post_url( path ) )
	      request.set_form_data( params )
      end
      request.basic_auth( login, password )
      response = Net::HTTP.start( 'twitter.com' ) do |h| 
        h.request( request )
      end
      response.value # triggers error if not 2xx
      logger.info "Success!"
      JSON.parse( response.body )
    end
    
    def get_url( path, params )
      "http://twitter.com/#{path}.json#{query(params)}"
    end

    def post_url( path )
      "http://twitter.com/#{path}.json"
    end
    
    def query( params )
      return '' if params.nil? or params.empty?
      params.inject('?') { |q,p| q << "#{p[0]}=#{p[1]}&" }
    end

    def login
      @auth[:user]
    end
    
    def password
      @auth[:password]
    end    
    
    def logger
      @logger ||= Logger.new( $stderr )
    end
    
  end
  
end

#begin
#client = Twitter::Client.new( :user => 'polymar', :password => 'inella' )
#resp = client.update_status( 'hallo' )
#p resp
#rescue Object => e
#puts "Log to logger message: #{e.message}" 
#end
