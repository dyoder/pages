require 'redcloth'

module Application

	module Helpers
	
		module Default
		  
		  DOCTYPES = {
		    :html3 => '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">',
				:html4_transitional => 
				  '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"' <<   
				   '"http://www.w3.org/TR/html4/loose.dtd">',
				:html4_strict =>
					'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" ' <<
						'"http://www.w3.org/TR/html4/strict.dtd">',
				:html4_frameset =>
				  '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN"' <<
  				  '"http://www.w3.org/TR/html4/frameset.dtd">',
				:xhtml1_transitional =>
				  '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"' <<
				    '"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">',
				:xhtml1_strict =>
				  '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"' <<
				    '"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">',
				:xhtml1_frameset =>
				  '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN"' <<
				    '"http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">',
				:xhtml2 => '<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">'
		  }

			attr_reader :request

		  include Waves::ResponseMixin
		  include Application::ResponseMixin
		  
			def layout( name, assigns = {}, &block )
			  assigns[ :layout_content ] = capture(&block)
				self << Application::Views::Layouts.process( request ) do 
					send( name, assigns )
				end
			end
			
			def doctype(type) ; self << DOCTYPES[type||:html4_strict] ; end
			
			# ------------------------------ EXPERIMENTAL ------------------------------ #
			
			def all( model )
			  Application.models[ model ].all( domain )
      end
      
			def find( model, name )
			  Application.models[ model ].find( domain, name ) rescue nil
			end
			
			def view( model, view, assigns = {} )
        self << Application.views[ model ].process( request ) do
	        send view, assigns
	      end
			end
			
			def show( model, name, assigns = {} )
			  assigns[ model ] = find( model, name )
			  view( model, :content, assigns ) if assigns[ model ]
			end
			
			def story( name, assigns = {} )
			  show( :story, name, assigns )
			end
			
			# TODO: this won't work inside a erb template!
			# but i hate to do a whole new Builder when I'm
			# already inside one! test self === Builder? 
			def mab( content )
		    eval content
			end

			def textile( content )
  			( ::RedCloth::TEXTILE_TAGS  << [ 96.chr, '&8216;'] ).each do |pat,ent|
  				content.gsub!( pat, ent.gsub('&','&#') )
  			end
				::RedCloth.new( content ).to_html
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
			
			def site ; Application::Models::Site.find( domain ) ; end
			
			# ------------------------------ FORM HELPERS ------------------------------ #
			
			def properties(&block)
			  div.properties do
			    yield
			  end
			end
			
			def property( options )
			  self << view( :form, options[:type], options )
			end
			
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