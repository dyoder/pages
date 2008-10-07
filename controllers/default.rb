module Pages

	module Controllers
		
		class Default
			
			include Waves::Controllers::Mixin
			include Pages::ResponseMixin
			
			alias_method :_model, :model ; def model ; _model( model_name ) ; end
			def create ; debugger ; model.create( assigns.to_h ) ; end
			def find( name ) ; model.find( name ) or not_found ; end
			def update( name ) ; find( name ).assign( assigns.to_h ).save ; end
			def delete( name ) ; find( name ).delete ; end
			
			private
			
			def assigns
			  unless @assigns
			    @assigns = query[ model_name ]
			    @assigns.key  = title.downcase.gsub(/\s+/,'-').gsub(/[^\w\-]/,'') unless @assigns.key
  			  @assigns.published = Date.today unless @assigns.published ; self
			  end
			  return @assigns
			end
									
		end
		
	end

end
			
			
