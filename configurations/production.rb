module Pages

  module Configurations
      
    class Production < Default
      
      reloadable []
      log :level => :error, :output => ( :log / 'log.out' ), :rotation => :weekly
      host '0.0.0.0'
      ports [ 3000, 3001, 3002 ]

      application do
        run ::Waves::Dispatchers::Default.new
      end

      server Waves::Servers::Mongrel.new

    end
  end
end
