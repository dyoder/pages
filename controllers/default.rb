module Pages

	module Controllers
		
		class Default
			
			include Waves::Controllers::Mixin
			include Pages::ResponseMixin
			
			class Assigns ; include Attributes ; end
			
			def assigns ; @assigns ||= create_assigns ; end
			alias _model model ; def model ; _model[:db/domain/model_name] ; end
			def create ; model.create( create_assigns.to_h ) ; end
			def find( name ) ; model.find( name ) or not_found ; end
			def update( name ) ; find( name ).assign( assigns.to_h ).save ; end
			def delete( name ) ; find( name ).delete ; end
			
			private
			
			def create_assigns
			  Assigns.new( params[ model_name.singular.intern ] ).instance_eval do
			    name = title.downcase.gsub(/\s+/,'-').gsub(/[^\w\-]/,'') if ( name.nil? || name.empty? )
  			  published = Date.today ; self
			  end
			end
									
		end
		
	end

end
			
			
