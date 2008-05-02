module Application

  module Configurations
      
    class Development < Default

			host '0.0.0.0'; port 3000; ports [ 2020, 2021, 2022 ]

      application do
				use Rack::ShowExceptions
				run Waves::Dispatchers::Default.new
			end				

    end

  end
  
end
