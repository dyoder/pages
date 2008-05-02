class Filebase
	
	def initialize( root = '.' )
		@root = root
	end
	
	def path( name )
		@root / name + '.yml'
	end
	
	def all
		rval = Dir[ path('*') ].inject({}) do |rval,path| 
		  rval[ File.basename( path,'.yml' ) ] = ( YAML.load( File.read( path ) ) || {} )
		  rval
		end
		rval
	end
	
	def find( name )
		( YAML.load( File.read( path( name ) ) ) if File.exists?( path( name ) ) ) || {}
	end
	
	def save( name, object )
		File.write( path( name ), object.to_yaml )
	end
	
	def delete( name )
		FileUtils.remove( path( name ) )
	end
	
end