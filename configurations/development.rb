module Pages
  module Configurations
    class Development < Default
      
      reloadable [ Pages ]
      log :level => :debug
      host '127.0.0.1'
      port 3000
#	    session :duration => 30.minutes, :path => './tmp/sessions'
	          
      application do
        use ::Rack::ShowExceptions
        use Rack::Session::Cookie, :key => 'rack.session',
        # :domain => 'foo.com',
        :path => '/',
        :expire_after => 2592000,
        :secret => 'Change it'

        run ::Waves::Dispatchers::Default.new
      end

      server Waves::Servers::Mongrel
      
    end
  end
end
