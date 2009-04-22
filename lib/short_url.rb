require 'net/http'
require 'json'
require 'logger'

#js function executed by bit.ly before submitting the url for shortening
#TODO add some of this logic in the client
#function beforeCompress() {
#   var url = $("#url").val();
#   var keyword = $("#keyword").val();
#   url = url.trim();
#   keyword = keyword.trim();
#   if (url == "") {
#     showError('Please enter an URL to shorten.');
#     return false;
#   }
#   re = new RegExp('^([a-zA-Z]+:\/\/)');
#   if (!url.match(re)) {
#     url = 'http://'+url;
#   }
#
#   if (url.search(BITLY_UTILS.http_regexp) > -1) { // /http:\/\/bit.ly\//i
#     showError('That is already a bitly URL.');
#     return false;
#   }
#
#   if (keyword != '') {
#     re = new RegExp('^([0-9a-zA-Z_-]+)$');
#     if (!keyword.match(re)) {
#       showError('Keywords may only contain letters, numbers, underscores and dashes.');
#       return false;
#     }
#   }
#
#   $("#s").val($("#tweet_body").val());
#   return true;
#};
  
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
      call( 'shorten', { :longUrl => dest_url, :version => '2.0.1', :format => 'json' } ) # this is not documented, but adding :history => 1 should add the short_url to your history.
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
      JSON.parse( response.body )
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

#begin
#client = ShortUrl::Client.new
#resp = client.short_url( 'http://dev.zeraweb.com' )
#p resp['results']['shortUrl']
#rescue Object => e
#puts "Log to logger message: #{e.message}" 
#end