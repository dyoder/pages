module Pages

  module Models

    class Image < Default

      def associate( domain )
        has_one :gallery, :class => Pages::Models::Gallery[ domain ]
      end

      def self.[]( domain )
        Class.new( self ) do
          include( Filebase::Model[ :db / domain / superclass.basename.snake_case ] )
          associate( domain )

          # callback from filebase before saving
          before_save do |obj|
            #Save the file only if file is uploaded.
            if obj.file and not obj.file['filename'].empty?
              rel_path = 'files'
              dirpath = :db / domain / superclass.basename.snake_case / rel_path
              ::FileUtils.mkdir_p(dirpath) unless File.exists?(dirpath)
              filepath = File.join dirpath, obj.key
              ::FileUtils.mv(obj.file.tempfile.path, filepath, :force => true)
              obj.filepath = rel_path / obj.key
              obj.content_type = obj.file['type']
              obj.orig_name = obj.file['filename']
            end
            obj.file = nil
            obj
          end

          # callback from filebase before deleting
          before_delete do |obj|
            g = Pages::Models[ 'gallery' ][ domain ].find( obj.gallery )
            if g
              g.save if g['images'].delete( obj.key )
            end
            obj
          end

        end
      end

    end

  end

end
