module Pages

  module Configurations
      
    class Production < Default
      
      reloadable []
      log :level => :info, :output => ( :log / 'log.out' )
      host '0.0.0.0'
      port 2020
      debug false

    end
  end
end
