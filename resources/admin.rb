module Pages
  
  module Resources
    
    class Admin < Waves::Resources::Delegate
      
      before( [ 'admin', :resource, :rest => true ] ) do
        redirect( paths( :site ).login ) unless session[:user]
        request.traits.authenticated = true 
        to( capture.resource )
      end
      
    end
    
  end
  
end