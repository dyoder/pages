module Pages
  module Configurations
    class Development < Default
      
      reloadable [ Pages ]
      log :level => :debug
      host '127.0.0.1'
      port 3000
	    handler ::Rack::Handler::Mongrel, :Host => host, :Port => port
	    session :duration => 30.minutes, :path => './tmp/sessions'
      
      application do
        use ::Rack::ShowExceptions
        run ::Waves::Dispatchers::Default.new
      end
      
    end
  end
end