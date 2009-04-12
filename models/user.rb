module Pages
  
  module Models
    
    class User < Default
      
      def self.[]( domain ) 
			  Class.new( self ) do
			    include( Filebase::Model[ :db / domain / superclass.basename.snake_case ] )
          
          alias_method :orig_assigns, :assign
      
          def assign( assigns )
            assigns[ :key ] = assigns['email'].downcase.gsub(/\s+/,'-').gsub(/[^\w\-]/,'-') unless get( :key )
            assigns[ :date_joined ] = Time.now unless assigns['date_joined']
            super( assigns )
          end
          
			    associate( domain )
          
			  end
			end
			
			def self.associate( domain )
			  has_many :entries, :class => Pages::Models::Story[ domain ]
			  has_many :listings, :class => Pages::Models::Listing[ domain ]
			  #has_many :announcements, :class => Pages::Models::Announcement[ domain ]
			end
			
			def date_joined
			  rval = get( :date_joined )
			  return rval if rval.is_a? Time
			  return Time.parse(rval) if rval.is_a? String
			  return Time.now
			end

			def username ; get( :key ) or '' ; end
			
			# TODO .. better identify the hierarchy of roles, not only driven by DW
			ROLES = [ 
			  ['Admin', 'Admin' ], 
			  ['Member','Member'],
			  ['Subscriber', 'Subscriber' ]
      ]
            
			def self.roles
			  ROLES
			end
      
		end
		
	end
	
end
	
