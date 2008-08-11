module Pages
  
  module Helpers
    
    module Default
      
      include Waves::Helpers::BuiltIn
      
      def model( name ) ; app::Models[ name ][ :db / domain / name ] ; end
      
      def find( m, n ); model( m ).find(n) ; end
      
      def show( model, name, assigns = {} )
			  assigns[ model ] = find( model, name )
			  view( model, :content, assigns ) if assigns[ model ]
			end
			
			def story( name, assigns = {} )
			  show( :story, name, assigns )
			end
			
			def format( options )
			  self << if ( options[:format] && 
			      options[:format] != 'html' && 
			      respond_to?( options[:format] ) )
  			  self.send options[:format], options[:content]
  			else
  			  options[:content]
  			end
			end
			
			def mab( content ) ; markaby( content ) ; end
			
			def site ; Pages::Models::Site[ :db / domain ].find( 'site' ) ; end

		end
	end
end