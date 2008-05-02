require 'lib/dynamo'
require 'lib/filebase'

module Application

	extend Autocreate; extend Autoload; extend Reloadable
	autoload true; directories :lib

	[ :Configurations, :Models, :Views, :Controllers, :Helpers ].each do | name |
		autocreate( name, Module.new ) do

			def self.[]( cname )
			  eval("#{name}::#{cname.to_s.camel_case}")
			end

		  # first try to load and only create if that fails
		  # which means install autoload *after* autocreate
		  extend Autocreate; extend Autoload
		  
			autoload true; directories name.to_s.snake_case
			unless name == :Configurations # don't autocreate configs
			  autocreate true, eval("Application::#{name}::Default")
			end

		end

	end
		
	class << self
		def config ; Waves::Server.config rescue nil || Waves::Console.config ; end
		def configurations ; Application::Configurations ; end
		def controllers ; Application::Controllers ; end
		def models ; Application::Models ; end
		def helpers ; Application::Helpers ; end
		def views ; Application::Views ; end
	end
	
end

Waves << Application
# LiveConsole.new(3333).run
