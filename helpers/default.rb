require 'simple-rss'
require 'open-uri'
module Pages
  
  module Helpers
    
    module Default
      
      include Waves::Helpers::Extended
      include Pages::ResponseMixin
      
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
			
			def feed( options )
			    SimpleRSS.parse( open( options[:url] ) )
			end
			
			def mab( content ) ; markaby( content ) ; end
			
      def buttons( list )
			  div.buttons do
  			  list.each do |button|
  			    self << view( :form, :button, button )
  			  end
  			end
			end
			
		end
	end
end