module Pages

  module Resources

    class Default

      include Waves::Resources::Mixin

      on( :get, [ :resource, { :name => 'home' }] ) { show }

      on( :get, :show => [{ :name => 'home' }] ) { show }



      on( :post, :add =>  [ 'admin', :resource ] ) do
        redirect( paths.edit( model_name, controller.create['key'] ) )
      end

      on( :get, :edit => [ 'admin', :resource, :name ] ) do
        view.editor( singular => controller.find( captured.name ) )
      end

      on( :post, :update =>  [ 'admin', :resource, :name ] ) do
        controller.update( captured.name ) and redirect( paths( :site ).admin )
      end

      on( :delete, :delete =>  [ 'admin', :resource, :name ] ) do
        controller.delete( captured.name ) and redirect( paths( :site ).admin )
      end

      private

      def show(response_format = nil)
        if request.accept[0] == 'text/html-fragment'
          view.content( :story => controller.find( captured.name ))
        else
          view.show( singular => controller.find( captured.name ))
        end
        # removed - validating based on Date is bad, cause we don't catch all the changes in the same day.
        # example of http validation
        # res = controller.find( captured.name )
        # modified = request['HTTP_IF_MODIFIED_SINCE']
        # none = request['HTTP_IF_NONE_MATCH']
        # if modified.nil? || none.nil?
          ## first time the client is asking this view - generating and setting 'Last-Modified'
          # response['Last-Modified'] = res.published.to_s
          # response['ETag'] = res.key
          # view.show( singular => res )
        #else
          ## client has already the view in cache - verifying if it's stale or valid
          # d = Date.parse( modified )
          # if (d <=> res.published) <= 0 # TODO replace Date with Time, otherwise validating cache loses updates to a models in the same day.
            ## the view is still valid
            # response.status = 304
          # else
            ## the view is stale - regenerating and updating 'Last-Modified' tag
            # response['Last-Modified'] = res.published.to_s
            # response['ETag'] = res.key
            # view.show( singular => res )
          # end
        # end
      end

    end

  end

end
