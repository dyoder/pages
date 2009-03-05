module Pages
  
  module Models
    
    class Default
      
      include Pages::ResponseMixin
      
      def self.[]( domain ) 
			  Class.new( self ) do
			    include( Filebase::Model[ :db / domain / superclass.basename.snake_case ] )
          
          alias_method :orig_assigns, :assign
      
          def assign( assigns )
            assigns[ :key ] = assigns['title'].downcase.gsub(/\s+/,'-').gsub(/[^\w\-]/,'') unless get( :key )
            assigns[ :published ] = Time.now unless assigns['published']
            super( assigns )
          end
          
			    associate( domain )
          
			  end
			end
			
			def self.associate( domain ) ; end
			
		  
			def title ;  get( :title ) or '' ; end
			
			def published
			  rval = get( :published )
			  return rval if rval.is_a? Time
			  return rval if rval.is_a? Date
			  return Date.parse(rval) if rval.is_a? String
			  return Time.now
			end

			def name ; get( :key ) ; end
      
		end
		
	end
	
end
	
