module Application

  module Configurations
      
    class Production < Default

			host '0.0.0.0'; port 80
			
			ports [ 2020, 2021, 2022 ]
      
      application do
				run Waves::Dispatchers::Default.new
			end				

    end

  end
  
end
