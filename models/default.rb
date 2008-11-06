module Pages
  
  module Models
    
    class Default
      
      include Pages::ResponseMixin
      def self.[]( domain ) 
			  Class.new( self ) do
			    include( Filebase::Model[ :db / domain / superclass.basename.snake_case ] )
			    associate( domain )
			  end
			end
			
			def self.associate( domain ) ; end
			
			def assign( assigns )
			  assigns[ :key ] = assigns.title.downcase.gsub(/\s+/,'-').gsub(/[^\w\-]/,'') unless get( :key )
			  assigns[ :published ] = Date.today unless assigns.published
			  super( assigns )
		  end
		  
			def title ;  get( :title ) or '' ; end
			
			def published
			  rval = get( :published )
			  return rval if rval.is_a? Date
			  return Date.today
			end
      
		end
		
	end
	
end
	
