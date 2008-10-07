module Pages
  
  module Resources
    
    class Admin
      
      include Waves::Resources::Mixin
      
      on( true, [ 'admin' ] ) { to( :site ) }

      on( true, [ 'admin', :resource ] ) { to( captured.resource ) }

      on( true, [ 'admin', :resource, { :rest => true } ] ) { to( captured.resource ) }

      private
      
    end
    
  end
  
end