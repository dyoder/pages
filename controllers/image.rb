module Pages

  module Controllers

    class Image < Default

      def get( path )
        path = resolve( path )
        #hack for handling some javascript libraries which set text/html in the accept and wants html code back.
        if params[:random]
          response.content_type = request.accept.default
          response['Cache-Control'] = 'no-cache'
          size = ( params[:size] ? params[:size] : 'medium' )
          return "<img src='#{resource.path}?size=#{size}' />"
        else
          ( params[:size] ? resize( path, params[:size] ) : ::Image.read( path ) ).to_blob
        end
      end

      def delete( name )
        instance = find( name )
        # clear_cache( instance )
        instance.delete
      end

      #def update( name )
      #  img = find(name)
      #  # updating relation with gallery
      #  sel_b = query[ model_name ].to_h['gallery']
      #  model_b = models('gallery').find(sel_b)
      #  unless model_b.nil?
      #    model_b.images.push(img)
      #    model_b.save
      #  end
      #  # updating image entry
      #  img.assign( query[ model_name ].to_h ).save
      #end

      # TODO: Add file upload support to controller (or resource)
      #functor( :file=, Hash ) do | file |
      #   unless f[:filename].empty?
      #     set( 'content_type',f[:type])
      #     puts "FILENAME",f[:filename]
      #     fname = set('file',"#{name}#{File.extname(f[:filename])}")
      #     FileUtils.cp( f[:tempfile].path, db.storage.path( fname ).gsub('/image/','/file/') )
      #   end
      #end

      private

      def resolve( path )
        unless request.extension.nil?
          path = [ :db / domain / :file / "#{path}.#{extension}", :public / :images / "#{path}.#{extension}"  ].find do | path |
            File.exist?( path )
          end
          path or not_found
        else
          image = app::Models[ model_name ][ domain ].find( path )
          response.content_type = image.content_type
          :db / domain / model_name / image.filepath
        end
      end

      def resize( path, size )
        dimensions = size.split('x').map { |d| d.to_i }
        dimensions = ::Image::Dimensions[ size.intern ] if dimensions.length == 1
        unless image = cached( path, dimensions )
            image = ::Image.read( path ).resize!( dimensions )
            # cache( path, dimensions, image )
        end
        image
      end

      def cached( path, size )
        path = cache_path( path, size )
        ::Image.new( File.read( path ) ) if File.exist?( path )
      end

      def cache( path, size, image )
        File.write( cache_path( path, size ), image.to_blob )
      end

      def clear_cache( instance )
        Dir[ :db / domain / :cache / instance.file + '*' ].each do |path|
          FileUtils.remove( path )
      end
      end

      def key( path, size )
        [ File.basename( path ),
          File.mtime( path ).strftime('%F-%H:%m:%S'),
          size.join('x') ].join('.')
      end

      def cache_path( path, size )
        :db / domain / :cache / key( path, size )
      end

    end
  end
end
