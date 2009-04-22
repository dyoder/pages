require 'net/http'
require 'json'
require 'logger'
require 'short_url'
  
module Twitter
  class Client
  
    def initialize( auth )
      @auth = auth
    end
    
    # public method for updating twitter status
    def update_status( status ) # status = { :message => 'new post on ruby', :url => 'http://www.ruby-lang.com' }
      message = status[:message]
      short_url = ::ShortUrl::Client.new.short_url( status[:url] )
      if message.nil? or message.empty?
        posted = shorted unless ( short_url.nil? or short_url.empty? )
      else
        posted = message
        posted = posted + ': ' + short_url unless ( short_url.nil? or short_url.empty? )
      end
      if posted.nil?
        logger.info "Invalid status for posting."
      else
        call( 'statuses/update', { :status => posted } , :post )
      end
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

#client = Twitter::Client.new( :user => 'polymar', :password => 'aaa' )
#begin
#  resp = client.update_status( { :message => 'testing from' } )
#  p resp
#rescue Object => e
#  puts "Log to logger message: #{e.message}" 
#end
#begin
#  resp = client.update_status( { :url => 'http://www.gazzetta.it' } )
#  p resp
#rescue Object => e
#  puts "Log to logger message: #{e.message}" 
#end
#begin
#  resp = client.update_status( { :message => 'testing from' , :url => 'http://www.google.com' } )
#  p resp
#rescue Object => e
#  puts "Log to logger message: #{e.message}" 
#end
#begin
#  resp = client.update_status( { :ciao => 'testing from' } )
#  p resp
#rescue Object => e
#  puts "Log to logger message: #{e.message}" 
#end
