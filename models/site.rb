module Pages
  
  module Models
    
    class Site < Default
      
      def self.[]( domain ) 
			  Class.new( self ) do
			    include( Filebase::Model[ :db / domain ] )
			    associate( domain )
			  end
			end
			
		end
		
	end
	
end
