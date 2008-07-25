module Pages
  module Helpers
    module Default
      
      def model( name )
        Waves.application.models[ name ][ :db / domain / name ]
      end
      
      def show( model, name, assigns = {} )
			  assigns[ model ] = find( model, name )
			  view( model, :content, assigns ) if assigns[ model ]
			end
			
			def story( name, assigns = {} )
			  show( :story, name, assigns )
			end
			
		end
	end
end