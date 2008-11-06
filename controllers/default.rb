module Pages

	module Controllers
		
		class Default
			
			include Waves::Controllers::Mixin
			include Pages::ResponseMixin
			
			alias_method :_model, :model ; def model ; _model( model_name ) ; end
			def create ; model.create( assigns.to_h ) ; end
			def find( name ) ; model.find( name ) or not_found ; end
			def update( name ) ; find( name ).assign( query[ model_name ].to_h ).save ; end
			def delete( name ) ; find( name ).delete ; end
			
		end
		
	end

end
			
			
