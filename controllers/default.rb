module Pages

  module Controllers

    class Default

      include Waves::Controllers::Mixin
      include Pages::ResponseMixin

      alias_method :_model, :model ; def model ; _model( model_name ) ; end
      def create; model.create( assign(query[ model_name ].to_h )) ; end
      def find( name ) ; model.find( name ) or not_found ; end
      def update( name )
        obj = find( name )
        obj.attributes = obj.attributes.merge( query[ model_name ].to_h )
        obj.save
      end
      def delete( name ) ; find( name ).delete ; end
      
      def assign( assigns )
        assigns[ :key ] ||= assigns['title'].downcase.gsub(/\s+/,'-').gsub(/[^\w\-]/,'')
        assigns[ :published ] ||= Time.now
        assigns
      end

    end

  end

end


