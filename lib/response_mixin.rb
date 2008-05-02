module Application
  
  module ResponseMixin
		def domain ; request.domain.gsub(/^www\./,'') ; end
		def site ; Application::Models::Site.find( domain ) ; end
	end
	
end