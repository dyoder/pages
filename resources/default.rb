module Pages
  
  module Resources
    
    class Default
      
      include Mixin
      
      def add
        action( :create ) and redirect( paths.show )
      end
      
      def update
        action( :update, name ) and redirect( resource( :site ).paths.main )
      end
      
      def delete
        action( :delete, name ) and redirect( resource( :site ).paths.main )
      end
      
      def edit
        action( :find, name ) and render( :editor ) }
      end
      
      def show
        action( :find, name ) and render( :show )
      end
      
      def home
        puts "Hello"
        params['name'] = 'home' ; show
      end
      
    end
    
  end
  
end