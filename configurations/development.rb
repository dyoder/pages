require 'layers/rack/rack_cache'
module Pages
  module Configurations
    class Development < Default
      
      reloadable [ Pages ]
	          
      include Waves::Cache::RackCache
      application.use Rack::Session::Cookie, :key => 'rack.session',
        # :domain => 'foo.com',
        :path => '/',
        :expire_after => 2592000,
        :secret => 'Change it'

      server Waves::Servers::Mongrel
    end
  end
end
