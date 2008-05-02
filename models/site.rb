module Application
	
	module Models
		
		class Site < Dynamo
			
			def self.databases
				@domains ||= {}
			end
			
			def self.database( domain )
				databases[ domain ] ||= Filebase.new( :db / domain )
			end
			
			# def self.create( domain, assigns )
			#   name = assigns[:name] || assigns['name']
			# 	raise( Error, 'create requires a name' ) if name.nil? or name.empty?
			# 	self.new( domain, name, assigns ).save
			# end
			
			# def self.all( domain )
			# 	database( domain ).all.map do | name, assigns | 
			# 	  new( domain, name, assigns )
			# 	end
			# end
			
			def self.find( domain )
			  assigns = database( domain ).find( 'site' )
			  new( domain, assigns ) if assigns
			end
			
			def initialize( domain, assigns={} )
				@db = self.class.database( domain )
				super( assigns )
			end
			
			def assign( assigns )
			  assigns.each { |k,v| send( "#{k}=", v ) }; self
			end
						
			def save
				@db.save( 'site', self.to_h ); self
			end
			
			#def delete
			#	FileUtils.remove( :db / domain / :file / file ) if file
			#	@db.delete( self.name ); self
			#end
			
		end
		
	end
	
end