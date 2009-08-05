#require 'waves/layers/rack/rack_cache'
module Pages
  module Configurations
    class Development < Default
      
      reloadable [ Pages ]
	    port 2030
	    debug true
      
      application.run Waves::Dispatchers::Default.new
      
      server Waves::Servers::Mongrel
    end
  end
end
