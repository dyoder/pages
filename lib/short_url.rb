require 'net/http'
require 'json'
require 'logger'
  
module ShortUrl
  class Client
    
    # wrapping my key here
    def initialize
      @auth = { :user => 'polymar', :password => 'R_9d491bcf62b85b75c42d415a561c5d74' }
    end
    
    # get a shorter url.
    # the json returned looks like this: 
    # {"results"=>{"http://dev.zeraweb.com"=>{"userHash"=>"YrDMv", "hash"=>"AbLkr", "shortKeywordUrl"=>"", "shortUrl"=>"http://bit.ly/YrDMv"}}, "errorMessage"=>"", "errorCode"=>0, "statusCode"=>"OK"}
    def short_url( dest_url )
      return '' if dest_url.nil? or dest_url.empty?
      http_reg = Regexp.new('^([a-zA-Z]+:\/\/)')
      dest_url = 'http://' + dest_url if( !http_reg.match( dest_url ))
      bit_reg = Regexp.new('^([a-zA-Z]+:\/\/bit.ly\/)')
      return dest_url if bit_reg.match( dest_url ) 
      call( 'shorten', { :longUrl => dest_url, :version => '2.0.1', :format => 'json' } ) # this is not documented, but adding :history => 1 should add the short_url to your history on bit.ly.
    end
    
    private
    
    def call( path, params = {} )
 	    logger.info "Calling #{url( path, params ) } ..."
	    request = Net::HTTP::Get.new( url( path, params ) )
	    request.basic_auth( login, password )
      response = Net::HTTP.start( 'api.bit.ly' ) do |h| 
        h.request( request )
      end
      response.value # triggers error if not 2xx
      logger.info "Success!"
      JSON.parse( response.body )['results'][params[:longUrl]]['shortUrl']
    end
    
    def url( path, params )
      "http://api.bit.ly/#{path}#{query(params)}"
    end
    
    def query( params )
      return '' if params.nil? or params.empty?
      params.inject('?') { |q,p| q << "#{p[0]}=#{p[1]}&" }
    end

    def logger
      @logger ||= Logger.new( $stderr )
    end
    
    def login
      @auth[:user]
    end
    
    def password
      @auth[:password]
    end
    
  end
  
end

#client = ShortUrl::Client.new
#begin
#  resp = client.short_url( 'http://www.google.com' )
#  p resp
#rescue Object => e
#  puts "Log to logger message: #{e.message}" 
#end
#begin
#  resp = client.short_url( 'www.google.com' )
#  p resp
#rescue Object => e
#  puts "Log to logger message: #{e.message}" 
#end
#begin
#  resp = client.short_url( 'google.com' )
#  p resp
#rescue Object => e
#  puts "Log to logger message: #{e.message}" 
#end
#begin
#  resp = client.short_url( 'http://bit.ly/fICXX' )
#  p resp
#rescue Object => e
#  puts "Log to logger message: #{e.message}" 
#end