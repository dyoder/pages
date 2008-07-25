module Pages
  module Configurations
    class Development < Default
      
      reloadable [ Pages ]
      log :level => :debug
      host '127.0.0.1'
      port 3000
	    handler ::Rack::Handler::Mongrel, :Host => host, :Port => port
      
      application do
        use ::Rack::ShowExceptions
        run ::Waves::Dispatchers::Default.new
      end
      
    end
  end
end
