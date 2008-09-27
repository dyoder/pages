module Pages

	module Controllers
		
		class Default
			
			include Waves::Controllers::Mixin
			include Pages::ResponseMixin
			
			alias_method :_model, :model ; def model ; _model( model_name ) ; end
			def create ; model.create( create_assigns.to_h ) ; end
			def find( name ) ; model.find( name ) or not_found ; end
			def update( name ) ; find( name ).assign( assigns.to_h ).save ; end
			def delete( name ) ; find( name ).delete ; end
			
			private
			
			def assigns
			  @assigns ||= query[ model_name ].instance_eval do
			    key = title.downcase.gsub(/\s+/,'-').gsub(/[^\w\-]/,'') if ( key.nil? || key.empty? )
  			  published = Date.today ; self
			  end
			end
									
		end
		
	end

end
			
			
