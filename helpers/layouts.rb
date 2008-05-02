module Application

	module Helpers
	
		module Layouts
		  
		  include Default

      def layout_content
        self << @layout_content
      end
    
    end
    
  end
  
end