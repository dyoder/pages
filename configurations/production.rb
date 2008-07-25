module Pages

  module Configurations
      
    class Production < Default
      
      reloadable []
      log :level => :error, :output => ( :log / "pages.#{$$}" ), :rotation => :weekly
      host '0.0.0.0'
      port 80
      handler ::Rack::Handler::Mongrel, :Host => host, :Port => port

      application do
        run ::Waves::Dispatchers::Default.new
      end

    end
  end
end
