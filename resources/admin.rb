module Pages
  
  module Resources
    
    class Admin < Waves::Resources::Delegate
    
      before do
        redirect( paths( :site ).login ) unless session[:user]
        request.traits.waves.authenticated? = true 
      end
      
    end
    
  end
  
end