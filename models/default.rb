module Pages
  
  module Models
    
    class Default
      
      def self.[]( path ) 
			  Class.new( self ) { include( Filebase::Model[ path ] ) }
			end
			
		end
		
	end
	
end
	