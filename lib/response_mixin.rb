module Pages
  module ResponseMixin
		def domain ; request.domain.gsub(/^www\./,'') ; end
		def site ; Pages::Models::Site[ domain ].find( :site ) ; end
    def model( name ) ; app::Models[ name ][ domain ]; end
    alias_method :models, :model
    def find( m, n ); model( m ).find(n) ; end
    def all( m ) ; model(m).all ; end
	end  
end