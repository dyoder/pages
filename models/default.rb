module Application
	
	module Models
		
		class Base < Dynamo
			
			def self.databases
				@domains ||= {}
			end
			
			def self.database( domain )
				databases[ domain ] ||= Filebase.new( :db / domain / self.basename.snake_case )
			end
			
			def self.create( domain, assigns )
			  name = assigns[:name] || assigns['name']
				raise( Error, 'create requires a name' ) if name.nil? or name.empty?
				self.new( domain, name, assigns ).save
			end
			
			def self.all( domain )
				database( domain ).all.map do | name, assigns | 
				  new( domain, name, assigns )
				end
			end
			
			def self.find( domain, name )
			  assigns = database( domain ).find( name )
			  new( domain, name, assigns ) if assigns
			end
			
			def initialize( domain, name, assigns={} )
				@db = self.class.database( domain ); super({})
				assign( :name => name.to_s, :domain => domain )
				assign( assigns )
			end

			def assign( assigns )
			  assigns.each { |k,v| self.send( "#{k}=", v ) }; self
			end
			
			def save
				@db.save( self.name, self.to_h ); self
			end
			
			def delete
				FileUtils.remove( :db / domain / :file / file ) if file
				@db.delete( self.name ); self
			end
			
			# some common properties
			
			def published=(date)
			  case date
		    when Date then set( :published, date )
	      when String then set( :published, 
	        ( Date.parse(date) rescue nil || Date.today ) )
        else set( :published, Date.today )
        end
      end
      
			def title
			 get(:title) || name.text.title_case
			end
			
      def title=(string)
        set(:title,( string.nil? or string.empty? ) ? nil : string )
      end
      
			def title?
			  ! ( self[:title].nil? or self[:title].empty? )
			end
						
		end
		
		class Default < Base ; end

	end

end
