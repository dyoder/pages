module Pages
  
  module Resources
    
    class Admin < Waves::Resources::Delegate
      include Functor::Method
      before do
        redirect( paths( :site ).login ) unless session[:user]
        request.traits.waves.authenticated = true 
      end
      
    end
    
  end
  
end