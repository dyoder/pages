module Pages
  module ResponseMixin
		def domain ; request.domain.gsub(/^www\./,'') ; end
		def site ; Pages::Models::Site[ :db / domain ].find( :site ) ; end
	end  
end