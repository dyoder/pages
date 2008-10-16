module Pages
  
  module Models
    
    class Default
      
      def self.[]( domain ) 
			  Class.new( self ) do
			    include( Filebase::Model[ :db / domain / superclass.basename.snake_case ] )
			    associate( domain )
			  end
			end
			
			def self.associate( domain ) ; end
			
			def title ; get( :title ) or '' ; end
			
			def published
			  rval = get( :published )
			  return rval if rval.is_a? Date
			  return Date.today
			end
      
		end
		
	end
	
end
	