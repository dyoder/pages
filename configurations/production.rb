module Pages

  module Configurations
      
    class Production < Default
      
      reloadable []
      log :level => :info, :output => ( :log / 'log.out' )
      host '0.0.0.0'
      ports [ 3000 ]

      application do
        run ::Waves::Dispatchers::Default.new
      end

      server Waves::Servers::Mongrel

    end
  end
end