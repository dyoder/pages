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
        view.edit( singular => controller.find( query.name ) )
      end
      
      def show( name )
        view.show( singular => controller.find( name ))
      end
            
    end
    
  end
  
end