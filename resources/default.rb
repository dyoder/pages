module Pages
  
  module Resources
    
    class Default < Waves::Resources::Base
            
      def add
        controller.create and redirect( paths.show )
      end
      
      def update
        controller.update( attributes.name ) and rediect( paths( :site ).admin )
      end
      
      def delete
        controller.delete( attributes.name ) and redirect( paths( :site ).main )
      end
      
      def edit
        view.edit( resource => controller.find( attributes.name ) )
      end
      
      def show( name )
        view.show( resource => controller.find( name or attributes.name ) )
      end
            
    end
    
  end
  
end