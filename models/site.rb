module Pages
  
  module Models
    
    class Site < Default
      
      ROLES = [ 
        'administrator',
        'member',
        'subscriber'
      ]
      
      def self.roles
        ROLES
      end
      
      def self.[]( domain ) 
			  Class.new( self ) do
			    include( Filebase::Model[ :db / domain ] )
			    associate( domain )
			  end
			end
			
		end
		
	end
	
end
