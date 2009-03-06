require 'layers/rack/rack_cache'
module Pages

  module Configurations
      
    class Production < Default
      
      reloadable []
      log :level => :info, :output => ( :log / 'log.out' )
      host '0.0.0.0'
      port 2020
      debug false
      
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
