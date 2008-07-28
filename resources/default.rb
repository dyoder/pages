module Pages
  
  module Resources
    
    class Default < Waves::Resources::Base
            
      def add
        action( :create ) and redirect( paths.show )
      end
      
      def update
        action( :update, name ) and redirect( paths( :site ).main )
      end
      
      def delete
        action( :delete, name ) and redirect( paths( :site ).main )
      end
      
      def edit
        action( :find, name ) and render( :editor )
      end
      
      def show
        action( :find, name ) and render( :show )
      end
      
      def home
        params['name'] = 'home' ; show
      end
      
    end
    
  end
  
end